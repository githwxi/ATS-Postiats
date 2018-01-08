(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2017 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)
  
#staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

#staload "libats/ML/SATS/basis.sats"
#staload "libats/ML/SATS/atspre.sats"

(* ****** ****** *)
//
// HX-2017-12-30:
// prelude/intrange
//
(* ****** ****** *)
//
implement
{}(*tmp*)
int_forall_cloptr
  (n, pred) =
(
intrange_forall_cloptr<>(0, n, pred)
) (* end of [int_forall_cloref] *)
implement
{}(*tmp*)
int_forall_cloref
  (n, pred) =
(
intrange_forall_cloref<>(0, n, pred)
) (* end of [int_forall_cloref] *)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
intrange_forall_cloptr
(
l, r, pred
) = res where
{
//
val res =
intrange_forall_cloref<>
  (l, r, $UN.castvwtp1(pred))
val ((*void*)) =
  cloptr_free{void}($UN.castvwtp0(pred))
} // end of [intrange_forall_cloptr]
//
implement
{}(*tmp*)
intrange_forall_cloref
  (l, r, pred) = loop(l, r) where
{
//
fun
loop
(l: int, r: int): bool =
if
(l < r)
then (
  if pred(l) then loop(l+1, r) else false
) else true
//
} // end of [intrange_forall_cloref]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
int_foreach_cloptr
  (n, fwork) =
(
intrange_foreach_cloptr<>(0, n, fwork)
) (* end of [int_foreach_cloref] *)
implement
{}(*tmp*)
int_foreach_cloref
  (n, fwork) =
(
intrange_foreach_cloref<>(0, n, fwork)
) (* end of [int_foreach_cloref] *)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
intrange_foreach_cloptr
(
l, r, fwork
) = res where
{
//
val res =
intrange_foreach_cloref<>
  (l, r, $UN.castvwtp1(fwork))
val ((*void*)) =
  cloptr_free{void}($UN.castvwtp0(fwork))
} // end of [intrange_foreach_cloptr]
//
implement
{}(*tmp*)
intrange_foreach_cloref
  (l, r, fwork) = let
//
implement
(env)(*tmp*)
intrange_foreach$cont<env>(i, env) = true
implement
(env)(*tmp*)
intrange_foreach$fwork<env>(i, env) = fwork(i)
//
var env: void = ()
//
in
  intrange_foreach_env<void>(l, r, env)
end // end of [intrange_foreach_cloref]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
int_rforeach_cloptr
  (n, fwork) =
(
intrange_rforeach_cloptr<>(0, n, fwork)
) (* end of [int_rforeach_cloptr] *)
implement
{}(*tmp*)
int_rforeach_cloref
  (n, fwork) =
(
intrange_rforeach_cloref<>(0, n, fwork)
) (* end of [int_rforeach_cloref] *)
//
//
implement
{}(*tmp*)
intrange_rforeach_cloptr
(
l, r, fwork
) = res where
{
//
val res =
intrange_rforeach_cloref<>
  (l, r, $UN.castvwtp1(fwork))
val ((*void*)) =
  cloptr_free{void}($UN.castvwtp0(fwork))
} // end of [intrange_rforeach_cloptr]
implement
{}(*tmp*)
intrange_rforeach_cloref
  (l, r, fwork) = let
//
implement
(env)(*tmp*)
intrange_rforeach$cont<env>(i, env) = true
implement
(env)(*tmp*)
intrange_rforeach$fwork<env>(i, env) = fwork(i)
//
var env: void = ()
//
in
  intrange_rforeach_env<void>(l, r, env)
end // end of [intrange_rforeach_cloref]
//
(* ****** ****** *)
//
// HX: prelude/list
//
(* ****** ****** *)
//
implement
{x}(*tmp*)
list_exists_cloptr
  (xs, p0) = res where
{
//
val p1 =
$UN.castvwtp1(p0)
val res =
list_exists_cloref<x>(xs, p1)
//
val ((*freed*)) =
cloptr_free($UN.castvwtp0{cloptr(void)}(p0))
//
} // end of [list_exists_cloptr]
//
implement
{x}(*tmp*)
list_exists_cloref
  (xs, pred) = let
//
implement(x2)
list_exists$pred<x2>(x2) = pred($UN.cast{x}(x2))
//
in
  list_exists<x>(xs)
