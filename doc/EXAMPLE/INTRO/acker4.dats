//
// Implementing Ackermann's function
// Author: Hongwei Xi (May 10, 2013)
//

(* ****** ****** *)
//
// HX: this one involves run-time closure creation
//
(* ****** ****** *)

staload "prelude/DATS/integer.dats"

(* ****** ****** *)

fun
acker
(
  m: int
) = lam
(
  n:int
) : int =<cloptr1>
//
if m <= 0 then n+1 else
(
  if n <= 0
    then acker (m-1) (1)
    else acker (m-1) (acker (m) (n-1))
  // end of [if]
) // end of [if]
//
// end of [acker]

(* ****** ****** *)

implement
main0 () = let
//
val () = assertloc (acker(3)(3) = 61)
//
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [acker4.dats] *)
