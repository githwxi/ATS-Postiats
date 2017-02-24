(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2017 Hongwei Xi, ATS Trustful Software, Inc.
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
// A list-based channel
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
//
(* ****** ****** *)
//
staload "./../SATS/chanlst_t.sats"
//
(* ****** ****** *)
//
datatype
chanlst =
{
l1,l2:agz
} CHANLST of
(
  ptr // List0_vt(a)
, mutex(l1), condvar(l2)
) (* end of [chanlst] *)
datavtype
chanlst_vt =
{
l1,l2:agz
} CHANLST_vt of
(
  ptr // List0_vt(a)
, mutex(l1), condvar(l2)
) (* end of [chanlst_vt] *)
//
(* ****** ****** *)
//
assume
chanlst_type(a:vt0p) = chanlst
//
(* ****** ****** *)

implement
{a}(*tmp*)
chanlst_create_exn
  ((*void*)) = let
//
val mut = mutex_create_exn()
//
val CVisnil = condvar_create_exn()
//
val xs0 = list_vt_nil{a}()
val xs0 = $UN.castvwtp0{ptr}(xs0)
//
in
  CHANLST(xs0, mut, CVisnil)
end // end of [chanlst_create_exn]

(* ****** ****** *)

implement
{a}(*tmp*)
chanlst_insert
  (chan, x0) = let
//
val
chan2 =
$UN.castvwtp0{chanlst_vt}(chan)
val+
@CHANLST_vt
{l1,l2}(buf, mut, CVisnil) = chan2
//
val
(pfmut | ()) = mutex_lock(mut)
//
val xs0 =
$UN.castvwtp0{List0_vt(a)}((pfmut|buf))
//
val
isnil = list_vt_is_nil(xs0)
//
val xs0 =
  list_vt_cons{a}( x0, xs0 )
val ((*void*)) =
  (buf := $UN.castvwtp0{ptr}(xs0))
//
val ((*void*)) =
  if isnil then condvar_broadcast(CVisnil)
// end of [val]
//
prval
pfmut = $UN.castview0{locked_v(l1)}(buf)
//
val ((*void*)) = mutex_unlock(pfmut | mut)
//
prval ((*void*)) = fold@(chan2)
prval ((*void*)) = $UN.cast2void(chan2)
//
in
  // nothing
end // end of [chanlst_insert]
//
(* ****** ****** *)

implement
{a}(*tmp*)
chanlst_insert_opt
(
  chan, x0
) = None_vt((*void*)) where
{
  val () = chanlst_insert(chan, x0) // non-blocking
} (* end of [chanlst_insert_opt] *)

(* ****** ****** *)
//
extern
fun{a:vt0p}
chanlst_takeout_buf
  (chan: chanlst(a), buf_p: !aPtr1(List0_vt(a))): (a)
//
(* ****** ****** *)

implement
{a}(*tmp*)
chanlst_takeout
  (chan) = x0_out where
{
//
val
chan2 =
$UN.castvwtp0{chanlst_vt}(chan)
val+
@CHANLST_vt
{l1,l2}(buf, mut, CVisnil) = chan2
//
val (pfmut | ()) = mutex_lock(mut)
//
val
buf_p =
$UN.castvwtp0
{aPtr1(List0_vt(a))}((pfmut|addr@buf))
//
val
x0_out =
  chanlst_takeout_buf<a>(chan, buf_p)
//
prval
pfmut = $UN.castview0{locked_v(l1)}(buf_p)
//
val ((*void*)) = mutex_unlock(pfmut | mut)
//
prval ((*void*)) = fold@(chan2)
prval ((*void*)) = $UN.cast2void(chan2)
//
} (* end of [chanlst_takeout] *)

(* ****** ****** *)
//
implement
{a}(*tmp*)
chanlst_takeout_opt
  (chan) = opt where
{
//
val
chan2 =
$UN.castvwtp0{chanlst_vt}(chan)
val+
@CHANLST_vt
{l1,l2}(buf, mut, CVisnil) = chan2
//
val
(pfmut | ()) = mutex_lock(mut)
//
val xs0 =
$UN.castvwtp0{List0_vt(a)}((pfmut|buf))
//
val opt =
(
case+ xs0 of
| ~list_vt_nil
    () => None_vt()
| ~list_vt_cons
    (x0, xs0) =>
    Some_vt(x0) where
  {
    val () =
      (buf := $UN.castvwtp0{ptr}(xs0))
  }
) : Option_vt(a)
//
prval
pfmut = $UN.castview0{locked_v(l1)}(buf)
//
val ((*void*)) = mutex_unlock(pfmut | mut)
//
prval ((*void*)) = fold@(chan2)
prval ((*void*)) = $UN.cast2void(chan2)
//
} (* end of [chanlst_takeout_opt] *)
//
(* ****** ****** *)

implement
{a}(*tmp*)
chanlst_takeout_buf
  (chan, buf_p) = let
//
val
chan2 =
$UN.castvwtp0{chanlst_vt}(chan)
val+
@CHANLST_vt
{l1,l2}(buf, mut, CVisnil) = chan2
//
val mut = mut and CVisnil = CVisnil
//
prval ((*void*)) = fold@(chan2)
prval ((*void*)) = $UN.cast2void(chan2)
//
val xs0 =
  $UN.ptr1_get<List0_vt(a)>(aptr2ptr(buf_p))
//
in (* in-of-let *)
//
case+ xs0 of
| ~list_vt_nil() => let
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
    prval ((*returned*)) = fpf( pfmut )
  in
    chanlst_takeout_buf<a>(chan, buf_p)
  end // end of [list_vt_nil]
| ~list_vt_cons(x0_out, xs0) => x0_out where
  {
    val () =
    $UN.ptr1_set<List0_vt(a)>(aptr2ptr(buf_p), xs0)
  }
//
end // end of [chanlst_takeout_buf]

(* ****** ****** *)

(* end of [chanlst_t.dats] *)
