(* ****** ****** *)
//
// Implementing Ackermann's function
// Author: Hongwei Xi (February 21, 2013)
//
(* ****** ****** *)

staload "prelude/DATS/integer.dats"

(* ****** ****** *)

fun acker
(
  m: int, n: int
) : int = let
//
fun acker_m
  (n: int): int =
(
if m <= 0
  then n+1
  else (
    if n <= 0
      then acker (m-1, 1)
      else acker (m-1, acker_m (n-1))
    // end of [if]
  ) // end of [else]
) (* end of [acker_m] *)
//
in
  acker_m (n)
end // end of [acker]

(* ****** ****** *)

implement
main0 () = let
//
val () = assertloc (acker (3, 3) = 61)
//
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [acker2.dats] *)
