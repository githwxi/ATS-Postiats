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
** A template-based functorial
** package for rational numbers
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)

abst@ype rat (a: t@ype) = (a, a)

(* ****** ****** *)

exception Denominator
exception DivisionByZero

(* ****** ****** *)

val{a:t@ype} ofint0: a // value templates
val{a:t@ype} ofint1: a // value templates
fun{a:t@ype} ofint: int -> a

(* ****** ****** *)

fun{a:t@ype} fprint_int (out: FILEref, x: a): void

(* ****** ****** *)

fun{a:t@ype} intneg: a -> a
fun{a:t@ype} intadd: (a, a) -> a
fun{a:t@ype} intsub: (a, a) -> a
fun{a:t@ype} intmul: (a, a) -> a
fun{a:t@ype} intdiv: (a, a) -> a

fun{a:t@ype} intmod: (a, a) -> a
fun{a:t@ype} intgcd: (a, a) -> a

(* ****** ****** *)

fun{a:t@ype} intlt: (a, a) -> bool
fun{a:t@ype} intlte: (a, a) -> bool
fun{a:t@ype} intgt: (a, a) -> bool
fun{a:t@ype} intgte: (a, a) -> bool
fun{a:t@ype} inteq: (a, a) -> bool
fun{a:t@ype} intneq: (a, a) -> bool

fun{a:t@ype} intcmp: (a, a) -> int

(* ****** ****** *)

fun{a:t@ype}
rat_make_int_int (p: int, q: int): rat a

fun{a:t@ype}
rat_make_numer_denom (p: a, q: a): rat a

(* ****** ****** *)

fun{a:t@ype}
fprint_rat (out: FILEref, x: rat a): void

(* ****** ****** *)

fun{a:t@ype} rat_numer (x: rat a): a
fun{a:t@ype} rat_denom (x: rat a): a

(* ****** ****** *)

fun{a:t@ype} ratneg: (rat a) -> rat a
fun{a:t@ype} ratadd: (rat a, rat a) -> rat a
fun{a:t@ype} ratsub: (rat a, rat a) -> rat a
fun{a:t@ype} ratmul: (rat a, rat a) -> rat a
fun{a:t@ype} ratdiv: (rat a, rat a) -> rat a

(* ****** ****** *)

fun{a:t@ype} ratlt: (rat a, rat a) -> bool
fun{a:t@ype} ratlte: (rat a, rat a) -> bool
fun{a:t@ype} ratgt: (rat a, rat a) -> bool
fun{a:t@ype} ratgte: (rat a, rat a) -> bool
fun{a:t@ype} rateq: (rat a, rat a) -> bool
fun{a:t@ype} ratneq: (rat a, rat a) -> bool

fun{a:t@ype} ratcmp: (rat a, rat a) -> int

(* ****** ****** *)

(* end of [ratfun_tmp.sats] *)
