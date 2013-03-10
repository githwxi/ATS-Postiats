//
// Computing the Fibonacci numbers
// (A naive implementation of expnential complexity)
//
// Author: Hongwei Xi (January 2013)
//
(* ****** ****** *)
//
staload INT = "prelude/DATS/integer.dats"
//
(* ****** ****** *)
//
fun fib (n: int): int =
  if n >= 2 then fib (n-1) + fib (n-2) else n
//
(* ****** ****** *)

implement
main0 () = {
  val ans = fib (10)
  val () = println! ("ans = ", ans)
} // end of [main]

(* ****** ****** *)

(* end of [fib1.dats] *)
