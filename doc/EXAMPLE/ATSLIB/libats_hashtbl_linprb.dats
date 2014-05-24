(*
** for testing [libats/hashtbl_linprb]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxiATcsDOTbuDOTedu
// Start time: May, 2014
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload UN = $UNSAFE
//
(* ****** ****** *)
//
staload "libats/SATS/hashtbl_linprb.sats"
//
staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/hashtbl_linprb.dats"
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
val-~None_vt() = hashtbl_insert_opt (tbl, "a", 1)
val-~Some_vt(1) = hashtbl_insert_opt (tbl, "a", 1)
val-~None_vt() = hashtbl_insert_opt (tbl, "b", 2)
val-~None_vt() = hashtbl_insert_opt (tbl, "ab", 3)
//
val ((*void*)) = assertloc (hashtbl_get_size (tbl) = 3)
//
val-~Some_vt(2) = hashtbl_takeout_opt (tbl, "b")
val-~Some_vt(3) = hashtbl_takeout_opt (tbl, "ab")
//
val ((*void*)) = assertloc (hashtbl_get_size (tbl) = 1)
//
val () = list_vt_free<(key,itm)> (hashtbl_listize (tbl))
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_hashtbl_linprb.dats] *)
