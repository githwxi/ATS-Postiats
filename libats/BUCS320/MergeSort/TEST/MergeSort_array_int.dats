(* ****** ****** *)
(*
** DivideConquer:
** MergeSort_array
**
*)
(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#staload "./testlib.dats"

(* ****** ****** *)
//
#define MERGESORT_ARRAY
//
#include "./../mydepies.hats"
#include "./../mylibies.hats"
//
(* ****** ****** *)
//
#staload
MS_array = $MergeSort_array
//
assume $MS_array.elt_t0ype = int
//
implement
gcompare_val_val<int>
  (x, y) = compare(x, y)
//
implement
$MS_array.MergeSort_array$cutoff<>() = 2
//
implement
MergeSort_array_int(xs, n) = $MS_array.MergeSort_array<>(xs, n)
//
(* ****** ****** *)

(* end of [MergeSort_array_int.dats] *)
