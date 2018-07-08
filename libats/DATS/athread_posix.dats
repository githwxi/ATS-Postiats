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
// An abstract thread interface
// implemented on top of pthreads
//
(* ****** ****** *)

%{^
//
#include <pthread.h>
//
%} // end of [%{^]

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/athread.sats"

(* ****** ****** *)
//
assume
locked_v (l:addr) = unit_v
//
(* ****** ****** *)

implement
{}(*tmp*)
spin_create () = let
//
typedef
pthread_spinlock_t = $extype"pthread_spinlock_t"
//
val (pfat, pfgc | p) = ptr_alloc<pthread_spinlock_t> ()
val err = $extfcall (int, "pthread_spin_init", p, 0(*pshared*))
//
in
//
if err = 0
  then
    $UN.castvwtp0{spin1}((pfat, pfgc | p))
  else let
    val () = ptr_free (pfgc, pfat | p) in $UN.castvwtp0{spin0}(0)
  end // end of [else]
//
end // end of [spin_create]

(* ****** ****** *)

implement
{}(*tmp*)
spin_vt_destroy (spn) = let
//
val p_spn = spin2ptr_vt (spn)
prval () = $UN.castview0 (spn)
//
in
//
if
p_spn > 0
then let
  val err = $extfcall (int, "pthread_spin_destroy", p_spn)
  val ((*freed*)) = $extfcall (void, "atspre_ptr_free", p_spn)
in
  // nothing
end // end of [then]
else () // end of [else]
//
end // end of [spin_vt_destroy]

(* ****** ****** *)

implement
{}(*tmp*)
spin_lock (spn) = let
//
val err = $extfcall
  (int, "pthread_spin_lock", $UN.cast{ptr}(spn))
//
(*
val ((*void*)) = assertloc (err = 0)
*)
//
in
  (unit_v () | ())
end // end of [spin_lock]

(* ****** ****** *)

implement
{}(*tmp*)
spin_unlock
  (pf | spn) = let
//
prval unit_v () = pf
//
val err = $extfcall
  (int, "pthread_spin_unlock", $UN.cast{ptr}(spn))
//
(*
val ((*void*)) = assertloc (err = 0)
*)
//
in
  // nothing
end // end of [spin_unlock]

(* ****** ****** *)

implement
{}(*tmp*)
mutex_create () = let
//
typedef
pthread_mutex_t = $extype"pthread_mutex_t"
//
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
{}(*tmp*)
mutex_vt_destroy (mtx) = let
//
val p_mtx = mutex2ptr_vt (mtx)
prval () = $UN.castview0 (mtx)
//
in
//
if
p_mtx > 0
then let
  val err = $extfcall (int, "pthread_mutex_destroy", p_mtx)
  val ((*freed*)) = $extfcall (void, "atspre_ptr_free", p_mtx)
in
  // nothing
end // end of [then]
else () // end of [else]
//
end // end of [mutex_vt_destroy]

(* ****** ****** *)

implement
{}(*tmp*)
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
{}(*tmp*)
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
{}(*tmp*)
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
{}(*tmp*)
condvar_vt_destroy (cvr) = let
//
val p_cvr = condvar2ptr_vt (cvr)
prval () = $UN.castview0 (cvr)
//
in
//
if
p_cvr > 0
then let
  val err = $extfcall (int, "pthread_cond_destroy", p_cvr)
  val ((*freed*)) = $extfcall (void, "atspre_ptr_free", p_cvr)
in
  // nothing
end // end of [then]
else () // end of [else]
//
end // end of [condvar_vt_destroy]

(* ****** ****** *)
  
implement
{}(*tmp*)
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
{}(*tmp*)
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
{}(*tmp*)
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
//
implement
{}(*tmp*)
athread_self
  ((*void*)) =
  $extfcall(tid, "pthread_self")
//
(* ****** ****** *)

implement
{}(*tmp*)
athread_create_funenv
  (tid, fwork, env) = let
//
var tid2: pthread_t
var attr: pthread_attr_t
val
_(*err*) =
$extfcall(int, "pthread_attr_init", addr@attr)
//
val
_(*err*) =
$extfcall(
  int
, "pthread_attr_setdetachstate"
, addr@attr, $extval(int, "PTHREAD_CREATE_DETACHED")
) (* end of [val] *)
//
val err =
$extfcall (
  int, "pthread_create"
, addr@tid2, addr@attr, fwork, $UN.castvwtp0{ptr}(env)
) (* end of [val] *)
val () = tid := $UN.cast2lint(tid2)
//
val _(*err*) = $extfcall (int, "pthread_attr_destroy", addr@attr)
//
in
  err
end // end of [athread_create_funenv]

(* ****** ****** *)

(* end of [athread_posix.dats] *)
