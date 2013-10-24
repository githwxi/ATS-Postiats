(*
** Some code for testing the implementation of [intset]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload _ = "libats/ML/DATS/list0.dats"

(* ****** ****** *)

staload "intset.sats"

(* ****** ****** *)

dynload "intset.sats"
dynload "intset.dats"

(* ****** ****** *)

val xs1 =
intset_make_list
  ((list0)$arrpsz{int}(0, 1, 2, 3, 4, 5, 6, 7, 8, 9))
val () = let
  val xs1 = intset_listize (xs1) in fprintln! (stdout_ref, "xs1 = ", xs1)
end // end of [val]

val xs2 =
intset_make_list 
  ((list0)$arrpsz{int}(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, ~9, ~8, ~7, ~6, ~5, ~4, ~3, ~2, ~1, 0))
val () = let
  val xs2 = intset_listize (xs2) in fprintln! (stdout_ref, "xs2 = ", xs2)
end // end of [val]

(* ****** ****** *)

val union_xs1_xs2 = intset_union (xs1, xs2)
val () = let
  val union_xs1_xs2 = intset_listize (union_xs1_xs2) in
  print "union_xs1_xs2 = "; fprint_list0_sep (stdout_ref, union_xs1_xs2, ", "); print_newline ()
end // end of [val]

val inter_xs1_xs2 = intset_inter (xs1, xs2)
val () = let
  val inter_xs1_xs2 = intset_listize (inter_xs1_xs2) in
  print "inter_xs1_xs2 = "; fprint_list0_sep (stdout_ref, inter_xs1_xs2, ", "); print_newline ()
end // end of [val]

val differ_xs1_xs2 = intset_differ (xs1, xs2)
val () = let
  val differ_xs1_xs2 = intset_listize (differ_xs1_xs2) in
  print "differ_xs1_xs2 = "; fprint_list0_sep (stdout_ref, differ_xs1_xs2, ", "); print_newline ()
end // end of [val]

val differ_xs2_xs1 = intset_differ (xs2, xs1)
val () = let
  val differ_xs2_xs1 = intset_listize (differ_xs2_xs1) in
  print "differ_xs2_xs1 = "; fprint_list0_sep (stdout_ref, differ_xs2_xs1, ", "); print_newline ()
end // end of [val]

(* ****** ****** *)

val () = assertloc (
  intset_size (xs1) + intset_size (xs2)
= intset_size (union_xs1_xs2) + intset_size (inter_xs1_xs2)
) // end of [val]

val () = assertloc (
  intset_size (union_xs1_xs2) - intset_size (inter_xs1_xs2)
= intset_size (differ_xs1_xs2) + intset_size (differ_xs2_xs1)
) // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test_intset.dats] *)
