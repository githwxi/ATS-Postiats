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

#staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
// HX: prelude/string
//
(* ****** ****** *)
//
fun{}
string_tabulate_cloref
  {n:int}
( n: size_t(n)
, f: (sizeLt(n)) -<cloref1> charNZ): strnptr(n)
//
(* ****** ****** *)
//
// HX-2017-12-30:
// prelude/intrange
//
(* ****** ****** *)

fun{}
int_forall_cloptr
(
 n: int, pred: (int) -<cloptr1> bool
) : bool // end of [int_forall_cloptr]
fun{}
int_forall_cloref
(
 n: int, pred: (int) -<cloref1> bool
) : bool // end of [int_forall_cloref]

(* ****** ****** *)

fun{}
intrange_forall_cloptr
(
 m: int, n: int, pred: (int) -<cloptr1> bool
) : bool // end of [intrange_forall_cloptr]
fun{}
intrange_forall_cloref
(
 m: int, n: int, pred: (int) -<cloref1> bool
) : bool // end of [intrange_forall_cloref]

(* ****** ****** *)
//
fun{}
int_foreach_cloptr
(
 n: int, fwork: (int) -<cloptr1> void
) : int // end of [int_foreach_cloptr]
fun{}
int_foreach_cloref
(
 n: int, fwork: (int) -<cloref1> void
) : int // end of [int_foreach_cloref]
//
fun{}
intrange_foreach_cloptr
(
 l: int, r: int, fwork: (int) -<cloptr1> void
) : int // end of [intrange_foreach_cloptr]
fun{}
intrange_foreach_cloref
(
 l: int, r: int, fwork: (int) -<cloref1> void
) : int // end of [intrange_foreach_cloref]
//
(* ****** ****** *)
//
fun{}
int_rforeach_cloptr
(
 n: int, fwork: (int) -<cloptr1> void
) : int // end of [int_rforeach_cloptr]
fun{}
int_rforeach_cloref
(
 n: int, fwork: (int) -<cloref1> void
) : int // end of [int_rforeach_cloref]
//
fun{}
intrange_rforeach_cloptr
(
 l: int, r: int, fwork: (int) -<cloptr1> void
) : int // end of [intrange_rforeach_cloptr]
fun{}
intrange_rforeach_cloref
(
 l: int, r: int, fwork: (int) -<cloref1> void
) : int // end of [intrange_rforeach_cloref]
//
(* ****** ****** *)
//
// HX: prelude/list
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
//
// HX: prelude/list_vt
//
(* ****** ****** *)
//
fun
{x:vt0p}
{y:vt0p}
list_vt_map_fun{n:int}
( xs: !list_vt(INV(x), n)
, f0: (&x) -<fun1> y): list_vt(y, n)
fun
{x:vt0p}
{y:vt0p}
list_vt_map_clo{n:int}
( xs: !list_vt(INV(x), n)
, f0: &(&x) -<clo1> y): list_vt(y, n)
//
fun
{x:vt0p}
{y:vt0p}
list_vt_map_cloptr{n:int}
( xs: !list_vt(INV(x), n)
, f0: ( &x ) -<cloref1> y): list_vt(y, n)
fun
{x:vt0p}
{y:vt0p}
list_vt_map_cloref{n:int}
( xs: !list_vt(INV(x), n)
, f0: ( &x ) -<cloref1> y): list_vt(y, n)
//
(* ****** ****** *)
//
fun
{x:vt0p}
{y:vt0p}
list_vt_mapfree_fun
  {n:int}
( xs: list_vt(INV(x), n)
, f0: (&x >> x?!) -<fun1> y): list_vt(y, n)
fun
{x:vt0p}
{y:vt0p}
list_vt_mapfree_clo
  {n:int}
( xs: list_vt(INV(x), n)
, f0: &(&x >> x?!) -<clo1> y): list_vt(y, n)
//
fun
{a:vt0p}
{b:vt0p}
list_vt_mapfree_cloptr
  {n:nat}
