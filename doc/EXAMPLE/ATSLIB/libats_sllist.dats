(*
** for testing [libats/sllist]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: March, 2013
//
(* ****** ****** *)

staload "libats/SATS/sllist.sats"

(* ****** ****** *)

staload "prelude/DATS/basics.dats"

staload "prelude/DATS/integer.dats"

staload "prelude/DATS/char.dats"
staload "prelude/DATS/float.dats"
staload "prelude/DATS/string.dats"

staload _ = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload _ = "libats/DATS/gnode.dats"
staload _ = "libats/DATS/sllist.dats"

(* ****** ****** *)

#define :: sllist_cons
#define cons sllist_cons

(* ****** ****** *)

val () = {
//
typedef T = int
val out = stdout_ref
//
val xs = sllist_nil {T} ()
val xs = 1 :: 2 :: 3 :: 4 :: 5 :: xs
//
val () = fprint_sllist (out, xs)
val () = fprint_newline (out)
val () = assertloc (sllist_length (xs) = 5)
//
val xs2 = sllist_reverse (xs)
//
val () = fprint_sllist (out, xs2)
val () = fprint_newline (out)
val () = assertloc (sllist_length (xs2) = 5)
//
val () = sllist_free (xs2)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_sllist.dats] *)
