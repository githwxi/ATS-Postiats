(* ****** ****** *)
//
// HX-2013-10-17
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

staload "./DiningPhil.sats"

(* ****** ****** *)

implement
phil_think (n) =
{
//
val () = println! ("Phil(", n, ") starts thinking") 
val () = randsleep (5)
val () = println! ("Phil(", n, ") finishes thinking") 
//
} (* end of [phil_think] *)

(* ****** ****** *)

(* end of [DiningPhil_think.dats] *)
