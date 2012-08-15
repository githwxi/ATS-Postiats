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
// Start Time: March, 2011
//
(* ****** ****** *)

staload SYM = "pats_symbol.sats"

(* ****** ****** *)

abstype filename_type

typedef
filename = filename_type
viewtypedef
filenameopt_vt = Option_vt (filename)

(* ****** ****** *)

fun theDirSep_get
  (): char = "patsopt_filename_theDirSep_get"
// end of [theDirSep_get]

fun theCurDir_get (): string // current directory
fun theParDir_get (): string // parent directory

(* ****** ****** *)
//
// HX-2012-08:
// 0/1: intepreted locally/externally
// 
fun path_get_srchknd (path: string): int

(* ****** ****** *)

fun fprint_filename
  (out: FILEref, fil: filename): void
overload fprint with fprint_filename
fun print_filename (fil: filename): void
overload print with print_filename
fun prerr_filename (fil: filename): void
overload prerr with prerr_filename

fun fprint_filename_full
  (out: FILEref, fil: filename): void
fun print_filename_full (fil: filename): void

(* ****** ****** *)

fun filename_get_part (fil: filename): string
fun filename_get_full (fil: filename): $SYM.symbol

(* ****** ****** *)

fun filename_merge (
  fil: string, bas: string
) : strptr1 = "patsopt_filename_merge"
fun filename_append (
  dir: string, bas: string
) :<> strptr1 = "patsopt_filename_append"

(* ****** ****** *)

fun eq_filename_filename
  (x1: filename, x2: filename):<> bool

fun compare_filename_filename
  (x1: filename, x2: filename):<> Sgn
overload compare with compare_filename_filename

(* ****** ****** *)

val filename_dummy : filename (* dummy *)

(* ****** ****** *)

fun filename_is_relative (name: string): bool

(* ****** ****** *)

fun filename_get_current (): filename

(* ****** ****** *)

absview
the_filenamelst_push_v

fun the_filenamelst_pop
  (pf: the_filenamelst_push_v | (*none*)): void

fun the_filenamelst_push
  (fil: filename): (the_filenamelst_push_v | void)
// end of [the_filenamelst_push]

fun the_filenamelst_push_check
  (fil: filename): (the_filenamelst_push_v | bool)
// end of [the_filenamelst_push_check]

fun the_filenamelst_ppush (fil: filename): void // permanent

fun fprint_the_filenamelst (out: FILEref): void

(* ****** ****** *)

typedef path = string

absview the_pathlst_push_v

fun the_pathlst_pop
  (pf: the_pathlst_push_v | (*none*)): void
fun the_pathlst_push (p: path): (the_pathlst_push_v | void)

fun the_prepathlst_push (p: path): void

(* ****** ****** *)

fun filename_make
  (part: string, full: string) : filename
// end of [filename_make]

fun filenameopt_make_local (name: string): filenameopt_vt
fun filenameopt_make_relative (name: string): filenameopt_vt

(* ****** ****** *)

(* end of [pats_filename.sats] *)
