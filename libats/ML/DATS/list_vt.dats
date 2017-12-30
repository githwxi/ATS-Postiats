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
  
staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list_vt.sats"

(* ****** ****** *)
//
implement
{a}(*tmp*)
list_vt_tuple_0() = list_vt_nil()
//
implement
{a}(*tmp*)
list_vt_tuple_1(x0) = $list_vt{a}(x0)
implement
{a}(*tmp*)
list_vt_tuple_2(x0, x1) = $list_vt{a}(x0, x1)
implement
{a}(*tmp*)
list_vt_tuple_3(x0, x1, x2) = $list_vt{a}(x0, x1, x2)
//
implement
{a}(*tmp*)
list_vt_tuple_4
(x0, x1, x2, x3) = $list_vt{a}(x0, x1, x2, x3)
implement
{a}(*tmp*)
list_vt_tuple_5
(x0, x1, x2, x3, x4) = $list_vt{a}(x0, x1, x2, x3, x4)
implement
{a}(*tmp*)
list_vt_tuple_6
(x0, x1, x2, x3, x4, x5) = $list_vt{a}(x0, x1, x2, x3, x4, x5)
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
  (xs, f0) = () where
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

(* end of [list_vt.dats] *)
