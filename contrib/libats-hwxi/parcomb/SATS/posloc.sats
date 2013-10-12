(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2002-2008 Hongwei Xi, Boston University
**
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
(*
** For recording
** location information on concrete syntax
*)
//
// Author: Hongwei Xi
// Authoremail: hwxiATcsDOTbuDOTedu
// Start Time: December 2008
//
(* ****** ****** *)
//
// Ported to ATS2 by HX-2013-10
//
(* ****** ****** *)

abstype filename_type = ptr
typedef filename = filename_type

(* ****** ****** *)

fun print_filename (filename): void
overload print with print_filename
fun prerr_filename (filename): void
overload prerr with prerr_filename
fun fprint_filename (out: FILEref, fil: filename): void
overload fprint with fprint_filename

(* ****** ****** *)

fun filename_make_string (name: string): filename

(* ****** ****** *)
//
val filename_none: filename
val filename_stdin: filename
//
fun filename_pop (): void
fun filename_push (x: filename): void
//
fun filename_get_current (): filename
//
(* ****** ****** *)

abstype position_type = ptr
typedef position = position_type

(* ****** ****** *)

fun position_line (p: position):<> int
fun position_loff (p: position):<> int
fun position_toff (p: position):<> lint

(* ****** ****** *)

fun fprint_position
  (fil: FILEref, pos: position): void
overload fprint with fprint_position
fun print_position (pos: position): void = "lexing_print_position"
overload print with print_position
fun prerr_position (pos: position): void = "lexing_prerr_position"
overload prerr with prerr_position

(* ****** ****** *)

val position_origin: position
fun position_next (p: position, c: char):<> position

fun lt_position_position (p1: position, p2: position):<> bool
overload < with lt_position_position
fun lte_position_position (p1: position, p2: position):<> bool
overload <= with lte_position_position

fun eq_position_position (p1: position, p2: position):<> bool
overload = with eq_position_position
fun neq_position_position (p1: position, p2: position):<> bool
overload <> with neq_position_position

(* ****** ****** *)

abstype location_type = ptr
typedef location = location_type

(* ****** ****** *)

val location_none: location
fun location_make (position, position): location
fun location_combine (location, location): location

fun print_location (location): void
overload print with print_location
fun prerr_location (location): void
overload prerr with prerr_location
fun fprint_location (out: FILEref, loc: location): void
overload fprint with fprint_location

(* ****** ****** *)

(* end of [posloc.sats] *)
