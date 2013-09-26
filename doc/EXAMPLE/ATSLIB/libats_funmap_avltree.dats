(*
** for testing [libats/funmap_avltree]
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

staload "libats/SATS/funmap_avltree.sats"

(* ****** ****** *)

staload
_(*anon*) = "libats/DATS/qlist.dats"
staload
_(*anon*) = "libats/DATS/funmap_avltree.dats"

(* ****** ****** *)

val () =
{
//
typedef key = int
typedef itm = string
typedef map = map (key, itm)
//
var res: itm?
//
var map =
  funmap_make_nil {key,itm} ()
//
val ans =
  funmap_insert (map, 0, "a1", res)
prval () = opt_clear (res)
val () = assertloc (not(ans)) // inserted
val () = assertloc (funmap_size (map) = 1)
//
val ans =
  funmap_insert (map, 1, "b1", res)
prval () = opt_clear (res)
val () = assertloc (not(ans)) // inserted
val () = assertloc (funmap_size (map) = 2)
//
val ans =
  funmap_insert (map, 1, "b2", res)
prval () = opt_clear (res)
val () = assertloc (ans=true) // replaced
val () = assertloc (funmap_size (map) = 2)
//
val-~Some_vt("a1") = funmap_search_opt (map, 0)
val-~Some_vt("b2") = funmap_search_opt (map, 1)
//
val ans =
  funmap_insert (map, 2, "c1", res)
prval () = opt_clear (res)
val () = assertloc (not(ans)) // inserted
val () = assertloc (funmap_size (map) = 3)
//
val () = assertloc (~funmap_remove (map, ~1))
//
val-~Some_vt("a1") = funmap_takeout_opt (map, 0)
val () = assertloc (funmap_size (map) = 2)
val-~Some_vt("b2") = funmap_takeout_opt (map, 1)
val () = assertloc (funmap_size (map) = 1)
val-~Some_vt("c1") = funmap_takeout_opt (map, 2)
val () = assertloc (funmap_size (map) = 0)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
typedef key = int
typedef itm = string
typedef map = map (key, itm)
//
var map = funmap_make_nil {key,itm} ()
//
val-~None_vt() = funmap_insert_opt (map, 0, "?")
val-~Some_vt("?") = funmap_insert_opt (map, 0, "0")
val-~None_vt() = funmap_insert_opt (map, 1, "1")
val-~None_vt() = funmap_insert_opt (map, 2, "2")
val-~None_vt() = funmap_insert_opt (map, 3, "3")
val-~None_vt() = funmap_insert_opt (map, 4, "4")
//
val () = assertloc (funmap_size (map) = 5)
//
val () = list_vt_free (funmap_listize (map))
//
val () = fprintln! (stdout_ref, "map = ", map)
//
val-~Some_vt("0") = funmap_takeout_opt (map, 0)
val-~Some_vt("1") = funmap_takeout_opt (map, 1)
val-~Some_vt("2") = funmap_takeout_opt (map, 2)
val-~Some_vt("3") = funmap_takeout_opt (map, 3)
val-~Some_vt("4") = funmap_takeout_opt (map, 4)
//
val () = assertloc (funmap_size (map) = 0)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_funmap_avltree.dats] *)
