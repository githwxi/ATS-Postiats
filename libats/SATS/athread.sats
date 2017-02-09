(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmmhwxiATgmailDOTcom
// Start Time: May, 2014
//
(* ****** ****** *)
//
// An abstract thread interface
//
(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.athread"
//
(* ****** ****** *)

absview locked_v(l:addr)

(* ****** ****** *)

abstype
spin_type (l:addr) = ptr(l)
typedef spin (l:addr) = spin_type(l)
typedef spin0 = [l:agez] spin_type(l)
typedef spin1 = [l:addr | l > null] spin_type(l)

(* ****** ****** *)

absvtype
spin_vtype (l:addr) = ptr(l)
vtypedef spin_vt (l:addr) = spin_vtype(l)
vtypedef spin0_vt = [l:agez] spin_vtype(l)
vtypedef spin1_vt = [l:addr | l > null] spin_vtype(l)

(* ****** ****** *)
//
castfn
spin2ptr{l:addr} (spin(l)):<> ptr (l)
castfn
spin2ptr_vt{l:addr} (!spin_vt(l)):<> ptr (l)
//
overload ptrcast with spin2ptr
overload ptrcast with spin2ptr_vt
//
(* ****** ****** *)

castfn
unsafe_spin_t2vt{l:addr}(spin(l)): spin_vt(l)
castfn
unsafe_spin_vt2t{l:addr}(!spin_vt(l)): spin(l)

(* ****** ****** *)
//
fun{} spin_create ((*void*)): spin0
fun{} spin_create_exn ((*void*)): spin1
//
(* ****** ****** *)

fun{} spin_vt_destroy{l:addr}(spin_vt(l)): void

(* ****** ****** *)
//
fun{}
spin_lock{l:agz} (x: spin(l)):<!wrt> (locked_v(l) | void)
fun{}
spin_trylock{l:agz}
  (x: spin(l)): [b:bool] (option_v(locked_v(l), b) | bool(b))
fun{}
spin_unlock{l:addr} (pf: locked_v(l) | x: spin(l)):<!wrt> void
//
(* ****** ****** *)

abstype
mutex_type (l:addr) = ptr(l)
typedef mutex (l:addr) = mutex_type(l)
typedef mutex0 = [l:agez] mutex_type(l)
typedef mutex1 = [l:addr | l > null] mutex_type(l)

(* ****** ****** *)

absvtype
mutex_vtype (l:addr) = ptr(l)
vtypedef mutex_vt (l:addr) = mutex_vtype(l)

(* ****** ****** *)
//
castfn
mutex2ptr{l:addr} (mutex(l)):<> ptr (l)
castfn
mutex2ptr_vt{l:addr} (!mutex_vt(l)):<> ptr (l)
//
overload ptrcast with mutex2ptr
overload ptrcast with mutex2ptr_vt
//
(* ****** ****** *)

castfn
unsafe_mutex_t2vt{l:addr}(mutex(l)): mutex_vt(l)
castfn
unsafe_mutex_vt2t{l:addr}(!mutex_vt(l)): mutex(l)

(* ****** ****** *)
//
fun{} mutex_create ((*void*)): mutex0
fun{} mutex_create_exn ((*void*)): mutex1
//
(* ****** ****** *)

fun{} mutex_vt_destroy{l:addr}(mutex_vt(l)): void

(* ****** ****** *)
//
fun{}
mutex_lock{l:agz} (m: mutex(l)):<!wrt> (locked_v(l) | void)
fun{}
mutex_trylock{l:agz}
  (m: mutex(l)): [b:bool] (option_v(locked_v(l), b) | bool(b))
fun{}
mutex_unlock{l:addr} (pf: locked_v(l) | m: mutex(l)):<!wrt> void
//
(* ****** ****** *)
//
abstype
condvar_type(l:addr) = ptr(l)
typedef condvar (l:addr) = condvar_type(l)
typedef condvar0 = [l:agez] condvar_type(l)
typedef condvar1 = [l:addr | l > null] condvar_type(l)
//
(* ****** ****** *)

absvtype
condvar_vtype (l:addr) = ptr(l)
vtypedef condvar_vt (l:addr) = condvar_vtype(l)

(* ****** ****** *)

castfn
condvar2ptr{l:addr} (condvar(l)):<> ptr (l)
overload ptrcast with condvar2ptr
castfn
condvar2ptr_vt{l:addr} (!condvar_vt(l)):<> ptr (l)
overload ptrcast with condvar2ptr_vt

(* ****** ****** *)

castfn
unsafe_condvar_t2vt{l:addr}(condvar(l)): condvar_vt(l)
castfn
unsafe_condvar_vt2t{l:addr}(!condvar_vt(l)): condvar(l)

(* ****** ****** *)
//
fun{} condvar_create (): condvar0
fun{} condvar_create_exn (): condvar1
//
(* ****** ****** *)

fun{} condvar_vt_destroy{l:addr}(condvar_vt(l)): void

(* ****** ****** *)
//
fun{} condvar_signal (cvr: condvar1): void
fun{} condvar_broadcast (cvr: condvar1): void
//
fun{} condvar_wait{l:addr}
  (pf: !locked_v(l) | cvr: condvar1, p: mutex (l)): void
//
(* ****** ****** *)
  
typedef tid = lint
  
(* ****** ****** *)
//
fun{}
athread_self((*void*)): tid
//
(* ****** ****** *)
//
fun{}
athread_create_funenv
  {env:vtype}
(
  tid: &tid? >> _
, fwork: (env) -> void, env: env
) : int(*err*)
//
fun{}
athread_create_cloptr
(
  tid: &tid? >> _, fwork: () -<lincloptr1> void
) : int(*err*)
fun{}
athread_create_cloptr_exn
  (fwork: ((*void*)) -<lincloptr1> void): lint(*tid*)
//
(* ****** ****** *)

(* end of [athread.sats] *)
