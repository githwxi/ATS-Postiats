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
// An array-based channel
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"libats/SATS/athread.sats"
staload
"libats/SATS/deqarray.sats"
//
(* ****** ****** *)
//
staload "./../SATS/channel_t.sats"
//
(* ****** ****** *)
//
datatype
channel = {
l1,l2,l3:agz
} CHANNEL of
(
  ptr(*buf*)
, size_t(*cap*)
, mutex(l1), condvar(l2), condvar(l3)
) (* end of [channel] *)
//
(* ****** ****** *)

assume channel_type(a:vt0p) = channel

(* ****** ****** *)

implement
{a}(*tmp*)
channel_create_exn
  (cap) = let
//
val mut = mutex_create_exn()
//
val CVisnil = condvar_create_exn()
val CVisful = condvar_create_exn()
//
val deq =
  deqarray_make_cap<a>(cap)
//
val deq = $UN.castvwtp0{ptr}(deq)
//
in
  CHANNEL(deq, cap, mut, CVisnil, CVisful)
end // end of [channel_create_exn]

(* ****** ****** *)
//
implement
{}(*tmp*)
channel_get_capacity
  (chan) = let
//
val+CHANNEL(ptr, cap, _, _, _) = chan in cap
//
end // end of [channel_get_capacity]
//
(* ****** ****** *)
//
extern
fun{a:vt0p}
channel_insert_buf
  (channel(a), !deqarray(a) >> _, a): void
//
extern
fun{a:vt0p}
channel_takeout_buf
  (chan: channel(a), !deqarray(a) >> _): (a)
//
(* ****** ****** *)

implement
{a}(*tmp*)
channel_insert
  (chan, x0) = let
//
val+
CHANNEL{l1,l2,l3}
(
deq, cap, mut, CVisnil, CVisful
) = chan // end of [val]
//
val
(pfmut | ()) = mutex_lock(mut)
//
val
deq =
$UN.castvwtp0{deqarray(a)}((pfmut|deq))
//
val ((*void*)) =
  channel_insert_buf<a>(chan, deq, x0)
//
prval
pfmut = $UN.castview0{locked_v(l1)}(deq)
//
val ((*void*)) = mutex_unlock(pfmut | mut)
//
in
  // nothing
end // end of [channel_insert]

(* ****** ****** *)

implement
{a}(*tmp*)
channel_insert_opt
  (chan, x0) = opt where
{
//
val+
CHANNEL{l1,l2,l3}
(
deq, cap, mut, CVisnil, CVisful
) = chan // end of [val]
//
val
(pfmut | ()) = mutex_lock(mut)
//
val
deq =
$UN.castvwtp0{deqarray(a)}((pfmut|deq))
//
val
isnot = deqarray_isnot_full<a>(deq)
//
prval
((*void*)) = lemma_deqarray_param(deq)
//
val opt =
(
if
isnot
then let
  val isnil =
    deqarray_is_nil{a}(deq)
  val ((*void*)) =
    deqarray_insert_atend<a>(deq, x0)
  val ((*void*)) =
    if isnil then condvar_broadcast(CVisnil)
  // end of [val]
in
  None_vt()
end (* end of [then] *)
else Some_vt(x0)
) : Option_vt(a) // end of [val]
//
prval
pfmut =
$UN.castview0{locked_v(l1)}(deq)
//
val ((*void*)) = mutex_unlock(pfmut | mut)
//
} (* end of [channel_insert_opt] *)

(* ****** ****** *)

implement
{a}(*tmp*)
channel_insert_buf
  (chan, deq, x0) = let
//
val+
CHANNEL{l1,l2,l3}
(
ptr, cap, mut, CVisnil, CVisful
) = chan // end of [val]
//
val
isnot = deqarray_isnot_full<a>(deq)
//
prval
((*void*)) = lemma_deqarray_param(deq)
//
in
//
if
isnot
then let
  val isnil =
    deqarray_is_nil{a}(deq)
  val ((*void*)) =
    deqarray_insert_atend<a>(deq, x0)
  val ((*void*)) =
    if isnil then condvar_broadcast(CVisnil)
  // end of [val]
in
  // nothing
end // end of [then]
else let
  prval
  (pfmut, fpf) =
  __assert((*void*)) where
  {
    extern
    praxi
    __assert
    (
    // argless
    ) : vtakeout0(locked_v(l1))
  }
  val ((*void*)) =
  condvar_wait(pfmut | CVisful, mut)
  prval ((* returned *)) = fpf(pfmut)
in
  channel_insert_buf<a>(chan, deq, x0)
end // end of [else]
//
end // end of [channel_insert_buf]

(* ****** ****** *)

implement
{a}(*tmp*)
channel_takeout
  (chan) = x0_out where
{
//
val+
CHANNEL{l1,l2,l3}
(
deq, cap, mut, CVisnil, CVisful
) = chan // end of [val]
//
val (pfmut | ()) = mutex_lock(mut)
//
val
deq =
$UN.castvwtp0{deqarray(a)}((pfmut|deq))
//
val
x0_out = channel_takeout_buf<a>(chan, deq)
//
prval
pfmut =
$UN.castview0{locked_v(l1)}(deq)
//
val ((*void*)) = mutex_unlock(pfmut | mut)
//
} (* end of [channel_takeout] *)

(* ****** ****** *)

implement
{a}(*tmp*)
channel_takeout_opt
  (chan) = opt where
{
//
val+
CHANNEL{l1,l2,l3}
(
deq, cap, mut, CVisnil, CVisful
) = chan // end of [val]
//
val (pfmut | ()) = mutex_lock(mut)
//
val
deq =
$UN.castvwtp0{deqarray(a)}((pfmut|deq))
//
val
isnot = deqarray_isnot_nil{a}(deq)
prval
((*void*)) = lemma_deqarray_param(deq)
//
val opt =
(
if
isnot
then let
  val isful =
    deqarray_is_full<a>(deq)
  val x0_out =
    deqarray_takeout_atbeg<a>(deq)
  val ((*void*)) =
    if isful then condvar_broadcast(CVisful)
  // end of [val]
in
  Some_vt(x0_out)
end // end of [then]
else None_vt((*void*))
) : Option_vt(a) // end of [val]
//
prval
pfmut =
$UN.castview0{locked_v(l1)}(deq)
//
val ((*void*)) = mutex_unlock(pfmut | mut)
//
} (* end of [channel_takeout_opt] *)

(* ****** ****** *)

implement
{a}(*tmp*)
channel_takeout_buf
  (chan, deq) = let
//
val+
CHANNEL{l1,l2,l3}
(
ptr, cap, mut, CVisnil, CVisful
) = chan // end of [val]
//
val
isnot = deqarray_isnot_nil{a}(deq)
prval
((*void*)) = lemma_deqarray_param(deq)
//
in
//
if
isnot
then let
  val isful =
    deqarray_is_full<a>(deq)
  val x0_out =
    deqarray_takeout_atbeg<a>(deq)
  val ((*void*)) =
    if isful then condvar_broadcast(CVisful)
  // end of [val]
in
  x0_out
end // end of [then]
else let
  prval
  (pfmut, fpf) =
  __assert((*void*)) where
  {
    extern
    praxi
    __assert
    (
    // argless
    ) : vtakeout0(locked_v(l1))
  }
  val ((*void*)) =
  condvar_wait(pfmut | CVisnil, mut)
  prval ((* returned *)) = fpf(pfmut)
in
  channel_takeout_buf<a>(chan, deq)
end // end of [else]
//
end // end of [channel_takeout_buf]

(* ****** ****** *)

(* end of [channel_t.dats] *)
