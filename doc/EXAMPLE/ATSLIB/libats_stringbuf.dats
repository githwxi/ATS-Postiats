(*
** for testing [libats/dynarray]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: May, 2013
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/stringbuf.sats"
staload _(*anon*) = "libats/DATS/stringbuf.dats"

(* ****** ****** *)

val () =
{
val sbf = stringbuf_make_cap (i2sz(1))
val ((*void*)) = assertloc (stringbuf_get_size (sbf) = 0)
val ((*void*)) = assertloc (stringbuf_get_capacity (sbf) = 1)
val-true = stringbuf_reset_capacity (sbf, i2sz(2))
val ((*void*)) = assertloc (stringbuf_get_capacity (sbf) = 2)
val ((*void*)) = stringbuf_free (sbf)
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_stringbuf.dats] *)
