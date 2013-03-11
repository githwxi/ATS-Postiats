//
// Computing the Fibonacci numbers
// (A naive implementation of expnential complexity)
//
// Author: Hongwei Xi (January 2013)
//
(* ****** ****** *)
//
staload _ = "prelude/DATS/integer.dats"
//
(* ****** ****** *)
//
fun fib (n: int): int =
  if n >= 2 then fib (n-1) + fib (n-2) else n
//
(* ****** ****** *)

implement
main0 () = {
  #define N 10
  val () = assertloc (fib(N) = 55)
(*
  val () = println! ("fib(", N, ") = ", fib (10))
*)
} // end of [main0]

(* ****** ****** *)

(* end of [fib1.dats] *)
