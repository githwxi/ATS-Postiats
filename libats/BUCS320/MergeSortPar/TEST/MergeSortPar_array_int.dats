(* ****** ****** *)
(*
** DivideConquer:
** MergeSortPar_array
**
*)
(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
%{^
//
#include <pthread.h>
//
%} // end of [%{^]
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
#define MERGESORTPAR_ARRAY
//
#include "./../mylibies.hats"
#include "./../mydepies.hats"
#include "./../mydepies_array.hats"
//
(* ****** ****** *)
//
assume
$MergeSort_array.elt_t0ype = int
//
implement
gcompare_val_val<int>(x, y) = compare(x, y)
//
implement
MergeSortPar_array_int
  (fws, A, n) =
(
  $MergeSortPar_array.MergeSortPar_array<>(fws, A, n)
) // end of [MergeSortPar_array_int]
//
(* ****** ****** *)

(* end of [MergeSortParPar_array_int.dats] *)
