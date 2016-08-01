(*
** for testing
** [libats/ML/myhashtblref]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

local
//
typedef
key = string and itm = int
//
in (* in-of-local *)
//
#include "libats/ML/HATS/myfunmap.hats"
//
end // end of [local]

(* ****** ****** *)
//
val out = stdout_ref
//
val mymap = myfunmap_make_nil()
//
(* ****** ****** *)
//
val ((*void*)) =
  fprintln! (out, "size = ", mymap.size())
//
(* ****** ****** *)
//
var mymap = mymap
//
val-~None_vt() = mymap.insert("a", 0)
val-~Some_vt(0) = mymap.insert("a", 0)
//
val-~None_vt() = mymap.insert("b", 1)
val-~Some_vt(1) = mymap.insert("b", 1)
//
val-~None_vt() = mymap.insert("c", 2)
val-~Some_vt(2) = mymap.insert("c", 2)
//
val-~None_vt() = mymap.insert("d", 3)
val-~Some_vt(3) = mymap.insert("d", 3)
//
val-~None_vt() = mymap.insert("e", 4)
val-~Some_vt(4) = mymap.insert("e", 4)
//
(* ****** ****** *)
//
val ((*void*)) =
  fprintln! (out, "size = ", mymap.size())
//
(* ****** ****** *)

val kxs = mymap.listize()
val ((*void*)) = fprintln! (out, "kxs = ", kxs)

(* ****** ****** *)
//
val ((*void*)) = fprintln! (out, "mymap = ", mymap)
//
(* ****** ****** *)

val-~None_vt() = mymap.search("")
val-~Some_vt(0) = mymap.search("a")
val-~Some_vt(1) = mymap.search("b")
val-~Some_vt(2) = mymap.search("c")

(* ****** ****** *)

val-true = mymap.remove("a")
val-false = mymap.remove("a")
val-~Some_vt(1) = mymap.takeout("b")
val-~Some_vt(2) = mymap.takeout("c")

(* ****** ****** *)
//
val ((*void*)) = fprintln! (out, "mymap = ", mymap)
//
(* ****** ****** *)

implement main0((*void*)) = ((*void*))

(* ****** ****** *)

(* end of [libats_ML_myfunmap.dats] *)
