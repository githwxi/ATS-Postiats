(* ****** ****** *)
(*
** DivideConquer:
** QuickSortPar_list
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
QuickSortPar_array_int{n:int}
  (fws: fworkshop, A: arrayref(int, n), n: int(n)): void
//
extern
fun
QuickSortPar_array_double{n:int}
  (fws: fworkshop, A: arrayref(double, n), n: int(n)): void
//
(* ****** ****** *)

(* end of [testlib.dats] *)
