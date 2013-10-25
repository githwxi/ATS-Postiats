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

extern
fun phil_dine2 (n: phil, lf: !fork, rf: !fork): void

(* ****** ****** *)

implement
phil_dine (n) = let
//
  val lf = phil_acquire_lfork (n)
  val () = randsleep (1) // HX: increasing the chance of deadlocking
  val rf = phil_acquire_rfork (n)
//
  val () = phil_dine2 (n, lf, rf)
//
  val () = phil_release_lfork (n, lf)
  val () = phil_release_rfork (n, rf)
//
in
  // nothing
end // end of [phil_dine]

(* ****** ****** *)

implement
phil_dine2 (n, lf, rf) =
{
//
val () = println! ("Phil(", n, ") starts dining.")
val () = randsleep (3)
val () = println! ("Phil(", n, ") finishes dining.")
//
} (* end of [phil_dine2] *)

(* ****** ****** *)

(* end of [DiningPhil_dine.dats] *)
