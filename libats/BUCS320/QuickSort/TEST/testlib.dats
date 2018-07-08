(* ****** ****** *)
(*
** DivideConquer:
** QuickSort_list
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
QuickSort_array_int
  {n:int}
  (arrayref(int, n), int(n)): void
//
(* ****** ****** *)
//
extern
fun
QuickSort_array_double
  {n:int}
  (arrayref(double, n), int(n)): void
//
(* ****** ****** *)

(* end of [testlib.dats] *)
