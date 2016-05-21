//
// Author: Hongwei Xi
// Start Date: May 19, 2016
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

implement
main0 () = () where
{
//
val x = 0
var y: int
//
val () = (
//
if :(
  y: intGte(0)
) => (x >= 0)
  then y := x + 1 else y := 0
//
) : void // end of [val]
//
val () = println! ("y = ", y)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [ifhead.dats] *)
