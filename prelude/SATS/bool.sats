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
#print "Loading [bool.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

castfn bool1_of_bool (x: bool):<> Bool
castfn bool1_of_bool0 (x: bool):<> Bool

(* ****** ****** *)

fun bool_of_int (i: int):<> bool
fun int_of_bool (b: bool):<> natLt(2) // that is, Two

fun bool1_of_int1 {i:int} (i: int i):<> bool (i != 0)
fun int1_of_bool1 {b:bool} (b: bool b):<> int (int_of_bool b)

(* ****** ****** *)

fun neg_bool
  (b: bool):<> bool = "mac#atspre_neg_bool"
overload ~ with neg_bool
overload not with neg_bool

fun add_bool_bool
  (b1: bool, b2: bool):<> bool = "mac#atspre_add_bool_bool"
overload || with add_bool_bool

fun mul_bool_bool
  (b1: bool, b2: bool):<> bool = "mac#atspre_mul_bool_bool"
overload && with mul_bool_bool

(* ****** ****** *)

fun lt_bool_bool
  (b1: bool, b2: bool):<> bool = "mac#atspre_lt_bool_bool"
and lte_bool_bool
  (b1: bool, b2: bool):<> bool = "mac#atspre_lte_bool_bool"
overload < with lt_bool_bool
overload <= with lte_bool_bool

fun gt_bool_bool
  (b1: bool, b2: bool):<> bool = "mac#atspre_gt_bool_bool"
and gte_bool_bool
  (b1: bool, b2: bool):<> bool = "mac#atspre_gte_bool_bool"
overload > with gt_bool_bool
overload >= with gte_bool_bool

fun eq_bool_bool
  (b1: bool, b2: bool):<> bool = "mac#atspre_eq_bool_bool"
and neq_bool_bool
  (b1: bool, b2: bool):<> bool = "mac#atspre_neq_bool_bool"
overload = with eq_bool_bool
overload <> with neq_bool_bool
overload != with neq_bool_bool

fun compare_bool_bool // HX: this one is a function
  (b1: bool, b2: bool):<> Sgn = "atspre_compare_bool_bool"
overload compare with compare_bool_bool

(* ****** ****** *)

fun fprint_bool
  (out: FILEref, x: bool): void
overload fprint with fprint_bool

fun print_bool (x: bool): void
and prerr_bool (x: bool): void
overload print with print_bool
overload prerr with prerr_bool

(* ****** ****** *)
//
// HX: the return is statically allocated
//
fun tostring_bool
  (b: bool):<> string = "atspre_tostring_bool"
overload tostring with tostring_bool

(* ****** ****** *)

fun neg_bool1 {b:bool}
  (b: bool b):<> bool (~b) = "mac#atspre_neg_bool1"
overload ~ with neg_bool1 of 1
overload not with neg_bool1 of 1

(* ****** ****** *)

fun add_bool1_bool0 {b1:bool}
  (b1: bool b1, b2: bool):<> [b:bool | b1 <= b] bool (b)
  = "mac#atspre_add_bool1_bool0"
overload || with add_bool1_bool0 of 1

fun add_bool0_bool1 {b2:bool}
  (b1: bool, b2: bool b2):<> [b:bool | b2 <= b] bool (b)
  = "mac#atspre_add_bool0_bool1"
overload || with add_bool0_bool1 of 1

fun add_bool1_bool1 {b1,b2:bool}
  (b1: bool b1, b2: bool b2):<> bool (b1 || b2)
  = "mac#atspre_add_bool1_bool1"
overload || with add_bool1_bool1 of 2

(* ****** ****** *)

fun mul_bool1_bool0 {b1:bool}
  (b1: bool b1, b2: bool):<> [b:bool | b <= b1] bool (b)
  = "mac#atspre_mul_bool1_bool0"
overload || with mul_bool1_bool0 of 1

fun mul_bool0_bool1 {b2:bool}
  (b1: bool, b2: bool b2):<> [b:bool | b <= b2] bool (b)
  = "mac#atspre_mul_bool0_bool1"
overload || with mul_bool0_bool1 of 1

fun mul_bool1_bool1 {b1,b2:bool}
  (b1: bool b1, b2: bool b2):<> bool (b1 && b2)
  = "mac#atspre_mul_bool1_bool1"
overload && with mul_bool1_bool1 of 2

(* ****** ****** *)

fun lt_bool1_bool1 {b1,b2:bool}
  (b1: bool b1, b2: bool b2):<> bool (b1 < b2) // ~b1 && b2
  = "mac#atspre_lt_bool1_bool1"
and lte_bool1_bool1 {b1,b2:bool}
  (b1: bool b1, b2: bool b2):<> bool (b1 <= b2) // ~b1 || b2
  = "mac#atspre_lte_bool1_bool1"
overload < with lt_bool1_bool1
overload <= with lte_bool1_bool1

fun gt_bool1_bool1 {b1,b2:bool}
  (b1: bool b1, b2: bool b2):<> bool (b1 > b2) // b1 && ~b2
  = "mac#atspre_gt_bool1_bool1"
and gte_bool1_bool1 {b1,b2:bool}
  (b1: bool b1, b2: bool b2):<> bool (b1 >= b2) // b1 || ~b2
  = "mac#atspre_gte_bool1_bool1"
overload > with gt_bool1_bool1
overload >= with gte_bool1_bool1

fun eq_bool1_bool1 {b1,b2:bool}
  (b1: bool b1, b2: bool b2):<> bool (b1 == b2)
  = "mac#atspre_eq_bool1_bool1"
and neq_bool1_bool1 {b1,b2:bool}
  (b1: bool b1, b2: bool b2):<> bool (b1 <> b2)
  = "mac#atspre_neq_bool1_bool1"
overload = with eq_bool1_bool1
overload <> with neq_bool1_bool1
overload != with neq_bool1_bool1

(* ****** ****** *)

fun compare_bool1_bool1
  {b1,b2:bool} // HX: this one is a function
  (b1: bool b1, b2: bool b2):<> int (int_of_bool b1 - int_of_bool b2)
  = "atspre_compare_bool1_bool1"
overload compare with compare_bool1_bool1

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [bool.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [bool.sats] *)
