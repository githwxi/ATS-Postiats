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

exception A and B and C

(* ****** ****** *)

fun ftest1
  (x: int): int =
(
  try if x > 0 then 0 else $raise (A) with ~A () => 0
) // end of [ftest1]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [trywith.dats] *)
