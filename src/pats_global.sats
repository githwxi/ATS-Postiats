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
// Start Time: August, 2012
//
(* ****** ****** *)

fun the_PACKNAME_get (): Stropt
fun the_PACKNAME_set (opt: Stropt): void
fun the_PACKNAME_set_none (): void
fun the_PACKNAME_set_name (ns: string): void

(* ****** ****** *)

fun the_ATSRELOC_get (): int
fun the_ATSRELOC_set (flag: int): void
fun the_ATSRELOC_get_decl (): ptr
fun the_ATSRELOC_set_decl (d0c: ptr): void

(* ****** ****** *)

(*
//
// HX-2014-06-06:
// [STALOADFLAG] is no longer in use
//
fun the_STALOADFLAG_get (): int
fun the_STALOADFLAG_set (flag: int): void
*)

(* ****** ****** *)

fun the_DYNLOADFLAG_get (): int
fun the_DYNLOADFLAG_set (flag: int): void

(* ****** ****** *)

fun the_DYNLOADNAME_get (): stropt
fun the_DYNLOADNAME_set (name: string): void

(* ****** ****** *)

fun the_MAINATSFLAG_get (): int
fun the_MAINATSFLAG_set (flag: int): void

(* ****** ****** *)

fun the_STATIC_PREFIX_get (): stropt
fun the_STATIC_PREFIX_set (name: string): void

(* ****** ****** *)
//
fun the_IATS_dirlst_get (): List (string)
//
// HX: ppush: permanent push
//
fun the_IATS_dirlst_ppush (dir: string):<!ref> void
//
(* ****** ****** *)
//
fun the_DEBUGATS_dbgflag_get (): int
fun the_DEBUGATS_dbgflag_set (flag: int): void
//
fun the_DEBUGATS_dbgline_get (): int
fun the_DEBUGATS_dbgline_set (flag: int): void
//
(* ****** ****** *)
//
// HX-2015-04-26:
// for managing tail-call optimization
//
fun the_CCOMPATS_tlcalopt_get (): int
fun the_CCOMPATS_tlcalopt_set (flag: int): void
//
(* ****** ****** *)

fun the_CCOMPENV_maxtmprecdepth_get (): int
fun the_CCOMPENV_maxtmprecdepth_set (mtd: int): void

(* ****** ****** *)

(* end of [pats_global.sats] *)
