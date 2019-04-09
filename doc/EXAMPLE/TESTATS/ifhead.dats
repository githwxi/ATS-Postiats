//
// Author: Hongwei Xi
// Start Date: May 19, 2016
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)
//
fun
foo{i:nat}
  (x: int(i), y: int(i+1)): void = ()
//
(* ****** ****** *)

implement
main0 () = () where
{
//
var x: int
var y: int
//
val i = (1: intGte(0))
//
val () = (
//
if: [i:nat]
(
  x: int(i), y: int(i+1)
) => (i >= 1)
  then (x := i; y := x+1)
  else (x := 10; y := 11)
//
) : void // end of [val]
//
val () = foo(x, y)
//
val () = assertloc(1 = x)
val () = assertloc(2 = y)
val () = println! ("x = ", x, " and y = ", y)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [ifhead.dats] *)
