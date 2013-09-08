(*
** for testing [libats/linhashtbl_chain]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: August, 2013
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/SATS/linhashtbl_chain.sats"
//
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/linhashtbl_chain.dats"
//
(* ****** ****** *)

val () =
{
val tbl =
  hashtbl_make_nil<string,string>(i2sz(1024))
val-~list_vt_nil () = hashtbl_listize (tbl)
} // end of [val]

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
typedef key = string and itm = int
//
val tbl =
  hashtbl_make_nil<key,itm>(i2sz(1))
//
val () = hashtbl_insert_any (tbl, "a", 0)
val-~Some_vt(0) = hashtbl_insert_opt (tbl, "a", 1)
//
val () = hashtbl_insert_any (tbl, "b", 2)
val () = hashtbl_insert_any (tbl, "c", 3)
val () = hashtbl_insert_any (tbl, "d", 4)
val () = hashtbl_insert_any (tbl, "e", 5)
val () = hashtbl_insert_any (tbl, "f", 6)
//
val () = hashtbl_insert_any (tbl, "g", 7)
val-~Some_vt(7) = hashtbl_takeout_opt (tbl, "g")
//
val () = fprintln! (out, "tbl = ", tbl)
val () = fprintln! (out, "size(tbl) = ", hashtbl_get_size (tbl))
val () = fprintln! (out, "capacity(tbl) = ", hashtbl_get_capacity (tbl))
//
val-~None_vt() = hashtbl_search_opt (tbl, "?")
val-~Some_vt(1) = hashtbl_search_opt (tbl, "a")
val-~Some_vt(2) = hashtbl_search_opt (tbl, "b")
val-~Some_vt(3) = hashtbl_search_opt (tbl, "c")
//
val true =
hashtbl_reset_capacity (tbl, i2sz(10))
val () = fprintln! (out, "tbl = ", tbl)
val () = fprintln! (out, "size(tbl) = ", hashtbl_get_size (tbl))
//
val () = list_vt_free<(key,itm)> (hashtbl_listize (tbl))
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_linhashtbl_chain.dats] *)
