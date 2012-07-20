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
// Start Time: June, 2012
//
(* ****** ****** *)
//
// HX: for handling macro expansion during typechecking
//
(* ****** ****** *)

staload ERR = "pats_error.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans2_dynexp"

(* ****** ****** *)

staload
STMP = "pats_stamp.sats"
typedef stamp = $STMP.stamp

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_dmacro2.sats"

(* ****** ****** *)

implement
liftval2exp
  (loc0, m2v) = let
in
  case+ m2v of
  | M2Vint (i) => d2exp_int (loc0, i)
  | M2Vchar (c) => d2exp_char (loc0, c)
  | M2Vfloat (rep) => d2exp_float (loc0, rep)
  | M2Vstring (s) => d2exp_string (loc0, s)
  | M2Vunit () => d2exp_empty (loc0)
  | _ => let
      val () = prerr_error2_loc (loc0)
      val () = prerr ": a value representing code (AST) cannot be lifted."
      val () = prerr_newline ()
    in
      d2exp_err (loc0)
    end // end of [_]
end // end of [lift_val_exp]

(* ****** ****** *)

local

dataviewtype alphenv = 
  | ALPHENVcons of (d2var, d2var(*new*), alphenv)
  | ALPHENVmark of (alphenv) // marking for unwinding
  | ALPHENVnil of ()
// end of [alphenv]

assume alphenv_viewtype = alphenv

in // in of [local]

implement
alphenv_free (env) = let
in
  case+ env of
  | ~ALPHENVcons
      (_, _, env) => alphenv_free (env)
  | ~ALPHENVmark env => alphenv_free (env)
  | ~ALPHENVnil () => ()
end // end of [alphenv_free]

implement
alphenv_insert
  (env, d2v, d2v_new) = let
in
  env := ALPHENVcons (d2v, d2v_new, env)
end // end of [alphaenv_add]

implement
alphenv_find
  (env, d2v0) = let
//
fun loop (
  env: !alphenv, d2v0: d2var
) : Option_vt (d2var) = let
in
//
case+ env of
| ALPHENVcons
    (_key, _val, !p_env1) => let
    val ans = (
      if d2v0 = _key then
        Some_vt (_val) else loop (!p_env1, d2v0)
      // end of [if]
    ) : Option_vt d2var // end of [val]
  in
    fold@ (env); ans
  end
| ALPHENVmark (!p_env1) => let
    val ans = loop (!p_env1, d2v0) in fold@ (env); ans
  end // end of [ALPHENVmark]
| ALPHENVnil () => let
    prval () = fold@ env in None_vt ()
  end // end of [ALPHENVnil]
end // end of [loop]
//
in
  loop (env, d2v0)
end // end of [alphenv_find]

implement
alphenv_pop (env) = let
//
fun loop
  (env: alphenv): alphenv = let
in
  case+ env of
  | ~ALPHENVcons
      (_, _, env) => loop (env)
  | ~ALPHENVmark (env) => (env)
  | ~ALPHENVnil () => ALPHENVnil ()
end // end of [loop]
//
in
  env := loop (env)
end // end of [alphaenv_pop]

implement
alphenv_push (env) = (env := ALPHENVmark env)

end // end of [local]

(* ****** ****** *)

implement
dmacro_eval_app_short
  (loc0, d2m, d2as) = let
in
  exitloc (1)
end // end of [dmacro_eval_app_short]

(* ****** ****** *)

(* end of [pats_dmacro2.dats] *)