end // end of [list_exists_cloref]
//
(* ****** ****** *)
//
implement
{x}(*tmp*)
list_iexists_cloptr
  (xs, p0) = res where
{
//
val p1 =
$UN.castvwtp1(p0)
val res =
list_iexists_cloref<x>(xs, p1)
//
val ((*freed*)) =
cloptr_free($UN.castvwtp0{cloptr(void)}(p0))
//
} // end of [list_iexists_cloptr]
//
implement
{x}(*tmp*)
list_iexists_cloref
  {n}(xs, pred) = let
//
prval() = lemma_list_param(xs)
//
fun
loop
{ i,j:nat
| i+j == n
} .<n-i>.
(
  i: int(i), xs: list(x, j)
) :<> bool =
(
  case+ xs of
  | list_nil() => false
  | list_cons(x, xs) =>
      if pred(i, x) then true else loop(i+1, xs)
    // end of [list_cons]
)
//
in
  loop(0, xs)
end // end of [list_iexists_cloref]
//
(* ****** ****** *)
//
implement
{x}(*tmp*)
list_forall_cloptr
  (xs, p0) = res where
{
//
val p1 =
$UN.castvwtp1(p0)
val res =
list_forall_cloref<x>(xs, p1)
//
val ((*freed*)) =
cloptr_free($UN.castvwtp0{cloptr(void)}(p0))
//
} // end of [list_forall_cloptr]
//
implement
{x}(*tmp*)
list_forall_cloref
  (xs, pred) = let
//
implement(x2)
list_forall$pred<x2>(x2) = pred($UN.cast{x}(x2))
//
in
  list_forall<x>(xs)
end // end of [list_forall_cloref]
//
(* ****** ****** *)
//
implement
{x}(*tmp*)
list_iforall_cloptr
  (xs, p0) = res where
{
//
val p1 =
$UN.castvwtp1(p0)
val res =
list_iforall_cloref<x>(xs, p1)
//
val ((*freed*)) =
cloptr_free($UN.castvwtp0{cloptr(void)}(p0))
//
} // end of [list_iforall_cloptr]
//
implement
{x}(*tmp*)
list_iforall_cloref
  {n}(xs, pred) = let
//
prval() = lemma_list_param(xs)
//
fun
loop
{ i,j:nat
| i+j == n
} .<n-i>.
(
  i: int(i), xs: list(x, j)
) :<> bool =
(
  case+ xs of
  | list_nil() => true
  | list_cons(x, xs) =>
      if pred(i, x) then loop(i+1, xs) else false
    // end of [list_cons]
)
//
in
  loop(0, xs)
end // end of [list_iforall_cloref]
//
(* ****** ****** *)

implement
{x}(*tmp*)
list_equal_cloref
  (xs1, xs2, eqfn) =
  list_equal<x>(xs1, xs2) where
{
//
implement{y}
list_equal$eqfn
  (x1, x2) = eqfn($UN.cast(x1), $UN.cast(x2))
//
} (* end of [list_equal_cloref] *)

(* ****** ****** *)

implement
{x}(*tmp*)
list_compare_cloref
  (xs1, xs2, cmpfn) =
  list_compare<x>(xs1, xs2) where
{
//
implement{y}
list_compare$cmpfn
  (x1, x2) = cmpfn($UN.cast(x1), $UN.cast(x2))
//
} (* end of [list_compare_cloref] *)

(* ****** ****** *)

implement
{x}(*tmp*)
list_app_fun
  (xs, fwork) =
  list_app<x>(xs) where
{
//
implement
{x2}(*tmp*)
list_app$fwork(x2) = fwork($UN.cast{x}(x2))
//
} (* end of [list_app_fun] *)

implement
{x}(*tmp*)
list_app_clo
  (xs, fwork) =
  list_app<x>(xs) where
{
//
val
fwork =
$UN.cast{cfun(x,void)}(addr@fwork)
//
implement
{x2}(*tmp*)
list_app$fwork(x2) = fwork($UN.cast{x}(x2))
//
} (* end of [list_app_clo] *)

implement
{x}(*tmp*)
list_app_cloref
  (xs, fwork) = let
