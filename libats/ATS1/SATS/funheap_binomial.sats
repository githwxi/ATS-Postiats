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
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
// HX-2014-01-15: Porting to ATS2
//
(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no staloading

(* ****** ****** *)

abstype
heap_t0ype_type (a:t@ype+)
stadef heap = heap_t0ype_type

(* ****** ****** *)
//
typedef cmp (a:t@ype) = (a, a) -<cloref> Sgn
//
fun{a:t@ype}
compare_elt_elt (x1: a, x2: a, cmp: cmp a):<> Sgn
//
(* ****** ****** *)

fun{} funheap_make_nil {a:t@ype} ():<> heap (a)

(* ****** ****** *)

fun{a:t@ype} funheap_size (hp: heap a): size_t

(* ****** ****** *)

fun
funheap_is_empty{a:t@ype} (hp: heap (a)):<> bool
fun
funheap_isnot_empty{a:t@ype} (hp: heap (a)):<> bool

(* ****** ****** *)

fun{a:t@ype}
funheap_insert
  (hp: &heap (a) >> _, x: a, cmp: cmp a):<!wrt> void
// end of [funheap_insert]

(* ****** ****** *)

fun{a:t@ype}
funheap_getmin (
  hp: heap (a), cmp: cmp a, res: &a? >> opt (a, b)
) :<!wrt> #[b:bool] bool b // end of [funheap_getmin]

(* ****** ****** *)

fun{a:t@ype}
funheap_delmin (
  hp: &heap (a) >> _, cmp: cmp a, res: &a? >> opt (a, b)
) :<!wrt> #[b:bool] bool b // end of [funheap_delmin]

(* ****** ****** *)

fun{a:t@ype}
funheap_merge
  (hp1: heap (a), hp2: heap (a), cmp: cmp a):<> heap (a)
// end of [funheap_merge]

(* ****** ****** *)

(* end of [funheap_binomial.sats] *)
