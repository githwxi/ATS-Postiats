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
// Start Time: March, 2011
//
(* ****** ****** *)

abstype filename_type
typedef filename = filename_type

(* ****** ****** *)

fun theDirSep_get
  (): char = "atsopt_filename_theDirSep_get"
fun theCurentDir_get
  (): string = "atsopt_filename_theCurentDir_get"
fun theParentDir_get
  (): string = "atsopt_filename_theParentDir_get"

(* ****** ****** *)

fun fprint_filename
  (out: FILEref, fil: filename): void
overload fprint with fprint_filename

fun print_filename (fil: filename): void
overload print with print_filename

(* ****** ****** *)

fun filename_get_current (): filename

(* ****** ****** *)

fun filename_is_relative (name: string): bool

(* ****** ****** *)

(* end of [pats_filename.sats] *)


