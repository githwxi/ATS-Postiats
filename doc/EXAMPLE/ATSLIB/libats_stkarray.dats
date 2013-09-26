(*
** for testing [libats/stkarray]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: September, 2013
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/SATS/stkarray.sats"
staload _(*anon*) = "libats/DATS/stkarray.dats"

(* ****** ****** *)

val () =
{
//
val M = i2sz(2)
//
val stk =
stkarray_make_cap<int> (M)
//
val () = assertloc (stkarray_get_size (stk) = 0)
val () = assertloc (stkarray_get_capacity (stk) = M)
//
val () = stkarray_insert (stk, 0)
val-(0) = stkarray_takeout (stk)
val-~None_vt() = stkarray_takeout_opt (stk)
//
val () = assertloc (stkarray_get_size (stk) = 0)
//
val-~None_vt() = stkarray_insert_opt (stk, 1)
val-~None_vt() = stkarray_insert_opt (stk, 2)
//
val () = fprintln! (stdout_ref, "stk = ", stk)
//
val-~Some_vt(3) = stkarray_insert_opt (stk, 3)
val () = assertloc (stkarray_get_size (stk) = 2)
val-(2) = stkarray_takeout (stk)
val-(1) = stkarray_takeout (stk)
val-~None_vt() = stkarray_takeout_opt (stk)
val () = assertloc (stkarray_get_size (stk) = 0)
//
val () = stkarray_free_nil (stk)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_stkarray.dats] *)
