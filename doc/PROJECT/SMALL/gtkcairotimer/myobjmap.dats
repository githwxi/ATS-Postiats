(*
** hashtable-based map
** from names to objects
*)

(* ****** ****** *)

extern
fun myobjmap_get (name: string): Ptr0

(* ****** ****** *)

extern
fun myobjmap_insert
  (name: string, obj: Ptr1): bool(*found*)

(* ****** ****** *)

extern
fun myobjmap_takeout (name: string): Ptr0

(* ****** ****** *)

(* end of [myobjmap.dats] *)
