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
MergeSort_array
  {n:int}
(
  A: arrayref(elt, n), n: int(n)
) : void // end-of-fun
//
(* ****** ****** *)
//
extern
fun{}
MergeSort_array$cutoff
  ((*void*)): intGte(2)
//
local
#define CUTOFF 128
in(*in-of-local*)
implement
{}(*tmp*)
MergeSort_array$cutoff() = CUTOFF
end // end of [local]
//
(* ****** ****** *)
//
datatype
input =
| {n:nat}
  MSORT1 of
  (int(n)(*asz*), ptr(*A*), ptr(*B*))
| {n:nat}
  MSORT2 of
  (int(n)(*asz*), ptr(*A*), ptr(*B*))
//
typedef output = input
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
  (inp) = let
//
val
CUTOFF = MergeSort_array$cutoff<>()
//
in
//
case+ inp of
| MSORT1(n, _, _) =>
  if n >= CUTOFF then false else true
| MSORT2(n, _, _) =>
  if n >= CUTOFF then false else true
//
end // end of [DivideConquer$base_test]
//
(* ****** ****** *)
//
implement
$DC.DivideConquer$base_solve<>
  (inp) = let
//
fun
sort{n:nat}
(
A: ptr, n: int(n)
) : void = let
//
implement
array_quicksort$cmp<elt>
  (x, y) = gcompare_ref_ref<elt>(x, y)
//
in
//
arrayref_quicksort<elt>
  ($UNSAFE.cast{arrayref(elt,n)}(A), i2sz(n))
//
end // end of [sort]
//
fun
copy{n:nat}
(
A: ptr, B: ptr, n: int(n)
) : void = let
//
(*
val () = println!("copy")
*)
//
in
//
$extfcall
( void
, "atspre_array_memcpy", B, A, n*sizeof<elt>
) (* $extfcall *)
//
end (* end of [copy] *)
//
in
//
case+ inp of
| MSORT1(n, A, B) => (sort(A, n); inp)
| MSORT2(n, A, B) => (sort(A, n); copy(A, B, n); inp)
//
end // end of [DivideConquer$base_solve]
//
(* ****** ****** *)
//
implement
$DC.DivideConquer$divide<>
  (inp) = let
//
(*
val () =
  println!("DivideConquer$divide")
*)
//
in
//
case+ inp of
| MSORT1(n, A, B) => let
    val n1 = half(n)
    val A1 = A and B1 = B
    val A2 = ptr_add<elt>(A, n1)
    val B2 = ptr_add<elt>(B, n1)
    val inp1 = MSORT2(n1, A1, B1)
    val inp2 = MSORT2(n-n1, A2, B2)
  in
    list0_pair(inp1, inp2)
  end // end of [MSORT1]
| MSORT2(n, A, B) => let
    val n1 = half(n)
    val A1 = A and B1 = B
    val A2 = ptr_add<elt>(A, n1)
    val B2 = ptr_add<elt>(B, n1)
    val inp1 = MSORT1(n1, A1, B1)
    val inp2 = MSORT1(n-n1, A2, B2)
  in
    list0_pair(inp1, inp2)
  end // end of [MSORT2]
//
end // end of [DivideConquer$divide]
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

implement
$DC.DivideConquer$conquer$combine<>
  (inp0, outs) = let
//
fun
copy{n:nat}
(
A: ptr, B: ptr, n: int(n)
) : void = let
//
(*
val () = println!("copy")
*)
//
in
//
$extfcall
( void
, "atspre_array_memcpy", B, A, n*sizeof<elt>
) (* $extfcall *)
//
end (* end of [copy] *)
//
fun
merge
{n1,n2:nat} .<n1+n2>.
(
A1: ptr, A2: ptr, B: ptr, n1: int(n1), n2: int(n2)
) : void =
(
if
(n1 = 0)
then copy(A2, B, n2)
else let
  val x1 =
    $UN.ptr0_get<elt>(A1)
  // end of [val]
  val A1 = ptr_succ<elt>(A1)
in
  merge1(x1, A1, A2, B, n1-1, n2)
end // end of [else]
)
and
merge1
{n1,n2:nat} .<n1+n2>.
(
x1: elt, A1: ptr, A2: ptr, B: ptr, n1: int(n1), n2: int(n2)
) : void =
(
if
(n2 = 0)
then let
  val () =
  $UN.ptr0_set<elt>(B, x1)
in
  copy(A1, ptr_succ<elt>(B), n1)
end // end of [then]
else let
  val x2 =
    $UN.ptr0_get<elt>(A2)
  // end of [val]
  val A2 = ptr_succ<elt>(A2)
  val sgn = gcompare_val_val<elt>(x1, x2)
in
//
if
(sgn <= 0)
then let
  val () =
  $UN.ptr0_set<elt>(B, x1)
in
  merge2(A1, x2, A2, ptr_succ<elt>(B), n1, n2-1)
end // end of [then]
else let
  val () =
  $UN.ptr0_set<elt>(B, x2)
in
  merge1(x1, A1, A2, ptr_succ<elt>(B), n1, n2-1)
end // end of [else]
//
end // end of [else]
) (* end of [merge1] *)
//
and
merge2
{n1,n2:nat} .<n1+n2>.
(
A1: ptr, x2: elt, A2: ptr, B: ptr, n1: int(n1), n2: int(n2)
) : void =
(
if
(n1 = 0)
then let
  val () =
  $UN.ptr0_set<elt>(B, x2)
in
  copy(A2, ptr_succ<elt>(B), n2)
end // end of [then]
else let
  val x1 =
    $UN.ptr0_get<elt>(A1)
  // end of [val]
  val A1 = ptr_succ<elt>(A1)
  val sgn = gcompare_val_val<elt>(x1, x2)
in
//
if
(sgn <= 0)
then let
  val () =
  $UN.ptr0_set<elt>(B, x1)
in
  merge2(A1, x2, A2, ptr_succ<elt>(B), n1-1, n2)
end // end of [then]
else let
  val () =
  $UN.ptr0_set<elt>(B, x2)
in
  merge1(x1, A1, A2, ptr_succ<elt>(B), n1-1, n2)
end // end of [else]
//
end // end of [else]
) (* end of [merge2] *)
//
val-list0_cons(out1, outs) = outs
val-list0_cons(out2, outs) = outs
//
in
//
case+ inp0 of
| MSORT1(n, A, B) => inp0 where
  {
    val-MSORT2(n1, A1, B1) = out1
    val-MSORT2(n2, A2, B2) = out2
    val () = merge(B1, B2, A, n1, n2)
  }
| MSORT2(n, A, B) => inp0 where
  {
    val-MSORT1(n1, A1, B1) = out1
    val-MSORT1(n2, A2, B2) = out2
    val () = merge(A1, A2, B, n1, n2)
  }
//
end // end of [DivideConquer$conquer$combine]

(* ****** ****** *)
//
implement
{}(*tmp*)
MergeSort_array
  (A, n) = () where
{
//
prval
() = lemma_arrayref_param(A)
//
val B =
arrayptr_make_uninitized<elt>
  (i2sz(n))
//
val inp =
MSORT1(n, ptrcast(A), ptrcast(B))
//
val _(*inp*) =
  $DC.DivideConquer$solve<>(inp)
//
val ((*freed*)) = arrayptr_free(B)
//
} (* end of [MergeSort_array] *)
//
(* ****** ****** *)

(* end of [MergeSort_list.dats] *)
