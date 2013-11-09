(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
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
** Example:
** A simple example of higher-order functions
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: May 10, 2013
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

typedef I (a:t@ype) = a -<cloref1> a

(* ****** ****** *)

fn{a:t0p}
twice (f: I(a)):<cloref> I(a) = lam (x) => f (f (x))

(* ****** ****** *)

typedef I0 = int
typedef I1 = I(I0)
typedef I2 = I(I1)
typedef I3 = I(I2)

(* ****** ****** *)
//
val Z = 0
val S = lam (x: int): int =<cloref> x + 1
//
val ans0 = twice<I0>(S)(Z)
val ans1 = twice<I1>(twice<I0>)(S)(Z)
val ans2 = twice<I2>(twice<I1>)(twice<I0>)(S)(Z)
val ans3 = twice<I3>(twice<I2>)(twice<I1>)(twice<I0>)(S)(Z)
//
(* ****** ****** *)

implement
main0 () =
{
//
val () = println! ("ans0 = ", ans0)
val () = println! ("ans1 = ", ans1)
val () = println! ("ans2 = ", ans2)
val () = println! ("ans3 = ", ans3)
//
} // end of [main0]

(* ****** ****** *)

(* end of [twice.dats]  *)
