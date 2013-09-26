(*
//
// ProjectEuler: Problem 1
// Finding the sum of all numbers below 1000 that is a multiple of 3 or 5
//
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Time: December, 2010
//
(* ****** ****** *)
//
// HX-2013-04: this one is ported from ATS to ATS2
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun sum35
(
  n: int, i: int, res: int
) : int =
(
  if i < n then
    sum35 (n, i+1, if (i mod 3 = 0 orelse i mod 5 = 0) then res+i else res)
  else res // end of [if]
) (* end of [sum35] *)

(* ****** ****** *)

implement
main0 () =
{
//
#define N 1000
//
val ans = sum35 (N, 0, 0)
val () =
(
  println! ("The sum of all the natural numbers < ", N, " that are multiples of 3 or 5 = ", ans)
) // end of [val]
} // end of [main]

(* ****** ****** *)

(* end of [problem1-hwxi.dats] *)
