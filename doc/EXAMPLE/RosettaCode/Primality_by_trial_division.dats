(* ****** ****** *)
//
// Author: HX-2017-01-02
//
(* ****** ****** *)
(*
Task

Write a boolean function that tells whether a given integer is prime.

Remember that 1 and all non-positive numbers are not prime.

Use trial division.

Even numbers over two may be eliminated right away.

A loop from 3 to sqrt(n) will suffice,   but other loops are allowed. 
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
#staload M = "libats/libc/SATS/math.sats"
//
(* ****** ****** *)
//
fun
isqrt(n: intGte(0)): intGte(0) =
  $UNSAFE.cast($M.sqrt_double(g0i2f(n)))
//
fun
is_prime
(
n : intGte(2)
) : bool =
(
if
(n = 2)
then true
else (
  if n % 2 = 0
    then false
    else (1, (isqrt(n)+1)/2).forall()(lam i => n % (2*i+1) != 0)
) (* else *)
) (* end of [is_prime] *)
//
(* ****** ****** *)

implement
main0 () =
{
//
val () = assertloc(is_prime(5))
val () = assertloc(is_prime(7))
val () = assertloc(~is_prime(9))
val () = assertloc(~is_prime(3*5))
val () = assertloc(~is_prime(7*7))
//
val
thePrimes =
(
(fix f(n:intGte(2)): stream_vt(intGte(2)) => $ldelay(stream_vt_cons(n, f(n+1))))(2)
).filter()(lam n => is_prime(n))
//
val () =
println!
(
"The first 10 primes are:"
) (* println! *)
val ((*void*)) =
stream_vt_fprint<int>(thePrimes, stdout_ref, 10)
val () = println! ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [Primality_by_trial_division.dats] *)
