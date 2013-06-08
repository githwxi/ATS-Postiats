//
// ProjectEuler: Problem 301
// Finding the winning strategry for the Nim game (of 3 heaps)
//
(* ****** ****** *)
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: September, 2010
//
(* ****** ****** *)
//
// HX-2013-06: ported to ATS2
//
(* ****** ****** *)
//
// HX:
//
// Given p, q, r, let
// p = a1 ... an (binary rep.)
// q = b1 ... bn (binary rep.)
// r = c1 ... cn (binary rep.)
// it is easy to prove that
// X (p, q, r) = 0 if and only if
// ai+bi+ci = 0 or 2 for any 1 <= i <= n
//
// This strategy easily generalizes to n heaps for each n >= 2
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)

fun X
(
  n1: uint, n2: uint, n3: uint
) : int =
(
if n1 = 0U then
  (if n2 = n3 then 0 else 1)
else let
  val r1 = n1 land 1U
  val r2 = n2 land 1U
  val r3 = n3 land 1U
in
  if ((r1+r2+r3) land 1U) = 0U then X (n1 >> 1, n2 >> 1, n3 >> 1) else 1
end // end of [if]
) (* end of [X] *)

(* ****** ****** *)

implement
main0 () =
{
val N = 1U << 30
var cnt: int = 0
var n: uint // uninitialized
val () = for
  (n := 1U; n <= N; n := n+1U)
  cnt := cnt + (1 - X (n, 2U*n, 3U*n))
// end of [val]
//
val ans = cnt
val () = assertloc (ans = 2178309)
val () = (print "ans = "; print ans; print_newline ())
//
} // end of [main0]

(* ****** ****** *)

(* end of [problem301-hwxi.dats] *)
