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
_(*anon*) = "prelude/DATS/basics.dats"
staload
_(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)

exception A and B
exception C of int and C2 of int

(* ****** ****** *)

fun ftest 
  (x: int): int =
  if x = 0 then $raise A else if x = 1 then $raise B else $raise C(x)
// end of [ftest]

(* ****** ****** *)

val () =
{
val x0 = 0
val x1 = 1
val x2 = 2
//
val ans0 =
(
try ftest (x0) with ~A () => x0 | ~B () => x1
) : int // end of [val]
val () = assertexn (ans0 = 0)
//
val ans1 =
(
try ftest (x1) with ~A () => x0 | ~B () => x1
) : int // end of [val]
val () = assertexn (ans1 = 1)
//
val ans2 =
(
try ftest (x2) with ~A () => x0 | ~B () => x1 | ~C2(y) => y
) : int // end of [val]
val () = assertexn (ans2 = 2)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [trywith.dats] *)
