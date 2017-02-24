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
staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/athread.sats"

(* ****** ****** *)

staload "./../SATS/nwaiter.sats"

(* ****** ****** *)
//
datavtype
nwaiter () =
{l1,l2:agz} NWAITER of (int, spin(l1), mutex(l2))
//
(* ****** ****** *)

assume nwaiter_vtype (i) = nwaiter ()

(* ****** ****** *)

implement
{}(*tmp*)
nwaiter_create_exn
  ((*void*)) = let
//
val spn = spin_create_exn ()
val mtx = mutex_create_exn ()
//
in
  NWAITER(0(*n*), spn, mtx)
end // end of [nwaiter_create_exn]

(* ****** ****** *)

implement
{}(*tmp*)
nwaiter_destroy
  (nw) = () where
{
//
val+~NWAITER(n, spn, mtx) = nw
//
val spn = unsafe_spin_t2vt (spn)
val ((*freed*)) = spin_vt_destroy (spn)
val mtx = unsafe_mutex_t2vt (mtx)
val ((*freed*)) = mutex_vt_destroy (mtx)
//
} (* end of [nwaiter_destroy] *)

(* ****** ****** *)

implement
{}(*tmp*)
nwaiter_initiate (nw) = let
//
val+@NWAITER(n, spn, mtx) = nw
//
val () = n := 1
val (pf | ()) = mutex_lock (mtx)
prval () = $UN.castview0 (pf)
//
prval ((*void*)) = fold@ (nw)
//
in
  $UN.castvwtp1{nwaiter_ticket}(nw)
end // end of [nwaiter_initiate]

(* ****** ****** *)

implement
{}(*tmp*)
nwaiter_waitfor (nw) = let
//
val+NWAITER(n, spn, mtx) = nw
//
val (pf | ()) = mutex_lock (mtx)
val ((*void*)) = mutex_unlock (pf | mtx)
//
in
  // nothing
end // end of [nwaiter_waitfor]

(* ****** ****** *)

implement
{}(*tmp*)
nwaiter_ticket_put
  (nwt) = () where
{
(*
val () = println! ("nwaiter_ticket_put")
*)
val nw =
$UN.castvwtp0{nwaiter(1)}(nwt)
val+@NWAITER (n, spn, mtx) = nw
//
val (pf | ()) = spin_lock (spn)
val () = n := n - 1
val ((*void*)) = spin_unlock (pf | spn)
(*
val () = println! ("nwaiter_ticket_put(aft): n = ", n)
*)
val () =
if (0 >= n) then let
  prval pf =
  __assert (mtx) where
  {
    extern praxi __assert {l:addr} (!mutex(l)): locked_v(l)
  } (* end of [prval] *)
in
  mutex_unlock (pf | mtx)
end else () // end of [if]
//
prval () = fold@ (nw)
prval () = $UN.castview0{void}(nw)
//
} (* end of [nwaiter_ticket_put] *)

(* ****** ****** *)

implement
{}(*tmp*)
nwaiter_ticket_split
  (nwt) = let
//
val nw =
$UN.castvwtp1{nwaiter(1)}(nwt)
val+@NWAITER (n, spn, mtx) = nw
//
val (pf | ()) = spin_lock (spn)
val () = n := n + 1
val ((*void*)) = spin_unlock (pf | spn)
//
prval ((*folded*)) = fold@ (nw)
//
in
  $UN.castvwtp0{nwaiter_ticket}(nw)
end // end of [nwaiter_ticket_split]

(* ****** ****** *)

(* end of [nwaiter.dats] *)
