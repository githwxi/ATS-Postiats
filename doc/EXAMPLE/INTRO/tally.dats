//
// Illustrating tail-recursion
//
// Author: Hongwei Xi (December 31, 2012)
//

(* ****** ****** *)

staload "prelude/DATS/integer.dats"

(* ****** ****** *)

fun tally
  (n: int): int = let
//
fun loop (n: int, res: int): int =
  if n > 0 then loop (n-1, res + n) else res
//
in
  loop (n, 0)
end // end of [tally]

(* ****** ****** *)

implement 
main () = let
  val N = 1000
  val () = assertloc (tally (N) = N * (N+1) / 2)
in
  0(*normalexit*)
end // end of [main]

(* ****** ****** *)

(* end of [tally.dats] *)
