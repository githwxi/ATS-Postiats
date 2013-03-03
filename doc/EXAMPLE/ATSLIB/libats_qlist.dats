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

staload "libats/SATS/qlist.sats"

(* ****** ****** *)

staload "prelude/DATS/basics.dats"
staload "prelude/DATS/integer.dats"
staload "prelude/DATS/pointer.dats"
staload _ = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload _ = "libats/DATS/qlist.dats"

(* ****** ****** *)

val () = {
//
typedef T = int
//
val xs = qlist_make_nil {T} ()
//
val x1 = 1
val () = qlist_insert (xs, x1)
val x2 = 2
val () = qlist_insert (xs, x2)
//
val y1 = qlist_takeout (xs)
val () = assertloc (x1 = y1)
val y2 = qlist_takeout (xs)
val () = assertloc (x2 = y2)
//
val () = qlist_insert (xs, x1)
val () = qlist_insert (xs, x2)
val y3 = qlist_takeout (xs)
val () = assertloc (x1 = y3)
val y4 = qlist_takeout (xs)
val () = assertloc (x2 = y4)
//
val () = qlist_free_nil (xs)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_qlist.dats] *)
