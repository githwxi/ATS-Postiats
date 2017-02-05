(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2015 Hongwei Xi, ATS Trustful Software, Inc.
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
// HX-2015-01:
// An array-based linear channel
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "libats/SATS/athread.sats"
//
staload "libats/SATS/deqarray.sats"
//
(* ****** ****** *)

staload "./../SATS/channel_vt.sats"

(* ****** ****** *)
//
absvtype
queue_vtype(a:vt@ype+, int(*id*)) = ptr
//
vtypedef
queue(a:vt0p, id:int) = queue_vtype(a, id)
vtypedef queue(a:vt0p) = [id:int] queue(a, id)
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
queue_make(cap: sizeGt(0)): queue(a)
//
extern
fun
{a:t@ype}
queue_free_type(que: queue(a)): void
//
(* ****** ****** *)
//
absprop ISNIL(id:int, b:bool)
absprop ISFUL(id:int, b:bool)
//
extern
fun
{a:vt0p}
queue_isnil{id:int}
  (que: !queue(a, id)): [b:bool] (ISNIL(id, b) | bool(b))
extern
fun
{a:vt0p}
queue_isful{id:int}
  (que: !queue(a, id)): [b:bool] (ISFUL(id, b) | bool(b))
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
queue_insert
  {id:int}
(
  ISFUL(id, false)
| xs: !queue(a, id) >> queue(a, id2), x: a
) : #[id2:int] void
//
extern
fun
{a:vt0p}
queue_takeout
  {id:int}
(
  ISNIL(id, false) | xs: !queue(a, id) >> queue(a, id2)
) : #[id2:int] a // end-of-fun
//
(* ****** ****** *)

local
//
staload
"libats/SATS/deqarray.sats"
//
assume
queue_vtype(a:vt0p, id:int) = deqarray(a)
//
assume ISNIL(id:int, b:bool) = unit_p
assume ISFUL(id:int, b:bool) = unit_p
//
in (* in-of-local *)

implement
{a}(*tmp*)
queue_make(cap) = deqarray_make_cap(cap)

implement
{a}(*tmp*)
queue_free_type(que) =
  deqarray_free_nil($UN.castvwtp0{deqarray(a,1,0)}(que))
// end of [queue_free_type]

implement
{a}(*tmp*)
queue_isnil(xs) = (unit_p() | deqarray_is_nil(xs))

implement
{a}(*tmp*)
queue_isful(xs) = (unit_p() | deqarray_is_full(xs))

implement
{a}(*tmp*)
queue_insert
  (pf | xs, x0) =
{
//
prval () =
__assert (pf) where
{
  extern
  praxi
  __assert
    {id:int}
  (
    pf: ISFUL(id, false)
  ) : [false] void
} (* end of [prval] *)
//
val () =
  deqarray_insert_atend<a> (xs, x0)
//
} (* end of [queue_insert] *)

(* ****** ****** *)

implement
{a}(*tmp*)
queue_takeout
  (pf | xs) = let
//
prval () =
__assert (pf) where
{
  extern
  praxi
  __assert
    {id:int}
  (
    pf: ISNIL(id, false)
  ) : [false] void
} (* end of [prval] *)
//
in
  deqarray_takeout_atbeg<a> (xs)
end (* end of [queue_takeout] *)

end // end of [local]

(* ****** ****** *)
//
datavtype
channel_ =
{
l0,l1,l2,l3:agz
} CHANNEL of
@{
  cap=sizeGt(0)
, spin=spin_vt(l0)
, rfcnt=intGt(0)
, mutex=mutex_vt(l1)
, CVisnil=condvar_vt(l2)
, CVisful=condvar_vt(l3)
, queue=ptr // deqarray
} (* end of [channel] *)
//
(* ****** ****** *)

assume
channel_vtype(a:vt0p) = channel_

(* ****** ****** *)

implement
{a}(*tmp*)
channel_create_exn
  (cap) = let
//
extern
praxi __assert(): [l:agz] void
//
prval [l0:addr] () = __assert()
prval [l1:addr] () = __assert()
prval [l2:addr] () = __assert()
prval [l3:addr] () = __assert()
//
val chan = CHANNEL{l0,l1,l2,l3}(_)
//
val+CHANNEL(ch) = chan
//
val () = ch.cap := cap
val () = ch.rfcnt := 1
//
local
val x = spin_create_exn()
in(*in-of-local*)
val () = ch.spin := unsafe_spin_t2vt(x)
end // end of [local]
//
local
val x = mutex_create_exn()
in(*in-of-local*)
val () = ch.mutex := unsafe_mutex_t2vt(x)
end // end of [local]
//
local
val x = condvar_create_exn()
in(*in-of-local*)
val () = ch.CVisnil := unsafe_condvar_t2vt(x)
end // end of [local]
//
local
val x = condvar_create_exn()
in(*in-of-local*)
val () = ch.CVisful := unsafe_condvar_t2vt(x)
end // end of [local]
//
val () = ch.queue := $UN.castvwtp0{ptr}(queue_make<a>(cap))
//
in
  fold@(chan); chan
end // end of [channel_create_exn]

(* ****** ****** *)

implement
{a}(*tmp*)
channel_ref
  (chan) = let
//
val@CHANNEL(ch) = chan
//
val spin =
  unsafe_spin_vt2t(ch.spin)
//
val
(pf | ()) = spin_lock (spin)
val () = ch.rfcnt := ch.rfcnt + 1
val ((*void*)) = spin_unlock (pf | spin)
//
prval () = fold@(chan)
//
in
  $UN.castvwtp1{channel(a)}(chan)
end // end of [channel_ref]

(* ****** ****** *)

implement
{a}(*tmp*)
channel_unref
  (chan) = let
//
val@CHANNEL
  {l0,l1,l2,l3}(ch) = chan
//
val spin =
  unsafe_spin_vt2t(ch.spin)
//
val
(pf | ()) = spin_lock (spin)
val rfcnt = ch.rfcnt
val ((*void*)) = spin_unlock (pf | spin)
//
in (* in-of-let *)
//
if
rfcnt > 1
then let
  val () = ch.rfcnt := rfcnt - 1
  prval ((*fold*)) = fold@(chan)
  prval ((*freed*)) = $UN.cast2void(chan)
in
  $UN.castvwtp0{queueopt(a)}(0)
end // end of [then]
else let
  val que =
    $UN.castvwtp0{queue(a)}(ch.queue)
  // end of [val]
  val ((*freed*)) = spin_vt_destroy(ch.spin)
  val ((*freed*)) = mutex_vt_destroy(ch.mutex)
  val ((*CVisnil*)) = condvar_vt_destroy(ch.CVisnil)
  val ((*CVisful*)) = condvar_vt_destroy(ch.CVisful)
  val ((*freed*)) = free@{l0,l1,l2,l3}(chan)
in
  $UN.castvwtp0{queueopt(a)}(que)
end // end of [else]
//
end // end of [channel_unref]

(* ****** ****** *)

implement
{}(*tmp*)
channel_get_refcount
  {a}(chan) = let
//
val@CHANNEL
  {l0,l1,l2,l3}(ch) = chan
//
val rfcnt = ch.rfcnt
//
in
  fold@(chan); rfcnt
end // end of [channel_get_refcount]

(* ****** ****** *)

local
//
extern
fun{a:vt0p}
channel_insert_buf
  (!channel(a), buf: !queue(a) >> _, a): void
//
in

implement{a}
channel_insert
  (chan, x0) = let
//
val+
CHANNEL
{l0,l1,l2,l3}(ch) = chan
//
val mutex =
  unsafe_mutex_vt2t(ch.mutex)
val (pfmut | ()) = mutex_lock(mutex)
//
val xs =
  $UN.castvwtp0{queue(a)}((pfmut | ch.queue))
val ((*void*)) = channel_insert_buf<a>(chan, xs, x0)
prval pfmut = $UN.castview0{locked_v(l1)}(xs)
val ((*void*)) = mutex_unlock (pfmut | mutex)
//
in
  // nothing
end // end of [channel_insert]

(* ****** ****** *)

implement
{a}(*tmp*)
channel_insert_buf
  (chan, xs, x0) = let
//
val+
CHANNEL
{l0,l1,l2,l3}(ch) = chan
//
val (pf | isful) = queue_isful(xs)
//
in
//
if
(isful)
then let
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
  val mutex =
    unsafe_mutex_vt2t(ch.mutex)
  val CVisful =
    unsafe_condvar_vt2t(ch.CVisful)
  val ((*void*)) =
    condvar_wait(pfmut | CVisful, mutex)
  // end of [val]
//
  prval ((*returned*)) = fpf(pfmut)
//
in
  channel_insert_buf<a>(chan, xs, x0)
end // end of [then]
else ((*void*)) where
{
  val isnil = queue_isnil(xs)
  val ((*void*)) = queue_insert(pf | xs, x0)
  val ((*void*)) =
  if isnil.1
    then condvar_broadcast(unsafe_condvar_vt2t(ch.CVisnil))
  // end of [if]
} (* end of [else] *)
//
end // end of [channel_insert_buf]

end // end of [local]

(* ****** ****** *)

local
//
extern
fun{a:vt0p}
channel_takeout_buf
  (chan: !channel(a), buf: !queue(a) >> _): (a)
//
in (* in-of-local *)

implement
{a}(*tmp*)
channel_takeout
  (chan) = x0 where
{
//
val+
CHANNEL
{l0,l1,l2,l3}(ch) = chan
//
val mutex =
  unsafe_mutex_vt2t(ch.mutex)
val (pfmut | ()) = mutex_lock(mutex)
val xs =
  $UN.castvwtp0{queue(a)}((pfmut | ch.queue))
val x0 = channel_takeout_buf<a> (chan, xs)
prval pfmut = $UN.castview0{locked_v(l1)}(xs)
val ((*void*)) = mutex_unlock (pfmut | mutex)
//
} (* end of [channel_takeout_buf] *)

(* ****** ****** *)

implement
{a}(*tmp*)
channel_takeout_buf
  (chan, xs) = let
//
val+CHANNEL
  {l0,l1,l2,l3}(ch) = chan
//
val (pf | isnil) = queue_isnil (xs)
//
in
//
if
(isnil)
then let
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
  val mutex =
    unsafe_mutex_vt2t(ch.mutex)
  val CVisnil =
    unsafe_condvar_vt2t(ch.CVisnil)
  val ((*void*)) =
    condvar_wait(pfmut | CVisnil, mutex)
  // end of [val]
//
  prval ((*returned*)) = fpf(pfmut)
//
in
  channel_takeout_buf<a>(chan, xs)
end // end of [then]
else x0_out where
{
  val isful = queue_isful(xs)
  val x0_out = queue_takeout(pf | xs)
  val ((*void*)) =
  if isful.1 then
    condvar_broadcast(unsafe_condvar_vt2t(ch.CVisful))
  // end of [if]
} (* end of [else] *)
//
end // end of [channel_takeout_buf]

end // end of [local]

(* ****** ****** *)

(* end of [channel_vt.dats] *)
