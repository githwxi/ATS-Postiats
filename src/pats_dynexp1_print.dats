(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Start Time: April, 2011
//
(* ****** ****** *)

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload SYM = "pats_symbol.sats"
macdef fprint_symbol = $SYM.fprint_symbol

(* ****** ****** *)

staload "pats_syntax.sats"
staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"

(* ****** ****** *)

implement
fprint_d1ecl
  (out, d1c0) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ d1c0.d1ecl_node of
| D1Cnone () => prstr "D1Cnone()"
//
| D1Cinclude (xs) => {
    val () = prstr "D1Cinclude(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_d1ecl)
    val () = prstr "\n)"
  }
//
| D1Cdatsrts (xs) => {
    val () = prstr "D1Cdatsrts(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_d1atsrtdec)
    val () = prstr "\n)"
  }
| D1Csrtdefs (xs) => {
    val () = prstr "D1Csrtdefs(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1rtdef)
    val () = prstr "\n)"
  }
//
| D1Cstacsts (xs) => {
    val () = prstr "D1Cstacsts(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1tacst)
    val () = prstr "\n)"
  }
| D1Cstacons (knd, xs) => {
    val () = prstr "D1Cstacons("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1tacon)
    val () = prstr "\n)"
  }
| D1Cstavars (xs) => {
    val () = prstr "D1Cstavars(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1tavar)
    val () = prstr "\n)"
  }
//
| D1Csexpdefs (knd, xs) => {
    val () = prstr "D1Csexpdefs("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1expdef)
    val () = prstr "\n)"
  }
| D1Csaspdec (x) => {
    val () = prstr "D1Csaspdec("
    val () = fprint_s1aspdec (out, x)
    val () = prstr ")"
  }
//
| D1Cdatdecs (knd, xs1, xs2) => {
    val () = prstr "D1Cdatdecs("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = prstr "..."
    val () = prstr "\n)"
  }
| D1Cexndecs (xs) => {
    val () = prstr "D1Cexndecs(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_e1xndec)
    val () = prstr "\n)"
  }
//
| D1Cdcstdecs (dck, qarg, xs) => {
    val () = prstr "D1Cdcstdecs("
    val () = fprint_dcstkind (out, dck)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_d1cstdec)
    val () = prstr "\n)"
  }
//
| D1Clocal (
    ds_head, ds_body
  ) => {
    val () = prstr "D1Clocal(\n"
    val () = fprint_d1eclist (out, ds_head)
    val () = prstr "\n(*in*)\n"
    val () = fprint_d1eclist (out, ds_body)
    val () = prstr "\n)"
  }
//
  | _ => prstr "D1C...(...)"
end // end of [fprint_d1ecl]

implement
fprint_d1eclist (out, xs) = $UT.fprintlst (out, xs, "\n", fprint_d1ecl)

(* ****** ****** *)

(* end of [pats_dynexp1_print.dats] *)
