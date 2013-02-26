(*
** for testing [libats/dlist_vt]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: February, 2013
//
(* ****** ****** *)

staload "libats/SATS/dlist_vt.sats"

(* ****** ****** *)

staload "prelude/DATS/basics.dats"

(* ****** ****** *)

staload "prelude/DATS/integer.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload _ = "libats/DATS/gnode.dats"
staload _ = "libats/DATS/dlist_vt.dats"

(* ****** ****** *)

val out = stdout_ref

val () = {
//
typedef T = int
//
val xs = dlist_vt_nil {T} ()
val xs = dlist_vt_cons (1, xs)
val xs = dlist_vt_cons (2, xs)
val xs = dlist_vt_cons (3, xs)
val xs = dlist_vt_cons (4, xs)
val xs = dlist_vt_cons (5, xs)
//
val (
) = fprint_dlist_vt<T> (out, xs)
val () = fprint_newline (out)
//
implement{}
fprint_dlist_vt$sep (out) = fprint_string (out, "<->")
val (
) = fprint_dlist_vt<T> (out, xs)
val () = fprint_newline (out)
//
val () = dlist_vt_free (xs)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_dlist_vt.dats] *)
