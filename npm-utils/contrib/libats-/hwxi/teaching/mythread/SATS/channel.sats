(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// HX-2013-11:
// An array-based channel for ATS
//
(* ****** ****** *)
//
abstype
channel_type(a:vt@ype) = ptr
typedef
channel(a:vt0p) = channel_type(a)
//
(* ****** ****** *)

fun
{a:vt0p}
channel_create_exn
  (cap: sizeGte(1)): channel(a)

(* ****** ****** *)
//
fun{}
channel_get_capacity
  {a:vt0p}(channel(a)):<> Size_t
//
(* ****** ****** *)

fun
{a:vt0p}
channel_insert(channel(a), a): void
fun
{a:vt0p}
channel_takeout(chan: channel(a)): (a) 

(* ****** ****** *)
//
(*
fun
{a:vt0p}
channel_process(chan: channel(a)): bool
fun
{a:vt0p}
channel_process$fwork(x0: &(a) >> opt(a, b)): #[b:bool] bool(b)
*)
//
(* ****** ****** *)

(* end of [channel.sats] *)
