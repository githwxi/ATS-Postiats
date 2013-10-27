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
// A simple mutex/condvar interface
//
(* ****** ****** *)

abstype mutex_type(v:view) = ptr
typedef mutex(v:view) = mutex_type(v)

(* ****** ****** *)

fun mutex_make{v:view} (pf: v | (*void*)): mutex (v)
fun mutex_make_unlocked{v:view} ((*void*)): mutex (v)

(* ****** ****** *)

fun mutex_acquire{v:view} (mutex(v)): (v | (*void*))
fun mutex_release{v:view} (pf: v | x: mutex(v)): void

(* ****** ****** *)

abstype condvar_type = ptr
typedef condvar = condvar_type

fun condvar_wait{v:view} (pf: !v | cv: condvar, p: mutex (v)): void

(* ****** ****** *)

(* end of [mutex.sats] *)
