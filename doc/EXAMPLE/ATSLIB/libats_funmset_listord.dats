(*
** for testing [libats/funmset_listord]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: Septmember, 2015
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/funmset_listord.sats"
staload _(*anon*) = "libats/DATS/funmset_listord.dats"

(* ****** ****** *)

val () =
{
//
typedef T = int
val out = stdout_ref
//
val xs =
$lst_vt{T}(0, 1, 2, 3, 4, 1, 2)
val mset =
  funmset_make_list ($UN.list_vt2t(xs))
val ((*void*)) =
  assertloc (funmset_size (mset) = length(xs))
val ((*freed*)) = list_vt_free (xs)
//
val () = assertloc (funmset_is_member (mset, 2))
val () = assertloc (funmset_is_member (mset, 3))
val () = assertloc (funmset_is_member (mset, 4))
val () = assertloc (funmset_isnot_member (mset, 5))
//
val ((*void*)) = fprintln! (out, "mset = ", mset)
//
val mset2 = funmset_union(mset, mset)
val ((*void*)) = fprintln! (out, "mset2 = ", mset2)
val mset3 = funmset_intersect(mset, mset)
val ((*void*)) = fprintln! (out, "mset3 = ", mset3)
//
var mset = mset
//
val n2 = funmset_get_ntime(mset, 2)
val () = assert(funmset_insert(mset, 2) = n2)
val () = assert(funmset_remove(mset, 2) = n2+1)
//
val n5 = funmset_get_ntime(mset, 5)
val () = assert(funmset_insert(mset, 5) = n5)
val () = assert(funmset_remove(mset, 5) = n5+1)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_funmset_listord.dats] *)