(
xs: list_vt(INV(a), n), fopr: (&a >> a?!) -<cloptr1> b
) : list_vt(b, n) // end-of-function
fun
{x:vt0p}{y:vt0p}
list_vt_mapfree_cloref{n:int}
(
xs: list_vt(INV(x), n), fopr: (&x >> x?!) -<cloref1> y
) : list_vt(y, n) // end-of-function
//
(* ****** ****** *)
//
fun
{a:vt0p}
{b:vt0p}
list_vt_mapfree_method
  {n:nat}
(
  list_vt(INV(a), n), TYPE(b)
) :
((&a >> a?!) -<cloptr1> b) -<lincloptr1> list_vt(b, n)
//
overload .mapfree with list_vt_mapfree_method
//
(* ****** ****** *)
//
fun{
x:vt0p
} list_vt_foreach_fun
  {fe:eff} (
  xs: !List_vt(INV(x)), f0: (&x >> _) -<fun,fe> void
) :<fe> void // end of [list_vt_foreach_fun]
fun{
x:vt0p
} list_vt_foreach_clo
  {fe:eff} (
  xs: !List_vt(INV(x)), f0: &(&x >> _) -<clo,fe> void
) :<fe> void // end of [list_vt_foreach_fun]
//
fun{
x:vt0p
} list_vt_foreach_cloptr
(
  xs: !List_vt(INV(x)), f0: (&x >> _) -<cloptr1> void
) :<1> void // end of [list_vt_foreach_cloptr]
fun{
x:vt0p
} list_vt_foreach_cloref
(
  xs: !List_vt(INV(x)), f0: (&x >> _) -<cloref1> void
) :<1> void // end of [list_vt_foreach_cloref]
//
(* ****** ****** *)
//
fun
{r:vt0p}
{x:vt0p}
list_vt_foldleft_cloptr
(xs: !List_vt(INV(x)), r0: r, f0: (r, &x) -<cloptr1> r): (r)
fun
{r:vt0p}
{x:vt0p}
list_vt_foldleft_cloref
(xs: !List_vt(INV(x)), r0: r, f0: (r, &x) -<cloref1> r): (r)
//
(* ****** ****** *)
//
// HX: prelude/array
//
(* ****** ****** *)
//
fun
{a:vt0p}
array_foreach_fun
  {n:int}{fe:eff}
(
A0: &(@[INV(a)][n]) >> @[a][n],
asz: size_t(n), fwork: (&a >> _) -<fun,fe> void
) :<fe> void // end of [array_foreach_fun]
fun
{a:vt0p}
array_foreach_clo
  {n:int}{fe:eff}
(
A0: &(@[INV(a)][n]) >> @[a][n],
asz: size_t (n), fwork: &(&a >> _) -<clo,fe> void
) :<fe> void // end of [array_foreach_clo]
fun
{a:vt0p}
array_foreach_cloptr
  {n:int}{fe:eff}
(
A0: &(@[INV(a)][n]) >> @[a][n],
asz: size_t n, fwork: (&a >> _) -<cloptr,fe> void
) :<fe> void // end of [array_foreach_cloptr]
fun
{a:vt0p}
array_foreach_cloref
  {n:int}{fe:eff}
(
A0: &(@[INV(a)][n]) >> @[a][n],
asz: size_t(n), fwork: (&a >> _) -<cloref,fe> void
) :<fe> void // end of [array_foreach_cloref]
//
(* ****** ****** *)
//
fun
{a:vt0p}
array_foreach_vclo
  {v:view}{n:int}{fe:eff}
(
  pf: !v
| A0: &(@[INV(a)][n]) >> @[a][n]
, asz: size_t n, f0: &(!v | &a >> _) -<clo,fe> void
) :<fe> void // end of [array_foreach_vclo]
fun
{a:vt0p}
array_foreach_vcloptr
  {v:view}{n:int}{fe:eff}
