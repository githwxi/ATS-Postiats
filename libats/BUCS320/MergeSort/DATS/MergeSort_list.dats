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
(* Start time: February, 2017 *)
(* Authoremail: hwxiATcsDOTbuDOTedu *)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

abst@ype elt_t0ype

(* ****** ****** *)

typedef elt = elt_t0ype

(* ****** ****** *)
//
#include "./../mydepies.hats"
//
(* ****** ****** *)
//
extern
fun{}
MergeSort_list
  (xs: list0(elt)): list0(elt)
//
(* ****** ****** *)
//
extern
fun{}
MergeSort_list$cutoff
  ((*void*)): intGte(2)
//
local
#define CUTOFF 128
in(*in-of-local*)
implement
{}(*tmp*)
MergeSort_list$cutoff() = CUTOFF
end // end of [local]
//
(* ****** ****** *)
//
typedef
input = (int, list0(elt))
//
typedef output = list0(elt)
//
(* ****** ****** *)
//
staload
DC = $DivideConquer
//
assume $DC.input_t0ype = input
assume $DC.output_t0ype = output
//
(* ****** ****** *)
//
implement
$DC.DivideConquer$base_test<>
  (nxs) = let
//
val
CUTOFF = MergeSort_list$cutoff<>()
//
in
  if nxs.0 >= CUTOFF then false else true
end // end of [DivideConquer$base_test]
//
(* ****** ****** *)
//
implement
$DC.DivideConquer$base_solve<>
  (nxs) =
(
list0_mergesort<elt>
  (nxs.1, lam(x1, x2) => gcompare_val_val<elt>(x1, x2))
// list0_mergesort
)
//
(* ****** ****** *)
//
implement
$DC.DivideConquer$divide<>
  (nxs) = let
//
val n =
  g1ofg0(nxs.0)
//
val () =
assertloc(n >= 2)
//
val n2 = half( n )
//
val xs = nxs.1
val xs1 = list0_take_exn(xs, n2)
val xs2 = list0_drop_exn(xs, n2)
//
in
//
g0ofg1_list($list{input}((n2, xs1), (n-n2, xs2)))
//
end // end of [DivideConquer$divide]
//
(* ****** ****** *)

implement
$DC.DivideConquer$conquer$combine<>
  (_, rs) = let
//
fun
merge
( xs10: output
, xs20: output, res: &ptr? >> output
) : void =
(
case+ xs10 of
| list0_nil() =>
    (res := xs20)
  // list0_nil
| list0_cons(x1, xs11) =>
  (
  case+ xs20 of
  | list0_nil() =>
      (res := xs10)
  | list0_cons(x2, xs21) => let
      val sgn =
      gcompare_val_val<elt>(x1, x2)
    in
      if sgn <= 0
        then () where
        {
          val () =
            (res := list0_cons(x1, _))
          val+list0_cons(_, res1) = res
          val ((*void*)) = merge(xs11, xs20, res1)
          prval ((*folded*)) = fold@(res)
        } (* end of [then] *)
        else () where
        {
          val () =
            (res := list0_cons(x2, _))
          val+list0_cons(_, res1) = res
          val ((*void*)) = merge(xs10, xs21, res1)
          prval ((*folded*)) = fold@(res)
        } (* end of [else] *)
    end // end of [list0_cons]
  )
)
//
val-list0_cons(xs1, rs) = rs
val-list0_cons(xs2, rs) = rs
//
in
//
let
var res: ptr
val ((*void*)) = merge(xs1, xs2, res) in res
end
//
end // end of [DivideConquer$conquer$combine]

(* ****** ****** *)
//
implement
{}(*tmp*)
MergeSort_list(xs) = let
  val n = list0_length(xs) in $DC.DivideConquer$solve<>((n, xs))
end // end of [MergeSort_list]
//
(* ****** ****** *)

(* end of [MergeSort_list.dats] *)
