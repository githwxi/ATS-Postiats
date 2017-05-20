(*
// Lazy-evaluation:
// Erathosthene's sieve for primes
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: September, 2007
//
(* ****** ****** *)

(*
** Ported to ATS2 by HX-2013-09
*)

(* ****** ****** *)
//
#define
LIBATSCC2PY3_targetloc
"$PATSHOME\
/contrib/libatscc2py3/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2PY3}/staloadall.hats"
//
(* ****** ****** *)
//
#define nil stream_nil
#define cons stream_cons
//
(* ****** ****** *)
//
fun
from
{n:int}
(
  n: int n
) : stream (int) = $delay(cons(n, from(n+1)))
//
(* ****** ****** *)

fun sieve
(
  ns: stream int
) :<!laz>
  stream (int) = $delay
(
let
  val-cons(n, ns) = !ns
in
  cons(n, sieve (stream_filter_cloref(ns, lam x => x % n > 0)))
end : stream_con (int)
) (* end of [sieve] *)

(* ****** ****** *)

fun
nth{a:t@ype}
(
  xs: stream(INV(a)), n: int
) : a = let
//
val-stream_cons (x, xs) = !xs
//
in
  if n > 0 then nth (xs, n-1) else x
end // end of [nth]

(* ****** ****** *)
//
extern 
fun
main0_py (): void = "mac#"
//
implement
main0_py ((*void*)) =
{
//
val ps = sieve (from(2))
//
val () = println! ("primes[0] = ", nth(ps, 0))
val () = println! ("primes[1] = ", nth(ps, 1))
val () = println! ("primes[2] = ", nth(ps, 2))
val () = println! ("primes[3] = ", nth(ps, 3))
val () = println! ("primes[4] = ", nth(ps, 4))
val () = println! ("primes[5] = ", nth(ps, 5))
val () = println! ("primes[6] = ", nth(ps, 6))
val () = println! ("primes[7] = ", nth(ps, 7))
val () = println! ("primes[8] = ", nth(ps, 8))
val () = println! ("primes[9] = ", nth(ps, 9))
//
val () = println! ("primes[100] = ", nth(ps, 100))
val () = println! ("primes[1000] = ", nth(ps, 1000))
//
} (* end of [main0_py] *)
//
(* ****** ****** *)

%{$
//
main0_py();
//
%} // end of [%{$]

(* ****** ****** *)

%{^
######
import sys
######
from libatscc2py3_all import *
######
sys.setrecursionlimit(1000000)
######
%} (* end of [%{^] *)

(* ****** ****** *)

(* end of [sieve_lazy.dats] *)
