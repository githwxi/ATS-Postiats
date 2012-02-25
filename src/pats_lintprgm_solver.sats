(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Anairiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2008 Hongwei Xi, Boston University
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
// Time: February 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_intinf.sats"

(* ****** ****** *)

abst@ype myint = int

(* ****** ****** *)

val myint_0 : myint
val myint_1 : myint
val myint_neg_1 : myint

fun myint_make_int (x: int): myint
fun myint_make_intinf (x: intinf): myint

(* ****** ****** *)

fun neg_myint (x: myint):<> myint
overload ~ with neg_myint

fun succ_myint (x: myint):<> myint
fun pred_myint (y: myint):<> myint
overload succ with succ_myint
overload pred with pred_myint

fun add_myint_myint (x: myint, y: myint):<> myint
fun sub_myint_myint (x: myint, y: myint):<> myint
overload + with add_myint_myint
overload - with sub_myint_myint

fun mul_myint_myint (x: myint, y: myint):<> myint
fun div_myint_myint (x: myint, y: myint):<> myint
overload * with mul_myint_myint
overload / with div_myint_myint

(* ****** ****** *)

fun lt_myint_int (x: myint, y: int):<> bool
and lte_myint_int (x: myint, y: int):<> bool
overload < with lt_myint_int
overload <= with lte_myint_int

fun gt_myint_int (x: myint, y: int):<> bool
and gte_myint_int (x: myint, y: int):<> bool
overload > with gt_myint_int
overload >= with gte_myint_int

fun eq_myint_int (x: myint, y: int):<> bool
and neq_myint_int (x: myint, y: int):<> bool
overload = with eq_myint_int
overload != with neq_myint_int

(* ****** ****** *)

fun lt_myint_myint (x: myint, y: myint):<> bool
and lte_myint_myint (x: myint, y: myint):<> bool
overload < with lt_myint_myint
overload <= with lte_myint_myint

fun gt_myint_myint (x: myint, y: myint):<> bool
and gte_myint_myint (x: myint, y: myint):<> bool
overload > with gt_myint_myint
overload >= with gte_myint_myint

(* ****** ****** *)

fun mod_myint_myint (x: myint, y: myint):<> myint
overload mod with mod_myint_myint
fun gcd_myint_myint (x: myint, y: myint):<> myint
overload gcd with gcd_myint_myint

(* ****** ****** *)

fun fprint_myint: fprint_type (myint)
fun print_myint (x: myint): void
fun prerr_myint (x: myint): void

(* ****** ****** *)

absviewtype myintvobj (n: int)

fun fprint_myintvobj {n:nat}
  (out: FILEref, x: !myintvobj(n), n: int n): void
fun print_myintvobj
  {n:nat} (x: !myintvobj(n), n: int n): void
fun prerr_myintvobj
  {n:nat} (x: !myintvobj(n), n: int n): void

(* ****** ****** *)

dataviewtype icnstr (int) =
  | {n:int}
    // knd: gte/lt: 2/~2; eq/neq: 1/~1
    ICvec (n) of (int(*knd*), myintvobj n)
  | {n:int}
    // knd:conj/disj: 0/1
    ICveclst (n) of (int(*knd*), icnstrlst (n))
// end of [icstr]

where icnstrlst (n:int) = List_vt (icnstr(n))

(* ****** ****** *)

fun icnstrlst_free {n:int} (xs: icnstrlst n): void

(* ****** ****** *)

fun fprint_icnstr {n:int}
  (out: FILEref, ic: !icnstr(n), n: int n): void
fun print_icnstr
  {n:int} (ic: !icnstr(n), n: int n): void
fun prerr_icnstr
  {n:int} (ic: !icnstr(n), n: int n): void

fun fprint_icnstrlst
  {n:int}{s:int} (
  out: FILEref, ics: !list_vt (icnstr(n), s), n: int n
) : void // end of [fprint_icnstrlst]
fun print_icnstrlst {n:int}{s:int}
  (ics: !list_vt (icnstr(n), s), n: int n): void
fun prerr_icnstrlst {n:int}{s:int}
  (ics: !list_vt (icnstr(n), s), n: int n): void

(* ****** ****** *)
//
// HX: 0/~1: unsolved constraints/contradiction reached
//
fun icnstrlst_solve
  {n:pos} (ics: &icnstrlst n, n: int n): [i:int | i <= 0] int(i)
// end of [icnstrlst_solve]

(* ****** ****** *)

(* end of [pats_lintprgm_solver.sats] *)
