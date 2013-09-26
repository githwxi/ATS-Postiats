(*
** for testing [libats/linset_avltree]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: June, 2013
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linset_avltree.sats"
staload _(*anon*) = "libats/DATS/linset_avltree.dats"

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
vtypedef set = set(int)
//
var xs: set = linset_nil{int}()
//
val-false = linset_insert (xs, 0)
val-false = linset_insert (xs, 1)
val-false = linset_insert (xs, 2)
val-false = linset_insert (xs, 3)
val-false = linset_insert (xs, 4)
//
val-~Some_vt(0) = linset_takeoutmin_opt (xs)
val-~Some_vt(4) = linset_takeoutmax_opt (xs)
//
val () = linset_free (xs)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_linset_avltree.dats] *)
