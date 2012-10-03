(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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
** Source:
** $PATSHOME/prelude/SATS/CODEGEN/tfprint.atxt
** Time of generation: Wed Oct  3 01:47:25 2012
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: August, 2012 *)

(* ****** ****** *)

sortdef t0p = t@ype

(* ****** ****** *)

fun{}
tfprint$out (): FILEref

(* ****** ****** *)

fun{a:t0p}
tfprint (x: a): void

(* ****** ****** *)

fun{}
tfprint_newline (): void

(* ****** ****** *)

fun{}
tfprint_list$sep (): string
fun{}
tfprint_list$beg (): string
fun{}
tfprint_list$end (): string

fun{a:t0p}
tfprint_list (xs: List (a)): void

(* ****** ****** *)

fun{}
tfprint_array$sep (): string
fun{}
tfprint_array$beg (): string
fun{}
tfprint_array$end (): string

fun{a:t0p}
tfprint_array
  {n:int} (A: &(@[a][n]), n: size_t n): void
// end of [tfprint_array]
fun{a:t0p}
tfprint_arrayptr
  {n:int} (A: !arrayptr (a, n), n: size_t n): void
// end of [tfprint_arrayptr]
fun{a:t0p}
tfprint_arrayref
  {n:int} (A: arrayref (a, n), n: size_t n): void
// end of [tfprint_arrayref]

(* ****** ****** *)

(* end of [tfprint.sats] *)
