//
// fixed-point operators
//
// Author: Hongwei Xi (2013-09)
// Authoremail: gmhwxiATgmailDOTcom
//

(* ****** ****** *)

staload "prelude/DATS/integer.dats"

(* ****** ****** *)
//
val fact =
  fix f (x: int): int => if x > 0 then x * f (x-1) else 1
val () = println! ("fact(10) = ", fact(10))
//
(* ****** ****** *)

val fib10 =
(fix f (x: int): int => if x >= 2 then f(x-1)+f(x-2) else x)(10)
val () = println! ("fib(10) = ", fib10)

(* ****** ****** *)

fun power (m: int, n: int): int = let
//
val f = fix f (n: int): int =<cloref1> if n > 0 then m*f(n-1) else 1
//
in
  f (n)
end // end of [foo]
val () = println! ("power(2, 10) = ", power(2, 10))

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [fixedpoint.dats] *)
