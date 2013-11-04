(* ****** ****** *)
//
// HX-2013-11
//
// Implementing a variant of
// the problem of Dining Philosophers
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

staload "./DiningPhil2.sats"

(* ****** ****** *)

implement
phil_acquire_lfork
  (ph) = let
//
val sf = phil_get_lshfork (ph)
//
in
  shfork_acquire_fork (sf)
end // end of [phil_acquire_lfork]

(* ****** ****** *)

implement
phil_acquire_rfork
  (ph) = let
//
val sf = phil_get_rshfork (ph)
//
in
  shfork_acquire_fork (sf)
end // end of [phil_acquire_rfork]

(* ****** ****** *)

implement
phil_release_lfork
  (ph, lf) = the_forkbuf_insert (lf)
// end of [phil_release_lfork]

implement
phil_release_rfork
  (ph, rf) = the_forkbuf_insert (rf)
// end of [phil_release_rfork]

(* ****** ****** *)

fun phil_dine_main
(
  ph: phil, lf: !fork, rf: !fork
) : void =
{
//
val () = randsleep (2)
//
} (* end of [phil_dine_main] *)

(* ****** ****** *)

implement
phil_dine (ph) =
{
//
val lf = phil_acquire_lfork (ph)
val rf = phil_acquire_rfork (ph)
//
val () = phil_dine_main (ph, lf, rf)
//
val () = phil_release_lfork (ph, lf)
val () = phil_release_rfork (ph, rf)
//
} (* end of [phil_dine] *)

(* ****** ****** *)

implement
phil_think (ph) =
{
//
val () = randsleep (6)
//
} (* end of [phil_think] *)

(* ****** ****** *)

implement
phil_loop (ph) = let
  val () = phil_think (ph)
  val ((*void*)) = phil_dine (ph)
in
  phil_loop (ph)
end // end of [phil_loop]

(* ****** ****** *)

(* end of [DiningPhil2_phil.dats] *)
