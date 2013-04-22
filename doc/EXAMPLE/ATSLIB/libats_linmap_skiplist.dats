(*
** for testing [libats/qlist]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: April, 2013
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "libats/SATS/linmap_skiplist.sats"
staload _(*anon*) = "libats/DATS/linmap_skiplist.dats"

(* ****** ****** *)

val () =
{
//
typedef key = int
typedef itm = string
val map = linmap_make_nil {key,itm} ()
val () = linmap_free (map)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_linmap_skiplist.dats] *)
