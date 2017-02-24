(* ****** ****** *)
(*
** DivideConquer:
** MergeSort_list
**
*)
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
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
#define MERGESORT_LIST
//
#include "./../mydepies.hats"
#include "./../mylibies.hats"
//
(* ****** ****** *)
//
#staload
MS_list = $MergeSort_list
//
assume $MS_list.elt_t0ype = double
//
implement
gcompare_val_val<double>
  (x, y) = compare(x, y)
//
implement
$MS_list.MergeSort_list$cutoff<>() = 2
//
implement
MergeSort_list_double(xs) = $MS_list.MergeSort_list<>(xs)
//
(* ****** ****** *)

(* end of [MergeSort_list_double.dats] *)
