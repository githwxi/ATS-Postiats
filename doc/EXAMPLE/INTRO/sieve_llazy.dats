//usr/bin/env myatscc "$0"; exit
(* ****** ****** *)
(*
// Linear Lazy-evaluation:
// Erathosthene's sieve for primes
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxiATcsDOTbuDOTedu)
// Start Time: February, 2008
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

#define nil stream_vt_nil
#define :: stream_vt_cons
#define cons stream_vt_cons

(* ****** ****** *)

fun{a:t0p}
stream_vt_nth
(
  xs0: stream_vt a, i: intGte(0)
) : a = let
  val xs0_con = !xs0
in
//
case+ xs0_con of
| ~(x :: xs) =>
  (
    if i = 0
      then (~xs; x) else stream_vt_nth<a> (xs, i-1)
    // end of [if]
  ) // end of [::]
| ~nil ((*void*)) => $raise StreamSubscriptExn(*void*)
end // end of [stream_vt_nth]

(* ****** ****** *)

fun
from_con{n:int} (n: int n)
  :<!laz> stream_vt_con (intGte n) =
  stream_vt_cons{intGte(n)}(n, from (n+1))
and from{n:int} (n: int n)
  :<!laz> stream_vt (intGte n) = $ldelay (from_con n)

(* ****** ****** *)

typedef N2 = intGte(2)

(* ****** ****** *)

fun sieve_con
  (ns: stream_vt N2)
  : stream_vt_con (N2) = let
  val ns_con = !ns
  val-@cons(n, ns2) = ns_con; val p = n
  val ps = sieve
  (
    stream_vt_filter_cloptr (ns2, lam x => g1int_nmod(x, p) > 0)
  ) (* end of [val] *)
  val () = (ns2 := ps)
in
  fold@ ns_con; ns_con
end // end of [sieve_con]

and sieve
  (ns: stream_vt N2): stream_vt (N2) = $ldelay (sieve_con ns, ~ns)
// end of [sieve]

(* ****** ****** *)

fn primes (): stream_vt N2 = sieve (from 2)
fn prime_get (n: Nat): Nat = stream_vt_nth<N2> (primes (), n)

(* ****** ****** *)

implement
main0 () = begin
//
println! ("prime(1000) = ", prime_get (1000)) ; // = 7927
(*
println! ("prime(5000) = ", prime_get (5000)) ; // = 48619
println! ("prime(10000) = ", prime_get (10000)) ; // = 104743
*)
//
end // end of [main0]

(* ****** ****** *)

(* end of [sieve_llazy.dats] *)
