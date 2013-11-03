(* ****** ****** *)
//
// HX-2013-11
//
// Implementing a variant of
// the problem of Dining Philosophers
//
(* ****** ****** *)

staload "./DiningPhil2.sats"

(* ****** ****** *)

implement
phil_acquire_lfork (ph) = let
  val shf = phil_get_lshfork (ph) in shfork_acquire_fork (shf)
end // end of [phil_acquire_lfork]

(* ****** ****** *)

(*
implement
phil_release_lfork (ph, lf) = let
  val shf = phil_get_lshfork (ph) in shfork_release_fork (shf, lf)
end // end of [phil_release_lfork]
*)

(* ****** ****** *)

implement
phil_release_lfork (ph, lf) = the_forkbuf_insert (lf)

(* ****** ****** *)

(* end of [DiningPhil2_fork.dats] *)
