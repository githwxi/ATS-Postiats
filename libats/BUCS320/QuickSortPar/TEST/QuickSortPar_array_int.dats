(* ****** ****** *)
(*
** DivideConquer:
** QuickSortPar_array
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
#define QUICKSORTPAR_ARRAY
//
#include "./../mylibies.hats"
#include "./../mydepies.hats"
#include "./../mydepies_array.hats"
//
(* ****** ****** *)
//
assume
$QuickSort_array.elt_t0ype = int
//
implement
gcompare_val_val<int>(x, y) = compare(x, y)
//
implement
QuickSortPar_array_int
  (fws, A, n) =
(
  $QuickSortPar_array.QuickSortPar_array<>(fws, A, n)
) // end of [QuickSortPar_array_int]
//
(* ****** ****** *)

(* end of [QuickSortParPar_array_int.dats] *)
