(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: June, 2012
//
(* ****** ****** *)
//
// HX: for handling macro expansion during typechecking
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload ERR = "./pats_error.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement
prerr_FILENAME<> () = prerr "pats_dmacro2"

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_dmacro2.sats"

(* ****** ****** *)

implement m2val_true = M2Vbool (true)
implement m2val_false = M2Vbool (false)

(* ****** ****** *)

implement
liftval2dexp
  (loc0, m2v) = let
in
  case+ m2v of
  | M2Vint (i) => d2exp_int (loc0, i)
  | M2Vchar (c) => d2exp_char (loc0, c)
  | M2Vfloat (rep) => d2exp_float (loc0, rep)
  | M2Vstring (s) => d2exp_string (loc0, s)
  | M2Vunit () => d2exp_empty (loc0)
  | _ => let
      val () = prerr_errmac_loc (loc0)
      val () = prerr ": a value representing code (AST) cannot be lifted."
      val () = prerr_newline ()
    in
      d2exp_errexp (loc0)
    end // end of [_]
end // end of [liftval2dexp]

(* ****** ****** *)

local
//
// HX: ptr for s2var or d2var
//
dataviewtype alphenv = 
  | ALPHENVsadd of (s2var, s2var(*new*), alphenv)
  | ALPHENVdadd of (d2var, d2var(*new*), alphenv)
  | ALPHENVmark of (alphenv) // marking for unwinding
  | ALPHENVnil of ()
// end of [alphenv]

assume alphenv_viewtype = alphenv

in (* in of [local] *)

implement
alphenv_nil () = ALPHENVnil ()

implement
alphenv_free (env) = let
in
//
case+ env of
| ~ALPHENVsadd
    (_, _, env) => alphenv_free (env)
| ~ALPHENVdadd
    (_, _, env) => alphenv_free (env)
| ~ALPHENVmark env => alphenv_free (env)
| ~ALPHENVnil () => ()
//
end // end of [alphenv_free]

implement
alphenv_sadd
  (env, s2v, s2v_new) = let
in
  env := ALPHENVsadd (s2v, s2v_new, env)
end // end of [alphenv_sadd]

implement
alphenv_dadd
  (env, d2v, d2v_new) = let
in
  env := ALPHENVdadd (d2v, d2v_new, env)
end // end of [alphenv_dadd]

(* ****** ****** *)

implement
alphenv_sfind
  (env, key) = let
//
fun loop (
  env: !alphenv, key: s2var
) : s2varopt_vt = let
in
//
case+ env of
| ALPHENVsadd
    (_key, _val, !p_env1) => let
    val ans = (
      if key = _key then
        Some_vt (_val) else loop (!p_env1, key)
      // end of [if]
    ) : s2varopt_vt // end of [val]
  in
    fold@ (env); ans
  end
| ALPHENVdadd
    (_key, _val, !p_env1) => let
    val ans = loop (!p_env1, key) in fold@ (env); ans
  end // end of [ALPHENVdadd]
| ALPHENVmark (!p_env1) => let
    val ans = loop (!p_env1, key) in fold@ (env); ans
  end // end of [ALPHENVmark]
| ALPHENVnil () => let
    prval () = fold@ env in None_vt ()
  end // end of [ALPHENVnil]
end // end of [loop]
//
in
  loop (env, key)
end // end of [alphenv_sfind]

(* ****** ****** *)

implement
alphenv_dfind
  (env, key) = let
//
fun loop (
  env: !alphenv, key: d2var
) : d2varopt_vt = let
in
//
case+ env of
| ALPHENVsadd
    (_key, _val, !p_env1) => let
    val ans = loop (!p_env1, key) in fold@ (env); ans
  end // end of [ALPHENVsadd]
| ALPHENVdadd
    (_key, _val, !p_env1) => let
    val ans = (
      if key = _key then
        Some_vt (_val) else loop (!p_env1, key)
      // end of [if]
    ) : d2varopt_vt // end of [val]
  in
    fold@ (env); ans
  end
| ALPHENVmark (!p_env1) => let
    val ans = loop (!p_env1, key) in fold@ (env); ans
  end // end of [ALPHENVmark]
| ALPHENVnil () => let
    prval () = fold@ env in None_vt ()
  end // end of [ALPHENVnil]
end // end of [loop]
//
in
  loop (env, key)
end // end of [alphenv_dfind]

(* ****** ****** *)

implement
alphenv_pop (env) = let
//
fun loop
  (env: alphenv): alphenv = let
in
  case+ env of
  | ~ALPHENVsadd
      (_, _, env) => loop (env)
  | ~ALPHENVdadd
      (_, _, env) => loop (env)
  | ~ALPHENVmark (env) => (env)
  | ~ALPHENVnil () => ALPHENVnil ()
end // end of [loop]
//
in
  env := loop (env)
end // end of [alphenv_pop]

implement
alphenv_push (env) = (env := ALPHENVmark env)

end // end of [local]

(* ****** ****** *)

local

datavtype evalctx =
  | EVALCTXsadd of (s2var, m2val, evalctx)
  | EVALCTXdadd of (d2var, m2val, evalctx)
  | EVALCTXnil of ()
// end of [eval0ctx]

assume evalctx_viewtype = evalctx

in (* in of [local] *)

implement
evalctx_nil () = EVALCTXnil ()

implement
fprint_evalctx
 (out, ctx) = let
in
//
case+ ctx of
| EVALCTXsadd (
    s2v, m2v, !p_ctx1
  ) => let
    val () = fprint_s2var (out, s2v)
    val () = fprint_string (out, " -<s> ")
    val () = fprint_m2val (out, m2v)
    val () = fprint_newline (out)
    val () = fprint_evalctx (out, !p_ctx1)
    prval () = fold@ (ctx)
  in
    // nothing
  end // end of [EVALCTXsadd]
| EVALCTXdadd (
    d2v, m2v, !p_ctx1
  ) => let
    val () = fprint_d2var (out, d2v)
    val () = fprint_string (out, " -<d> ")
    val () = fprint_m2val (out, m2v)
    val () = fprint_newline (out)
    val () = fprint_evalctx (out, !p_ctx1)
    prval () = fold@ (ctx)
  in
    // nothing
  end // end of [EVALCTXsadd]
| EVALCTXnil () => let
    prval () = fold@ ctx in (*nothing*)
  end // end of [EVALCTXnil]
//
end // end of [fprint_evalctx]

implement
print_evalctx
  (ctx) = fprint_evalctx (stdout_ref, ctx)
// end of [print_evalctx]
implement
prerr_evalctx
  (ctx) = fprint_evalctx (stderr_ref, ctx)
// end of [prerr_evalctx]

(* ****** ****** *)

implement
evalctx_sadd
  (ctx, s2v, m2v) = EVALCTXsadd (s2v, m2v, ctx)
// end of [evalctx_sadd]

implement
evalctx_dadd
  (ctx, d2v, m2v) = EVALCTXdadd (d2v, m2v, ctx)
// end of [evalctx_dadd]

implement
evalctx_dfind
  (ctx, d2v) = let
in
//
case+ ctx of
| EVALCTXsadd (
    _key, _val, !p_ctx1
  ) => let
    val ans = evalctx_dfind (!p_ctx1, d2v)
    prval () = fold@ (ctx)
  in
    ans
  end // end of [EVALCTXsadd]
| EVALCTXdadd (
    _key, _val, !p_ctx1
  ) => let
  in
    if d2v = _key then let
      prval () = fold@ (ctx)
    in
      Some_vt (_val)
    end else let
      val ans = evalctx_dfind (!p_ctx1, d2v)
      prval () = fold@ (ctx)
    in
      ans
    end // end of [if]
  end // end of [EVALCTXdadd]
| EVALCTXnil () => let
    prval () = fold@ (ctx) in None_vt ()
  end // end of [EVALCTXnil]
//
end // end of [evalctx_dfind]

implement
evalctx_free (ctx) = (
  case+ ctx of
  | ~EVALCTXsadd (_, _, ctx) => evalctx_free (ctx)
  | ~EVALCTXdadd (_, _, ctx) => evalctx_free (ctx)
  | ~EVALCTXnil () => ()
) // end of [evalctx_free]

(* ****** ****** *)
//
fun
s2exp_make_m2val
  (m2v: m2val): s2exp =
(
  case m2v of
  | M2Vscode(s2e) => s2e
  | _ (*non-M2Vscode*) => s2exp_errexp(s2rt_t0ype)
) (* end of [s2exp_make_m2val] *)
//
implement
stasub_make_evalctx
  (ctx) = let
//
fun aux (
  ctx: !evalctx, sub: &stasub
) : void = let
in
  case+ ctx of
  | EVALCTXsadd
      (_key, _val, !p_ctx1) => let
      val () = aux (!p_ctx1, sub)
      val s2v = _key
      val s2e = s2exp_make_m2val (_val)
      val () = stasub_add (sub, s2v, s2e)
    in
      fold@ (ctx)
    end
  | EVALCTXdadd
      (_key, _val, !p_ctx1) => let
      val () = aux (!p_ctx1, sub)
    in
      fold@ (ctx)
    end
  | EVALCTXnil () => fold@ (ctx)
end // end of [aux]
//
var sub = stasub_make_nil ()
val () = aux (ctx, sub)
//
in
  sub
end // end of [stasub_make_evalctx]
//
(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
dmacro_eval_xstage
  (d2e) = let
  val loc0 = d2e.d2exp_loc
  var ctx = evalctx_nil ()
  var env = alphenv_nil ()
  val m2v = eval0_d2exp (loc0, ctx, env, d2e)
  val () = alphenv_free (env)
  val () = evalctx_free (ctx)
in
  liftval2dexp (loc0, m2v)
end // end of [dmacro_eval_xstage]

implement
dmacro_eval_decode (d2e) = let
  val loc0 = d2e.d2exp_loc
  var ctx = evalctx_nil ()
  var env = alphenv_nil ()
  val m2v = eval0_d2exp (loc0, ctx, env, d2e)
  val () = alphenv_free (env)
  val () = evalctx_free (ctx)
in
//
case+ m2v of
| M2Vdcode
    (d2e_new) => d2e_new
| _ => let
    val () = prerr_errmac_loc (loc0)
    val () = prerr ": the macro expansion should yield code (AST)"
    val () = prerr ", but the following value is obtained instead: "
    val () = prerr_m2val (m2v)
    val () = prerr_newline ()
  in
    d2exp_errexp (loc0)
  end // end of [_]
//
end // end of [dmacro_eval_decode]

(* ****** ****** *)

implement
dmacro_eval_app_short
  (loc0, d2m, d2as) = let
  var ctx = evalctx_nil ()
  var env = alphenv_nil ()
  val d2e = eval0_app_mac_short (loc0, d2m, ctx, env, d2as)
  val () = alphenv_free (env)
  val () = evalctx_free (ctx)
in
  d2e
end // end of [dmacro_eval_app_short]

(* ****** ****** *)

(* end of [pats_dmacro2.dats] *)
