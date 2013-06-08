//
// ProjectEuler: Problem 4
// Finding the largest palindrome
// made from the product of two 3-digit numbers
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Time: August, 2010
//
(* ****** ****** *)
//
// HX-2013-06: ported to ATS2
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)

fun test
  (x: int): bool = let
  fun rev (x: int, res: int): int =
    if x > 0 then let
      val r = x mod 10 in rev (x / 10, 10 * res + r)
    end else res
  // end of [rev]
in
  x = rev (x, 0)
end // end of [test]

(* ****** ****** *)

implement
main0 () = let
//
var pmax: int = 0
var imax: int = 0 and jmax: int = 0
var i: int = 0 and j: int = 0
val () =
(
for (i := 0; i <= 999; i := i + 1)
for (j := i; j <= 999; j := j + 1)
let
//
val x = i * j
val () = if test (x) then
  (if x > pmax then (pmax := x; imax := i; jmax := j))
//
in
  // nothing
end // end of [val]
) (* end of [val] *)
//
val ans = pmax
val () = assert_errmsg (ans = 906609, $mylocation)
//
in
  println! "ans(" imax "*" jmax ") = " ans
end // end of [main]

(* ****** ****** *)

(* end of [problem4-hwxi.dats] *)
