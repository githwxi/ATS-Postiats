(* ****** ****** *)
(*
** DivideConquer:
** MergeSort_list
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
MergeSort_list_int
  (xs: list0(int)): list0(int)
//
(* ****** ****** *)
//
extern
fun
MergeSort_list_double
  (xs: list0(double)): list0(double)
//
(* ****** ****** *)
//
extern
fun
MergeSort_array_int
  {n:int}
  (arrayref(int, n), int(n)): void
//
(* ****** ****** *)
//
extern
fun
MergeSort_array_double
  {n:int}
  (arrayref(double, n), int(n)): void
//
(* ****** ****** *)

(* end of [testlib.dats] *)
