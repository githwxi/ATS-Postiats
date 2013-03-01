(*
** for testing [libats/dllist]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: February, 2013
//
(* ****** ****** *)

staload "libats/SATS/dllist.sats"

(* ****** ****** *)

staload "prelude/DATS/basics.dats"

(* ****** ****** *)

staload "prelude/DATS/integer.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload _ = "libats/DATS/gnode.dats"
staload _ = "libats/DATS/dllist.dats"

(* ****** ****** *)

val out = stdout_ref

val () = {
//
typedef T = int
//
val xs = dllist_nil {T} ()
val xs = dllist_cons (1, xs)
val xs = dllist_cons (2, xs)
val xs = dllist_cons (3, xs)
val xs = dllist_cons (4, xs)
val xs = dllist_cons (5, xs)
//
val (
) = fprint_dllist<T> (out, xs)
val () = fprint_newline (out)
//
val xs = dllist_move_all (xs)
//
val (
) = fprint_dllist<T> (out, xs)
val () = fprint_newline (out)
val (
) = fprint_rdllist<T> (out, xs)
val () = fprint_newline (out)
//
val xs = rdllist_move_all (xs)
//
val () = dllist_free (xs)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_dllist.dats] *)
