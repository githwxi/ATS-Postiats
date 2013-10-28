(* ****** ****** *)
//
// HX-2013-10-18
//
// A straightforward implementation
// of the problem of Dining Philosophers
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
val () = println! ("Phil(", n, ") starts thinking.")
val () = randsleep (10)
val () = println! ("Phil(", n, ") finishes thinking.")
//
} (* end of [phil_think] *)

(* ****** ****** *)

(* end of [DiningPhil_think.dats] *)
