(*
** for testing
** [libats/ML/myhashtblref]
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
//
#include "libats/ML/HATS/myhashtblref.hats"
//
end // end of [local]

(* ****** ****** *)

#define N 1

(* ****** ****** *)
//
val out = stdout_ref
//
val mytbl = myhashtbl_make_nil(N)
//
(* ****** ****** *)
//
val ((*void*)) =
  fprintln! (out, "size = ", mytbl.size())
val ((*void*)) =
  fprintln! (out, "capacity = ", mytbl.capacity())
//
(* ****** ****** *)
//
val-~None_vt() = mytbl.insert("a", 0)
val-~Some_vt(0) = mytbl.insert("a", 0)
//
val-~None_vt() = mytbl.insert("b", 1)
val-~Some_vt(1) = mytbl.insert("b", 1)
//
val-~None_vt() = mytbl.insert("c", 2)
val-~Some_vt(2) = mytbl.insert("c", 2)
//
val-~None_vt() = mytbl.insert("d", 3)
val-~Some_vt(3) = mytbl.insert("d", 3)
//
val-~None_vt() = mytbl.insert("e", 4)
val-~Some_vt(4) = mytbl.insert("e", 4)
//
(* ****** ****** *)
//
val ((*void*)) =
  fprintln! (out, "size = ", mytbl.size())
val ((*void*)) =
  fprintln! (out, "capacity = ", mytbl.capacity())
//
(* ****** ****** *)

val kxs = mytbl.listize1()
val ((*void*)) = fprintln! (out, "kxs = ", kxs)

(* ****** ****** *)
//
val ((*void*)) = fprintln! (out, "mytbl = ", mytbl)
//
(* ****** ****** *)

val-~None_vt() = mytbl.search("")
val-~Some_vt(0) = mytbl.search("a")
val-~Some_vt(1) = mytbl.search("b")
val-~Some_vt(2) = mytbl.search("c")

(* ****** ****** *)

val-true = mytbl.remove("a")
val-false = mytbl.remove("a")
val-~Some_vt(1) = mytbl.takeout("b")
val-~Some_vt(2) = mytbl.takeout("c")

(* ****** ****** *)
//
val ((*void*)) = fprintln! (out, "mytbl = ", mytbl)
//
val ((*void*)) =
  myhashtbl_foreach_cloref(mytbl, lam (k, x) => x:=x+x)
//
val ((*void*)) = fprintln! (out, "mytbl = ", mytbl)
//
(* ****** ****** *)

implement main0((*void*)) = ((*void*))

(* ****** ****** *)

(* end of [libats_ML_myhashtblref.dats] *)
