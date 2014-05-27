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
// HX: general locking mechanism
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.locking"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time

(* ****** ****** *)

absview locked (l:addr)

(* ****** ****** *)

abstype spin_type (v:view, l:addr) = ptr(l)
abstype mutex_type (v:view, l:addr) = ptr(l)
abstype condvar_type (lc:addr, lm:addr) = ptr(lc)

(* ****** ****** *)
//
stadef spin = spin_type
stadef mutex = mutex_type
stadef condvar = condvar_type
//
typedef spin(v:view) = [l:addr] spin(v, l)
typedef mutex(v:view) = [l:addr] mutex(v, l)
//
(* ****** ****** *)
//
castfn
spin2ptr{v:view}{l:addr}(spin (v, l)):<> ptr(l)
//
castfn
mutex2ptr{v:view}{l:addr}(mutex (v, l)):<> ptr(l)
//
castfn
condvar2ptr{lc,lm:addr}(condvar (lc, lm)):<> ptr(lc)
//
(* ****** ****** *)
//
fun{}
spin_create_locked
  {v:view}
(
// argumentless
) : [l:addr] (locked(l) | spin(v, l))
//
fun{}
spin_create_unlocked
  {v:view} (pf: v | (*void*)): spin(v)
//
symintr spin_create
overload spin_create with spin_create_locked
overload spin_create with spin_create_unlocked
//
(* ****** ****** *)

fun{}
spin_lock
  {v:view}{l:addr}
  (lock: spin(v, l)): (v, locked(l)| void)
// end of [spin_lock]

fun{}
spin_unlock
  {v:view}{l:addr}
  (pf1: v, pf2: locked (l) | lock: spin(v, l)): void
// end of [spin_unlock]

(* ****** ****** *)
//
fun{}
mutex_create_locked
  {v:view}
(
// argumentless
) : [l:addr] (locked(l) | mutex(v, l))
//
fun{}
mutex_create_unlocked
  {v:view} (pf: v | (*void*)): mutex(v)
//
symintr mutex_create
overload mutex_create with mutex_create_locked
overload mutex_create with mutex_create_unlocked
//
(* ****** ****** *)

fun{}
mutex_lock
  {v:view}{l:addr}
  (lock: mutex(v, l)): (v, locked(l) | void)
// end of [mutex_lock]

fun{}
mutex_unlock
  {v:view}{l:addr}
  (pf1: v, pf2: locked (l) | lock: mutex(v, l)): void
// end of [mutex_unlock]

(* ****** ****** *)
//
fun{}
condvar_create
  {v:view}{lm:addr}
  (lock: mutex (v, lm)): [lc:addr] condvar (lc, lm)
//
fun{}
condvar_signal{lc,lm:addr} (cond: condvar(lc, lm)): void
fun{}
condvar_broadcast{lc,lm:addr} (cond: condvar(lc, lm)): void
//
fun{}
condvar_wait
  {v:view}{lc,lm:addr}
  (pf1: !v, pf2: !locked (lm) | cond: condvar(lc, lm), p: mutex (v, lm)): void
//
(* ****** ****** *)

(* end of [locking.sats] *)
