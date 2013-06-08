//
// ProjectEuler: Problem 12
// Finding the first triangular number containing more than 500 divisors
//
(* ****** ****** *)
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: August, 2010
//
(* ****** ****** *)
//
// HX-2013-06: ported to ATS2
//
(* ****** ****** *)
//
staload _(*anon*) = "prelude/DATS/integer.dats"
//
(* ****** ****** *)
//
// HX: Please note that gcd (n, n+1) = 1
//
(* ****** ****** *)

fun count (n: int) = let
//
fun loop (n: int, i: int, c: int): int =
  if i < n then
    (if (n mod i = 0) then loop (n, i+1, c+1) else loop (n, i+1, c))
  else c // end of [if]
// end of [loop]
in
  loop (n, 2, 2)
end // end of [count]

(* ****** ****** *)

implement
main0 () = let
//
#define N 500
//
fnx loop1 (n: int): int = let // n is odd
  val c1 = count (n)
  val c2 = count ((n+1)/2)
in
  if c1 * c2 > N then n else loop2 (n+1)
end // end of [loop1]

and loop2 (n: int): int = let // n is even
  val c1 = count (n/2)
  val c2 = count (n+1)
in
  if c1 * c2 > N then n else loop1 (n+1)
end
//
val n = loop1 (1)
val ans = n*(n+1)/2
//
val () = assertloc (ans = 76576500)
//
in
  print "ans = "; print ans; print_newline ()
end // end of [main0]

(* ****** ****** *)

(* end of [problem12-hwxi.dats] *)
