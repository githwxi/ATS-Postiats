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

fun fork_wash
  (f: !fork): void =
{
  val ((*void*)) = randsleep (1)
} (* end of [fork_wash] *)

(* ****** ****** *)

extern
fun cleaner_fork_release (fork): void

(* ****** ****** *)

implement
cleaner_loop () = let
//
val f = the_forkbuf_takeout ()
val () = fork_wash (f)
val () = cleaner_fork_release (f)
//
in
  cleaner_loop ()
end // end of [cleaner_loop]

(* ****** ****** *)

(* end of [DiningPhil2_cleaner.dats] *)
