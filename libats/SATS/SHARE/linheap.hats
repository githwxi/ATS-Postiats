(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: November, 2011 *)

(* ****** ****** *)

absvtype heap_vtype (a:vt@ype+) = ptr
vtypedef heap (a:vt0p) = heap_vtype (a)

(* ****** ****** *)

fun{a:vt0p}
compare_elt_elt (x1: &a, x2: &a):<> int

(* ****** ****** *)

fun{} linheap_nil {a:vt0p} ():<> heap (a)
fun{} linheap_make_nil {a:vt0p} ():<> heap (a)

(* ****** ****** *)

fun{
} linheap_is_nil{a:vt0p}(hp: !heap (INV(a))):<> bool
fun{
} linheap_isnot_nil{a:vt0p}(hp: !heap (INV(a))):<> bool

(* ****** ****** *)

fun{a:vt0p}
linheap_size (hp: !heap (INV(a))):<> size_t

(* ****** ****** *)

fun{a:vt0p}
linheap_insert (hp: &heap (INV(a)) >> _, x: a): void

(* ****** ****** *)

fun{a:t0p}
linheap_getmin
(
  hp: !heap (INV(a)), res: &a? >> opt (a, b)
) : #[b:bool] bool (b) // endfun

fun{a:vt0p}
linheap_getmin_ref (hp: !heap (INV(a))): cPtr0 (a)

fun{a:t0p}
linheap_getmin_opt (hp: !heap (INV(a))): Option_vt (a)

(* ****** ****** *)

fun{a:vt0p}
linheap_delmin
(
  hp: &heap (INV(a)) >> _, res: &a? >> opt (a, b)
) : #[b:bool] bool b // endfun

fun{a:vt0p}
linheap_delmin_opt (hp: &heap (INV(a)) >> _): Option_vt (a)

(* ****** ****** *)

fun{a:vt0p}
linheap_merge
  (hp1: heap (INV(a)), hp2: heap (a)): heap (a)
// end of [linheap_merge]

(* ****** ****** *)

fun{a:t0p}
linheap_free (hp: heap (INV(a))):<!wrt> void

(* ****** ****** *)

fun{x:vt0p}
linheap_freelin$clear
  (x: &x >> x?):<!wrt> void
fun{a:vt0p}
linheap_freelin (hp: heap (INV(a))):<!wrt> void

(* ****** ****** *)
//
// HX: a heap is freed only if it is empty
//
fun{a:vt0p}
linheap_free_ifnil
  (hp: !heap (INV(a)) >> opt (heap (a), b)) :<> #[b:bool] bool(b)
// end of [linheap_free_ifnil]

(* ****** ****** *)

(* end of [linheap.hats] *)
