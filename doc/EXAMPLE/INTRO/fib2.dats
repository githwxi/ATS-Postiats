//
// Computing the Fibonacci numbers
//
// Author: Hongwei Xi (January 2013)
//
(* ****** ****** *)
//
staload _ = "prelude/DATS/integer.dats"
//
(* ****** ****** *)

typedef T = int
typedef T2 = (T, T)
fun fib (n: int): T = let
//
fun loop
(
  xx: &T2, n: int
) : void = let
in
  if n > 0 then let
    val x0 = xx.0 and x1 = xx.1
    val () = xx.0 := x1 and () = xx.1 := x0+x1
  in
    loop (xx, n-1)
  end // end of [if]
end // end of [loop]
//
var xx: T2 = (0, 1)
val () = loop (xx, n)
//
in
  xx.0
end // end of [fib]

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

(* end of [fib2.dats] *)
