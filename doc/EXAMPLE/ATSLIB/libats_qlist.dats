(*
** for testing [libats/qlist]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: March, 2013
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/SATS/qlist.sats"
staload _(*anon*) = "libats/DATS/qlist.dats"

(* ****** ****** *)

val (
) = {
//
typedef T = int
//
val out = stdout_ref
//
val xs = qlist_make_nil {T} ()
//
val x1 = 1
val () = qlist_insert (xs, x1)
val x2 = 2
val () = qlist_insert (xs, x2)
val x3 = 3
val () = qlist_insert (xs, x3)
//
val () = fprint (out, "xs = ")
val () = fprint_qlist_sep (out, xs, ", ")
val () = fprint_newline (out)
//
val () = assertloc (qlist_length (xs) = 3)
//
val y1 = qlist_takeout (xs)
val () = assertloc (x1 = y1)
val y2 = qlist_takeout (xs)
val () = assertloc (x2 = y2)
val y3 = qlist_takeout (xs)
val () = assertloc (x3 = y3)
//
val () = qlist_insert (xs, x1)
val () = qlist_insert (xs, x2)
val y1 = qlist_takeout (xs)
val () = assertloc (x1 = y1)
val y2 = qlist_takeout (xs)
val () = assertloc (x2 = y2)
//
val () = qlist_free_nil (xs)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_qlist.dats] *)
