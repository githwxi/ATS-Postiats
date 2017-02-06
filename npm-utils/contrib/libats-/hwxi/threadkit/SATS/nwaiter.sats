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
// For waiting until the proofs for
// a predeterminted view are all uploaded
// in a piecewise manner.
// Note that this version does not use types
// to ensure a correct match between the uploaded
// proofs and the downloaded proof.
//
(* ****** ****** *)
//
absvtype
nwaiter_vtype (i:int) = ptr
vtypedef nwaiter(i:int) = nwaiter_vtype(i)
absvtype nwaiter_ticket_vtype = ptr
vtypedef nwaiter_ticket = nwaiter_ticket_vtype
//
(* ****** ****** *)
//
fun{}
nwaiter_create_exn (): nwaiter(0)
//
(* ****** ****** *)

fun{}
nwaiter_destroy (nw: nwaiter(0)): void

(* ****** ****** *)
//
fun{}
nwaiter_initiate
  (nw: !nwaiter(0) >> nwaiter(1)): nwaiter_ticket
//
(* ****** ****** *)
//
fun{}
nwaiter_waitfor (nw: !nwaiter(1) >> nwaiter(0)): void
//
(* ****** ****** *)
//
fun{}
nwaiter_ticket_put (nwt: nwaiter_ticket): void
fun{}
nwaiter_ticket_split
  (nwt: !nwaiter_ticket >> nwaiter_ticket): nwaiter_ticket
//
(* ****** ****** *)

(* end of [nwaiter.sats] *)
