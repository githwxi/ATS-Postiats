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
val () = linmap_skiplist_initize ()
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
typedef key = int
typedef itm = string
vtypedef map = map (key, itm)
//
var map = linmap_make_nil {key,itm} ()
//
var res: itm?
//
val ans = linmap_insert (map, 0, "a", res)
prval () = opt_clear (res)
val () = println! ("ans = ", ans)
//
val ans = linmap_insert (map, 0, "a", res)
prval () = opt_clear (res)
val () = println! ("ans = ", ans)
//
//
val () = linmap_free (map)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_linmap_skiplist.dats] *)
