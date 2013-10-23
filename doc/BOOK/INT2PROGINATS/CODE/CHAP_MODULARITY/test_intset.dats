(*
** Some code for testing the implementation of [intset]
*)

(* ****** ****** *)

staload "intset.sats"
dynload "intset.dats"

(* ****** ****** *)

staload "libc/SATS/random.sats"

staload "contrib/testing/SATS/randgen.sats"
staload _(*anon*) = "contrib/testing/DATS/randgen.dats"
staload "contrib/testing/SATS/fprint.sats"
staload _(*anon*) = "contrib/testing/DATS/fprint.dats"

(* ****** ****** *)

typedef T = int

macdef INTMAX = 100L

implement randgen<T> () = let
  val x = lrand48 () mod INTMAX in int_of_lint (x)
end // end of [randgen]

implement fprint_elt<T> (out, x) = fprintf (out, "%2.2i", @(x))

(* ****** ****** *)

// 
// using the current time to update
// the seed for random number generation
//
val () = srand48_with_time ()

(* ****** ****** *)

#define N1 10
val xs1 = intset_make_list (list0_randgen<T> (N1))
val () = let
  val xs1 = intset_listize (xs1) in
  print "xs1 = "; list0_fprint_elt (stdout_ref, xs1, ", "); print_newline ()
end // end of [val]

#define N2 20
val xs2 = intset_make_list (list0_randgen<T> (N2))
val () = let
  val xs2 = intset_listize (xs2) in
  print "xs2 = "; list0_fprint_elt (stdout_ref, xs2, ", "); print_newline ()
end // end of [val]

(* ****** ****** *)

val union_xs1_xs2 = intset_union (xs1, xs2)
val () = let
  val union_xs1_xs2 = intset_listize (union_xs1_xs2) in
  print "union_xs1_xs2 = "; list0_fprint_elt (stdout_ref, union_xs1_xs2, ", "); print_newline ()
end // end of [val]

val inter_xs1_xs2 = intset_inter (xs1, xs2)
val () = let
  val inter_xs1_xs2 = intset_listize (inter_xs1_xs2) in
  print "inter_xs1_xs2 = "; list0_fprint_elt (stdout_ref, inter_xs1_xs2, ", "); print_newline ()
end // end of [val]

val differ_xs1_xs2 = intset_differ (xs1, xs2)
val () = let
  val differ_xs1_xs2 = intset_listize (differ_xs1_xs2) in
  print "differ_xs1_xs2 = "; list0_fprint_elt (stdout_ref, differ_xs1_xs2, ", "); print_newline ()
end // end of [val]

val differ_xs2_xs1 = intset_differ (xs2, xs1)
val () = let
  val differ_xs2_xs1 = intset_listize (differ_xs2_xs1) in
  print "differ_xs2_xs1 = "; list0_fprint_elt (stdout_ref, differ_xs2_xs1, ", "); print_newline ()
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

implement main () = ()

(* ****** ****** *)

(* end of [test_intset.dats] *)
