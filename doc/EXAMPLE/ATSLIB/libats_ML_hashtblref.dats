(*
** for testing
** [libats/ML/hashtblref]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "libats/ML/SATS/hashtblref.sats"
//
staload _(*anon*) = "libats/DATS/qlist.dats"
//
staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"
//
(* ****** ****** *)

val () = {
//
val N = i2sz(1024)
//
typedef
key = string and itm = int
//
val mytbl =
  hashtbl_make_nil<key,itm>(N)
//
val () = assertloc (hashtbl_get_capacity(mytbl)=N)
//
val () = assertloc (iseqz(hashtbl_get_size(mytbl)))
//
val-~None_vt() =
  hashtbl_insert<key,itm> (mytbl, "a", 0)
val-~None_vt() =
  hashtbl_insert<key,itm> (mytbl, "b", 1)
val-~None_vt() =
  hashtbl_insert<key,itm> (mytbl, "c", 2)
val-~None_vt() =
  hashtbl_insert<key,itm> (mytbl, "d", 3)
val-~None_vt() =
  hashtbl_insert<key,itm> (mytbl, "e", 4)
val-~None_vt() =
  hashtbl_insert<key,itm> (mytbl, "f", 5)
val-~None_vt() =
  hashtbl_insert<key,itm> (mytbl, "g", 6)
val-~None_vt() =
  hashtbl_insert<key,itm> (mytbl, "h", 7)
val-~None_vt() =
  hashtbl_insert<key,itm> (mytbl, "i", 8)
val-~None_vt() =
  hashtbl_insert<key,itm> (mytbl, "j", 9)
//
val-~Some_vt(0) =
  hashtbl_search<key,itm> (mytbl, "a")
val-true = hashtbl_remove<key,itm> (mytbl, "a")
val-~None_vt((*void*)) =
  hashtbl_search<key,itm> (mytbl, "a")
val-false = hashtbl_remove<key,itm> (mytbl, "a")
//
val-~Some_vt(1) = hashtbl_search<key,itm> (mytbl, "b")
val-~Some_vt(2) = hashtbl_search<key,itm> (mytbl, "c")
val-~Some_vt(3) = hashtbl_search<key,itm> (mytbl, "d")
val-~Some_vt(4) = hashtbl_search<key,itm> (mytbl, "e")
//
val () = assertloc (hashtbl_get_size(mytbl)=i2sz(10-1))
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_hashtblref.dats] *)
