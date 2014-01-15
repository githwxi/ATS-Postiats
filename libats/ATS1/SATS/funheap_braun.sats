(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2010 Hongwei Xi, Boston University
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

(*
**
** A functional heap implementation based on Braun trees
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: April, 2010 // based on a version done in November, 2008
**
*)

(* ****** ****** *)
//
// HX-2011-11-13:
// This style of heap is VERY inefficient! Please use funheap_binomial
// instead, which is about 20 times faster for a heap of the size 1M.
//
(* ****** ****** *)
//
// HX-2014-01-15: Porting to ATS2
//
(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

abstype
heap_t0ype_type (a:t@ype+)
stadef heap = heap_t0ype_type

(* ****** ****** *)

typedef cmp (a:t@ype) = (a, a) -<cloref> Sgn

(* ****** ****** *)

fun{a:t@ype}
compare_elt_elt (x1: a, x2: a, cmp: cmp a):<> Sgn

(* ****** ****** *)

fun{} funheap_make_nil {a:t@ype} ():<> heap (a)

(* ****** ****** *)
//
fun{a:t@ype}
funheap_size (heap a):<> size_t
//
(* ****** ****** *)
//
// HX: primarily for statistics
//
fun{a:t@ype}
funheap_height (hp: heap a):<> Nat
//
(* ****** ****** *)

fun{a:t@ype}
funheap_insert
  (hp: &heap (a) >> _, x: a, cmp: cmp a):<!wrt> void

(* ****** ****** *)

fun{a:t@ype}
funheap_delmin (
  hp: &heap (a) >> _, res: &a? >> opt (a, b), cmp: cmp a
) :<!wrt> #[b:bool] bool b // end of [funheap_delim]

(* ****** ****** *)

(* end of [funheap_braun.sats] *)
