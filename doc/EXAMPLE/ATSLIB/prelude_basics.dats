(*
** for testing [prelude/float]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val () =
{
val out = stdout_ref
//
val () = println! 0 1 2 3 4 5 6 7 8 9
val () = println! (0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
//
val () = prerrln! 0 1 2 3 4 5 6 7 8 9
val () = prerrln! (0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
//
val () = fprintln! out 0 1 2 3 4 5 6 7 8 9
val () = fprintln! (out, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_basics.dats] *)
