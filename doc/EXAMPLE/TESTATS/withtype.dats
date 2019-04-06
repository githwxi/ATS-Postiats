//
// A simple example of withtype
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: October, 2014
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun fact (n) =
  if n > 0
    then n * fact(n-1) else 1
  // end of [if]
withtype {n:nat} int (n) -> int

(* ****** ****** *)

fun
fact2
{n:nat}
(
  n:int(n)
) : int = let
//
fun loop (i, res) =
  if i < n then loop (i+1, (i+1) * res) else res
withtype {i:nat | i <= n} (int(i), int) -> int
//
in
  loop (0, 1)
end // end of [fact2]

(* ****** ****** *)

implement
main0 () =
{
//
val () = assertloc(3628800 = fact(10))
val () = assertloc(3628800 = fact2(10))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [withtype.dats] *)

