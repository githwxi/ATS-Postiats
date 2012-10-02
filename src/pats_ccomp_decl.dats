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
// Start Time: October, 2012
//
(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_typerase.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

extern
fun hivardec_ccomp_sta (
  env: !ccompenv, res: !instrseq, level: int, hvd: hivardec
) : primdec // end of [hivardec_ccomp_sta]

(* ****** ****** *)

implement
hidecl_ccomp
  (env, res, hdc) = let
in
//
case+ hdc of
| _ => exitloc (1)
//
end // end of [hidecl_ccomp]

(* ****** ****** *)

implement
hideclist_ccomp
  (env, res, hdcs) = let
//
fun loop (
  env: !ccompenv
, res: !instrseq
, hdcs: hideclist
, pmds: &primdeclst_vt? >> primdeclst_vt
) : void = let
in
//
case+ hdcs of
| list_cons
    (hdc, hdcs) => let
    val pmd =
      hidecl_ccomp (env, res, hdc)
    val () = pmds := list_vt_cons {..}{0} (pmd, ?)
    val list_vt_cons (_, !p_pmds) = pmds
    val () = loop (env, res, hdcs, !p_pmds)
    val () = fold@ (pmds)
  in
    // nothing
  end // end of [list_cons]
| list_nil () => let
    val () = pmds := list_vt_nil () in (*nothing*)
  end // end of [list_nil]
//
end // end of [loop]
//
var pmds: primdeclst_vt
val () = loop (env, res, hdcs, pmds)
//
in
//
list_of_list_vt (pmds)
//
end // end of [hideclist_ccomp]

(* ****** ****** *)

implement
hivardec_ccomp_sta (
  env, res, level, hvd
) = let
//
val loc = hvd.hivardec_loc
val d2v = hvd.hivardec_dvar_ptr
val d2vw = hvd.hivardec_dvar_view
val loc_d2v = d2var_get_loc (d2v)
val () = d2var_set_level (d2v, level)
val s2at = d2var_get_type_some (loc_d2v, d2vw)
val- S2Eat (s2e_elt, _) = s2at.s2exp_node
val hse_elt = s2exp_tyer_shallow (loc_d2v, s2e_elt)
val tmp = tmpvar_make (loc_d2v, hse_elt)
val () = (
  case+ hvd.hivardec_ini of
  | Some (hde) => hidexp_ccomp_ret (env, res, hde, tmp) | None () => ()
) : void // end of [val]
//
in
  primdec_vardec (loc, d2v)
end // end of [hivardec_ccomp_sta]

(* ****** ****** *)

(* end of [pats_ccomp_decl.dats] *)
