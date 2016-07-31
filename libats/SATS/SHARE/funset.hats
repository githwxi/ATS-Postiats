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

sortdef t0p = t@ype

(* ****** ****** *)
//
abstype
set_type (a:t@ype+) = ptr
typedef set (a:t0p) = set_type (a)
//
(* ****** ****** *)

fun{a:t0p}
compare_elt_elt (x1: a, x2: a):<> int

(* ****** ****** *)

fun{}
funset_nil {a:t0p} ():<> set(a)
fun{}
funset_make_nil {a:t0p} ():<> set(a)

fun{a:t0p}
funset_sing (x0: a):<> set(a) // singleton set
fun{a:t0p}
funset_make_sing (x0: a):<> set(a) // singleton set

(* ****** ****** *)

fun{a:t0p}
funset_make_list (xs: List(INV(a))):<> set(a)

(* ****** ****** *)

fun{}
funset_is_nil {a:t0p} (xs: set(INV(a))):<> bool
fun{}
funset_isnot_nil {a:t0p} (xs: set(INV(a))):<> bool

(* ****** ****** *)

fun{a:t0p}
funset_size (xs: set(INV(a))):<> size_t

(* ****** ****** *)

fun{a:t0p}
funset_is_member (xs: set(INV(a)), x0: a):<> bool
fun{a:t0p}
funset_isnot_member (xs: set(INV(a)), x0: a):<> bool

(* ****** ****** *)

fun{a:t0p}
funset_insert
  (xs: &set(INV(a)) >> _, x0: a):<!wrt> bool(*[x0] in [xs]*)
// end of [funset_insert]

fun{a:t0p}
funset_remove
  (xs: &set(INV(a)) >> _, x0: a):<!wrt> bool(*[x0] in [xs]*)
// end of [funset_remove]

(* ****** ****** *)

fun{a:t0p}
funset_getmax
(
  xs: set(INV(a)), x0: &a? >> opt(a, b)
) :<!wrt> #[b:bool] bool(b) // endfun
fun{a:t0p}
funset_getmax_opt (xs: set(INV(a))):<> Option_vt (a)

fun{a:t0p}
funset_getmin
(
  xs: set(INV(a)), x0: &a? >> opt(a, b)
) :<!wrt> #[b:bool] bool(b) // endfun
fun{a:t0p}
funset_getmin_opt (xs: set(INV(a))):<> Option_vt (a)

(* ****** ****** *)

fun{a:t0p}
funset_takeoutmax
(
  xs: &set(INV(a)) >> _, x0: &a? >> opt(a, b)
) :<!wrt> #[b:bool] bool (b)
fun{a:t0p}
funset_takeoutmax_opt (xs: &set(INV(a)) >> _):<> Option_vt(a)

(* ****** ****** *)

fun{a:t0p}
funset_takeoutmin
(
  xs: &set(INV(a)) >> _, x0: &a? >> opt(a, b)
) :<!wrt> #[b:bool] bool (b)
fun{a:t0p}
funset_takeoutmin_opt (xs: &set(INV(a)) >> _):<> Option_vt(a)

(* ****** ****** *)

fun{a:t0p}
funset_union (xs1: set(INV(a)), xs2: set(a)):<> set(a)
fun{a:t0p}
funset_intersect (xs1: set(INV(a)), xs2: set(a)):<> set(a)
fun{a:t0p}
funset_differ (xs1: set(INV(a)), xs2: set(a)):<> set(a)
fun{a:t0p}
funset_symdiff (xs1: set(INV(a)), xs2: set(a)):<> set(a)

(* ****** ****** *)

fun{a:t0p}
funset_equal (xs1: set(INV(a)), xs2: set(a)):<> bool

(* ****** ****** *)
//
// set ordering induced by the ordering on elements
//
fun{a:t0p}
funset_compare (xs1: set(INV(a)), xs2: set(a)):<> Sgn
//
(* ****** ****** *)

fun{a:t0p}
funset_is_subset (xs1: set(INV(a)), xs2: set(a)):<> bool
fun{a:t0p}
funset_is_supset (xs1: set(INV(a)), xs2: set(a)):<> bool

(* ****** ****** *)
//
fun{}
fprint_funset$sep
  (out: FILEref): void // ", "
//
fun{a:t0p}
fprint_funset
  (out: FILEref, xs: set(INV(a))): void
fun{a:t0p}
fprint_funset_sep
  (out: FILEref, xs: set(INV(a)), sep: string): void
//
overload fprint with fprint_funset
//
(* ****** ****** *)
//
fun{
a:t0p}{env:vt0p
} funset_foreach$fwork
  (x: a, env: &(env) >> _): void
//
fun{a:t0p}
funset_foreach (set: set(INV(a))): void
fun{
a:t0p}{env:vt0p
} funset_foreach_env
  (set: set(INV(a)), env: &(env) >> _): void
// end of [funset_foreach_env]
//
(* ****** ****** *)
//
fun
{a:t0p}
funset_tabulate{n:nat}(n: int(n)): set(a)
fun
{a:t0p}
funset_tabulate$fopr (index: intGte(0)): (a)
//
(* ****** ****** *)

fun{a:t0p}
funset_listize(xs: set(INV(a))):<!wrt> List0_vt(a)

(* ****** ****** *)
//
fun{
a:t0p}{b:t0p
} funset_flistize$fopr(x: a): b
fun{
a:t0p}{b:t0p
} funset_flistize (xs: set(INV(a))): List0_vt(b)
//
(* ****** ****** *)
//
fun{a:t0p}
funset_streamize(xs: set(INV(a))):<!wrt> stream_vt(a)
//
(* ****** ****** *)

(* end of [funset.hats] *)
