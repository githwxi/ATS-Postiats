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
// Start Time: May, 2011
//
(* ****** ****** *)

staload "pats_errmsg.sats"

(* ****** ****** *)

implement{}
prerr_interror () = {
  val () = prerr "INTERROR("
  val () = prerr_FILENAME<> ()
  val () = prerr ")"
}
implement{}
prerr_interror_loc (loc) = {
  val () = $LOC.prerr_location (loc)
  val () = prerr ": INTERROR("
  val () = prerr_FILENAME<> ()
  val () = prerr ")"
} // end of [prerr_interror_loc]

(* ****** ****** *)

implement{}
prerr_error1_loc (loc) = (
  $LOC.prerr_location loc; prerr ": error(1)"
) // end of [prerr_error1_loc]

implement{}
prerr_error2_loc (loc) = (
  $LOC.prerr_location loc; prerr ": error(2)"
) // end of [prerr_error2_loc]

implement{}
prerr_error3_loc (loc) = (
  $LOC.prerr_location loc; prerr ": error(3)"
) // end of [prerr_error3_loc]

(* ****** ****** *)

(* end of [pats_errmsg.dats] *)
