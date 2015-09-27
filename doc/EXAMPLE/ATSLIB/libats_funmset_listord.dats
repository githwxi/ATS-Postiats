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
val () = fprintln! (out, "mset = ", mset)
//
var mset = mset
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_funmset_listord.dats] *)
