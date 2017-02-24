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

staload SYM = "./pats_symbol.sats"

(* ****** ****** *)

abstype filename_type

typedef
filename = filename_type
vtypedef
filenameopt_vt = Option_vt (filename)

(* ****** ****** *)

fun theDirSep_get
  (): char = "patsopt_filename_theDirSep_get"
// end of [theDirSep_get]

fun theParDir_get (): string // parent directory
fun theCurDir_get (): string // current directory

(* ****** ****** *)
//
// HX-2012-08:
// 0/1: intepreted locally/externally
// 
fun givename_srchknd (given: string): int
//
(* ****** ****** *)

fun givename_get_ngurl (given: string): int

(* ****** ****** *)

fun filename_get_givename (fil: filename): string
fun filename_get_partname (fil: filename): string
fun filename_get_fullname (fil: filename): $SYM.symbol

(* ****** ****** *)
(*
//
fun print_filename: filename -> void
fun prerr_filename: filename -> void
fun fprint_filename : (FILEref, filename) -> void
//
overload print with print_filename
overload prerr with prerr_filename
overload fprint with fprint_filename
//
*)
(* ****** ****** *)

fun print_filename_full (fil: filename): void
fun prerr_filename_full (fil: filename): void
fun fprint_filename_full (out: FILEref, fil: filename): void

(* ****** ****** *)

fun fprint2_filename_full (out: FILEref, fil: filename): void

(* ****** ****** *)

fun filename_merge
(
  fil: string, givename: string
) : Strptr1 = "patsopt_filename_merge"

fun filename_append
(
  dir: string, givename: string
) :<> Strptr1 = "patsopt_filename_append"

(* ****** ****** *)

fun eq_filename_filename
  (x1: filename, x2: filename):<> bool

fun compare_filename_filename
  (x1: filename, x2: filename):<> Sgn
overload compare with compare_filename_filename

(* ****** ****** *)
//
val filename_dummy : filename (* DUMMY *)
//
val filename_stdin : filename (* STDIN *)
val filename_string : filename (* STRING *)
//
(* ****** ****** *)

fun filename_is_dummy : filename -> bool
fun filename_isnot_dummy : filename -> bool

(* ****** ****** *)

fun filename_is_sats (fil: filename): bool
fun filename_is_dats (fil: filename): bool

(* ****** ****** *)
//
fun filename_get_current((*void*)): filename
//
(* ****** ****** *)
//
absview
the_filenamelst_push_v
//
fun the_filenamelst_pop
  (pf: the_filenamelst_push_v | (*none*)): void
//
fun the_filenamelst_push
  (fil: filename): (the_filenamelst_push_v | void)
// end of [the_filenamelst_push]
//
fun the_filenamelst_push_check
  (fil: filename): (the_filenamelst_push_v | bool)
// end of [the_filenamelst_push_check]
//
fun the_filenamelst_ppop(): void 
fun the_filenamelst_ppush(fil: filename): void
(*
// HX-2017-01-31: push from the back!
fun the_filenamelst_ppushb(fil: filename): void
//
*)
fun fprint_the_filenamelst (out: FILEref): void
//
(* ****** ****** *)
//
typedef path = string
typedef pathlst = List0(path)
//
(* ****** ****** *)
//
fun print_pathlst(xs: pathlst): void
fun prerr_pathlst(xs: pathlst): void
fun fprint_pathlst(out: FILEref, xs: pathlst): void
//
(* ****** ****** *)
//
fun path_normalize(s0: NSHARED(path)): path
fun path_normalize_vt(s0: NSHARED(path)): Strptr1
//
(* ****** ****** *)
//
absview
the_pathlst_push_v
//
(* ****** ****** *)
//
fun
the_pathlst_pop
(
  pf: the_pathlst_push_v | (*none*)
) : void // end-of-function
//
fun
the_pathlst_push
  (x: path): (the_pathlst_push_v | void)
//
// HX: permanent push
//
fun the_pathlst_ppush(x: path): void
//
(*
// HX: permanent push from the back!
fun the_pathlst_ppushb(x: path): void
*)
//
(* ****** ****** *)
//
fun
the_prepathlst_push
  (x: path): void = "ext#libatsopt_the_prepathlst_push"
//
(* ****** ****** *)
//
fun
filename_make
  (given: string, part: string, full: string): filename
//
(* ****** ****** *)
//
fun
pkgsrcname_relocatize (given: string, ngurl: int): string
//
(* ****** ****** *)
//
fun
filenameopt_make_local(name: string): filenameopt_vt
//
fun
filenameopt_make_relative
  (given: string, given2: &string? >> string): filenameopt_vt
//
(* ****** ****** *)
//
vtypedef
pathlst_vt = List0_vt(path)
//
fun the_PATSHOMELOCS_get_pathlst((*void*)): pathlst
//
(* ****** ****** *)

(* end of [pats_filename.sats] *)
