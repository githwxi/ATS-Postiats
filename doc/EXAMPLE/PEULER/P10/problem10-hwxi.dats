//
// ProjectEuler: Problem 10
// Calculating the sum of all primes < 2M
//

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Time: August, 2010 // the first solution
//
(* ****** ****** *)
//
// HX-2013-06: ported to ATS2
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun sumprimes
  {m:nat} (m: int m): ulint = let
//
local
implement array_tabulate$fopr<bool> (i) = true
in (* in of [local] *)
val [l:addr] (pf, pfgc | A) = array_ptr_tabulate<bool> (i2sz(m))
end // end of [local]
//
viewdef V = array_v (bool, l, m)
//
fun remmul
(
  pf: !V | i: Nat, j: Nat
) : void =
(
if (j < m) then let
  val () = if A->[j] then A->[j] := false
in
  remmul (pf | i, j+i)
end // end of [if]
) (* end of [remmul] *)
//
fun loop
(
  pf: !V | i: Nat, res: ulint
) : ulint =
(
if i < m then
(
  if A->[i] then let
    val () = remmul (pf | i, i+i)
  in
    loop (pf | i+1, res+g0i2u(i))
  end else
    loop (pf | i+1, res)
  // end of [if]
) else res // end of [if]
) (* end of [loop] *)
//
val res = loop (pf | 2, g0i2u(0))
//
val () = array_ptr_free (pf, pfgc | A)
//
in
  res
end // end of [sumprimes]

(* ****** ****** *)

implement
main0 () = () where {
//
val sum10 = sumprimes (10)
val () = assertloc (sum10 = 17)
val () = println! "The sum of all the primes < 10 = " sum10
//
val sum2M = sumprimes (2000000)
val () = assertloc (sum2M = 142913828922UL)
val () = println! "The sum of all the primes < 2M = " sum2M
//
} // end of [main]

(* ****** ****** *)

(* end of [problem10-hwxi.dats] *)
