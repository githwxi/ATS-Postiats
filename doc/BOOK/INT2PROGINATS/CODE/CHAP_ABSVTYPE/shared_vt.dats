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
(* ****** ****** *)
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

absvtype shared(a:vtype) = ptr

(* ****** ****** *)

extern
fun shared_make{a:vtype}(x: a): shared(a)  
  
(* ****** ****** *)
//
extern
fun shared_ref{a:vtype}(!shared(a)): shared(a)
extern
fun shared_unref{a:vtype}(shared(a)): Option_vt(a)
//
(* ****** ****** *)

absview locked_v

(* ****** ****** *)

extern
fun shared_lock{a:vtype}(!shared(a)): (locked_v | a)
extern
fun shared_unlock{a:vtype}(locked_v | !shared(a), x: a): void

(* ****** ****** *)

local
//
datavtype
shared_ (a:vtype) =
  SHARED of (spin1_vt, int, ptr)
//
assume shared = shared_
//
in

implement
shared_make(x) = let
  val spin =
    unsafe_spin_t2vt(spin_create_exn())
  // end of [val]
in
  SHARED(spin, 1, $UN.castvwtp0{ptr}(x))
end // end of [shared_make]

(* ****** ****** *)

implement
shared_ref
  {a}(sh) = let
//
val+@SHARED
  (spin, count, _) = sh
//
val
spin =
  unsafe_spin_vt2t(spin)
//
val
(pf | ()) = spin_lock(spin)
val c0 = count
val () = count := c0 + 1
val ((*void*)) = spin_unlock(pf | spin)
prval ((*void*)) = fold@sh
//
in
  $UN.castvwtp1{shared(a)}(sh)
end // end of [shared_ref]

(* ****** ****** *)

implement
shared_unref
  {a}(sh) = let
//
val+@SHARED
  (spin, count, _) = sh
//
val
spin =
  unsafe_spin_vt2t(spin)
//
val
(pf | ()) = spin_lock(spin)
val c0 = count
val () = count := c0 - 1
val ((*void*)) = spin_unlock(pf | spin)
prval ((*void*)) = fold@sh
//
in
if
c0 <= 1
then let
  val+~SHARED(spin, _, x) = sh
  val ((*freed*)) = spin_vt_destroy(spin)
in
  Some_vt($UN.castvwtp0{a}(x))
end // end of [then]
else let
  prval () = $UN.cast2void(sh) in None_vt()
end // end of [else]
//
end // end of [shared_unref]

(* ****** ****** *)

implement
shared_lock
  {a}(sh) = let
//
val+@SHARED(spin, _, x) = sh
//
val
spin =
  unsafe_spin_vt2t(spin)
//
val
(pf | ()) = spin_lock(spin)
//
val x0 = $UN.castvwtp0{a}(x)
//
prval () = fold@sh
//
in
  ($UN.castview0(pf) | x0)
end // end of [shared_lock]

(* ****** ****** *)

implement
shared_unlock
  {a}(pf | sh, x0) = let
//
val+@SHARED(spin, _, x) = sh
//
val
spin =
  unsafe_spin_vt2t(spin)
//
val () = x := $UN.castvwtp0{ptr}(x0)
//
val () =
  spin_unlock($UN.castview0(pf) | spin)
//
prval () = fold@sh
//
in
  // nothing
end // end of [shared_unlock]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

#define N 3
#define TOTAL 10

(* ****** ****** *)

extern
fun
do_work (sh: shared(ptr), int): void

(* ****** ****** *)

implement
do_work
  (sh, n) = let
//
val
(pf | x) = shared_lock(sh)
//
val x = $UNSAFE.ptr2int(x)
//
in
//
if
x < TOTAL
then (
  if (x mod N = n)
    then let
      val () =
        println! ("do_work(", n, "): x = ", x)
      val () =
        shared_unlock (pf | sh, $UN.int2ptr(x+1))
      // end of [val]
    in
      do_work (sh, n)
    end // end of [then]
    else let
      val x = $UN.int2ptr(x)
      val () = shared_unlock (pf | sh, x) in do_work (sh, n)
    end // end of [else]
  // end of [if]
) // end of [then]
else let
  val x = $UN.int2ptr(x)
  val () = shared_unlock (pf | sh, x) in option_vt_free(shared_unref(sh))
end // end of [else]
//
end // end of [do_work]

(* ****** ****** *)

implement
main0((*void*)) = let
  val x =
    $UN.int2ptr(0)
  // end of [val]
  val sh0 =
    shared_make (x)
  // end of [val]
//
  val sh1 = shared_ref (sh0)
  val tid = athread_create_cloptr_exn (llam () => do_work(sh1, 1))
  val sh2 = shared_ref (sh0)
  val tid = athread_create_cloptr_exn (llam () => do_work(sh2, 2))
//
  val () = do_work (sh0, 0)
in
  ignoret(usleep(1000u)) // HX: a cheap hack!!!
end // end of [main0]

(* ****** ****** *)

(* end of [shared_vt.dats] *)
