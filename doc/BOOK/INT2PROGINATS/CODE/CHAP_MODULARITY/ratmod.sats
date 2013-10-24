(*
** Copyright (C) 2011 Hongwei Xi, Boston University
**
** Permission is hereby granted, free of charge, to any person
** obtaining a copy of this software and associated documentation
** files (the "Software"), to deal in the Software without
** restriction, including without limitation the rights to use,
** copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following
** conditions:
**
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)

(*
** A package for rational numbers
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)

abst@ype rat = (int, int)

(* ****** ****** *)

exception Denominator
exception DivisionByZero

(* ****** ****** *)

fun rat_make_int_int (p: int, q: int): rat

(* ****** ****** *)
//
fun fprint_rat (out: FILEref, x: rat): void
//
overload fprint with fprint_rat
//
(* ****** ****** *)

fun rat_numer (x: rat): int // numerator of [x]
fun rat_denom (x: rat): int // denominator of [x]

(* ****** ****** *)

fun ratneg: (rat) -> rat // negation
fun ratadd: (rat, rat) -> rat // addition
fun ratsub: (rat, rat) -> rat // subtraction
fun ratmul: (rat, rat) -> rat // multiplication
fun ratdiv: (rat, rat) -> rat // division

(* ****** ****** *)

(* end of [ratmono.sats] *)
