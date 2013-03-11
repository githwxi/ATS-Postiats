(*
** for testing [prelude/char]
*)

(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

val () = {
  val () = assertloc ('A' = 'A')
  val () = assertloc ('A' < 'B')
  val () = assertloc ('A' <= 'B')
  val () = assertloc ('Z' > 'Y')
  val () = assertloc ('Z' >= 'Y')
  val () = assertloc (compare ('A', 'B') < 0)
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_reference.dats] *)