(
  pf: !v
| A0: &(@[INV(a)][n]) >> @[a][n]
, asz: size_t(n), f0: !(!v | &a >> _) -<cloptr,fe> void
) :<fe> void // end of [array_foreach_vcloptr]
//
(* ****** ****** *)
//
// HX: prelude/arrayptr
//
(* ****** ****** *)
//
fun
{a:vt0p}
arrayptr_foreach_fun
  {n:int}{fe:eff}
(
A0: !arrayptr(INV(a), n),
asz: size_t(n), fwork: (&a) -<fun,fe> void
) :<fe> void // end of [arrayptr_foreach_fun]
//
(* ****** ****** *)
//
fun{a:vt0p}
arrayptr_tabulate_cloref
  {n:int}
( asz: size_t(n)
, fopr: (sizeLt(n)) -<cloref> a): arrayptr(a, n)
//
(* ****** ****** *)
//
// HX: prelude/arrayref
//
(* ****** ****** *)
//
fun{a:vt0p}
arrayref_tabulate_cloref
  {n:int}
( asz: size_t(n)
, fopr: (sizeLt(n)) -<cloref> (a)): arrayref(a, n)
//
fun{a:vt0p}
arrszref_tabulate_cloref
  {n:int}
  (size_t(n), (sizeLt(n)) -<cloref> a): arrszref(a)
//
(* ****** ****** *)
//
// HX: prelude/option
//
(* ****** ****** *)
//
fun
{x:t0p}
{y:vt0p}
option_map_fun
  {b:bool}
  (option(INV(x), b), fopr: (x) -<fun1> y): option_vt(y, b)
fun
{x:t0p}
{y:vt0p}
option_map_clo
  {b:bool}
  (option(INV(x), b), fopr: &(x) -<clo1> y): option_vt(y, b)
//
fun
{x:t0p}
{y:vt0p}
option_map_cloptr
  {b:bool}
  (option(INV(x), b), fopr: (x) -<cloptr1> y): option_vt(y, b)
fun
{x:t0p}
{y:vt0p}
option_map_cloref
  {b:bool}
  (option(INV(x), b), fopr: (x) -<cloref1> y): option_vt(y, b)
//
(* ****** ****** *)
//
// HX: prelude/matrixptr
//
(* ****** ****** *)
//
fun
{a:vt0p}
matrixptr_tabulate_cloptr
  {m,n:int}
( nrow: size_t(m)
, ncol: size_t(n)
, fopr: (sizeLt(m), sizeLt(n)) -<cloptr> (a)
) : matrixptr(a, m, n) // end-of-function
//
fun
{a:vt0p}
matrixptr_tabulate_cloref
  {m,n:int}
( nrow: size_t(m)
, ncol: size_t(n)
, fopr: (sizeLt(m), sizeLt(n)) -<cloref> (a)
) : matrixptr(a, m, n) // end-of-function
//
(* ****** ****** *)
//
fun
{a:vt0p}
matrixref_tabulate_cloref
  {m,n:int}
( nrow: size_t(m)
, ncol: size_t(n)
, fopr: (sizeLt(m), sizeLt(n)) -<cloref> (a)
) : matrixref(a, m, n) // end-of-function
fun
{a:vt0p}
mtrxszref_tabulate_cloref
  {m,n:int}
( nrow: size_t(m)
, ncol: size_t(n)
, fopr: (sizeLt(m), sizeLt(n)) -<cloref> (a)): mtrxszref(a)
//
fun
{a:vt0p}
matrixref_foreach_cloref
  {m,n:int}
(
M: matrixref(a, m, n)
,
m: size_t(m), n: size_t(n), fwork: (&(a) >> _) -<cloref1> void 
) : void // end of [mtrxszref_foreach_cloref]
fun
{a:vt0p}
mtrxszref_foreach_cloref
  (M0: mtrxszref(a), fwork: (&(a) >> _) -<cloref1> void): void
//
(* ****** ****** *)

(* end of [atspre.sats] *)
