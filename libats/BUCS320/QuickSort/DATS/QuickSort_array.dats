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
extern
fun{}
QuickSort_array$randint
  {n:int | n >= 1}(int(n)): intBtw(0, n)
//
implement
QuickSort_array$randint<>(n) = randint<>(n)
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

implement
$DC.DivideConquer$divide<>
  (nxs) = let
//
val n0 = nxs.0
and A0 = nxs.1
//
prval
[n0:int]
EQINT() = eqint_make_gint(n0)
//
stadef n1 = n0 - 1
//
val n1 = n0 - 1
val () = assertloc(n0 >= 2)
//
val () = () where
{
val i0 =
QuickSort_array$randint<>(n0)
val () =
arrayref_interchange<elt>(A0, i2sz(i0), i2sz(n1))
}
//
val
p0 = ptrcast(A0)
val
p_pivot =
ptr_add<elt>(p0, n1)
//
fun{}
ptrinc
(
 p: ptr
) : ptr = ptr_succ<elt>(p)
fun{}
ptrdec
(
 p: ptr
) : ptr = ptr_pred<elt>(p)
//
fun{}
ptrcmp
(p: ptr): int = sgn where
{
//
val
(pf1, fpf1 | p) =
$UNSAFE.ptr_vtake{elt}(p)
val
(pf2, fpf2 | p_pivot) =
$UNSAFE.ptr_vtake{elt}(p_pivot)
//
val
sgn =
gcompare_ref_ref<elt>(!p, !p_pivot)
//
prval ((*returned*)) = fpf1(pf1)
prval ((*returned*)) = fpf2(pf2)
//
} (* end of [ptrcmp] *)
//
fnx
split
(
pa0: ptr, pz0: ptr
) : ptr =
(
if
(pa0 < pz0)
then let
  val sgn = ptrcmp(pa0)
  val pa1 = ptrinc(pa0)
in
//
if
(sgn < 0)
then split(pa1, pz0)
else split2(pa0, pa1, pz0)
//
end // end of [then]
else (pa0) // end of [else]
)
//
and
split2
(
pa0: ptr, pa1: ptr, pz0: ptr
) : ptr =
(
if
(pa1 < pz0)
then let
  val pz1 = ptrdec(pz0)
  val sgn = ptrcmp(pz1)
in
//
if
(sgn < 0)
then split(pa1, pz1) where
{
  val () =
  $UNSAFE.ptr0_intch<elt>(pa0, pz1)
}
else split2(pa0, pa1, pz1)
//
end // end of [split2]
else (pa0) // end of [else]
)
//
val p_split = split(p0, p_pivot)
//
val nf = ptr0_diff<elt>(p_split, p0)
//
val
[nf:int] nf =
$UNSAFE.cast{intBtw(0, n0)}(nf)
val nr = n1 - nf
//
val () =
$UNSAFE.ptr0_intch<elt>(p_split, p_pivot)
//
val Af =
$UNSAFE.cast{arrayref(elt, nf)}(p0)
val Ar =
$UNSAFE.cast{arrayref(elt, n1-nf)}(ptrinc(p_split))
//
in
  g0ofg1($list{input}( @(nf, Af), @(nr, Ar) ))
end // end of [DivideConquer$divide]
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
