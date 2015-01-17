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

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

staload UN = $UNSAFE

(* ****** ****** *)

staload "libc/SATS/unistd.sats"

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

absvtype
queue_vtype
  (a:vt@ype, int(*id*)) = ptr
vtypedef
queue(a:vt@ype, id:int) = queue_vtype(a, id)
vtypedef queue(a:vt@ype) = [id:int] queue(a, id)

(* ****** ****** *)
//
absprop ISNIL(id:int, b:bool)
absprop ISFUL(id:int, b:bool)
//
extern
fun
{a:vt@ype}
queue_isnil{id:int}(!queue(a, id)): [b:bool] (ISNIL(id, b) | bool(b))
extern
fun
{a:vt@ype}
queue_isful{id:int}(!queue(a, id)): [b:bool] (ISFUL(id, b) | bool(b))
//
(* ****** ****** *)

extern
fun
{a:vt@ype}
queue_insert
  {id:int}
(
  ISFUL(id, false)
| xs: !queue(a, id) >> queue(a, id2), x: a
) : #[id2:int] void
//
extern
fun
{a:vt@ype}
queue_takeout
  {id:int}
(
  ISNIL(id, false) | xs: !queue(a, id) >> queue(a, id2)
) : #[id2:int] a // end-of-fun
//
(* ****** ****** *)
//
absvtype
channel_vtype(a:vt@ype) = ptr
vtypedef
channel(a:vt@ype) = channel_vtype(a)
//
(* ****** ****** *)

extern
fun
{a:vt@ype}
channel_ref(ch: !channel(a)): channel(a)

extern
fun
{a:vt@ype}
channel_unref(ch: channel(a)): Option_vt(queue(a))

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
} (* end of [channel] *)
//
(* ****** ****** *)

assume
channel_vtype(a:vt@ype) = channel_

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
in
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

extern
fun{a:vt0p}
channel_insert (!channel(a), a): void
extern
fun{a:vt0p}
channel_takeout (chan: !channel(a)): (a)

(* ****** ****** *)
//
extern
fun{a:vt0p}
channel_insert2
  (!channel(a), !queue(a) >> _, a): void
//
extern
fun{a:vt0p}
channel_takeout2 (!channel(a), !queue(a) >> _): (a)
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
  prval
  (pfmut, fpf) =
  __assert () where
  {
    extern
    praxi __assert (): vtakeout0(locked_v(l1))
  }
  val mutex = unsafe_mutex_vt2t(ch.mutex)
  val CVisful = unsafe_condvar_vt2t(ch.CVisful)
  val ((*void*)) = condvar_wait (pfmut | CVisful, mutex)
  prval ((*void*)) = fpf (pfmut)
in
  channel_insert2 (chan, xs, x0)
end // end of [then]
else let
  val isnil = queue_isnil (xs)
  val ((*void*)) = queue_insert (pf | xs, x0)
  val CVisnil = unsafe_condvar_vt2t(ch.CVisnil)
  val ((*void*)) = if isnil.1 then condvar_signal (CVisnil)
in
  // nothing
end // end of [else]
//
end // end of [channel_insert2]

(* ****** ****** *)

implement{a}
channel_takeout
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
val x0 = channel_takeout2<a> (chan, xs)
prval pfmut = $UN.castview0{locked_v(l1)}(xs)
val ((*void*)) = mutex_unlock (pfmut | mutex)
//
} // end of [channel_takeout2]

(* ****** ****** *)

implement{a}
channel_takeout2
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
  prval
  (pfmut, fpf) =
  __assert () where
  {
    extern
    praxi __assert (): vtakeout0(locked_v(l1))
  }
  val mutex = unsafe_mutex_vt2t(ch.mutex)
  val CVisnil = unsafe_condvar_vt2t(ch.CVisnil)
  val ((*void*)) = condvar_wait (pfmut | CVisnil, mutex)
  prval ((*void*)) = fpf (pfmut)
in
  channel_takeout2 (chan, xs)
end // end of [then]
else let
  val isful = queue_isful (xs)
  val x0_out = queue_takeout (pf | xs)
  val CVisful = unsafe_condvar_vt2t(ch.CVisful)
  val ((*void*)) = if isful.1 then condvar_signal (CVisful)
in
  x0_out
end // end of [else]
//
end // end of [channel_takeout2]

(* ****** ****** *)

(* end of [channel_vt.dats] *)