//
fun
loop
{n:nat} .<n>.
(
  xs: list(x, n)
, fwork: (x) -<cloref1> void
) : void = (
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => (fwork(x); loop(xs, fwork))
//
) (* end of [loop] *)
//
prval() = lemma_list_param(xs)
//
in
  loop(xs, fwork)
end // end of [list_app_cloref]

(* ****** ****** *)

implement
{x}{y}(*tmp*)
list_map_fun
  (xs, fopr) = let
//
implement
{x2}{y2}
list_map$fopr(x2) =
  $UN.castvwtp0{y2}(fopr($UN.cast{x}(x2)))
//
in
  list_map<x><y>(xs)
end // end of [list_map_fun]

implement
{x}{y}(*tmp*)
list_map_clo
  (xs, fopr) = let
//
val fopr =
  $UN.cast{(x) -<cloref1> y}(addr@fopr)
//
implement
{x2}{y2}
list_map$fopr(x2) =
  $UN.castvwtp0{y2}(fopr($UN.cast{x}(x2)))
//
in
  list_map<x><y>(xs)
end // end of [list_map_clo]

implement
{x}{y}(*tmp*)
list_map_cloref
  (xs, fopr) = let
//
implement
{x2}{y2}
list_map$fopr(x2) =
  $UN.castvwtp0{y2}(fopr($UN.cast{x}(x2)))
//
in
  list_map<x><y>(xs)
end // end of [list_map_cloref]

(* ****** ****** *)

implement
{a}(*tmp*)
list_tabulate_fun
  (n, fopr) =
  list_tabulate<a>(n) where
{
//
val fopr = $UN.cast{int->a}(fopr)
//
implement(a2)
list_tabulate$fopr<a2>(n) = $UN.castvwtp0{a2}(fopr(n))
//
} (* end of [list_tabulate_fun] *)

implement
{a}(*tmp*)
list_tabulate_clo
  (n, fopr) =
  list_tabulate<a>(n) where
{
//
val fopr = $UN.cast{cfun(int,a)}(addr@fopr)
//
implement(a)
list_tabulate$fopr<a>(n) = $UN.castvwtp0{a}(fopr(n))
//
} (* end of [list_tabulate_clo] *)

implement
{a}(*tmp*)
list_tabulate_cloref
  (n, fopr) = let
//
val fopr =
$UN.cast{int -<cloref1> a}(fopr)
//
implement(a)
list_tabulate$fopr<a>(n) = $UN.castvwtp0{a}(fopr(n))
//
in
  list_tabulate<a>(n)
end // end of [list_tabulate_cloref]

(* ****** ****** *)

implement
{x}(*tmp*)
list_foreach_fun
  (xs, fwork) = let
//
fun
loop(xs: List(x)): void =
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => (fwork(x); loop(xs))
//
in
  $effmask_all (loop(xs))
end // end of [list_foreach_fun]

(* ****** ****** *)
//
implement
{x}(*tmp*)
list_foreach_clo
  (xs, fwork) =
(
$effmask_all
  (list_foreach_cloref<x>(xs, $UN.cast(addr@fwork)))
) (* list_foreach_clo *)
implement
{x}(*tmp*)
list_foreach_vclo
  (pf | xs, fwork) =
(
$effmask_all
  (list_foreach_cloref<x>(xs, $UN.cast(addr@fwork)))
) (* list_foreach_vclo *)
//
(* ****** ****** *)

implement
{x}(*tmp*)
list_foreach_cloptr
  (xs, fwork) =
  cloptr_free
  ($UN.castvwtp0{cloptr(void)}(fwork)) where
{
val () =
$effmask_all
  (list_foreach_cloref<x>(xs, $UN.castvwtp1(fwork)))
} (* list_foreach_cloptr *)
implement
{x}(*tmp*)
list_foreach_vcloptr
  (pf | xs, fwork) =
  cloptr_free
  ($UN.castvwtp0{cloptr(void)}(fwork)) where
{
val () =
$effmask_all
  (list_foreach_cloref<x>(xs, $UN.castvwtp1(fwork)))
} (* list_foreach_vcloptr *)

(* ****** ****** *)

implement
{x}(*tmp*)
list_foreach_cloref
  (xs, fwork) = let
//
fun
loop(xs: List(x)): void =
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => (fwork(x); loop(xs))
//
in
  $effmask_all (loop(xs))
