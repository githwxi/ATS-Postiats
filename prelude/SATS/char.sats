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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: September, 2011
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [char.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

fun lt_char_char
  (c1: char, c2: char):<> bool = "mac#atspre_lt_char_char"
overload < with lt_char_char of 0
fun lte_char_char
  (c1: char, c2: char):<> bool  = "mac#atspre_lte_char_char"
overload <= with lte_char_char of 0

fun gt_char_char
  (c1: char, c2: char):<> bool = "mac#atspre_gt_char_char"
overload > with gt_char_char of 0
fun gte_char_char
  (c1: char, c2: char):<> bool  = "mac#atspre_gte_char_char"
overload >= with gte_char_char of 0

fun eq_char_char
  (c1: char, c2: char):<> bool = "mac#atspre_eq_char_char"
overload = with eq_char_char of 0
fun neq_char_char
  (c1: char, c2: char):<> bool = "mac#atspre_neq_char_char"
overload <> with neq_char_char of 0
overload != with neq_char_char of 0

fun compare_char_char
  (c1: char, c2: char):<> int = "mac#atspre_compare_char_char"
overload compare with compare_char_char of 0

(* ****** ****** *)

fun fprint_char
  (out: FILEref, x: char): void
overload fprint with fprint_char

fun print_char (x: char): void
and prerr_char (x: char): void
overload print with print_char
overload prerr with prerr_char

(* ****** ****** *)
//
// HX: the return is dynamically allocated
//
fun tostring_char
  (c: char):<> strnptr(1) = "atspre_tostring_char"
overload tostring with tostring_char

(* ****** ****** *)
//
castfn
char1_of_schar1 {c:int} (c: schar (c)):<> char (c)
castfn
schar1_of_char1 {c:int} (c: char (c)):<> schar (c)
//
castfn
char1_of_uchar1 {c:int} (c: uchar (c)):<> char (u2i8(c))
castfn
uchar1_of_char1 {c:int} (c: char (c)):<> uchar (i2u8(c))
//
(* ****** ****** *)

fun{knd:t@ype}
g1int_of_schar1
  {c:int} (c: schar (c)):<> g1int (knd, c)
// end of [g1int_of_schar1]
fun{knd:t@ype}
g1int_of_uchar1
  {c:int} (c: uchar (c)):<> g1int (knd, u2i8(c))
// end of [g1int_of_uchar1]

(*
** HX: g1uint_of_schar1: schar -> int -> uint
*)
fun{knd:t@ype}
g1uint_of_uchar1
  {c:int} (c: uchar (c)):<> g1uint (knd, c)
// end of [g1uint_of_uchar1]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [char.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [char.sats] *)
