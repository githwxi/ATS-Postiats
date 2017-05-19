(*
** Copyright (C) 2015 Hongwei Xi, Boston University
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
//
(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: January, 2015
*)
//
(* ****** ****** *)

%{^
#include <pthread.h>
%} // end of [%{^]

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
staload UN = $UNSAFE
//
(* ****** ****** *)
//
staload
"libats/libc/SATS/unistd.sats"
//
(* ****** ****** *)
//
staload
"libats/SATS/athread.sats"  
staload
_ = "libats/DATS/athread.dats"
staload
_ = "libats/DATS/athread_posix.dats"
//  
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
queue_make (cap: intGt(0)): queue(a)
//
extern
fun
{a:t@ype}
queue_free_type (que: queue(a)): void
//
(* ****** ****** *)
//
absprop ISNIL(id:int, b:bool)
absprop ISFUL(id:int, b:bool)
//
extern
fun
{a:vt0p}
queue_isnil
  {id:int}
  (!queue(a, id)): [b:bool] (ISNIL(id, b) | bool(b))
extern
fun
{a:vt0p}
queue_isful
  {id:int}
  (!queue(a, id)): [b:bool] (ISFUL(id, b) | bool(b))
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
queue_remove
  {id:int}
(
  ISNIL(id, false) | xs: !queue(a, id) >> queue(a, id2)
) : #[id2:int] a // end-of-fun
//
(* ****** ****** *)
//
absvtype
channel_vtype(a:vt@ype+) = ptr
vtypedef
channel(a:vt0p) = channel_vtype(a)
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
channel_make(cap: intGt(0)): channel(a)
//
(* ****** ****** *)

extern
fun
{a:vt0p}
channel_ref(ch: !channel(a)): channel(a)
extern
fun
{a:vt0p}
channel_unref(ch: channel(a)): Option_vt(queue(a))

(* ****** ****** *)

extern
fun{}
channel_rfcnt{a:vt0p}(ch: !channel(a)): intGt(0)

(* ****** ****** *)

extern
fun{a:vt0p}
channel_insert (!channel(a), a): void
extern
fun{a:vt0p}
channel_remove (chan: !channel(a)): (a)

(* ****** ****** *)
//
datavtype
channel_ =
{
l0,l1,l2,l3:agz
} CHANNEL of
@{
  cap=intGt(0)
, spin=spin_vt(l0)
, rfcnt=intGt(0)
, mutex=mutex_vt(l1)
, CVisnil=condvar_vt(l2)
, CVisful=condvar_vt(l3)
, queue=ptr // deqarray
} (* end of [channel_] *)
//
(* ****** ****** *)

local

assume
channel_vtype(a:vt0p) = channel_

in (*in-of-local*)

(* ****** ****** *)

implement
{a}(*tmp*)
channel_make
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
val () =
ch.queue := $UN.castvwtp0{ptr}(queue_make<a>(cap))
//
in
  fold@(chan); chan
end // end of [channel_make]

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
rfcnt <= 1
then let
  val que =
    $UN.castvwtp0{queue(a)}(ch.queue)
  // end of [val]
  val ((*freed*)) = spin_vt_destroy(ch.spin)
  val ((*freed*)) = mutex_vt_destroy(ch.mutex)
  val ((*CVisnil*)) = condvar_vt_destroy(ch.CVisnil)
  val ((*CVisful*)) = condvar_vt_destroy(ch.CVisful)
  val ((*freed*)) = free@{l0,l1,l2,l3}(chan)
in
  Some_vt(que)
end // end of [then]
else let
  val () = ch.rfcnt := rfcnt - 1
  prval ((*fold*)) = fold@(chan)
  prval ((*freed*)) = $UN.cast2void(chan)
in
  None_vt((*void*))
end // end of [else]
//
end // end of [channel_unref]

(* ****** ****** *)

implement
{}(*tmp*)
channel_rfcnt
  {a}(chan) = let
//
val@CHANNEL
  {l0,l1,l2,l3}(ch) = chan
//
val rfcnt = ch.rfcnt
//
in
  fold@(chan); rfcnt
end // end of [channel_rfcnt]

(* ****** ****** *)
//
extern
fun{a:vt0p}
channel_insert2
  (!channel(a), !queue(a) >> _, a): void
//
(* ****** ****** *)

implement{a}
channel_insert
  (chan, x0) = let
//
val+CHANNEL
  {l0,l1,l2,l3}(ch) = chan
val mutex = unsafe_mutex_vt2t(ch.mutex)
val (pfmut | ()) = mutex_lock (mutex)
val xs =
  $UN.castvwtp0{queue(a)}((pfmut | ch.queue))
val ((*void*)) = channel_insert2<a> (chan, xs, x0)
prval pfmut = $UN.castview0{locked_v(l1)}(xs)
val ((*void*)) = mutex_unlock (pfmut | mutex)
//
in
  // nothing
end // end of [channel_insert]

(* ****** ****** *)

implement
{a}(*tmp*)
channel_insert2
  (chan, xs, x0) = let
//
val+CHANNEL
  {l0,l1,l2,l3}(ch) = chan
//
val (pf | isful) = queue_isful (xs)
//
in
//
if
isful
then let
//
  prval
  (pfmut, fpf) =
  __assert () where
  {
    extern
    praxi
    __assert(): vtakeout0(locked_v(l1))
  } (* end of [prval] *)
//
  val mutex = unsafe_mutex_vt2t(ch.mutex)
  val CVisful = unsafe_condvar_vt2t(ch.CVisful)
  val ((*void*)) = condvar_wait (pfmut | CVisful, mutex)
  prval ((*void*)) = fpf (pfmut)
//
in
  channel_insert2 (chan, xs, x0)
end // end of [then]
else let
  val isnil = queue_isnil (xs)
  val ((*void*)) = queue_insert (pf | xs, x0)
  val ((*void*)) =
  if isnil.1
    then condvar_broadcast(unsafe_condvar_vt2t(ch.CVisnil))
  // end of [if]
in
  // nothing
end // end of [else]
//
end // end of [channel_insert2]

(* ****** ****** *)
//
extern
fun{a:vt0p}
channel_remove2
  (chan: !channel(a), !queue(a) >> _): (a)
//
(* ****** ****** *)

implement
{a}(*tmp*)
channel_remove
  (chan) = x0 where
{
//
val+CHANNEL
  {l0,l1,l2,l3}(ch) = chan
val mutex =
  unsafe_mutex_vt2t(ch.mutex)
val (pfmut | ()) = mutex_lock (mutex)
val xs =
  $UN.castvwtp0{queue(a)}((pfmut | ch.queue))
val x0 = channel_remove2<a> (chan, xs)
prval pfmut = $UN.castview0{locked_v(l1)}(xs)
val ((*void*)) = mutex_unlock (pfmut | mutex)
//
} // end of [channel_remove]

(* ****** ****** *)

implement{a}
channel_remove2
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
isnil
then let
//
  prval
  (pfmut, fpf) =
  __assert () where
  {
    extern
    praxi
    __assert (): vtakeout0(locked_v(l1))
  } (* end of [prval] *)
//
  val mutex = unsafe_mutex_vt2t(ch.mutex)
  val CVisnil = unsafe_condvar_vt2t(ch.CVisnil)
  val ((*void*)) = condvar_wait (pfmut | CVisnil, mutex)
  prval ((*void*)) = fpf (pfmut)
//
in
  channel_remove2 (chan, xs)
end // end of [then]
else let
  val isful = queue_isful (xs)
  val x0_out = queue_remove (pf | xs)
  val ((*void*)) =
  if isful.1
    then condvar_broadcast(unsafe_condvar_vt2t(ch.CVisful))
  // end of [if]
in
  x0_out
end // end of [else]
//
end // end of [channel_remove2]

(* ****** ****** *)

end // end of [local]

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
queue_make(cap) = deqarray_make_cap(i2sz(cap))

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
queue_remove
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
end (* end of [queue_remove] *)

end // end of [local]

(* ****** ****** *)

staload
_(*anon*) = "libats/DATS/deqarray.dats"

(* ****** ****** *)
//
fun
do_work
(
  chan: channel(int)
) : void =
{
//
val () = channel_insert (chan, 0)
val-~None_vt() = channel_unref(chan)
//
} (* end of [do_work] *)
//
(* ****** ****** *)

implement
main0 () =
{
//
val chan = channel_make<int>(2)
//
val chan2 = channel_ref(chan)
val chan3 = channel_ref(chan)
val chan4 = channel_ref(chan)
//
val tid2 =
athread_create_cloptr_exn (llam () => do_work(chan2))
val tid3 =
athread_create_cloptr_exn (llam () => do_work(chan3))
val tid4 =
athread_create_cloptr_exn (llam () => do_work(chan4))
//
val-(0) = channel_remove(chan)
val-(0) = channel_remove(chan)
//
// HX: a cheap hack!!!
//
val () = ignoret(usleep(1000u))
//
val () =
  while(channel_rfcnt(chan) >= 2)()
//
val-
~Some_vt(que) = channel_unref<int>(chan)
//
val () = queue_free_type<int>(que)
//
val () = println! ("Testing for [channel_vt] has passed!")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [channel_vt.dats] *)