end // end of [list_foreach_cloref]

(* ****** ****** *)
//
implement
{a}(*tmp*)
list_foreach_method(xs) =
  lam(fwork) => list_foreach_cloref<a>(xs, fwork)
//
(* ****** ****** *)

implement
{x}(*tmp*)
list_iforeach_cloref
  {n}(xs, fwork) = let
//
prval() = lemma_list_param(xs)
//
fun
loop
{
  i,j:nat
| i+j == n
} .<n-i>.
(
  i: int(i), xs: list(x, j)
) : void =
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => (fwork (i, x); loop(i+1, xs))
//
in
  loop(0, xs)
end // end of [list_iforeach_cloref]

(* ****** ****** *)
//
implement
{a}(*tmp*)
list_iforeach_method(xs) =
  lam(fwork) => list_iforeach_cloref<a>(xs, fwork)
//
(* ****** ****** *)

implement
{res}{x}
list_foldleft_cloptr
(
xs, ini, f0
) = res where
{
//
val f1 =
$UN.castvwtp1(f0)
val res =
list_foldleft_cloref<res><x>(xs, ini, f1)
//
val ((*freed*)) =
cloptr_free($UN.castvwtp0{cloptr(void)}(f0))
//
} // end of [list_foldleft_cloptr]

implement
{res}{x}
list_foldleft_cloref
  (xs, ini, fopr) = let
//
implement
{res2}{x2}
list_foldleft$fopr
  (res2, x2) =
(
$UN.castvwtp0{res2}
  (fopr($UN.castvwtp0{res}(res2), $UN.cast{x}(x2)))
)
//
in
  list_foldleft<res><x>(xs, ini)
end // end of [list_foldleft_cloref]

(* ****** ****** *)

implement
{x}{res}
list_foldright_cloptr
(
xs, f0, snk
) = res where
{
//
val f1 =
$UN.castvwtp1(f0)
val res =
list_foldright_cloref<x><res>(xs, f1, snk)
//
val ((*freed*)) =
cloptr_free($UN.castvwtp0{cloptr(void)}(f0))
//
} // end of [list_foldright_cloptr]

implement
{x}{res}
list_foldright_cloref
  (xs, fopr, snk) = let
//
implement
{x2}{res2}
list_foldright$fopr
  (x2, res2) =
(
$UN.castvwtp0{res2}
  (fopr($UN.cast{x}(x2), $UN.castvwtp0{res}(res2)))
)
//
in
  list_foldright<x><res>(xs, snk)
end // end of [list_foldright_cloref]

(* ****** ****** *)
//
// HX: prelude/list_vt
//
(* ****** ****** *)

implement
{x}{y}(*tmp*)
list_vt_map_fun
  (xs, f0) = let
//
implement
{x2}{y2}
list_vt_map$fopr(x2) = let
//
val f0 =
$UN.cast{(&x2)->y}(f0) in $UN.castvwtp0{y2}(f0(x2))
//
end // end of [list_vt_map$fopr]
//
in
  list_vt_map<x><y>(xs)
end // end of [list_vt_map_fun]

implement
{x}{y}(*tmp*)
list_vt_map_clo
  (xs, f0) = let
//
val f0 =
$UN.cast{(&x) -<cloref1> y}(addr@f0)
//
implement
{x2}{y2}
list_vt_map$fopr(x2) = let
//
val f0 =
$UN.cast{(&x2)-<cloref1>y}(f0) in $UN.castvwtp0{y2}(f0(x2))
//
end // end of [list_vt_map$fopr]
//
in
  list_vt_map<x><y>(xs)
end // end of [list_vt_map_clo]

implement
{x}{y}(*tmp*)
list_vt_map_cloptr
  (xs, f0) = ys where
{
//
val f1 =
$UN.castvwtp1(f0)
val ys =
list_vt_map_cloref<x><y>(xs, f1)
val () =
cloptr_free($UN.castvwtp0{cloptr(void)}(f0))
//
} (* end of [list_vt_map_cloptr] *)

implement
{x}{y}(*tmp*)
list_vt_map_cloref
  (xs, f0) = let
//
implement
{x2}{y2}
list_vt_map$fopr(x2) = let
//
val f0 =
$UN.cast{(&x2)-<cloref1>y}(f0) in $UN.castvwtp0{y2}(f0(x2))
//
end // end of [list_vt_map$fopr]
//
in
  list_vt_map<x><y>(xs)
