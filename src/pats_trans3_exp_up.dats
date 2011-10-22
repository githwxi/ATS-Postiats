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

staload LOC = "pats_location.sats"
macdef print_location = $LOC.print_location

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fun d2exp_trup_bool
  (d2e0: d2exp, b: bool): d3exp = let
  val loc0 = d2e0.d2exp_loc
  val s2f = s2exp_bool_bool_t0ype (b) in d3exp_bool (loc0, s2f, b)
end // end of [d2exp_trup_bool]

fun d2exp_trup_char
  (d2e0: d2exp, c: char): d3exp = let
  val loc0 = d2e0.d2exp_loc
  val s2f = s2exp_char_char_t0ype (c) in d3exp_char (loc0, s2f, c)
end // end of [d2exp_trup_char]

(* ****** ****** *)

implement
d2exp_trup
  (d2e0) = let
//
  val loc0 = d2e0.d2exp_loc
//
(*
val () = begin
  print "d2exp_trup: loc0 = "; print_location loc0; print_newline ()
end // end of [val]
*)
//
val d3e0 = (
case+ d2e0.d2exp_node of
//
| D2Ebool (b(*bool*)) => d2exp_trup_bool (d2e0, b)
| D2Echar (c(*char*)) => d2exp_trup_char (d2e0, c)
//
| _ => let val () = assertloc (false) in exit (1) end
//
) : d3exp // end of [val]
in
//
d3e0 // the return value
//
end // end of [d2exp_trup]

(* ****** ****** *)

implement
d2explst_trup
  (d2es) = l2l (list_map_fun (d2es, d2exp_trup))
// end of [d2explst_trup]

implement
d2explstlst_trup
  (d2ess) = l2l (list_map_fun (d2ess, d2explst_trup))
// end of [d2explstlst_trup]

(* ****** ****** *)

(* end of [pats_trans3_exp_up.dats] *)
