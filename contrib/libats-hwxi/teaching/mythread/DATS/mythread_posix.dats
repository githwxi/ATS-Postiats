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
// HX-2013-10:
// A simple thread interface
// implemented on top of pthreads
//
(* ****** ****** *)

%{^
#include <pthread.h>
%} // end of [%{^]

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/mythread.sats"

(* ****** ****** *)
//
assume
mutex_v (l:addr) = unit_v
//
(* ****** ****** *)

implement
mutex_create () = let
//
typedef
pthread_mutex_t = $extype"pthread_mutex_t"
///
val (pfat, pfgc | p) = ptr_alloc<pthread_mutex_t> ()
val err = $extfcall (int, "pthread_mutex_init", p, 0(*attr*))
//
in
//
if err = 0
  then
    $UN.castvwtp0{mutex1}((pfat, pfgc | p))
  else let
    val () = ptr_free (pfgc, pfat | p) in $UN.castvwtp0{mutex0}(0)
  end // end of [else]
//
end // end of [mutex_create]
  
(* ****** ****** *)

implement
mutex_lock (mtx) = let
//
val err = $extfcall
  (int, "pthread_mutex_lock", $UN.cast{ptr}(mtx))
//
(*
val ((*void*)) = assertloc (err = 0)
*)
//
in
  (unit_v () | ())
end // end of [mutex_lock]
  
(* ****** ****** *)
  
implement
mutex_unlock
  (pf | mtx) = let
//
prval unit_v () = pf
//
val err = $extfcall
  (int, "pthread_mutex_unlock", $UN.cast{ptr}(mtx))
//
(*
val ((*void*)) = assertloc (err = 0)
*)
//
in
  // nothing
end // end of [mutex_unlock]

(* ****** ****** *)

implement
condvar_create () = let
//
typedef
pthread_cond_t = $extype"pthread_cond_t"
//
val (pfat, pfgc | p) = ptr_alloc<pthread_cond_t> ()
val err = $extfcall (int, "pthread_cond_init", p, 0(*attr*))
//
in
//
if err = 0
  then
    $UN.castvwtp0{condvar1}((pfat, pfgc | p))
  else let
    val () = ptr_free (pfgc, pfat | p) in $UN.castvwtp0{condvar0}(0)
  end // end of [else]
//
end // end of [condvar_create]

(* ****** ****** *)
  
implement
condvar_signal
  (cvr) = let
//
val err = (
  $extfcall (int, "pthread_cond_signal", $UN.cast{ptr}(cvr))
) (* end of [val] *)
//
(*
val ((*void*)) = assertloc (err = 0)
*)
//
in
  // nothing
end // end of [condvar_signal]

(* ****** ****** *)

implement
condvar_broadcast
  (cvr) = let
//
val err = (
  $extfcall (int, "pthread_cond_broadcast", $UN.cast{ptr}(cvr))
) (* end of [val] *)
//
(*
val ((*void*)) = assertloc (err = 0)
*)
//
in
  // nothing
end // end of [condvar_broadcast]

(* ****** ****** *)

implement
condvar_wait
  (pf | cvr, mtx) = let
//
val err = $extfcall
  (int, "pthread_cond_wait", $UN.cast{ptr}(cvr), $UN.cast{ptr}(mtx))
//
(*
val ((*void*)) = assertloc (err = 0)
*)
//
in
  // nothing
end // end of [condvar_wait]
    
(* ****** ****** *)

abst@ype pthread_t = $extype"pthread_t"
abst@ype pthread_attr_t = $extype"pthread_attr_t"

(* ****** ****** *)

implement
mythread_create_funenv
  (fwork, env) = let
//
var tid: pthread_t
var attr: pthread_attr_t
val err = $extfcall
  (int, "pthread_attr_init", addr@attr)
//
val err = $extfcall
(
  int
, "pthread_attr_setdetachstate"
, addr@attr, $extval(int, "PTHREAD_CREATE_DETACHED")
)
//
val err = $extfcall
(
  int
, "pthread_create"
, addr@tid, addr@attr, fwork, $UN.castvwtp0{ptr}(env)
)
//
val ((*void*)) = assertloc (err = 0)
//
val err = $extfcall (int, "pthread_attr_destroy", addr@attr)
//
in
  // nothing
end // end of [mythread_create_funenv]

(* ****** ****** *)

(* end of [mythread_posix.dats] *)
