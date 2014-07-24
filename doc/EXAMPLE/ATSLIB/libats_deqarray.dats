(*
** for testing [libats/deqarray]
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

staload "libats/SATS/deqarray.sats"
staload _(*anon*) = "libats/DATS/deqarray.dats"

(* ****** ****** *)

val () =
{
//
val M = i2sz(2)
//
val deq = deqarray_make_cap<int> (M)
//
val () = assertloc (deqarray_get_size (deq) = 0)
val () = assertloc (deqarray_get_capacity (deq) = M)
//
val () = deqarray_insert_atbeg (deq, 0)
val-(0) = deqarray_takeout_atbeg (deq)
val () = assertloc (deqarray_get_size (deq) = 0)
//
val-~None_vt() = deqarray_insert_atbeg_opt (deq, 1)
val-~None_vt() = deqarray_insert_atbeg_opt (deq, 2)
//
val-~Some_vt(3) = deqarray_insert_atbeg_opt (deq, 3)
//
val-~Some_vt(2) = deqarray_takeout_atbeg_opt (deq)
val-~Some_vt(1) = deqarray_takeout_atbeg_opt (deq)
val-~None_vt((*void*)) = deqarray_takeout_atbeg_opt (deq)
//
val () = assertloc (deqarray_get_size (deq) = 0)
//
val () = deqarray_free_nil (deq)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val M = i2sz(2)
//
val deq = deqarray_make_cap<int> (M)
//
val () = assertloc (deqarray_get_size (deq) = 0)
val () = assertloc (deqarray_get_capacity (deq) = M)
//
val () = deqarray_insert_atend (deq, 0)
val-(0) = deqarray_takeout_atend (deq)
val () = assertloc (deqarray_get_size (deq) = 0)
//
val-~None_vt() = deqarray_insert_atend_opt (deq, 1)
val-~None_vt() = deqarray_insert_atend_opt (deq, 2)
//
val-~Some_vt(3) = deqarray_insert_atend_opt (deq, 3)
//
val-~Some_vt(2) = deqarray_takeout_atend_opt (deq)
val-~Some_vt(1) = deqarray_takeout_atend_opt (deq)
val-~None_vt((*void*)) = deqarray_takeout_atend_opt (deq)
//
val () = assertloc (deqarray_get_size (deq) = 0)
//
val () = deqarray_free_nil (deq)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val M = i2sz(3)
//
val deq = deqarray_make_cap<int> (M)
//
val () = deqarray_insert_atend (deq, 0)
val () = deqarray_insert_atend (deq, 1)
//
val-(0) = deqarray_takeout_atbeg (deq)
//
val () = deqarray_insert_atend (deq, 2)
val () = deqarray_insert_atend (deq, 3)
//
val-(3) = deqarray_get_at (deq, i2sz(2))
//
val-(1) = deqarray_takeout_atbeg (deq)
val-(2) = deqarray_takeout_atbeg (deq)
val-(3) = deqarray_takeout_atbeg (deq)
//
val () = assertloc (deqarray_get_size (deq) = 0)
//
val () = deqarray_free_nil (deq)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_deqarray.dats] *)
