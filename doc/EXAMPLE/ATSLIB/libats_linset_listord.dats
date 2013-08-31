(*
** for testing [libats/linset_listord]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: June, 2013
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linset_listord.sats"
staload _(*anon*) = "libats/DATS/linset_listord.dats"

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val ints =
  $list_vt{int}(1, 1, 1, 2, 3)
//
val xs = linset_make_list ($UN.list_vt2t(ints))
//
val () = list_vt_free (ints)
//
val () = fprintln! (out, "xs = ", xs)
val () = assertloc (linset_size(xs) = 3)
//
val () = assertloc (linset_is_member (xs, 1))
val () = assertloc (linset_is_member (xs, 2))
val () = assertloc (linset_is_member (xs, 3))
val () = assertloc (linset_isnot_member (xs, 0))
val () = assertloc (linset_isnot_member (xs, 4))
//
var xs = xs
val () = assertloc (~linset_insert (xs, 0))
val () = assertloc ( linset_insert (xs, 1))
val () = assertloc ( linset_remove (xs, 1))
val () = assertloc (~linset_remove (xs, 4))
val () = assertloc (~linset_insert (xs, 4))
//
val () = fprintln! (out, "xs = ", xs)
//
val () = linset_free (xs)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
vtypedef set = set(int)
//
var xs: set = linset_sing<int>(0)
//
val nx = linset_takeout_ngc (xs, 0)
val () = println! ("ptrcast(nx) = ", ptrcast(nx))
val () = assertloc (ptrcast(nx) > 0)
//
val () = mynode_set_elt<int> (nx, 1)
val nx2 = linset_insert_ngc (xs, nx)
val () = assertloc (ptrcast(nx2) = 0)
prval () = mynode_free_null (nx2)
//
val nx = linset_takeout_ngc (xs, 1)
val () = println! ("ptrcast(nx) = ", ptrcast(nx))
val () = assertloc (ptrcast(nx) > 0)
//
val () = linset_free (xs)
val (1) = mynode_getfree_elt (nx)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_linset_listord.dats] *)
