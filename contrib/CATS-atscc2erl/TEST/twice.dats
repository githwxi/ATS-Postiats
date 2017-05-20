(* ****** ****** *)
//
// HX-2015-07:
// A running example
// from ATS2 to Erlang
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

%{^
%%
-module(twice_dats).
%%
-export([main0_erl/0]).
%%
-compile(nowarn_unused_vars).
-compile(nowarn_unused_function).
%%
-include("./libatscc2erl/libatscc2erl_all.hrl").
%%
%} // end of [%{]

(* ****** ****** *)
//
#define
LIBATSCC2ERL_targetloc
"$PATSHOME\
/contrib/libatscc2erl/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2ERL}/staloadall.hats"
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
main0_erl
(
// argumentless
) : void = "mac#main0_erl"
//
implement
main0_erl () =
{
val Z = 0
val S = lam (x: int): int =<cloref1> x + 1
//
val ans0 = twice<I0>(S)(Z)
val ((*void*)) = println! ("ans0(2) = ", ans0)
//
val ans1 = twice<I1>(twice<I0>)(S)(Z)
val ((*void*)) = println! ("ans1(4) = ", ans1)
//
val ans2 = twice<I2>(twice<I1>)(twice<I0>)(S)(Z)
val ((*void*)) = println! ("ans2(16) = ", ans2)
//
val ans3 = twice<I3>(twice<I2>)(twice<I1>)(twice<I0>)(S)(Z)
val ((*void*)) = println! ("ans3(65536) = ", ans3)
//
} (* end of [main0_erl] *)

(* ****** ****** *)

(* end of [twice.dats]  *)