end // end of [list_vt_map_cloref]

(* ****** ****** *)

implement
{x}{y}(*tmp*)
list_vt_mapfree_fun
  (xs, f0) = let
//
implement
{x2}{y2}
list_vt_mapfree$fopr
  (x2) = let
//
val f0 =
$UN.cast{(&x2>>_?)->y}(f0) in $UN.castvwtp0{y2}(f0(x2))
//
end // end of [list_vt_mapfree$fopr]
//
in
  list_vt_mapfree<x><y>(xs)
end // end of [list_vt_mapfree_fun]

implement
{x}{y}(*tmp*)
list_vt_mapfree_clo
  (xs, f0) = let
//
val f0 =
$UN.cast{(&x>>_?) -<cloref1> y}(addr@f0)
//
implement
{x2}{y2}
list_vt_mapfree$fopr(x2) = let
//
val f0 =
$UN.cast{(&x2>>_?)-<cloref1>y}(f0) in $UN.castvwtp0{y2}(f0(x2))
//
end // end of [list_vt_mapfree$fopr]
//
in
  list_vt_mapfree<x><y>(xs)
end // end of [list_vt_mapfree_clo]

implement
{x}{y}(*tmp*)
list_vt_mapfree_cloptr
  (xs, f0) = ys where
{
//
val f1 =
$UN.castvwtp1(f0)
val ys =
list_vt_mapfree_cloref<x><y>(xs, f1)
val () =
cloptr_free($UN.castvwtp0{cloptr(void)}(f0))
//
} (* end of [list_vt_mapfree_cloptr] *)

implement
{x}{y}(*tmp*)
list_vt_mapfree_cloref
  (xs, f0) = let
//
implement
{x2}{y2}
list_vt_mapfree$fopr(x2) = let
//
val f0 =
$UN.cast{(&x2>>_?)-<cloref1>y}(f0) in $UN.castvwtp0{y2}(f0(x2))
//
end // end of [list_vt_mapfree$fopr]
//
in
  list_vt_mapfree<x><y>(xs)
end // end of [list_vt_mapfree_cloref]

(* ****** ****** *)

implement
{a}{b}
list_vt_mapfree_method
  (xs, _(*type*)) =
(
  llam(fopr) => list_vt_mapfree_cloptr<a><b>(xs, fopr)
) (* list_vt_mapfree_method *)

(* ****** ****** *)

implement
{a}(*tmp*)
list_vt_foreach_fun
  {fe}(xs, f0) = let
//
prval() = lemma_list_vt_param(xs)
//
fun
loop
{n:nat} .<n>.
(
xs: !list_vt(a, n), f0: (&a) -<fe> void
) :<fe> void =
  case+ xs of
  | @list_vt_cons
      (x, xs1) => let
      val () = f0(x)
      val () = loop(xs1, f0)
    in
      fold@ (xs)
    end // end of [cons]
  | list_vt_nil((*void*)) => ()
// end of [loop]
in
  loop(xs, f0)
end // end of [list_vt_foreach_fun]

(* ****** ****** *)

implement
{a}(*tmp*)
list_vt_foreach_cloptr
(
  xs, f0
) = () where
{
//
val f1 =
$UN.castvwtp1(f0)
val () =
list_vt_foreach_cloref<a>(xs, f1)
val () =
cloptr_free($UN.castvwtp0{cloptr(void)}(f0))
//
} // end of [list_vt_foreach_cloptr]

implement
{a}(*tmp*)
list_vt_foreach_cloref
  (xs, f0) =
  loop(xs, f0) where
{
//
fun
loop{n:nat} .<n>.
(
xs: !list_vt(a, n),
f0: (&a) -<cloref1> void
) : void =
  case+ xs of
  | @list_vt_cons
      (x, xs1) =>
      fold@(xs) where
    {
      val () = f0(x)
      val () = loop(xs1, f0)
    } // end of [cons]
  | list_vt_nil((*void*)) => ()
// end of [loop]
//
prval() = lemma_list_vt_param(xs)
//
} // end of [list_vt_foreach_cloref]

(* ****** ****** *)

