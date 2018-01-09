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
typedef
cfun0(a:vt0p) = () -<cloref1> a
//
(* ****** ****** *)
//
fun{}
time_spent$show(time: double): void
//
fun
{a:vt0p}
time_spent_cloptr
(f0: ((*void*)) -<cloptr1> (a)): (a)
fun
{a:vt0p}
time_spent_cloref
(f0: ((*void*)) -<cloref1> (a)): (a)
//
(* ****** ****** *)
//
fun{}
time_spent_add$show(time: double): void
//
(* ****** ****** *)
fun
{a:vt0p}
time_spent_add_cloptr
(f0: () -<cloptr1> (a), time: &double >> _): a
fun
{a:vt0p}
time_spent_add_cloref
(f0: () -<cloref1> (a), time: &double >> _): a
//
(* ****** ****** *)

(* end of [timing.sats] *)
