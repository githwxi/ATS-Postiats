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
//
(* ****** ****** *)
//
abst@ype
thread_type = lint
//
typedef thread = thread_type
//
(* ****** ****** *)

absview mutex_v (l:addr)

(* ****** ****** *)

abstype mutex_type (l:addr) = ptr (l)
typedef mutex (l:addr) = mutex_type (l)
typedef mutex0 = [l:agez] mutex_type(l)
typedef mutex1 = [l:addr | l > null] mutex_type(l)

(* ****** ****** *)

castfn
mutex2ptr{l:addr} (mutex(l)):<> ptr (l)
overload ptrcast with mutex2ptr

(* ****** ****** *)
//
fun mutex_create ((*void*)): mutex0
//
fun mutex_create_exn ((*void*)): mutex1
//
(* ****** ****** *)
//
fun
mutex_lock{l:agz} (m: mutex(l)): (mutex_v(l) | void)
fun
mutex_trylock
  {l:agz}(m: mutex(l)): [b:bool] (option_v(mutex_v(l), b) | bool(b))
//
fun
mutex_unlock{l:agz} (pf: mutex_v(l) | m: mutex(l)): void
//
(* ****** ****** *)
//
abstype condvar_type(l:addr) = ptr(l)
//
typedef condvar (l:addr) = condvar_type(l)
typedef condvar0 = [l:agez] condvar_type(l)
typedef condvar1 = [l:addr | l > null] condvar_type(l)
//
(* ****** ****** *)

castfn
condvar2ptr{l:addr} (condvar(l)):<> ptr (l)
overload ptrcast with condvar2ptr

(* ****** ****** *)
//
fun condvar_create (): condvar0
fun condvar_create_exn (): condvar1
//
fun condvar_signal (cv: condvar1): void
fun condvar_broadcast (cv: condvar1): void
//
fun
condvar_wait{l:agz}
  (pf: !mutex_v (l) | cv: condvar1, p: mutex (l)): void
//
(* ****** ****** *)

(* end of [mythread.sats] *)
