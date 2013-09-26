(*
** for testing [libats/linmap_list]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: June, 2013
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/SATS/linmap_list.sats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"

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
val ans =
  linmap_insert (map, 1, "b1", res)
prval () = opt_clear (res)
val () = assertloc (not(ans)) // inserted
val () = assertloc (linmap_size (map) = 2)
val ans =
  linmap_insert (map, 1, "b2", res)
prval () = opt_clear (res)
val () = assertloc (ans=true) // replaced
//
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
val () = assertloc (~linmap_remove (map, ~1))
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

val () =
{
//
typedef key = int
typedef itm = string
vtypedef map = map (key, itm)
//
var map = linmap_make_nil {key,itm} ()
//
val-~None_vt() = linmap_insert_opt (map, 0, "0")
val-~None_vt() = linmap_insert_opt (map, 1, "1")
val-~None_vt() = linmap_insert_opt (map, 2, "2")
val-~None_vt() = linmap_insert_opt (map, 3, "3")
val-~None_vt() = linmap_insert_opt (map, 4, "4")
//
val () = assertloc (linmap_size (map) = 5)
//
val () = fprintln! (stdout_ref, "map = ", map)
//
val () = list_vt_free (linmap_listize1 (map))
//
val-~Some_vt("0") = linmap_takeout_opt (map, 0)
val-~Some_vt("1") = linmap_takeout_opt (map, 1)
val-~Some_vt("2") = linmap_takeout_opt (map, 2)
val-~Some_vt("3") = linmap_takeout_opt (map, 3)
val-~Some_vt("4") = linmap_takeout_opt (map, 4)
//
val () = assertloc (linmap_size (map) = 0)
//
val () = linmap_free (map)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_linmap_list.dats] *)
