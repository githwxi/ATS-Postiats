(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2012-2018 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM
** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
** THE SOFTWARE.
** 
*)

(* ****** ****** *)

(*
** HX-2018-01-09:
** Some timing functions
*)

(* ****** ****** *)
//
#staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload
TIME =
"libats/libc/SATS/time.sats"
#staload
STDLIB =
"libats/libc/SATS/stdlib.sats"
//
(* ****** ****** *)

#staload "./../SATS/timing.sats"

(* ****** ****** *)

implement
{}(*tmp*)
time_spent$show
  (time) =
(
println!
("The time spent: ", time, "(sec)")
) (* end of [time_spent_add$show] *)

(* ****** ****** *)

implement
{}(*tmp*)
time_spent_add$show
  (time) =
(
println!
("The time spent: ", time, "(sec)")
) (* end of [time_spent_add$show] *)

(* ****** ****** *)

implement
{a}(*tmp*)
time_spent_cloptr
  (f0) =
  result where
{
//
val f1 =
$UN.castvwtp1{cfun0(a)}(f0)
val result = time_spent_cloref<a>(f1)
val ((*freed*)) =
  cloptr_free{void}($UN.castvwtp0(f0))
//
} (* end of [time_spent_cloptr] *)

implement
{a}(*tmp*)
time_spent_cloref
  (f0) =
  result where
{
//
val clock0 =
$UN.cast{double}($TIME.clock())
//
val result = f0()
//
val clock1 =
$UN.cast{double}($TIME.clock())
//
val tspent =
(clock1-clock0) /
$UN.cast{double}($TIME.CLOCKS_PER_SEC)
//
val ((*void*)) = time_spent$show<>(tspent)
//
} (* end of [time_spent_cloref] *)

(* ****** ****** *)
//
implement
{a}(*tmp*)
time_spent_add_cloptr
  (f0, time) =
  result where
{
//
val f1 =
$UN.castvwtp1{cfun0(a)}(f0)
val result =
time_spent_add_cloref<a>(f1, time)
val ((*freed*)) =
  cloptr_free{void}($UN.castvwtp0(f0))
//
} (* end of [time_spent_add_cloptr] *)
//
implement
{a}(*tmp*)
time_spent_add_cloref
  (f0, time) =
  result where
{
//
val clock0 =
$UN.cast{double}($TIME.clock())
//
val result = f0()
//
val clock1 =
$UN.cast{double}($TIME.clock())
//
val tspent =
(clock1-clock0) /
$UN.cast{double}($TIME.CLOCKS_PER_SEC)
//
val ((*void*)) = (time := time + tspent)
//
val ((*void*)) = time_spent_add$show<>(time)
//
} (* end of [time_spent_add_cloref] *)
//
(* ****** ****** *)

(* end of [timing.dats] *)
