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

(* ****** ****** *)

staload "./pats_ccomp.sats"

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
fun s2var_s2hnf_ismat
  (s2v: s2var, s2f: s2hnf): bool
implement
s2var_s2hnf_ismat
  (s2v, s2f) = let
  val s2e = s2hnf2exp (s2f)
in
//
case+ s2e.s2exp_node of
| S2Evar (s2v1) => s2v = s2v1 | _ => false
//
end // end of [s2var_s2hnf_ismat]

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
    val s2e = s2exp_var (s2v)
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
fun tmparg_match
  (env: !impenv, s2e_pat: s2exp, s2e_arg: s2exp): bool
implement
tmparg_match (
  env, s2e_pat, s2e_arg
) = let
//
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
    val ismat = s2var_s2hnf_ismat (s2v, s2f)
  in
    if ismat then let
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
//
val s2f_pat = s2exp2hnf (s2e_pat)
val s2f_arg = s2exp2hnf (s2e_arg)
//
in
  aux (env, s2f_pat, s2f_arg)
end // end of [tmparg_match]

(* ****** ****** *)

(* end of [pats_ccomp_template.dats] *)
