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
** A linear map implementation based on ordered lists
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: February 17, 2012
**
*)

(* ****** ****** *)
//
// HX-2014-01-17:
// Porting to ATS2 from ATS1
//
(* ****** ****** *)

absvtype
set_t0ype_vtype (a:t@ype+) = ptr
vtypedef
set (a:t0p) = set_t0ype_vtype (a)

(* ****** ****** *)

typedef
cmp (a:t0p) = (a, a) -<cloref> int

(* ****** ****** *)

fun{a:t0p}
compare_elt_elt
  (x1: a, x2: a, cmp: cmp (a)):<> int
// end of [compare_elt_elt]

(* ****** ****** *)

fun{} linset_nil{a:t0p} ():<> set (a)
fun{} linset_make_nil{a:t0p} ():<> set (a)

(* ****** ****** *)

fun{a:t0p}
linset_make_sing (x: a):<!wrt> set (a) // singleton set

(* ****** ****** *)

fun{
} linset_is_empty {a:t0p} (xs: !set(INV(a))):<> bool
fun{
} linset_isnot_empty {a:t0p} (xs: !set(INV(a))):<> bool

(* ****** ****** *)
//
// HX: the time complexity of this function is O(n)
//
fun{a:t0p} linset_size (xs: !set(INV(a))):<> sizeGte(0)
//
(* ****** ****** *)

fun{a:t0p}
linset_is_member (xs: !set(INV(a)), x0: a, cmp: cmp a):<> bool
fun{a:t0p}
linset_isnot_member (xs: !set(INV(a)), x0: a, cmp: cmp a):<> bool

(* ****** ****** *)

fun{a:t0p}
linset_is_subset // xs2 contains xs1
  (xs1: !set(INV(a)), xs2: !set(a), cmp: cmp a):<> bool
// end of [linset_is_subset]

fun{a:t0p}
linset_is_supset // xs1 contains xs2
  (xs1: !set(INV(a)), xs2: !set(a), cmp: cmp a):<> bool
// end of [linset_is_supset]

fun{a:t0p}
linset_is_equal
  (xs1: !set(INV(a)), xs2: !set(a), cmp: cmp a):<> bool
// end of [linset_is_equal]

(* ****** ****** *)
//
fun{a:t0p}
linset_copy (!set(INV(a))):<!wrt> set (a)
//
fun{a:t0p}
linset_free (xs: set(INV(a))):<!wrt> void
//
(* ****** ****** *)

fun{a:t0p}
linset_insert
  (xs: &set(INV(a)) >> _, x0: a, cmp: cmp a) :<!wrt> bool
// end of [linset_insert]

(* ****** ****** *)

fun{a:t0p}
linset_remove
  (xs: &set(INV(a)) >> _, x0: a, cmp: cmp (a)):<!wrt> bool
// end of [linset_remove]

(* ****** ****** *)
//
// HX: choosing an element in an unspecified manner
//
fun{a:t0p}
linset_choose (
  xs: !set(INV(a)), x: &a? >> opt (a, b)
) :<!wrt> #[b:bool] bool (b) // end of [linset_choose]

fun{a:t0p}
linset_choose_opt (xs: !set(INV(a))):<!wrt> Option_vt(a)

(* ****** ****** *)
//
// HX: removing an element chosen in an unspecified manner
//
fun{a:t0p}
linset_chooseout (
  xs: &set(INV(a)) >> _, x: &a? >> opt (a, b)
) :<!wrt> #[b:bool] bool (b) // end of [linset_chooseout]
//
fun{a:t0p}
linset_chooseout_opt (xs: &set(INV(a)) >> _):<!wrt> Option_vt(a)
//
(* ****** ****** *)

fun{a:t0p}
linset_union
  (xs1: set(INV(a)), xs2: set(a), cmp: cmp a):<!wrt> set (a)
(*
fun{a:t0p}
linset_intersect
  (xs1: set(INV(a)), xs2: set(a), cmp: cmp a):<!wrt> set (a)
fun{a:t0p}
linset_diff
  (xs1: set(INV(a)), xs2: set(a), cmp: cmp a):<!wrt> set (a)
fun{a:t0p}
linset_symdiff
  (xs1: set(INV(a)), xs2: set(a), cmp: cmp a):<!wrt> set (a)
*)
(* ****** ****** *)

fun{a:t0p}
linset_listize (xs: set(INV(a))):<!wrt> List0_vt (a)
fun{a:t0p}
linset_listize1 (xs: !set(INV(a))):<!wrt> List0_vt (a)

(* ****** ****** *)

fun{a:t0p}
fprint_linset_sep
  (out: FILEref, xs: !set(INV(a)), sep: string): void
// end of [fprint_linset_sep]

(* ****** ****** *)

fun{a:t0p}
linset_foreach_funenv
  {v:view}{vt:viewtype}
(
  pf: !v 
| xs: !set(INV(a)), f: (!v | a, !vt) -> void, env: !vt
) : void // end of [linset_foreach_funenv]

(* ****** ****** *)

fun{a:t0p}
linset_foreach_fun
(
  xs: !set(INV(a)), f: (a) -<fun1> void
) : void // end of [linset_foreach_fun]

fun{a:t0p}
linset_foreach_cloref
(
  xs: !set(INV(a)), f: (a) -<cloref1> void
) : void // end of [linset_foreach_cloref]

(* ****** ****** *)

(* end of [linset_listord.sats] *)
