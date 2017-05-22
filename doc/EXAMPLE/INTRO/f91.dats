(* ****** ****** *)
//
// Implementing MacCarthy's 91-function
// Author: Hongwei Xi (February 21, 2013)
//
(* ****** ****** *)

staload "prelude/DATS/integer.dats"

(* ****** ****** *)

fun f91 (x: int): int =
  if x >= 101 then x - 10 else f91 (f91 (x+11))
// end of [f91]

(* ****** ****** *)

implement
main0 () = let
//
val N = 0
val () = assertloc (f91 (N+0) = 91)
val () = assertloc (f91 (N+1) = 91)
val () = assertloc (f91 (N+2) = 91)
val () = assertloc (f91 (N+3) = 91)
val () = assertloc (f91 (N+4) = 91)
val () = assertloc (f91 (N+5) = 91)
val () = assertloc (f91 (N+6) = 91)
val () = assertloc (f91 (N+7) = 91)
val () = assertloc (f91 (N+8) = 91)
val () = assertloc (f91 (N+9) = 91)
//
val () = println! ("Testing for [f91] is done!")
//
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [f91.dats] *)
