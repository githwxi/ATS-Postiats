(*
** Some testing code for [ratmod]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "ratmod.sats"
dynload "ratmod.sats"
dynload "ratmod.dats"

(* ****** ****** *)

val r_1_2 = rat_make_int_int (2, 4)
val () = fprintln! (stdout_ref, "r_1_2 = ", r_1_2)

val r_1_3 = rat_make_int_int (~3, ~9)
val () = fprintln! (stdout_ref, "r_1_3 = ", r_1_3)

(* ****** ****** *)

val r_5_6 = ratadd (r_1_2, r_1_3)
val () = fprintln! (stdout_ref, "r_5_6 = ", r_5_6)

val r_1_6 = ratsub (r_1_2, r_1_3)
val () = fprintln! (stdout_ref, "r_1_6 = ", r_1_6)

(* ****** ****** *)

val r_1_1 = ratadd (r_5_6, r_1_6)
val () = fprintln! (stdout_ref, "r_1_1 = ", r_1_1)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test_ratmod.dats] *)
