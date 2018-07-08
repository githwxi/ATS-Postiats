//usr/bin/env myatscc "$0"; exit
(* ****** ****** *)
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
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -
*)
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define :: stream_cons
#define cons stream_cons
#define nil stream_nil

(* ****** ****** *)
//
fun
from{n:int} (n: int n)
  :<!laz> stream (intGte(n)) = $delay (cons{intGte(n)}(n, from (n+1)))
//
(* ****** ****** *)

typedef N2 = intGte(2)

(* ****** ****** *)

fun sieve
(
  ns: stream N2
) :<!laz>
  stream (N2) = $delay
(
let
  val-cons(n, ns) = !ns
in
  cons{N2}(n, sieve (stream_filter_cloref<N2> (ns, lam x => g1int_nmod(x, n) > 0)))
end : stream_con (N2)
) // end of [sieve]

//

val primes: stream (N2) = sieve (from(2))

//

macdef prime_get (n) = stream_nth_exn (primes, ,(n))

//

implement
main0 () = begin
//
println! ("prime 1000 = ", prime_get (1000)) ; // = 7927
(*
println! ("prime 5000 = ", prime_get (5000)) ; // = 48619
println! ("prime 10000 = ", prime_get (10000)) ; // = 104743
*)
//
end // end of [main0]

(* ****** ****** *)

(* end of [sieve_lazy.dats] *)
