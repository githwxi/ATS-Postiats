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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: September, 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_typerase.sats"

(* ****** ****** *)

implement
p3at_tyer (p3t0) = let
//
val loc0 = p3t0.p3at_loc
val s2e0 = p3at_get_type (p3t0)
val hse0 = s2exp_tyer_shallow (loc0, s2e0)
//
(*
val () = println! ("p3at_tyer: p3t0 = ", p3t0)
val () = println! ("p3at_tyer: s2e0 = ", s2e0)
val () = println! ("p3at_tyer: hse0 = ", hse0)
*)
//
in
//
case+ p3t0.p3at_node of
//
| P3Tann (p3t, s2e_ann) => let
    val hip = p3at_tyer (p3t)
    val hse_ann = s2exp_tyer_shallow (loc0, s2e_ann)
  in
    hipat_ann (loc0, hse0, hip, hse_ann)
  end // end of [P3Tann]
//
| _ => exitloc (1)
//
end // endof [p3at_tyer]

(* ****** ****** *)

implement
d3exp_tyer (d3e0) = let
in
  exitloc (1)
end // endof [d3exp_tyer]

(* ****** ****** *)

(* end of [pats_typerase_dynexp.dats] *)
