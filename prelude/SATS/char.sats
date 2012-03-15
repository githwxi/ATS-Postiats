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

fun lt_char1_char1
  {c1,c2:int} (
  c1: char (c1), c2: char (c2)
) :<> bool (c1 < c2) = "mac#atspre_lt_char1_char1"
fun lte_char1_char1
  {c1,c2:int} (
  c1: char (c1), c2: char (c2)
) :<> bool (c1 <= c2) = "mac#atspre_lte_char1_char1"
overload < with lt_char1_char1 of 2
overload <= with lte_char1_char1 of 2

fun gt_char1_char1
  {c1,c2:int} (
  c1: char (c1), c2: char (c2)
) :<> bool (c1 > c2) = "mac#atspre_gt_char1_char1"
fun gte_char1_char1
  {c1,c2:int} (
  c1: char (c1), c2: char (c2)
) :<> bool (c1 >= c2) = "mac#atspre_gte_char1_char1"
overload > with gt_char1_char1 of 2
overload >= with gte_char1_char1 of 2

fun eq_char1_char1
  {c1,c2:int} (
  c1: char (c1), c2: char (c2)
) :<> bool (c1 == c2) = "mac#atspre_eq_char1_char1"
fun neq_char1_char1
  {c1,c2:int} (
  c1: char (c1), c2: char (c2)
) :<> bool (c1 != c2) = "mac#atspre_neq_char1_char1"
overload = with eq_char1_char1 of 2
overload <> with neq_char1_char1 of 2
overload != with neq_char1_char1 of 2

(* ****** ****** *)

fun compare_char1_char1
  {c1,c2:int} (
  c1: char c2, c2: char c2
) :<> int (c1-c2)
  = "mac#atspre_compare_char1_char1"
overload compare with compare_char1_char1 of 2

(* ****** ****** *)
//
// unsigned characters
//
(* ****** ****** *)

fun lt_uchar_uchar
  (c1: uchar, c2: uchar):<> bool = "mac#atspre_lt_uchar_uchar"
overload < with lt_uchar_uchar of 0
fun lte_uchar_uchar
  (c1: uchar, c2: uchar):<> bool  = "mac#atspre_lte_uchar_uchar"
overload <= with lte_uchar_uchar of 0

fun gt_uchar_uchar
  (c1: uchar, c2: uchar):<> bool = "mac#atspre_gt_uchar_uchar"
overload > with gt_uchar_uchar of 0
fun gte_uchar_uchar
  (c1: uchar, c2: uchar):<> bool  = "mac#atspre_gte_uchar_uchar"
overload >= with gte_uchar_uchar of 0

fun eq_uchar_uchar
  (c1: uchar, c2: uchar):<> bool = "mac#atspre_eq_uchar_uchar"
overload = with eq_uchar_uchar of 0
fun neq_uchar_uchar
  (c1: uchar, c2: uchar):<> bool = "mac#atspre_neq_uchar_uchar"
overload <> with neq_uchar_uchar of 0
overload != with neq_uchar_uchar of 0

fun compare_uchar_uchar
  (c1: uchar, c2: uchar):<> int = "mac#atspre_compare_uchar_uchar"
overload compare with compare_uchar_uchar of 0

(* ****** ****** *)

fun{knd:t@ype}
g0int_of_char (c: char): g0int (knd)
fun{knd:t@ype}
g0int_of_schar (c: schar): g0int (knd)
fun{knd:t@ype}
g0int_of_uchar (c: uchar): g0int (knd)

fun{knd:t@ype}
g0uint_of_uchar (c: uchar): g0uint (knd)

(* ****** ****** *)

fun{knd:t@ype}
g1int_of_char1 // c:int8
  {c:int} (c: char (c)):<> g1int (knd, c)
// end of [g1int_of_char1]
fun{knd:t@ype}
g1int_of_schar1 // c:int8
  {c:int} (c: schar (c)):<> g1int (knd, c)
// end of [g1int_of_schar1]
fun{knd:t@ype}
g1int_of_uchar1 // c:uint8
  {c:int} (c: uchar (c)):<> g1int (knd, c)
// end of [g1int_of_uchar1]

(*
** HX: g1uint_of_schar1: schar -> int -> uint
*)
fun{knd:t@ype}
g1uint_of_uchar1
  {c:int} (c: uchar (c)):<> g1uint (knd, c)
// end of [g1uint_of_uchar1]

(* ****** ****** *)

fun isalpha (c: int):<> bool = "atspre_isalpha"
fun isalnum (c: int):<> bool = "atspre_isalnum"

fun isascii (c: int):<> bool = "atspre_isascii"

fun isblank (c: int):<> bool = "atspre_isblank"
fun isspace (c: int):<> bool = "atspre_isspace"

fun iscntrl (c: int):<> bool = "atspre_iscntrl"

fun isdigit (c: int):<> bool = "atspre_isdigit"
fun isxdigit (c: int):<> bool = "atspre_isxdigit"

fun isgraph (c: int):<> bool = "atspre_isgraph"
fun isprint (c: int):<> bool = "atspre_isprint"
fun ispunct (c: int):<> bool = "atspre_ispunct"

fun islower (c: int):<> bool = "atspre_islower"
fun isupper (c: int):<> bool = "atspre_isupper"

fun toascii (c: int):<> bool = "atspre_toascii"

fun tolower (c: int):<> bool = "atspre_tolower"
fun toupper (c: int):<> bool = "atspre_toupper"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [char.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [char.sats] *)
