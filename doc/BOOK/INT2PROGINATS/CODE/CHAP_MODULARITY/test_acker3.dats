(*
** Some code used in the book PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./acker3.dats"
dynload "./acker3.dats"

(* ****** ****** *)

implement
main0 () =
{
  val () = assertloc (acker (3, 3) = 61)
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test_acker3.dats] *)
