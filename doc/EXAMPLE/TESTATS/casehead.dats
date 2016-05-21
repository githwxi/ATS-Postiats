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
var x: int
var y: int
//
val i = (0: intGte(0))
//
val () = (
//
case: [i:nat]
(
  x: int(i), y: int(i+1)
) => (i >= 1) of
  true => (x := i; y := x+1)
| false => (x := 10; y := 11)
//
) : void // end of [val]
//
val () = println! ("y = ", y)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [casehead.dats] *)
