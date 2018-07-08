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

abstype
set_t0ype_type (a:t@ype+) = ptr
typedef set (a:t0p) = set_t0ype_type (a)

(* ****** ****** *)

typedef cmp (a:t0p) = (a, a) -<cloref> int

fun{a:t0p}
compare_elt_elt (x1: a, x2: a, cmp: cmp(a)):<> int

(* ****** ****** *)

fun{}
funset_make_nil{a:t0p} ():<> set (a)
fun{a:t0p}
funset_make_sing (x0: a):<> set (a) // singleton set
fun{a:t0p}
funset_make_list (xs: List(INV(a)), cmp: cmp a):<!wrt> set (a)

(* ****** ****** *)

fun{a:t0p}
funset_size (xs: set(INV(a))):<> sizeGte(0)

(* ****** ****** *)

fun{a:t0p}
funset_is_member
  (xs: set(INV(a)), x0: a, cmp: cmp a):<> bool
fun{a:t0p}
funset_isnot_member
  (xs: set(INV(a)), x0: a, cmp: cmp a):<> bool

(* ****** ****** *)

fun{a:t0p}
funset_is_equal
  (xs1: set(INV(a)), xs2: set (a), cmp: cmp (a)):<> bool
// end of [funset_is_equal]

fun{a:t0p}
funset_is_subset
  (xs1: set(INV(a)), xs2: set (a), cmp: cmp (a)):<> bool
// end of [funset_is_subset]

(* ****** ****** *)
(*
** set ordering induced by the ordering on elements
*)
fun{a:t0p}
funset_compare
  (xs1: set(INV(a)), xs2: set(a), cmp: cmp (a)):<> int
// end of [funset_compare]

(* ****** ****** *)

fun{a:t0p}
funset_insert (
  xs: &set(INV(a)) >> _, x0: a, cmp: cmp (a)
) :<!wrt> bool (* [x0] alreay exists in [xs] *)

fun{a:t0p}
funset_remove (
  xs: &set(INV(a)) >> _, x0: a, cmp: cmp (a)
) :<!wrt> bool(* removed/~removed: true/false *)

(* ****** ****** *)

fun{a:t0p}
funset_union
  (xs1: set(INV(a)), xs2: set(a), cmp: cmp (a)):<> set (a)
fun{a:t0p} funset_intersect
  (xs1: set(INV(a)), xs2: set(a), cmp: cmp (a)):<> set (a)
fun{a:t0p} funset_diff
  (xs1: set(INV(a)), xs2: set(a), cmp: cmp (a)):<> set (a)
fun{a:t0p} funset_symdiff
  (xs1: set(INV(a)), xs2: set(a), cmp: cmp (a)):<> set (a)

(* ****** ****** *)

fun{a:t0p}
funset_foreach_funenv
  {v:view}{vt:vtype}
(
  pf: !v  | xs: set(INV(a)), f: (!v | a, !vt) -> void, env: !vt
) : void // end of [funset_foreach_funenv]

(* ****** ****** *)
//
castfn
funset2list
  {a:t0p}(xs: set(INV(a))):<> List (a)
//
fun{a:t0p}
funset_listize(xs: set(a)):<!wrt> List0_vt (a) // = list_copy
//
(* ****** ****** *)

(* end of [funset_listord.sats] *)
