(*
** Some testing code for [ratmod]
*)

(* ****** ****** *)

staload "ratmod.sats"
dynload "ratmod.dats"

(* ****** ****** *)

val r_1_2 = rat_make_int_int (2, 4)
val () = (print "r_1_2 = "; fprint_rat (stdout_ref, r_1_2); print_newline ())

val r_1_3 = rat_make_int_int (~3, ~9)
val () = (print "r_1_3 = "; fprint_rat (stdout_ref, r_1_3); print_newline ())

(* ****** ****** *)

val r_5_6 = ratadd (r_1_2, r_1_3)
val () = (print "r_5_6 = "; fprint_rat (stdout_ref, r_5_6); print_newline ())

val r_1_6 = ratsub (r_1_2, r_1_3)
val () = (print "r_1_6 = "; fprint_rat (stdout_ref, r_1_6); print_newline ())

(* ****** ****** *)

val r_1_1 = ratadd (r_5_6, r_1_6)
val () = (print "r_1_1 = "; fprint_rat (stdout_ref, r_1_1); print_newline ())

(* ****** ****** *)

implement main () = ()

(* ****** ****** *)

(* end of [test_ratmod.dats] *)
