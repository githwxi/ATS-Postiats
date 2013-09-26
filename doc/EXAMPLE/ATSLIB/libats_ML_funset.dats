(*
** for testing [libats/ML/funset]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: July, 2013
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/funset.sats"
staload _(*anon*) = "libats/ML/DATS/funset.dats"
staload _(*anon*) = "libats/DATS/funset_avltree.dats"

(* ****** ****** *)

val () =
{
//
typedef T = int
val out = stdout_ref
//
val xs =
$list{T}(0, 1, 2, 3, 4, 3, 2, 1, 0)
val set = funset_make_list (g0ofg1(xs))
//
val () = assertloc (funset_size (set) = 5)
//
val () = assertloc (funset_is_member (set, 2))
val () = assertloc (funset_is_member (set, 3))
val () = assertloc (funset_is_member (set, 4))
val () = assertloc (funset_isnot_member (set, 5))
//
val () = fprintln! (out, "set = ", set)
//
val () = assertloc (funset_equal (set, set))
val () = assertloc (funset_compare (set, set) = 0)
val () = assertloc (funset_is_subset (set, set))
val () = assertloc (funset_is_supset (set, set))
//
var set = set
val-true = funset_remove (set, 1)
val-true = funset_insert (set, 2)
val-true = funset_remove (set, 3)
val-true = funset_insert (set, 4)
val-false = funset_remove (set, 5)
val-false = funset_insert (set, 5)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
staload "libc/SATS/stdlib.sats"
//
val N = 100000
//
typedef T = int
val out = stdout_ref
//
var xs1: set(T) = funset_nil ()
var xs2: set(T) = funset_nil ()
//
local
//
fun loop
  (i: int, xs: &set(T) >> _): void =
  if i < N then (
    ignoret(funset_insert (xs, g0f2i(N*drand48()))); loop (i+1, xs)
  ) else () // end of [if]
//
in (* in of [local] *)
//
val () = loop (0, xs1)
val () = loop (0, xs2)
//
end (* end of [local] *)
//
val () = fprintln! (out, "|xs1| = ", funset_size (xs1))
val () = fprintln! (out, "|xs2| = ", funset_size (xs2))
//
val-~Some_vt(x1_max) = funset_getmax_opt (xs1)
val-~Some_vt(x2_max) = funset_getmax_opt (xs2)
val () = fprintln! (out, "x1_max = ", x1_max)
val () = fprintln! (out, "x2_max = ", x2_max)
//
val sgn = funset_compare (xs1, xs2)
val () = fprintln! (out, "funset_compare (xs1, xs2) = ", sgn)
val sgn = funset_compare (xs2, xs1)
val () = fprintln! (out, "funset_compare (xs2, xs1) = ", sgn)
//
val xs12_u = funset_union (xs1, xs2)
val () = fprintln! (out, "|xs12_u| = ", funset_size (xs12_u))
val xs12_i = funset_intersect (xs1, xs2)
val () = fprintln! (out, "|xs12_i| = ", funset_size (xs12_i))
//
val xs12_df = funset_diff (xs1, xs2)
val () = fprintln! (out, "|xs12_df| = ", funset_size (xs12_df))
val xs21_df = funset_diff (xs2, xs1)
val () = fprintln! (out, "|xs21_df| = ", funset_size (xs21_df))
//
val-~Some_vt(x12_df_max) = funset_getmax_opt (xs12_df)
val-~Some_vt(x21_df_max) = funset_getmax_opt (xs21_df)
val () = fprintln! (out, "x12_df_max = ", x12_df_max)
val () = fprintln! (out, "x21_df_max = ", x21_df_max)
//
val xs12_sdf = funset_symdiff (xs1, xs2)
val () = fprintln! (out, "|xs12_sdf| = ", funset_size (xs12_sdf))
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_funset.dats] *)
