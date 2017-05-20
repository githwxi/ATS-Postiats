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

#define nil stream_vt_nil
#define cons stream_vt_cons

(* ****** ****** *)
//
fun
stream_vt_nth
  {a:t0p}
(
  xs0: stream_vt a, i: intGte(0)
) : a = let
//
val-~cons(x, xs) = !xs0
//
in
  if i = 0
    then (~xs; x) else stream_vt_nth(xs, i-1)
  // end of [if]
end // end of [stream_vt_nth]
//
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

fun
sieve_con
  (ns: stream_vt N2)
  : stream_vt_con (N2) = let
  val-
  ~cons(n, ns2) = !ns; val p = n
  val ps = sieve
  (
    stream_vt_filter_cloref
      (ns2, lam x => nmod_int1_int1(x, p) > 0)
    // stream_vt_filter_cloref
  ) (* end of [val] *)
in
  cons(p, ps)
end // end of [sieve_con]

and
sieve
(
  ns: stream_vt N2
) : stream_vt (N2) = $ldelay (sieve_con ns, ~ns)
// end of [sieve]

(* ****** ****** *)

fn primes (): stream_vt N2 = sieve (from 2)
fn prime_get (n: Nat): Nat = stream_vt_nth{N2}(primes(), n)

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
val () =
println! ("prime(1000) = ", prime_get (1000)) ; // = 7927
//
} (* end of [main0_py] *)

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

(* end of [sieve_llazy.dats] *)
