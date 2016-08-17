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

(*
**
** A functional map implementation based on ordered lists
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: May 18, 2011
**
*)

(* ****** ****** *)
//
// HX-2014-01-15: Porting to ATS2
//
(* ****** ****** *)
//
abstype
mset_t0ype_type (a:t@ype+) = ptr
//
typedef
mset(a:t@ype) = mset_t0ype_type(a)
//
(* ****** ****** *)
//
typedef
cmp(a:t@ype) = (a, a) -<cloref> int
//
fun{a:t@ype}
compare_elt_elt(x1: a, x2: a, cmp: cmp(a)):<> int
//
(* ****** ****** *)
//
fun{}
funmset_make_nil
  {a:t@ype} ((*void*)):<> mset (a)
//
fun{a:t@ype}
funmset_make_sing(x: a): mset (a)
fun{a:t@ype}
funmset_make_pair
  (x1: a, x2: a, cmp: cmp a): mset (a)
//
fun{a:t@ype}
funmset_make_list(xs: List a, cmp: cmp a): mset (a)
//
(* ****** ****** *)

fun{a:t@ype}
funmset_size(xs: mset(INV(a))):<> Size

(* ****** ****** *)

fun{a:t@ype}
funmset_get_ntime
  (xs: mset(INV(a)), x0: a, cmp: cmp a):<> intGte(0)
// end of [funmset_get_ntime]

(* ****** ****** *)
//
fun{a:t@ype}
funmset_is_member
  (xs: mset(INV(a)), x0: a, cmp: cmp a):<> bool
fun{a:t@ype}
funmset_isnot_member
  (xs: mset(INV(a)), x0: a, cmp: cmp a):<> bool
//
(* ****** ****** *)

fun{a:t@ype}
funmset_is_equal
(
  xs1: mset(INV(a)), mxs2: mset(a), cmp: cmp(a)
) :<> bool // end of [funmset_is_equal]

(* ****** ****** *)

fun{a:t@ype}
funmset_is_subset
(
  xs1: mset(INV(a)), xs2: mset(a), cmp: cmp(a)
) :<> bool // end of [funmset_is_subset]

(* ****** ****** *)
(*
** HX:
** multiset ordering
** induced by the ordering on elements
*)
fun{a:t@ype}
funmset_compare
(
  xs1: mset(INV(a)), xs2: mset(a), cmp: cmp (a)
) :<> int // end of [funmset_compare]

(* ****** ****** *)

fun{a:t@ype}
funmset_insert
(
  xs: &mset(INV(a)) >> _, x0: a, cmp: cmp(a)
) :<!wrt> void // end of [funmset_insert]

fun{a:t@ype}
funmset_remove
(
  xs: &mset(INV(a)) >> _, x0: a, cmp: cmp(a)
) :<!wrt> bool(*removed/not: true/false*)
// end of [funmset_remove]

(* ****** ****** *)
//
fun{a:t@ype}
funmset_union
(
  xs1: mset(INV(a)), xs2: mset(a), cmp: cmp(a)
) : mset(a) // end of [funmset_union]
//
fun{a:t@ype}
funmset_intersect
(
  xs1: mset(INV(a)), xs2: mset(a), cmp: cmp(a)
) : mset(a) // end of [funmset_intersect]
//
(* ****** ****** *)
//
fun{a:t@ype}
funmset_listize (xs: mset(INV(a))): List0_vt(a) // no repeats
//
fun{a:t@ype} // if an element occurs n times, then it is repeated
funmset_mlistize (xs: mset(INV(a))): List0_vt(a) // n times in the output
//
(* ****** ****** *)

(* end of [funmset_listord.sats] *)
