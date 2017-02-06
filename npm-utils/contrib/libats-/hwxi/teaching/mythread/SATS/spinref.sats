(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
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
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// HX-2014-05:
// This is based on spinlock
//
(* ****** ****** *)
//
abstype
spinref_type(a:vt@ype) = ptr
//
typedef
spinref(a:vt0p) = spinref_type(a)
//
(* ****** ****** *)
//
fun
{a:vt0p}
spinref_create_exn(x0: a): spinref(a)
//
(* ****** ****** *)
//
fun{a:t0p} spinref_get(spnr: spinref(a)): (a)
//
(* ****** ****** *)
//
fun{
a:vt0p
} spinref_process(spnr: spinref(a)): void
fun{
a:vt0p}{env:vt0p
} spinref_process_env
  (spnr: spinref(a), env: &(env) >> _): void
//
fun{
a:vt0p}{env:vt0p
} spinref_process$fwork(x: &a >> _, env: &(env) >> _): void
//
(* ****** ****** *)

(* end of [spinref.sats] *)
