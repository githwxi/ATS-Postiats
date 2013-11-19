(* ****** ****** *)
//
// HX-2013-11
//
// Implementing a variant of
// the problem of Dining Philosophers
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "{$LIBATSHWXI}/teaching/mythread/SATS/mychannel.sats"

(* ****** ****** *)

staload "./DiningPhil2.sats"

(* ****** ****** *)

implement phil_left (n) = n
implement phil_right (n) = (n+1) \nmod NPHIL

(* ****** ****** *)

implement
phil_loop (n) = let
//
val () = phil_think (n)
//
val nl = phil_left (n)
val nr = phil_right (n)
//
val ch_lfork = fork_changet (nl)
val ch_rfork = fork_changet (nr)
//
val lf = channel_takeout (ch_lfork)
val rf = channel_takeout (ch_rfork)
//
val () = phil_dine (n, lf, rf)
//
val ch_forktray = forktray_changet ()
val () = channel_insert (ch_forktray, lf)
val () = channel_insert (ch_forktray, rf)
//
in
  phil_loop (n)
end // end of [phil_loop]

(* ****** ****** *)

implement
cleaner_return (f) =
{
  val n = fork_get_num (f)
  val ch = fork_changet (n)
  val () = channel_insert (ch, f)
}

(* ****** ****** *)

implement
cleaner_loop () = let
//
val ch = forktray_changet ()
//
val f = channel_takeout (ch)
val () = cleaner_wash (f)
val () = cleaner_return (f)
//
in
  cleaner_loop ()
end // end of [cleaner_loop]

(* ****** ****** *)

(* end of [DiningPhil2.dats] *)
