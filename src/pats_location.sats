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
// Start Time: March, 2011
//
(* ****** ****** *)

%{#
#include "pats_location.cats"
%} // end of [%{#]

(* ****** ****** *)

staload
FIL = "./pats_filename.sats"
typedef filename = $FIL.filename

(* ****** ****** *)

abst@ype
position_t0ype =
$extype "pats_position_struct"
typedef position = position_t0ype

(* ****** ****** *)

fun fprint_position
  (out: FILEref, pos: position): void
overload fprint with fprint_position

fun print_position (pos: position): void
overload print with print_position

(* ****** ****** *)

fun position_get_ntot
  (pos: &position): lint // total char offset
fun position_get_nrow (pos: &position): int // line number
fun position_get_ncol (pos: &position): int // line offset

(* ****** ****** *)

fun position_init (
  pos0: &position? >> position, ntot: lint, nrow: int, ncol: int
) : void // end of [position_init]

fun position_copy (
  pos0: &position? >> position, pos1: &position
) : void // end of [position_copy]

(* ****** ****** *)

fun position_incby_char (pos: &position, i: int): void

fun position_decby_count (pos: &position, n: uint): void
fun position_incby_count (pos: &position, n: uint): void

(* ****** ****** *)

abstype location_type
typedef location = location_type

(* ****** ****** *)

(*
** HX: returning the beginning char count
*)
fun location_get_bchar (loc: location): lint

(* ****** ****** *)

fun location_beg_ntot (loc: location): lint // beg char count
fun location_end_ntot (loc: location): lint // end char count

(* ****** ****** *)

fun location_get_filename (loc: location): filename

(* ****** ****** *)
//
fun print_location (loc: location): void
fun prerr_location (loc: location): void
fun fprint_location (out: FILEref, loc: location): void
//
overload print with print_location
overload prerr with prerr_location
overload fprint with fprint_location
//
(* ****** ****** *)

fun fprint_location2 (out: FILEref, loc: location): void

(* ****** ****** *)

val location_dummy : location (* dummy location *)

(* ****** ****** *)

fun location_make_pos_pos (
  pos1: position, pos2: position
) : location // end of [location_make_pos_pos]

fun location_make_fil_pos_pos (
  fil: filename, pos1: position, pos2: position
) : location // end of [location_make_fil_pos_pos]

(* ****** ****** *)

fun location_leftmost (loc: location): location
fun location_rightmost (loc: location): location

(* ****** ****** *)

fun location_combine
  (loc1: location, loc2: location): location
// end of [location_combine]

(* ****** ****** *)

fun fprint_line_pragma (out: FILEref, loc: location): void

(* ****** ****** *)

(* end of [pats_location.sats] *)
