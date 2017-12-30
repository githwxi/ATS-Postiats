(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2017 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: December, 2017 *)
(* Authoremail: gmmhwxiATgmailDOTcom *)

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.ML"
//
#define
ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
fun{a:t0p}
list_tuple_0(): list(a, 0)
//
fun{a:t0p}
list_tuple_1(x0: a): list(a, 1)
fun{a:t0p}
list_tuple_2(x0: a, x1: a): list(a, 2)
fun{a:t0p}
list_tuple_3(x0: a, x1: a, x2: a): list(a, 3)
//
fun{a:t0p}
list_tuple_4
  (x0: a, x1: a, x2: a, x3: a): list(a, 4)
fun{a:t0p}
list_tuple_5
  (x0: a, x1: a, x2: a, x3: a, x4: a): list(a, 5)
fun{a:t0p}
list_tuple_6
  (x0: a, x1: a, x2: a, x3: a, x4: a, x5: a): list(a, 6)
//
(* ****** ****** *)
//
fun{x:t0p}
list_exists_cloptr
( xs: List(INV(x))
, pred: (x) -<cloptr> bool):<!wrt> bool
fun{x:t0p}
list_exists_cloref
( xs: List(INV(x))
, pred: (x) -<cloref> bool):<(*0*)> bool
//
fun{x:t0p}
list_iexists_cloptr
  {n:int}
(
  xs: list(INV(x), n), pred: (natLt(n), x) -<cloptr> bool
) :<!wrt> bool // end of [list_iexists_cloptr]
fun{x:t0p}
list_iexists_cloref
  {n:int}
(
  xs: list(INV(x), n), pred: (natLt(n), x) -<cloref> bool
) :<(*0*)> bool // end of [list_iexists_cloref]
//
(* ****** ****** *)
//
fun{x:t0p}
list_forall_cloptr
( xs: List(INV(x))
, pred: (x) -<cloptr> bool):<!wrt> bool
fun{x:t0p}
list_forall_cloref
( xs: List(INV(x))
, pred: (x) -<cloref> bool):<(*0*)> bool
//
fun{x:t0p}
list_iforall_cloptr
  {n:int}
(
  xs: list(INV(x), n), pred: (natLt(n), x) -<cloptr> bool
) :<!wrt> bool // end of [list_iforall_cloptr]
fun{x:t0p}
list_iforall_cloref
  {n:int}
(
  xs: list(INV(x), n), pred: (natLt(n), x) -<cloref> bool
) :<(*0*)> bool // end of [list_iforall_cloref]
//
(* ****** ****** *)
//
fun{x:t0p}
list_equal_cloref
  (List(INV(x)), List(x), eqfn: (x, x) -<cloref> bool):<> bool
//
fun{x:t0p}
list_compare_cloref
  (List(INV(x)), List(x), cmpfn: (x, x) -<cloref> int):<> int
//
(* ****** ****** *)
//
fun{x:t0p}
list_app_fun
  (List(INV(x)), fwork: (x) -<fun1> void): void
fun{x:t0p}
list_app_clo
  (List(INV(x)), fwork: &(x) -<clo1> void): void
//
fun{x:t0p}
list_app_cloref
  (xs: List(INV(x)), fwork: (x) -<cloref1> void): void
//
(* ****** ****** *)
//
fun{
x:t0p}{y:vt0p
} list_map_fun{n:int}
  (xs: list(INV(x), n), f: (x) -<fun1> y): list_vt(y, n)
fun{
x:t0p}{y:vt0p
} list_map_clo{n:int}
  (xs: list(INV(x), n), f: &(x) -<clo1> y): list_vt(y, n)
//
fun{
x:t0p}{y:vt0p
} list_map_cloref{n:int}
  (xs: list(INV(x), n), f: (x) -<cloref1> y): list_vt(y, n)
//
(* ****** ****** *)
//
fun{
a:vt0p
} list_tabulate_fun{n:nat}
  (n: int n, f: natLt(n) -<fun1> a): list_vt(a, n)
fun{
a:vt0p
} list_tabulate_clo{n:nat}
  (n: int n, f: &(natLt(n)) -<clo1> a): list_vt(a, n)
//
fun{
a:vt0p
} list_tabulate_cloref{n:nat}
  (n: int n, f: natLt(n) -<cloref1> a): list_vt(a, n)
//
(* ****** ****** *)
//
fun
{x:t0p}
list_foreach_fun
  {fe:eff}
(
  xs: List(INV(x)), f: (x) -<fun,fe> void
) :<fe> void // end of [list_foreach_fun]
//
fun
{x:t0p}
list_foreach_clo
  {fe:eff}
(
  xs: List(INV(x)), f0: &(x) -<clo,fe> void
) :<fe> void // end of [list_foreach_clo]
fun
{x:t0p}
list_foreach_vclo
  {v:view}{fe:eff}
(
  pf: !v
| xs: List(INV(x))
, f0: &(!v | x) -<clo,fe> void
) :<fe> void // end of [list_foreach_vclo]
//
fun
{x:t0p}
list_foreach_cloptr
  {fe:eff} (
  xs: List(INV(x)), f0: (x) -<cloptr,fe> void
) :<fe,!wrt> void // end of [list_foreach_cloptr]
fun
{x:t0p}
list_foreach_vcloptr
  {v:view}{fe:eff} (
  pf: !v
| xs: List(INV(x))
, f0: (!v | x) -<cloptr,fe> void
) :<fe,!wrt> void // end of [list_foreach_vcloptr]
//
fun
{x:t0p}
list_foreach_cloref
  {fe:eff} (
  xs: List(INV(x)), f: (x) -<cloref,fe> void
) :<fe> void // end of [list_foreach_cloref]
//
(* ****** ****** *)
//
fun
{a:t0p}
list_foreach_method
(
xs: List(INV(a))
) : (cfun(a,void)) -<cloref1> void
//
overload .foreach with list_foreach_method
//
(* ****** ****** *)
//
fun{
x:t0p
} list_iforeach_cloref
  {n:int}
(
  xs: list(INV(x), n)
, fwork: (natLt(n), x) -<cloref1> void
) : void // end of [list_iforeach_cloref]
//
(* ****** ****** *)
//
fun
{a:t0p}
list_iforeach_method
  {n:int}
(
xs: list(INV(a), n)
) : (cfun(natLt(n),a,void)) -<cloref1> void
//
overload .iforeach with list_iforeach_method
//
(* ****** ****** *)
//
fun{
res:vt0p}{x:t0p
} list_foldleft_cloptr
  (xs: List(INV(x)), ini: res, fopr: (res, x) -<cloptr1> res): res
fun{
res:vt0p}{x:t0p
} list_foldleft_cloref
  (xs: List(INV(x)), ini: res, fopr: (res, x) -<cloref1> res): res
//
(* ****** ****** *)
//
fun{
x:t0p}{res:vt0p
} list_foldright_cloptr
  (xs: List(INV(x)), fopr: (x, res) -<cloptr1> res, snk: res): res
fun{
x:t0p}{res:vt0p
} list_foldright_cloref
  (xs: List(INV(x)), fopr: (x, res) -<cloref1> res, snk: res): res
//
(* ****** ****** *)

(* end of [list.sats] *)