implement
{r}{x}//tmp
list_vt_foldleft_cloptr
(
  xs, r0, f0
) = res where
{
//
val f1 =
$UN.castvwtp1(f0)
val res =
list_vt_foldleft_cloref<r><x>(xs, r0, f1)
val ((*freed*)) =
cloptr_free($UN.castvwtp0{cloptr(void)}(f0))
//
} // end of [list_vt_foldleft_cloptr]

implement
{r}{x}//tmp
list_vt_foldleft_cloref
  (xs, r0, f0) = let
//
fun
auxlst:
$d2ctype
(
list_vt_foldleft_cloref<r><x>
) = lam(xs, r0, f0) =>
(
case+ xs of
| @list_vt_nil
    () => (fold@(xs); r0)
| @list_vt_cons
    (x0, xs1) => res where
  {
    val res =
    auxlst(xs1, f0(r0, x0), f0)
    prval ((*folded*)) = fold@(xs)
  } (* end of [list_vt_cons] *)
)
//
in
  auxlst(xs, r0, f0)
end // end of [list_vt_foldleft_cloref]

(* ****** ****** *)
//
// HX: prelude/array
//
(* ****** ****** *)

implement
{a}(*tmp*)
array_foreach_fun
  {n}{fe}
(
  A0, asz, fwork
) = let
//
typedef
fwork_t =
(!unit_v | &a, !ptr) -<fun,fe> void
// end of [typedef]
//
prval pfu = unit_v()
//
var env: ptr = the_null_ptr
val fwork = $UN.cast{fwork_t}(fwork)
//
val ((*void*)) =
array_foreach_funenv<a>(pfu | A0, asz, fwork, env)
//
prval ((*freed*)) = unit_v_elim(pfu)
//
in
  // nothing
end // end of [array_foreach_fun]

implement
{a}(*tmp*)
array_foreach_cloref
  {n}{fe}
(
  A0, asz, fwork
) = let
//
viewdef v = unit_v
typedef tenv = (&a) -<cloref,fe> void
//
fun app .<>.
  (pf: !v | x: &a, fwork: !tenv):<fe> void = fwork(x)
// end of [fun]
//
var env = fwork
prval pfu = unit_v()
//
val ((*void*)) =
array_foreach_funenv<a>{v}{tenv}(pfu | A0, asz, app, env)
//
prval ((*freed*)) = unit_v_elim(pfu)
//
in
  // nothing
end // end of [array_foreach_cloref]

(* ****** ****** *)
//
// HX: prelude/arrayptr
//
(* ****** ****** *)

implement
{a}(*tmp*)
arrayptr_tabulate_cloref
{n}(asz, f0) = let
//
implement(a2)
array_tabulate$fopr<a2>(i) =
$UN.castvwtp0{a2}
(f0($UN.cast{sizeLt(n)}(i)))
//
in
  arrayptr_tabulate<a>(asz)
end // end of [arrayptr_tabulate_cloref]

(* ****** ****** *)
//
// HX: prelude/arrayref
//
(* ****** ****** *)

implement
{a}(*tmp*)
arrayptr_foreach_fun
(
A0, asz, f0
) = ((*void*)) where
{
//
val p0 = ptrcast(A0)
prval pf0 = arrayptr_takeout(A0)
//
val () =
array_foreach_fun<a>(!p0, asz, f0)
//
prval () = arrayptr_addback{a}(pf0 | A0)
//
} // end of [arrayptr_foreach_fun]

(* ****** ****** *)
//
implement
{a}(*tmp*)
arrayref_tabulate_cloref
{n}(asz, f0) = let
//
implement(a2)
array_tabulate$fopr<a2>(i) =
$UN.castvwtp0{a2}
(f0($UN.cast{sizeLt(n)}(i)))
//
in
  arrayref_tabulate<a>(asz)
end // end of [arrayptr_tabulate_cloref]
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
arrszref_tabulate_cloref
  (asz, f0) =
(
arrszref_make_arrayref
(arrayref_tabulate_cloref<a>(asz, f0), asz)
)
//
(* ****** ****** *)
//
implement
{x}{y}
option_map_fun
  (opt, fopr) = (
//
case+ opt of
| None() => None_vt()
| Some(x0) => Some_vt(fopr(x0))
//
) // end of [option_map_fun]
//
implement
{x}{y}
option_map_clo
  (opt, fopr) = let
