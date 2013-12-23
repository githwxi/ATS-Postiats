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
** A record-based functorial
** package for rational numbers
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)

exception Denominator
exception DivisionByZero

(* ****** ****** *)

abst@ype rat (a:t@ype) = (a, a)

(* ****** ****** *)

typedef
intmod (a:t@ype) = '{
  ofint= int -> a
, fprint= (FILEref, a) -> void
, neg= (a) -> a // negation
, add= (a, a) -> a // addition
, sub= (a, a) -> a // subtraction
, mul= (a, a) -> a // multiplication
, div= (a, a) -> a // division
, mod= (a, a) -> a // modulo
, cmp= (a, a) -> int // comparison
} // end of [intmod]

typedef
ratmod (a:t@ype) = '{
  make= (a, a) -<cloref1> rat a
, fprint= (FILEref, rat a) -<cloref1> void
, numer= rat a -> a // numerator
, denom= rat a -> a // denominator
, neg= (rat a) -<cloref1> rat a // negation
, add= (rat a, rat a) -<cloref1> rat a // addition
, sub= (rat a, rat a) -<cloref1> rat a // subtraction
, mul= (rat a, rat a) -<cloref1> rat a // multiplication
, div= (rat a, rat a) -<cloref1> rat a // division
, cmp= (rat a, rat a) -<cloref1> int // comparison
} // end of [ratmod]

(* ****** ****** *)

fun{a:t@ype}
ratmod_make_intmod (int: intmod a): ratmod a

(* ****** ****** *)

(* end of [ratfun_rec.sats] *)
