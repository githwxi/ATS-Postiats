(*
** Implementing
** Monte Carlo pi simulation
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#define :: list0_cons

(* ****** ****** *)

macdef
list0_sing(x) =
list0_cons(,(x), list0_nil())

(* ****** ****** *)

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)
//
#define
int2dbl g0int2float_int_double
#define
dbl2int g0float2int_double_int
//
(* ****** ****** *)

(* ****** ****** *)

(* end of [MonteCarlo.dats] *)
