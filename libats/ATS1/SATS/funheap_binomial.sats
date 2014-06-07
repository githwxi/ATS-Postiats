(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2011 Hongwei Xi, Boston University
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
// HX-2014-01-15:
// Porting to ATS2 from ATS1
//
(* ****** ****** *)
//
abstype
heap_t0ype_type (a:t@ype+) = ptr
//
typedef heap(a:t0p) = heap_t0ype_type(a)
//
(* ****** ****** *)
//
typedef cmp (a:t0p) = (a, a) -<cloref> int
//
fun{a:t0p}
compare_elt_elt (x1: a, x2: a, cmp: cmp a):<> int
//
(* ****** ****** *)

fun{} funheap_make_nil{a:t0p} ():<> heap (a)

(* ****** ****** *)

fun{a:t0p} funheap_size (hp: heap(INV(a))):<> Size

(* ****** ****** *)

fun
funheap_is_empty{a:t0p} (hp: heap(INV(a))):<> bool
fun
funheap_isnot_empty{a:t0p} (hp: heap(INV(a))):<> bool

(* ****** ****** *)

fun{a:t0p}
funheap_insert
  (hp: &heap(INV(a)) >> _, x: a, cmp: cmp a):<!wrt> void
// end of [funheap_insert]

(* ****** ****** *)

fun{a:t0p}
funheap_getmin (
  hp: heap(INV(a)), cmp: cmp a, res: &a? >> opt (a, b)
) :<!wrt> #[b:bool] bool b // end of [funheap_getmin]

(* ****** ****** *)

fun{a:t0p}
funheap_delmin (
  hp: &heap(INV(a)) >> _, cmp: cmp a, res: &a? >> opt (a, b)
) :<!wrt> #[b:bool] bool b // end of [funheap_delmin]

fun{a:t0p}
funheap_delmin_opt
  (hp: &heap(INV(a)) >> _, cmp: cmp a):<!wrt> Option_vt (a)
// end of [funheap_delmin_opt]

(* ****** ****** *)

fun{a:t0p}
funheap_merge
  (hp1: heap(INV(a)), hp2: heap (a), cmp: cmp a):<> heap (a)
// end of [funheap_merge]

(* ****** ****** *)

(* end of [funheap_binomial.sats] *)
