(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

local
//
typedef
key = string and itm = int
//
staload
FM = "libats/ML/SATS/funmap.sats"
implement
$FM.compare_key_key<key>(x, y) = compare(x, y)
//
in (* in-of-local *)

#include "libats/ML/HATS/myfunmap.hats"

end // end of [local]

(* ****** ****** *)
//
val
mymap =
myfunmap_nil()
//
(* ****** ****** *)
//
var mymap = mymap
//
val-~None_vt() = mymap.insert("a", 0)
val-~Some_vt(0) = mymap.insert("a", 1)
//
val-~None_vt() = mymap.insert("b", 1)
val-~Some_vt(1) = mymap.insert("b", 2)
//
val-~None_vt() = mymap.insert("c", 2)
val-~Some_vt(2) = mymap.insert("c", 3)
//
(* ****** ****** *)

val () = assertloc (mymap.size() = 3)

(* ****** ****** *)
//
val () =
fprintln! (stdout_ref, "mymap = ", mymap)
//
(* ****** ****** *)

val-~None_vt() = mymap.search("")
val-~Some_vt(1) = mymap.search("a")

(* ****** ****** *)
//
val-true = mymap.remove("a")
val-false = mymap.remove("a")
//
val-~Some_vt(2) = mymap.takeout("b")
val-~Some_vt(3) = mymap.takeout("c")
//
(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_funsetmap.dats] *)
