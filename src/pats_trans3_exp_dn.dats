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

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_exp_dn"

(* ****** ****** *)

staload LOC = "pats_location.sats"
macdef print_location = $LOC.print_location

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload SOL = "pats_staexp2_solve.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
d2exp_trdn (d2e0, s2f0) = let
(*
*)
in
//
case+ d2e0 of
| _ => d2exp_trdn_rest (d2e0, s2f0)
//
end // end of [d2exp_trdn]

(* ****** ****** *)

implement
d2exp_trdn_rest
  (d2e0, s2f0) = let
  val loc0 = d2e0.d2exp_loc
  val d3e0 = d2exp_trup (d2e0)
(*
  var iswth: int = 0
  val s2f0: s2hnf =
    if s2exp_is_wth s2f0 then let
      val () = iswth := 1; val () = d3exp_open_and_add d3e0
    in
      s2exp_wth_instantiate (loc0, s2f0)
    end else begin
      s2f0 // not a type with state
    end // end of [if]
*)
  val d3e0 = d3exp_trdn (d3e0, s2f0)
(*
  val () = if iswth > 0 then funarg_varfin_check (loc0)
*)
in
  d3e0
end // end of [d2exp_trdn_rest]

(* ****** ****** *)

implement
d2explst_trdn_elt (d2es, s2f) = let
  var !p_clo = @lam
    (pf: !unit_v | d2e: d2exp): d3exp =<clo1> d2exp_trdn (d2e, s2f)
  // end of [var]
  prval pfu = unit_v
  val d3es = list_map_vclo<d2exp><d3exp> {unit_v} (pfu | d2es, !p_clo)
  prval unit_v () = pfu
in
  l2l (d3es)
end // end of [d2explst_trdn_elt]

(* ****** ****** *)

(* end of [pats_trans3_exp_dn.dats] *)
