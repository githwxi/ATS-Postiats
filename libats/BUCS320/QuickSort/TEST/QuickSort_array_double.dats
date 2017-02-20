(* ****** ****** *)
(*
** DivideConquer:
** QuickSort_array
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
#define QUICKSORT_ARRAY
//
#include "./../mydepies.hats"
#include "./../mylibies.hats"
//
(* ****** ****** *)
//
#staload
QS_array = $QuickSort_array
//
assume $QS_array.elt_t0ype = double
//
implement
gcompare_val_val<double>
  (x, y) = compare(x, y)
//
implement
$QS_array.QuickSort_array$cutoff<>
  ((*void*)) = 2
//
implement
QuickSort_array_double
  (xs, n) = $QS_array.QuickSort_array<>(xs, n)
//
(* ****** ****** *)

(* end of [QuickSort_array_double.dats] *)
