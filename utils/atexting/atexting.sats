(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)
//
abstype
filename_type = ptr
typedef
filename = filename_type
typedef fil_t = filename
//
fun
fprint_filename : fprint_type(fil_t)
//
overload fprint with fprint_filename
//
(* ****** ****** *)
//
typedef
position =
@{
, pos_ntot= int
, pos_nrow= int
, pos_ncol= int
} (* end of [position] *)
//
fun
fprint_position
(
  out: FILEref, pos: &position
) : void // end-of-function
//
overload fprint with fprint_position
//
fun position_byrow(&position >> _): void
//
fun position_incby_1(&position >> _): void
fun position_incby_n(&position >> _, n: intGte(0)): void
fun position_decby_n(&position >> _, n: intGte(0)): void
//
overload .incby with position_incby_1
overload .incby with position_incby_n
//
overload .decby with position_decby_n
//
(* ****** ****** *)

fun position_incby_char(&position >> _, c: int): void

(* ****** ****** *)
//
abstype
location_type = ptr
typedef
location = location_type
typedef loc_t = location
//
fun
fprint_location : fprint_type(loc_t)
//
overload fprint with fprint_location
//
(* ****** ****** *)

(* end of [atexting.sats] *)
