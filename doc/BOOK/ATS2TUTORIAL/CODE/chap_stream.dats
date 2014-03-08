(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
fun
from (n: int): stream (int) =
  $delay (stream_cons (n, from (n+1)))
//
fun sieve
(
  ns: stream(int)
) :<!laz> stream(int) = $delay let
//
// [val-] means no warning message from the compiler
//
  val-stream_cons(n, ns) = !ns
in
  stream_cons (n, sieve (stream_filter_cloref<int> (ns, lam x => x mod n > 0)))
end // end of [$delay let] // end of [sieve]
//
val thePrimes = sieve(from(2))
//
(* ****** ****** *)

val () = println! ("p0 = ", thePrimes[0])
val () = println! ("p10 = ", thePrimes[10])
val () = println! ("p100 = ", thePrimes[100])
val () = println! ("p1000 = ", thePrimes[1000])

(* ****** ****** *)
//
val _0_ = $UNSAFE.cast{int64}(0)
val _1_ = $UNSAFE.cast{int64}(1)
//
val // the following values are defined mutually recursively
rec theFibs_0
  : stream(int64) = $delay (stream_cons(_0_, theFibs_1)) // fib0, fib1, ...
and theFibs_1
  : stream(int64) = $delay (stream_cons(_1_, theFibs_2)) // fib1, fib2, ...
and theFibs_2
  : stream(int64) = // fib2, fib3, fib4, ...
(
  stream_map2_fun<int64,int64><int64> (theFibs_0, theFibs_1, lam (x, y) => x + y)
) (* end of [val/and/and] *)
//
(* ****** ****** *)

val () = println! ("fib(10) = ", theFibs_0[10])
val () = println! ("fib(50) = ", theFibs_0[50])

(* ****** ****** *)
//
val
compare_int_int =
  lam (x1: int, x2: int): int =<fun> compare(x1, x2)
//
macdef
merge2 (xs1, xs2) =
  stream_mergeq_fun<int> (,(xs1), ,(xs2), compare_int_int)
//
val
rec theHamming
  : stream(int) = $delay
(
  stream_cons (1, merge2 (merge2 (theHamming2, theHamming3), theHamming5))
) (* end of [val] *)

and theHamming2
  : stream(int) = stream_map_fun<int><int> (theHamming, lam x => 2 * x)
and theHamming3
  : stream(int) = stream_map_fun<int><int> (theHamming, lam x => 3 * x)
and theHamming5
  : stream(int) = stream_map_fun<int><int> (theHamming, lam x => 5 * x)
//
(* ****** ****** *)

val () = println! ("theHamming[0] = ", theHamming[0])
val () = println! ("theHamming[1] = ", theHamming[1])
val () = println! ("theHamming[2] = ", theHamming[2])
val () = println! ("theHamming[3] = ", theHamming[3])
val () = println! ("theHamming[4] = ", theHamming[4])
val () = println! ("theHamming[5] = ", theHamming[5])
val () = println! ("theHamming[6] = ", theHamming[6])
val () = println! ("theHamming[7] = ", theHamming[7])
val () = println! ("theHamming[8] = ", theHamming[8])
val () = println! ("theHamming[9] = ", theHamming[9])

(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_stream.dats] *)

