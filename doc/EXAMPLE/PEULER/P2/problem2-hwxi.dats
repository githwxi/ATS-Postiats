//
// ProjectEuler: Problem 2
// Finding the sum of all even Fibonacci numbers not exceeding 4M
//

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Time: August, 2010
//
(* ****** ****** *)
//
// Ported to ATS2 by Hongwei Xi (June, 2013)
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libgmp/SATS/gmp.sats"

(* ****** ****** *)

fun loop
(
  N: ulint, i: ulint, ifib: &mpz, sum: &mpz
) : void = let
//
val () = mpz_fib (ifib, i)
//
(*
val () = println! ("i = ", i)
val () = println! ("ifib = ", ifib)
*)
//
val sgn = mpz_cmp_ulint (ifib, N)
//
in
//
if sgn < 0 then let
  val () = if mpz_even_p (ifib) then mpz_add (sum, ifib)
in
  loop (N, succ(i), ifib, sum)
end else () // end of [if]
//
end // end of [loop]

(* ****** ****** *)

implement
main0 () = () where
{
//
val out = stdout_ref
//
macdef N = 4000000UL
//
var ifib: mpz; val () = mpz_init (ifib)
var fibsum: mpz; val () = mpz_init_set (fibsum, 0UL)
val () = loop (N, 2UL, ifib, fibsum) // starting from the 2nd Fib number
val () = assertloc (mpz_get_ulint (fibsum) = 4613732UL)
val () = fprintln! (out, "The sum of all even Fibonacci numbers < 4 million = ", fibsum)
val () = mpz_clear (ifib)
val () = mpz_clear (fibsum)
//
} // end of [main]

(* ****** ****** *)

(* end of [problem2-hwxi.dats] *)
