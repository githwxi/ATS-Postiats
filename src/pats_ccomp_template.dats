(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: November, 2012
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

dataviewtype impenv =
  | IMPENVcons of (s2var, s2hnf, impenv) | IMPENVnil of ()
// end of [impenv]

extern
fun fprint_impenv : fprint_vtype (impenv)

extern
fun impenv_find (env: !impenv, s2v: s2var): s2hnf
extern
fun impenv_update (env: !impenv, s2v: s2var, s2f: s2hnf): void

(* ****** ****** *)

implement
fprint_impenv
  (out, env) = let
//
fun loop (
  out: FILEref, env: !impenv, i: int
) : void = let
in
//
case+ env of
| IMPENVcons (
    s2v, s2f, !p_env
  ) => let
    val () =
      if i > 0 then
        fprint_string (out, "; ")
      // end of [if]
    val () = fprint_s2var (out, s2v)
    val () = fprint_string (out, " -> ")
    val () = fprint_s2hnf (out, s2f)
    val () = loop (out, !p_env, i+1)
    prval () = fold@ (env)
  in
    // nothing
  end // end of [IMPENVcons]
| IMPENVnil () => let
    prval () = fold@ (env) in (*nothing*)
  end // end of [IMPENVnil]
//
end // end of [loop]
//
in
  loop (out, env, 0)
end // end of [fprint_impenv]

(* ****** ****** *)

implement
impenv_find
  (env, s2v) = let
in
//
case+ env of
| IMPENVcons (
    s2v1, s2f, !p_env
  ) => (
    if s2v = s2v1 then let
      prval () = fold@ (env)
    in
      s2f
    end else let
      val s2f =
        impenv_find (!p_env, s2v)
      // end of [val]
      prval () = fold@ (env)
    in
      s2f
    end // end of [if]
  ) // end of [IMPENVcons]
| IMPENVnil () => let
    prval () = fold@ (env)
    val s2t = s2var_get_srt (s2v)
    val s2e = s2exp_err (s2t)
  in
    s2exp2hnf_cast (s2e)
  end // end of [IMPENVnil]
//
end // end of [impenv_find]

(* ****** ****** *)

implement
impenv_update
  (env, s2v, s2f) = let
in
//
case+ env of
| IMPENVcons (
    s2v1, !p_s2f, !p_env
  ) => (
    if s2v = s2v1 then let
      val () = !p_s2f := s2f
      prval () = fold@ (env)
    in
      // nothing
    end else let
      val () =
        impenv_update (!p_env, s2v, s2f)
      // end of [val]
      prval () = fold@ (env)
    in
      // nothing
    end // end of [if]
  ) // end of [IMPENVcons]
| IMPENVnil () => let
    prval () = fold@ (env) in assertloc (false)
  end // end of [IMPENVnil]
//
end // end of [impenv_update]

(* ****** ****** *)

extern
fun s2hnf_is_err (s2f: s2hnf): bool
implement
s2hnf_is_err
  (s2f) = let
  val s2e = s2hnf2exp (s2f)
in
//
case+ s2e.s2exp_node of S2Eerr () => true | _ => false
//
end // end of [s2hnf_is_err]

(* ****** ****** *)

extern
fun impenv_make_svarlst
  (s2vs: s2varlst): impenv
implement
impenv_make_svarlst (s2vs) = let
in
//
case+ s2vs of
| list_cons
    (s2v, s2vs) => let
    val s2t =
      s2var_get_srt (s2v)
    // end of [val]
    val s2e = s2exp_err (s2t)
    val s2f = s2exp2hnf_cast (s2e)
    val env = impenv_make_svarlst (s2vs)
  in
    IMPENVcons (s2v, s2f, env)
  end // end of [list_cons]
| list_nil () => IMPENVnil ()
//
end // end of [impenv_make_svarlst]

(* ****** ****** *)

extern
fun impenv_free (env: impenv): void
implement
impenv_free (env) = let
in
//
case+ env of
| ~IMPENVcons (_, _, env) => impenv_free (env) | ~IMPENVnil () => ()
//
end // end of [impenv_free]

(* ****** ****** *)

extern
fun impenv2stasub (env: impenv): stasub
implement
impenv2stasub
  (env) = let
//
fun aux (
  sub: &stasub, env: impenv
) : void = let
in
  case+ env of
  | ~IMPENVcons
      (s2v, s2f, env) => let
      val s2e = s2hnf2exp (s2f)
      val () = stasub_add (sub, s2v, s2e)
    in
      aux (sub, env)
    end // end of [IMPENVcons]
  | ~IMPENVnil () => ()
end // end of [aux]
//
var sub
  : stasub = stasub_make_nil ()
val () = aux (sub, env)
//
in
  sub
end // end of [impenv2stasub]

(* ****** ****** *)

local

fun aux (
  env: !impenv
, s2f_pat: s2hnf
, s2f_arg: s2hnf
) : bool = let
//
val s2e_pat = s2hnf2exp (s2f_pat)
val s2e_arg = s2hnf2exp (s2f_arg)
val s2en_pat = s2e_pat.s2exp_node
//
in
//
case+ s2en_pat of
| S2Evar (s2v) => let
    val s2f = impenv_find (env, s2v)
  in
    if s2hnf_is_err (s2f) then let
      val () = impenv_update (env, s2v, s2f_arg)
    in
      true
    end else
      s2hnf_syneq (s2f, s2f_arg)
    // end of [if]
  end // end of [S2Evar]
//
| _ => false
//
end // end of [aux]

fun auxlst (
  env: !impenv, s2es_pat: s2explst, s2es_arg: s2explst
) : bool = let
in
//
case+ s2es_pat of
| list_cons (
    s2e_pat, s2es_pat
  ) => (
    case+ s2es_arg of
    | list_cons (
        s2e_arg, s2es_arg
      ) => let
         val s2f_pat = s2exp2hnf (s2e_pat)
         val s2f_arg = s2exp2hnf (s2e_arg)
         val ans = aux (env, s2f_pat, s2f_arg)
       in
         if ans then auxlst (env, s2es_pat, s2es_arg) else false
       end // end of [list_cons]
     | list_nil () => true // HX: deadcode
  ) // end of [list_cons]
| list_nil () => true
//
end // end of [auxlst]

in // in of [local]

implement
hiimpdec_match (
  impdec, d2c0, t2mas
) = let
//
fun auxlstlst (
  env: !impenv, s2ess: s2explstlst, t2mas: t2mpmarglst
) : bool = let
in
//
case+ s2ess of
| list_cons (s2es, s2ess) => (
    case+ t2mas of
    | list_cons (t2ma, t2mas) => let
        val ans =
          auxlst (env, s2es, t2ma.t2mpmarg_arg)
        // end of [val]
      in
        if ans then auxlstlst (env, s2ess, t2mas) else false
      end // end of [list_cons]
    | list_nil () => true // HX: deadcode
  ) // end of [list_cons]
| list_nil () => true
//
end // end of [auxlstlst]
//
val d2c = impdec.hiimpdec_cst
//
in
//
if d2c = d2c0 then let
  val env =
    impenv_make_svarlst (impdec.hiimpdec_imparg)
  // end of [val]
  val ans = auxlstlst (env, impdec.hiimpdec_tmparg, t2mas)
in
  if ans then
    Some_vt (impenv2stasub (env))
  else let
    val () = impenv_free (env) in None_vt ()
  end // end of [if]
end else None_vt () // end of [if]
//
end // end of [hiimpdec_match]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_template.dats] *)