//
val fopr =
$UN.cast{cfun(x,y)}(addr@fopr)
//
in
  option_map_cloref<x><y>(opt, fopr)
end // end of [option_map_clo]
//
implement
{x}{y}
option_map_cloref
  (opt, fopr) = (
//
case+ opt of
| None() => None_vt()
| Some(x0) => Some_vt(fopr(x0))
//
) // end of [option_map_cloref]
//
implement
{x}{y}
option_map_cloptr
  (xs, f0) = res where
{
//
val f1 =
$UN.castvwtp1(f0)
val res =
option_map_cloref<x>(xs, f1)
//
val ((*freed*)) =
cloptr_free($UN.castvwtp0{cloptr(void)}(f0))
//
} // end of [option_map_cloptr]
//
(* ****** ****** *)
//
// HX: prelude/matrixptr
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
matrixptr_tabulate_cloptr
  (nrow, ncol, f0) = mat where
{
//
val mat =
matrixptr_tabulate_cloref<a>
  (nrow, ncol, $UN.castvwtp1(f0))
//
val ((*freed*)) =
cloptr_free($UN.castvwtp0{cloptr(void)}(f0))
//
} // end of [matrixptr_tabulate_cloptr]
//
implement
{a}(*tmp*)
matrixptr_tabulate_cloref
  {m,n}(nrow, ncol, fopr) = let
//
implement(a2)
matrix_tabulate$fopr<a2>(i, j) =
  $UN.castvwtp0{a2}
  (fopr($UN.cast{sizeLt(m)}(i), $UN.cast{sizeLt(n)}(j)))
//
in
matrixptr_tabulate<a>(nrow, ncol)
end // end of [matrixptr_tabulate_cloref]

(* ****** ****** *)
//
// HX: prelude/matrixref
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
matrixref_tabulate_cloref
  {m,n}(nrow, ncol, fopr) = let
//
implement(a2)
matrix_tabulate$fopr<a2>(i, j) =
  $UN.castvwtp0{a2}
  (fopr($UN.cast{sizeLt(m)}(i), $UN.cast{sizeLt(n)}(j)))
//
in
matrixptr_refize
(matrixptr_tabulate<a>(nrow, ncol))
end // end of [matrixref_tabulate_cloref]
//
(* ****** ****** *)

implement
{a}(*tmp*)
mtrxszref_tabulate_cloref
(
  nrow, ncol, fopr
) = let
//
val M =
matrixref_tabulate_cloref<a>
  (nrow, ncol, fopr)
//
in
//
mtrxszref_make_matrixref(M, nrow, ncol)
//
end // end of [mtrxszref_tabulate_cloref]

(* ****** ****** *)

implement
{a}(*tmp*)
matrixref_foreach_cloref
  (A, m, n, fwork) = let
//
implement
{a2}{env}
matrix_foreach$fwork
  (x, env) = let
  val (pf,fpf|p) =
    $UN.ptr_vtake{a}(addr@x)
  // end of [val]
  val ((*void*)) = fwork(!p)
  prval ((*returned*)) = fpf(pf)
in
  // nothing
end // end of [matrix_foreach$work]
//
in
  matrixref_foreach<a>(A, m, n)
end // end of [matrixref_foreach_cloref]

(* ****** ****** *)

implement
{a}(*tmp*)
mtrxszref_foreach_cloref
  (MSZ, fwork) = let
//
implement
{a2}{env}
matrix_foreach$fwork
  (x, env) = let
  val (pf,fpf|p) =
    $UN.ptr_vtake{a}(addr@x)
  // end of [val]
  val ((*void*)) = fwork(!p)
  prval ((*returned*)) = fpf(pf)
in
  // nothing
end // end of [matrix_foreach$work]
//
in
  mtrxszref_foreach<a>(MSZ)
end // end of [mtrxszref_foreach_cloref]

(* ****** ****** *)

implement
{}(*tmp*)
string_tabulate_cloref
  {n}(n, fopr) = let
//
implement
string_tabulate$fopr<>(i) = fopr($UN.cast{sizeLt(n)}(i))
//
in
  string_tabulate<>(n)
end // end of [string_tabulate_cloref]

(* ****** ****** *)

(* end of [atspre.dats] *)
