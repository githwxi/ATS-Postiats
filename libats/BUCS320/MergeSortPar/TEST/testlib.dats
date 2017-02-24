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

#include "./../mydepies.hats"

(* ****** ****** *)
//
typedef
fworkshop = $FWORKSHOP_chanlst.fworkshop
//
(* ****** ****** *)
//
extern
fun
MergeSortPar_list_int
  (fws: fworkshop, xs: list0(int)): list0(int)
//
extern
fun
MergeSortPar_list_double
  (fws: fworkshop, xs: list0(double)): list0(double)
//
(* ****** ****** *)
//
extern
fun
MergeSortPar_array_int{n:int}
  (fws: fworkshop, A: arrayref(int, n), n: int(n)): void
//
extern
fun
MergeSortPar_array_double{n:int}
  (fws: fworkshop, A: arrayref(double, n), n: int(n)): void
//
(* ****** ****** *)

(* end of [testlib.dats] *)
