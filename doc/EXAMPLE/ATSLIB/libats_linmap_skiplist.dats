(*
** for testing [libats/linma_skiplist]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: April, 2013
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/SATS/linmap_skiplist.sats"

(* ****** ****** *)

staload _(*anon*) = "libats/DATS/qlist.dats"
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
var res: itm?
//
var map =
  linmap_make_nil {key,itm} ()
//
val ans =
  linmap_insert (map, 0, "a1", res)
prval () = opt_clear (res)
val () = assertloc (not(ans)) // inserted
val () = assertloc (linmap_size (map) = 1)
//
val ans =
  linmap_insert (map, 1, "b1", res)
prval () = opt_clear (res)
val () = assertloc (not(ans)) // inserted
val () = assertloc (linmap_size (map) = 2)
//
val ans =
  linmap_insert (map, 1, "b2", res)
prval () = opt_clear (res)
val () = assertloc (ans=true) // replaced
val () = assertloc (linmap_size (map) = 2)
//
val-~Some_vt("a1") = linmap_search_opt (map, 0)
val-~Some_vt("b2") = linmap_search_opt (map, 1)
//
val ans =
  linmap_insert (map, 2, "c1", res)
prval () = opt_clear (res)
val () = assertloc (not(ans)) // inserted
val () = assertloc (linmap_size (map) = 3)
//
val () = list_vt_free (linmap_listize1 (map))
//
val () = fprintln! (stdout_ref, "map = ", map)
//
val-~Some_vt("a1") = linmap_takeout_opt (map, 0)
val () = assertloc (linmap_size (map) = 2)
val-~Some_vt("b2") = linmap_takeout_opt (map, 1)
val () = assertloc (linmap_size (map) = 1)
val-~Some_vt("c1") = linmap_takeout_opt (map, 2)
val () = assertloc (linmap_size (map) = 0)
//
val () = linmap_free (map)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_linmap_skiplist.dats] *)
