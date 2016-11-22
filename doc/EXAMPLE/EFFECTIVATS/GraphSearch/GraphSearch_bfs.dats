(*
For Effective ATS
*)

(* ****** ****** *)
//
#include
"./GraphSearch.dats"
//
(* ****** ****** *)
//
staload
"libats/ML/SATS/qlistref.sats"
//
(* ****** ****** *)
//
extern
fun{}
GraphSearch_bfs
  (nx0: node): void
//
(* ****** ****** *)
//
extern
fun{}
node_mark(node): void
extern
fun{}
node_unmark(node): void
//
extern
fun{}
node_is_marked(node): bool
//
overload
.is_marked with node_is_marked
//
(* ****** ****** *)
//
implement
{}(*tmp*)
GraphSearch_bfs
  (nx0) = let
//
val
theStore =
qlistref_make_nil{node}()
//
implement
theSearchStore_insert<>
  (nx) = (
//
if
~(nx.is_marked())
then
(
node_mark(nx);
qlistref_insert(theStore, nx)
)
//
) (* end of [theSearchStore_insert] *)
//
implement
{}(*tmp*)
theSearchStore_insert_lst(nxs) =
(
nxs
).foreach()(lam nx => theSearchStore_insert(nx))
//
implement
theSearchStore_choose<>
  ((*void*)) =
  qlistref_takeout_opt(theStore)
//
in
//
let val () = theSearchStore_insert(nx0) in GraphSearch<>() end
//
end // end of [GraphSearch_bfs]
//
(* ****** ****** *)

(* end of [GraphSearch_bfs.dats] *)
