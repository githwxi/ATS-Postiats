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
in (* in-of-local *)

#include "libats/ML/HATS/myhashtblref.hats"

end // end of [local]

(* ****** ****** *)
//
val mymap = myhashtbl_make_nil(1000)
//
val () =
fprintln! (stdout_ref, "mymap.size = ", mymap.size())
val () =
fprintln! (stdout_ref, "mymap.capacity = ", mymap.capacity())
//
(* ****** ****** *)
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
//
val () = assertloc (mymap.size() = 3)
val () = fprintln! (stdout_ref, "mymap = ", mymap)
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
//
val () = assertloc (mymap.size() = 0)
//
(* ****** ****** *)
//
val () = mymap.insert_any("a", 0)
val () = mymap.insert_any("b", 1)
val () = mymap.insert_any("c", 2)
val kxs = mymap.listize1((*void*))
val ((*void*)) = fprintln! (stdout_ref, "kxs = ", kxs)
val kxs = mymap.takeout_all((*void*))
val ((*void*)) = fprintln! (stdout_ref, "kxs = ", kxs)
//
val () = assertloc (mymap.size() = 0)
//
(* ****** ****** *)
//
val () = mymap.insert_any("a", 0)
val () = mymap.insert_any("b", 1)
val () = mymap.insert_any("c", 2)
//
val () =
myhashtbl_foreach_cloref
(
  mymap
, lam (k, x) =>
  fprintln! (stdout_ref, "k=", k, " and ", "x=", x)
) (* myhashtbl_foreach_cloref *)
//
val () =
mymap.foreach()
  (lam(k, x) => println! ("k=", k, " and ", "x=", x))
//
(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_hashtable.dats] *)
