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
// HX-2017-04-18: fixed!!!
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
val xy =
$tup_vt(0, 1)
//
val $tup(x, y) = xy
//
in
  println! ("x = ", x, " and y = ", y)
end // end of [main0]

(* ****** ****** *)

(* end of [bug-2017-04-16] *)
