(* ****** ****** *)
//
// HX-2017-10:
// A running example
// from ATS2 to R(stat)
//
(* ****** ****** *)
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
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
LIBATSCC2R34_targetloc
"$PATSHOME/contrib/libatscc2r34"
//
(* ****** ****** *)
//
#staload
"{$LIBATSCC2R34}/SATS/integer.sats"
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
extern
fun
main_r34 (): void = "mac#main_r34"
//
implement
main_r34 () =
{
val Z = 0
val S = lam (x: int): int =<cloref1> x + 1
//
val ans0 =
twice<I0>(S)(Z)
val ((*void*)) =
$extfcall(void, "message", "ans0(2) = ", ans0)
//
val ans1 =
twice<I1>(twice<I0>)(S)(Z)
val ((*void*)) =
$extfcall(void, "message", "ans1(4) = ", ans1)
//
val ans2 =
twice<I2>
(twice<I1>)(twice<I0>)(S)(Z)
val ((*void*)) =
$extfcall(void, "message", "ans2(16) = ", ans2)
//
val ans3 =
twice<I3>
(twice<I2>)(twice<I1>)(twice<I0>)(S)(Z)
val ((*void*)) = 
$extfcall(void, "message", "ans3(65536) = ", ans3)
//
} (* end of [main_r34] *)

(* ****** ****** *)

%{^
######
options(expressions=100000);
######
if
(
!(exists("libatscc2r34.is.loaded"))
)
{
  assign("libatscc2r34.is.loaded", FALSE)
}
######
if
(
!(libatscc2r34.is.loaded)
)
{
  sys.source("./libatscc2r34/libatscc2r34_all.R")
}
######
%} // end of [%{^]

(* ****** ****** *)

%{$
######
main_r34()
######
%} // end of [%{$]

(* ****** ****** *)

(* end of [twice.dats]  *)
