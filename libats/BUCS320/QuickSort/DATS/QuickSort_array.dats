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
QuickSort_array
  {n:int}
(
  A: arrayref(elt, n), n: int(n)
) : void // end-of-fun
//
(* ****** ****** *)
//
extern
fun{}
QuickSort_array$cutoff
  ((*void*)): intGte(2)
//
local
#define CUTOFF 128
in(*in-of-local*)
implement
{}(*tmp*)
QuickSort_array$cutoff() = CUTOFF
end // end of [local]
//
(* ****** ****** *)
//
typedef input =
[n:nat] (int(n), arrayref(elt, n))
typedef output = int(*void*)
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
CUTOFF = QuickSort_array$cutoff<>()
//
in
  if nxs.0 >= CUTOFF then false else true
end // end of [DivideConquer$base_test]
//
(* ****** ****** *)
//
implement
$DC.DivideConquer$base_solve<>
  (nxs) = (0) where
{
//
implement
array_quicksort$cmp<elt>
  (x, y) = gcompare_ref_ref<elt>(x, y)
//
val () =
arrayref_quicksort<elt>(nxs.1, i2sz(nxs.0))
//
} (* end of [DivideConquer$base_solve] *)
//
(* ****** ****** *)
//
implement
$DC.DivideConquer$divide<>(nxs) = list0_nil()
//
(* ****** ****** *)

implement
$DC.DivideConquer$conquer$combine<>(_, _) = 0

(* ****** ****** *)
//
implement
{}(*tmp*)
QuickSort_array
  (xs, n) = () where
{
//
prval
((*void*)) = lemma_arrayref_param(xs)
//
val _(*0*) = $DC.DivideConquer$solve<>((n, xs))
//
} (* end of [QuickSort_array] *)
//
(* ****** ****** *)

(* end of [QuickSort_array.dats] *)
