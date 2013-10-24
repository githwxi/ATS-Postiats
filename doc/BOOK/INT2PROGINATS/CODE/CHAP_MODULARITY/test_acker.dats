(*
** Some code used in the book PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./acker.sats"
dynload "./acker.dats"

(* ****** ****** *)

implement
main0 () =
{
  val () = assertloc (acker (3, 3) = 61)
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test_acker.dats] *)
