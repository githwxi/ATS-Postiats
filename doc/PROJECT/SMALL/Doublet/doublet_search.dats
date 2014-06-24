(*
** Implementing the doublet game
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload "libats/SATS/qlist.sats"
//
staload _ = "libats/DATS/qlist.dats"
//
(* ****** ****** *)
//
staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/strarr.sats"
//
staload _ = "libats/ML/DATS/list0.dats"
staload _ = "libats/ML/DATS/array0.dats"
staload _ = "libats/ML/DATS/strarr.dats"
//
(* ****** ****** *)
//
staload "libats/ML/SATS/funset.sats"
//
staload _ = "libats/ML/DATS/funset.dats"
staload _ = "libats/DATS/funset_avltree.dats"
//
(* ****** ****** *)

staload "./doublet.sats"

(* ****** ****** *)

typedef node = list0 (word)

(* ****** ****** *)

extern
fun{}
doublet_get_source (): word
extern
fun{}
doublet_get_target (): word

(* ****** ****** *)

extern
fun{}
node_test (node): bool

(* ****** ****** *)

implement
{}(*tmp*)
node_test
  (nxs) =
(
  nxs.head = doublet_get_target ()
) (* end of [node_test] *)

(* ****** ****** *)

typedef wordset = set (word)

(* ****** ****** *)

implement
gcompare_val<strarr> = strarr_compare

(* ****** ****** *)
//
extern
fun{}
search_qlist
  (qlist(node), wordset): Option_vt(node)
//
extern
fun{}
search_qlist_add
  (!qlist(node) >> _, wordset, node): wordset
//
(* ****** ****** *)

implement
{}(*tmp*)
search_qlist
  (nxs, visited) = let
//
val isnot = qlist_isnot_nil (nxs)
//
prval () = lemma_qlist_param (nxs)
//
in
//
if
isnot
then let
//
val nx =
qlist_takeout (nxs)
//
val test = node_test (nx)
//
(*
val () =
println! ("search_qlist: nx = ", nx)
*)
//
in
//
if
test
then let
  val () =
  free (
    qlist_takeout_list (nxs)
  ) (* end of [val] *)
  val () = qlist_free_nil (nxs)
in
  Some_vt (nx)
end // end of [then]
else let
//
val visited =
search_qlist_add (nxs, visited, nx)
//
in
  search_qlist (nxs, visited)
end // end of [else]
//
end // end of [then]
else let
//
val () = qlist_free_nil (nxs)
//
in
  None_vt ((*void*))
end // end of [else]
//
end // end of [search_qlist]

(* ****** ****** *)

implement
{}(*tmp*)
search_qlist_add
  (nxs, visited, nx0) = let
//
fun loop
(
  nxs: !qlist(node) >> _
, visited: &wordset >> _, ws: List_vt(word)
) : void =
(
case+ ws of
| ~list_vt_nil () => ()
| ~list_vt_cons (w, ws) => let
    val ans = funset_is_member (visited, w)
  in
    if ans
      then loop (nxs, visited, ws)
      else let
        val _ = funset_insert (visited, w)
        val () = qlist_insert (nxs, cons0 (w, nx0))
      in
        loop (nxs, visited, ws)
      end // end of [else]
  end // end of [list_vt_cons]
)
//
var visited: wordset = visited
val ((*void*)) = loop (nxs, visited, word_get_friends (nx0.head))
//
in
  visited
end // end of [search_qlist_add]

(* ****** ****** *)

implement
doublet_search
  (src, dst) = let
//
implement
doublet_get_source<> () = src
implement
doublet_get_target<> () = dst
//
val nx0 = list0_sing (src)
//
val nxs = qlist_make_nil ()
val ((*void*)) = qlist_insert (nxs, nx0)
//
val visited = funset_make_nil ()
//
in
  search_qlist (nxs, visited)
end // end of [doublet_search]

(* ****** ****** *)

(* end of [doublet_search.dats] *)
