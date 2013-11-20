(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
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
// A simple channel implementation
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/deqarray.sats"

(* ****** ****** *)

staload "./../SATS/mythread.sats"

(* ****** ****** *)
//
staload "./../SATS/channel.sats"
//
(* ****** ****** *)
//
datatype
channel =
{l1,l2,l3:agz}
CHANNEL of (ptr(*buffer*), mutex(l1), condvar(l2), condvar(l3))
//
(* ****** ****** *)

assume channel_type (a:vt0p) = channel

(* ****** ****** *)

implement{a}
channel_create_exn (cap) = let
//
val deq = deqarray_make_cap<a> (cap)
val mut = mutex_create_exn ()
val CVisnil = condvar_create_exn ()
val CVisful = condvar_create_exn ()
//
in
  CHANNEL ($UN.castvwtp0{ptr}(deq), mut, CVisnil, CVisful)
end // end of [channel_create_exn]

(* ****** ****** *)

extern
fun{a:vt0p}
channel_insert2 (channel(a), !deqarray(a) >> _, a): void

(* ****** ****** *)

implement{a}
channel_insert
  (chan, x0) = let
//
val+CHANNEL{l1,l2,l3}
  (deq, mut, CVisnil, CVisful) = chan
val (pfmut | ()) = mutex_lock (mut)
val deq =
  $UN.castvwtp0{deqarray(a)}((pfmut | deq))
val ((*void*)) = channel_insert2<a> (chan, deq, x0)
prval pfmut = $UN.castview0{mutex_v(l1)}(deq)
val ((*void*)) = mutex_unlock (pfmut | mut)
//
in
  // nothing
end // end of [channel_insert]

(* ****** ****** *)

implement{a}
channel_insert2
  (chan, deq, x0) = let
//
val+CHANNEL{l1,l2,l3}
  (ptr, mut, CVisnil, CVisful) = chan
//
val isnot = deqarray_isnot_full (deq)
prval ((*void*)) = lemma_deqarray_param (deq)
//
in
//
if isnot
  then let
    val isnil = deqarray_is_nil (deq)
    val ((*void*)) = deqarray_insert_atend (deq, x0)
    val ((*void*)) = condvar_signal (CVisnil)
  in
    // nothing
  end // end of [then]
  else let
    prval (pfmut, fpf) = __assert () where
    {
      extern praxi __assert (): vtakeout0(mutex_v(l1))
    }
    val ((*void*)) = condvar_wait (pfmut | CVisful, mut)
    prval ((*void*)) = fpf (pfmut)
  in
    channel_insert2 (chan, deq, x0)
  end // end of [else]
//
end // end of [channel_insert2]

(* ****** ****** *)

extern
fun{a:vt0p}
channel_takeout2 (channel(a), !deqarray(a) >> _): (a)

(* ****** ****** *)

implement{a}
channel_takeout
  (chan) = x0 where
{
//
val+CHANNEL{l1,l2,l3}
  (deq, mut, CVisnil, CVisful) = chan
val (pfmut | ()) = mutex_lock (mut)
val deq =
  $UN.castvwtp0{deqarray(a)}((pfmut | deq))
val x0 = channel_takeout2<a> (chan, deq)
prval pfmut = $UN.castview0{mutex_v(l1)}(deq)
val ((*void*)) = mutex_unlock (pfmut | mut)
//
} // end of [channel_takeout2]

(* ****** ****** *)

implement{a}
channel_takeout2
  (chan, deq) = let
//
val+CHANNEL{l1,l2,l3}
  (ptr, mut, CVisnil, CVisful) = chan
//
val isnot = deqarray_isnot_nil (deq)
prval ((*void*)) = lemma_deqarray_param (deq)
//
in
//
if isnot
  then let
    val isful = deqarray_is_full (deq)
    val x0 = deqarray_takeout_atbeg (deq)
    val ((*void*)) = condvar_signal (CVisful)
  in
    x0
  end // end of [then]
  else let
    prval (pfmut, fpf) = __assert () where
    {
      extern praxi __assert (): vtakeout0(mutex_v(l1))
    }
    val ((*void*)) = condvar_wait (pfmut | CVisnil, mut)
    prval ((*void*)) = fpf (pfmut)
  in
    channel_takeout2 (chan, deq)
  end // end of [else]
//
end // end of [channel_takeout2]

(* ****** ****** *)

(* end of [channel.dats] *)
