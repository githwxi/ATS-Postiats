//
// Some code involving try-with-expressions
//
(* ****** ****** *)
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
//
// Start time: June, 2013
//
(* ****** ****** *)

staload
_(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)

exception A and B

(* ****** ****** *)

fun ftest
  (x: int): int =
(
  try (
    if aux (x) > 0 then 0 else $raise (A)
  ) with ~B () => 1
) // end of [ftest1]

and aux (x: int): int = if x > 0 then $raise (B) else 0

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [trywith.dats] *)
