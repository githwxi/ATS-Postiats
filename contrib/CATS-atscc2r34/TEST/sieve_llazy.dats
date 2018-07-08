(* ****** ****** *)
//
// HX-2017-10:
// A running example
// from ATS2 to R(stat)
//
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

#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "sieve_llazy_main"

(* ****** ****** *)
//
#define
LIBATSCC2R34_targetloc
"$PATSHOME/contrib/libatscc2r34"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2R34}/mylibies.hats"
#staload
"{$LIBATSCC2R34}/SATS/print.sats"
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

fun
{a:t@ype}
stream_vt_filter_cloref
( xs: stream_vt(a)
, test: (a) -<cloref1> bool
) : stream_vt(a) = auxmain(xs) where
{
fun
auxmain
(
xs: stream_vt(a)
) : stream_vt(a) = $ldelay
(
(case+ !xs of
| ~stream_vt_nil() => stream_vt_nil()
| ~stream_vt_cons(x, xs) =>
  if test(x) then stream_vt_cons(x, auxmain(xs)) else !(auxmain(xs))
)
,
~(xs) // it is called when the stream is freed
)
} (* end of [stream_vt_filter_cloref] *)

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
    stream_vt_filter_cloref<N2>(ns2, lam x => nmod_int1_int1(x, p) > 0)
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

fn primes(): stream_vt N2 = sieve (from 2)
fn prime_get(n: Nat): Nat = stream_vt_nth{N2}(primes(), n)

(* ****** ****** *)
//
val () =
{
//
val () =
println! ("prime(1000) = ", prime_get (1000)) ; // = 7927
//
} (* end of [val] *)

(* ****** ****** *)

%{^
######
options(expressions=100000);
######
if
(
!(exists("libatscc2r34.is.loaded"))
)
{
  assign("libatscc2r34.is.loaded", FALSE)
}
######
if
(
!(libatscc2r34.is.loaded)
)
{
  sys.source("./libatscc2r34/libatscc2r34_all.R")
}
######
%} // end of [%{^]

(* ****** ****** *)

%{$
######
sieve_llazy_main();
######
%} // end of [%{$]

(* ****** ****** *)

(* end of [sieve_llazy.dats] *)
