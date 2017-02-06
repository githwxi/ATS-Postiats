(* ****** ****** *)
(*
** DivideConquer:
** MergeSortPar_list
**
*)
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
extern
fun
MergeSortPar_list_int
  (xs: list0(int)): list0(int)
//
(* ****** ****** *)
//
extern
fun
MergeSortPar_list_double
  (xs: list0(double)): list0(double)
//
(* ****** ****** *)

(* end of [testlib.dats] *)
