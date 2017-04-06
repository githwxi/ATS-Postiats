(* ****** ****** *)
//
// Generic
// Graph DFS-streamization
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
  ((*void*)): slistref(node)
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
  slistref_insert(theStore, nx)
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
  slistref_takeout_opt(theStore)
end // end of [theStreamizeStore_choose]
//
(* ****** ****** *)
//
extern
fun{}
GraphStreamize_dfs
  (store: slistref(node)): stream(node)
implement
{}(*tmp*)
GraphStreamize_dfs(store) =
  GraphStreamize<>() where
{
implement theStreamizeStore_get<>() = store
} (* GraphStreamize_dfs *)
//
(* ****** ****** *)

(* end of [GraphStreamize_dfs.dats] *)
