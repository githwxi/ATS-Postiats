(*
** for testing [libats/funset_listord]
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

staload "libats/SATS/funset_listord.sats"
staload _(*anon*) = "libats/DATS/funset_listord.dats"

(* ****** ****** *)

val () =
{
//
typedef T = int
val out = stdout_ref
//
val xs =
$lst_vt{T}(0, 1, 2, 3, 4, 1, 2)
val set = funset_make_list ($UN.list_vt2t(xs))
val () = list_vt_free (xs)
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
var set = set
val-true = funset_remove (set, 1)
val-true = funset_remove (set, 3)
val-false = funset_remove (set, 5)
val-~Some_vt(4) = funset_takeoutmax_opt (set)
val-~Some_vt(2) = funset_takeoutmax_opt (set)
val-~Some_vt(0) = funset_takeoutmin_opt (set)
//
val () = assertloc (funset_is_nil (set))
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_funset_listord.dats] *)
