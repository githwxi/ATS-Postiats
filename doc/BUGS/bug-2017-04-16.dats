(* ****** ****** *)
//
// Reported by
// HX-2017-04-16
//
(* ****** ****** *)
//
// HX:
// Using 'tup_vt' causes memory leak!
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

implement
main0() = let
//
val x = 0
val y = 1
val xy = $tup_vt(x, y)
//
val $tup(x, y) = xy
//
in
  println! ("x = ", x, " and y = ", y)
end // end of [main0]

(* ****** ****** *)

(* end of [bug-2017-04-16] *)
