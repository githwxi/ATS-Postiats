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
// A simple thread interface implmented via pthreads
//
(* ****** ****** *)

%{^
#include <pthread.h>
%} // end of [%{^]

(* ****** ****** *)

staload "./../SATS/mythread.sats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

implement
condvar_signal
  (pf | cvr) = let
//
val err = (
  $extfcall (int, "pthread_cond_signal", $UN.cast{ptr}(cvr))
) (* end of [val] *)
//
(*
val () = assertloc (err = 0)
*)
//
in
  // nothing
end // end of [condvar_signal]

(* ****** ****** *)

implement
condvar_broadcast
  (pf | cvr) = let
//
val err = (
  $extfcall (int, "pthread_cond_broadcast", $UN.cast{ptr}(cvr))
) (* end of [val] *)
//
(*
val () = assertloc (err = 0)
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

(* end of [mythread_posix.dats] *)
