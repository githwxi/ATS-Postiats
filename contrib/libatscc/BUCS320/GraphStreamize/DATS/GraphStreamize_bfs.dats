(* ****** ****** *)
//
// Generic
// Graph BFS-streamization
// for libatscc
//
(* ****** ****** *)
//
#include "./GraphStreamize.dats"
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
theStreamizeStore_get
  ((*void*)): qlistref(node)
//
(* ****** ****** *)
//
implement
theStreamizeStore_insert<>
  (nx) = let
//
val
theStore = theStreamizeStore_get()
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
end (* end of [theStreamizeStore_insert] *)
//
implement
theStreamizeStore_choose<>
  ((*void*)) = let
//
val
theStore = theStreamizeStore_get()
//
in
  qlistref_takeout_opt(theStore)
end // end of [theStreamizeStore_choose]
//
(* ****** ****** *)
//
extern
fun{}
GraphStreamize_bfs
  (store: qlistref(node)): stream(node)
implement
{}(*tmp*)
GraphStreamize_bfs(store) =
  GraphStreamize<>() where
{
implement theStreamizeStore_get<>() = store
} (* GraphStreamize_bfs *)
//
(* ****** ****** *)

(* end of [GraphStreamize_bfs.dats] *)
