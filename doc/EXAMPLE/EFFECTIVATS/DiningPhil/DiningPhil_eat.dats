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
fun phil_eat2 (n: phil, lf: !fork, rf: !fork): void

(* ****** ****** *)

implement
phil_eat (n) = let
//
  val lf = phil_acquire_lfork (n)
  val () = randsleep (1) // HX: increasing the chance of deadlocking
  val rf = phil_acquire_rfork (n)
//
  val () = phil_eat2 (n, lf, rf)
//
  val () = phil_release_lfork (n, lf)
  val () = phil_release_rfork (n, rf)
//
in
  // nothing
end // end of [phil_eat]

(* ****** ****** *)

implement
phil_eat2 (n, lf, rf) =
{
//
val () = println! ("Phil(", n, ") starts eating") 
val () = randsleep (3)
val () = println! ("Phil(", n, ") finishes eating") 
//
} (* end of [phil_eat2] *)

(* ****** ****** *)

(* end of [DiningPhil_eat.dats] *)
