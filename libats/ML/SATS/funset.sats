(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: August, 2013 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
// HX-2013-08:
// for sets of elements of type a
//
abstype
set_type
(
  a:t@ype+
) = ptr(*boxed*)
//
typedef set(a:t0p) = set_type(a)
//
(* ****** ****** *)

fun{a:t0p}
compare_elt_elt(x: a, y: a):<> int

(* ****** ****** *)

fun{} funset_nil{a:t0p}():<> set(a)
fun{} funset_make_nil{a:t0p}():<> set(a)

(* ****** ****** *)

fun{a:t0p} funset_sing(x: a): set(a)
fun{a:t0p} funset_make_sing(x: a): set(a)

(* ****** ****** *)

fun{a:t0p}
funset_make_list(xs: list0(INV(a))): set(a)

(* ****** ****** *)
//
fun
{a:t0p}
fprint_funset
(
  out: FILEref, set: set(INV(a))
) : void // end of [fprint_funset]
//
fun{}
fprint_funset$sep(out: FILEref): void // fprint(", ")
//
overload fprint with fprint_funset
//
(* ****** ****** *)

fun{}
funset_is_nil{a:t0p}(xs: set(INV(a))):<> bool
fun{}
funset_isnot_nil{a:t0p}(xs: set(INV(a))):<> bool

(* ****** ****** *)

fun{a:t0p}
funset_size(xs: set(INV(a))):<> size_t

(* ****** ****** *)

fun{a:t0p}
funset_is_member(xs: set(INV(a)), x0: a):<> bool
fun{a:t0p}
funset_isnot_member(xs: set(INV(a)), x0: a):<> bool

(* ****** ****** *)

fun{a:t0p}
funset_insert
  (xs: &set(INV(a)) >> _, x0: a): bool(*[x0] in [xs]*)
// end of [funset_insert]

(* ****** ****** *)

fun{a:t0p}
funset_remove
  (xs: &set(INV(a)) >> _, x0: a): bool(*[x0] in [xs]*)
// end of [funset_remove]

(* ****** ****** *)

fun{a:t0p}
funset_getmax_opt(xs: set(INV(a))): Option_vt(a)
fun{a:t0p}
funset_getmin_opt(xs: set(INV(a))): Option_vt(a)

(* ****** ****** *)

fun{a:t0p}
funset_takeoutmax_opt(xs: &set(INV(a)) >> _): Option_vt(a)
fun{a:t0p}
funset_takeoutmin_opt(xs: &set(INV(a)) >> _): Option_vt(a)

(* ****** ****** *)

fun{a:t0p}
funset_union(xs1: set(INV(a)), xs2: set(a)):<> set(a)
fun{a:t0p}
funset_intersect(xs1: set(INV(a)), xs2: set(a)):<> set(a)
fun{a:t0p}
funset_differ(xs1: set(INV(a)), xs2: set(a)):<> set(a)
fun{a:t0p}
funset_symdiff(xs1: set(INV(a)), xs2: set(a)):<> set(a)

(* ****** ****** *)

fun{a:t0p}
funset_equal(xs1: set(INV(a)), xs2: set(a)):<> bool

(* ****** ****** *)
//
// HX: set ordering induced by the ordering on elements
//
fun{a:t0p}
funset_compare(xs1: set(INV(a)), xs2: set(a)):<> int

(* ****** ****** *)
//
fun{a:t0p}
funset_is_subset(xs1: set(INV(a)), xs2: set(a)):<> bool
fun{a:t0p}
funset_is_supset(xs1: set(INV(a)), xs2: set(a)):<> bool
//
(* ****** ****** *)
//
fun{a:t0p}
funset_foreach(set: set(INV(a))): void
fun
{a:t0p}
{env:vt0p}
funset_foreach_env
  (set: set(INV(a)), env: &(env) >> _): void
// end of [funset_foreach_env]
//
fun
{a:t0p}
{env:vt0p}
funset_foreach$fwork(x: a, env: &(env) >> _): void
//
(* ****** ****** *)
//
fun{a:t0p}
funset_foreach_cloref
  (set: set(INV(a)), fwork: (a) -<cloref1> void): void
//
(* ****** ****** *)
//
fun{a:t0p}
funset_tabulate_cloref
  {n:nat}(int(n), fopr: (natLt(n)) -<cloref1> a): set(a)
//
(* ****** ****** *)
//
fun{a:t0p}
funset_listize(xs: set(INV(a))):<> list0(a)
//
fun{a:t0p}
funset_streamize(xs: set(INV(a))):<> stream_vt(a)
//
(* ****** ****** *)

typedef
set_modtype
(
  elt:t@ype
) = $rec{
//
nil = () -<> set(elt)
,
sing =
$d2ctype(funset_sing<elt>)
,
make_list =
$d2ctype(funset_make_list<elt>)
,
size = $d2ctype(funset_size<elt>)
,
is_nil = (set(elt)) -<> bool
,
isnot_nil = (set(elt)) -<> bool
,
insert = $d2ctype(funset_insert<elt>)
,
remove = $d2ctype(funset_remove<elt>)
,
union = $d2ctype(funset_union<elt>)
,
intersect = $d2ctype(funset_intersect<elt>)
,
listize = $d2ctype(funset_listize<elt>)
,
streamiize = $d2ctype(funset_streamize<elt>)
//
} (* end of [set_modtype] *)

(* ****** ****** *)
//
fun
{a:t@ype}
funset_make_module((*void*)): set_modtype(a)
//
(* ****** ****** *)

(* end of [funset.sats] *)
