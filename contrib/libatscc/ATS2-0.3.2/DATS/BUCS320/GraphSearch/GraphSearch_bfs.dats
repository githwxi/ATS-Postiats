(* ****** ****** *)
//
// Generic
// Graph-based BFS
// for libatscc
//
(* ****** ****** *)
//
#include "./GraphSearch.dats"
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
overload
.is_marked with node_is_marked
//
(* ****** ****** *)
//
extern
fun{}
theSearchStore_get
  ((*void*)): qlistref(node)
//
(* ****** ****** *)
//
implement
theSearchStore_insert<>
  (nx) = let
//
val
theStore = theSearchStore_get()
//
in
//
if
~(nx.is_marked())
then
(
  node_mark(nx);
  qlistref_insert(theStore, nx)
)
//
end (* end of [theSearchStore_insert] *)
//
implement
theSearchStore_choose<>
  ((*void*)) = let
//
val
theStore = theSearchStore_get()
//
in
  qlistref_takeout_opt(theStore)
end // end of [theSearchStore_choose]
//
(* ****** ****** *)
//
extern
fun{}
GraphSearch_bfs
  (store: qlistref(node)): void
implement
{}(*tmp*)
GraphSearch_bfs(store) =
  GraphSearch<>() where
{
implement theSearchStore_get<>() = store
} (* GraphSearch_bfs *)
//
(* ****** ****** *)

(* end of [GraphSearch_bfs.dats] *)
