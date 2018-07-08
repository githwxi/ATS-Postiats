(* ****** ****** *)
//
// Reported by
// HWWU-2016-10-08
//
(* ****** ****** *)
//
// Status
// HWXi-2016-10-11: fixed:
// pats_ccomp_claulst
//
(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

datatype abc = A of int | B of int | C of ()

(* ****** ****** *)
//
fun
test
(
x0: abc
) : int =
case- x0 of
| A(n) when n >= 2 => ~2
| A(n) when n >= 1 => ~1
| B(n) => 1
| C( ) => 2
(*
| A(n) => 0
*)
//
(* ****** ****** *)

implement
main0() = println! (test(A(0)))

(* ****** ****** *)

(* end of [bug-2016-10-08.dats] *)
