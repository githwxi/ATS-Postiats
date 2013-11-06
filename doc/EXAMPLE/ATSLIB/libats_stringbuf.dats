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
//
val ((*void*)) = assertloc (stringbuf_get_size (sbf) = 0)
val ((*void*)) = assertloc (stringbuf_get_capacity (sbf) = 1)
val-true = stringbuf_reset_capacity (sbf, i2sz(2))
val ((*void*)) = assertloc (stringbuf_get_capacity (sbf) = 2)
//
val ((*void*)) = stringbuf_free (sbf)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val sbf = stringbuf_make_cap (i2sz(2))
//
val-1 = stringbuf_insert_char (sbf, 'a')
val-1 = stringbuf_insert_char (sbf, 'b')
val ((*void*)) = assertloc (stringbuf_get_capacity (sbf) = 2)
//
val-1 = stringbuf_insert_char (sbf, 'c')
val ((*void*)) = assertloc (stringbuf_get_capacity (sbf) = 4)
//
var n: size_t
val str = stringbuf_getfree_strnptr (sbf, n)
val ((*void*)) = assertloc (g0u2i(n) = strnptr_length (str))
//
val str = strnptr2strptr (str)
val ((*void*)) = println! ("str = ", str)
//
val ((*void*)) = strptr_free (str)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val sbf = stringbuf_make_cap (i2sz(1))
//
val _ = stringbuf_insert_string (sbf, "Hello")
val _ = stringbuf_insert_string (sbf, ", world!")
//
var n: size_t
val str = stringbuf_getfree_strnptr (sbf, n)
val ((*void*)) = assertloc (g0u2i(n) = strnptr_length (str))
//
val str = strnptr2strptr (str)
val ((*void*)) = println! ("str = ", str)
//
val ((*void*)) = strptr_free (str)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_stringbuf.dats] *)
