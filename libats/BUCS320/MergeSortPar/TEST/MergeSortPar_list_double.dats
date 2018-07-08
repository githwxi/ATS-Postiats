(* ****** ****** *)
(*
** DivideConquer:
** MergeSortPar_list
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
#define MERGESORTPAR_LIST
//
#include "./../mylibies.hats"
#include "./../mydepies.hats"
#include "./../mydepies_list.hats"
//
(* ****** ****** *)
//
assume
$MergeSort_list.elt_t0ype = double
//
implement
gcompare_val_val<double>(x, y) = compare(x, y)
//
implement
MergeSortPar_list_double
  (fws, xs) =
(
  $MergeSortPar_list.MergeSortPar_list<>(fws, xs)
) (* end of [MergeSortPar_list_double] *)
//
(* ****** ****** *)

(* end of [MergeSortParPar_list_double.dats] *)
