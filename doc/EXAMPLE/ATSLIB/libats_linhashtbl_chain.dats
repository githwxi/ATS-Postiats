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
#include
"share/atspre_staload_tmpdef.hats"
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
val-~list_vt_nil () = hashtbl_listize_free (tbl)
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef key = string and itm = int
//
val tbl =
  hashtbl_make_nil<key,itm>(i2sz(1024))
val () = hashtbl_insert_any (tbl, "a", 0)
val () = hashtbl_insert_any (tbl, "b", 1)
val () = hashtbl_insert_any (tbl, "c", 2)
val () = hashtbl_insert_any (tbl, "d", 3)
val () = hashtbl_insert_any (tbl, "e", 4)
val () = hashtbl_insert_any (tbl, "f", 5)
val () = hashtbl_insert_any (tbl, "g", 6)
val kxs = hashtbl_listize_free (tbl)
val () = let
//
fun loop
(
  kxs: List_vt @(key, itm)
) : void = (
  case+ kxs of
  | ~list_vt_cons
      ((k, x), kxs) => let
      val () = println! (k, " -> ", x)
    in
      loop (kxs)
    end // end of [list_vt_cons]
  | ~list_vt_nil ((*void*)) => ()
) (* end of [loop] *)
//
in
  loop (kxs)
end // end of [val]
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_linhashtbl_chain.dats] *)
