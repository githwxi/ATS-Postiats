(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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

staload "libats/ML/basics.sats"

(* ****** ****** *)

sortdef t0p = t@ype

(* ****** ****** *)
//
// HX: for sets of elements of type a
//
abstype set_t0ype_type (a: t@ype+)
typedef set (a:t0p) = set_t0ype_type (a)
//
(* ****** ****** *)

typedef cmp (a:t0p) = (a, a) -<cloref0> int

(* ****** ****** *)

fun{a:t0p}
funset_is_member (xs: set a, x0: a, cmp: cmp a):<> bool
fun{a:t0p}
funset_isnot_member (xs: set a, x0: a, cmp: cmp a):<> bool

(* ****** ****** *)

fun{a:t0p}
funset_insert
  (xs: &set (a) >> _, x0: a, cmp: cmp (a)):<> bool(*[x0] in [xs]*)
// end of [funset_insert]

fun{a:t0p}
funset_remove
  (xs: &set (a) >> _, x0: a, cmp: cmp (a)):<> bool(*[x0] is [xs]*)
// end of [funset_remove]

(* ****** ****** *)

fun{a:t0p}
funset_union
  (xs1: set (a), xs2: set (a), cmp: cmp a):<> set (a)
// end of [funset_union]
fun{a:t0p}
funset_intersect
  (xs1: set (a), xs2: set (a), cmp: cmp a):<> set (a)
// end of [funset_intersect]
fun{a:t0p}
funset_diff
  (xs1: set (a), xs2: set (a), cmp: cmp a):<> set (a)
// end of [funset_diff]
fun{a:t0p}
funset_symdiff
  (xs1: set (a), xs2: set (a), cmp: cmp a):<> set (a)
// end of [funset_symdiff]

(* ****** ****** *)

fun{a:t0p}
funset_is_equal
  (xs1: set (a), xs2: set (a), cmp: cmp a):<> bool
// end of [funset_is_equal]

fun{a:t0p}
funset_is_subset
  (xs1: set (a), xs2: set (a), cmp: cmp a):<> bool
// end of [funset_is_subset]

fun{a:t0p}
funset_is_supset
  (xs1: set (a), xs2: set (a), cmp: cmp a):<> bool
// end of [funset_is_supset]

(* ****** ****** *)
//
// set ordering induced by the ordering on elements
//
fun{a:t0p}
funset_compare
  (xs1: set (a), xs2: set (a), cmp: cmp a):<> int
// end of [funset_compare]

(* ****** ****** *)

fun{a:t0p}
funset_listize (xs: set (a)):<> list0 (a)

(* ****** ****** *)

(* end of [funset.sats] *)
