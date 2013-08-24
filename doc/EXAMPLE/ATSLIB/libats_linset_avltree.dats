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
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "libats/SATS/linset_avltree.sats"
staload _(*anon*) = "libats/DATS/linset_avltree.dats"

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val xs =
  $list{int}(1, 1, 1, 2, 3)
//
val xs = linset_make_list (xs)
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
//
val () = fprintln! (out, "xs = ", xs)
//
val () = linset_free (xs)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_linset_avltree.dats] *)
