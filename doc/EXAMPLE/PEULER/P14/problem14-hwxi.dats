//
// ProjectEuler: Problem 14
// Finding the longest chain using a starting number below 1M
//
(* ****** ****** *)
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: August, 2010
//
(* ****** ****** *)
//
// HX-2013-06: ported to ATS2
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "{$LIBGMP}/SATS/gmp.sats"

(* ****** ****** *)

#define N 1000000
val theTable = arrayref_make_elt<int> (i2sz(N), ~1)
val () = theTable[1] := 0

(* ****** ****** *)

fun eval
  (n: &mpz, c: int): int = let
  var saved: int = ~1
  val () =
  if mpz_cmp (n, N) < 0 then let
    val n1 = mpz_get_int (n)
    val [n:int] n1 = g1ofg0_int (n1)
    prval () = __assert () where {
      extern prfun __assert (): [0 <= n; n < N] void
    }
  in
    saved := theTable[n1]
  end // end of [val]
in
  if saved >= 0 then c + saved
  else if mpz_even_p (n) then let
    val _ = mpz_fdiv_q (n, 2UL) in eval (n, c+1)
  end else let
    val () = mpz_mul (n, 3UL); val () = mpz_add (n, 1UL)
  in
    eval (n, c+1)
  end // end of [if]
end // end of [eval]

(* ****** ****** *)

implement
main0 () =
{
var imax: int = 0
var cmax: int = 0
//
var i: int
var x: mpz
val () = mpz_init (x)
//
val () = for*
  {i:int | i >= 2} (i: int i) =>
  (i := 2; i < N; i := i+1) let
  val () = mpz_set_ulint (x, g0i2u(i))
  val c = eval (x, 0)
  val () = theTable[i] := c
in
  if :(i: int i) => c > cmax then (imax := i; cmax := c)
end // end of [val]
//
val () = mpz_clear (x)
//
val ans = imax
val () = assertloc (ans = 837799)
val () = (print "ans = "; print ans; print_newline ())
//
} // end of [main]

(* ****** ****** *)

(* end of [problem14-hwxi.dats] *)
