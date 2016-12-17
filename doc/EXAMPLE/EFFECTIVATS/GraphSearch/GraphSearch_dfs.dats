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
"libats/ML/SATS/slistref.sats"
//
(* ****** ****** *)
//
extern
fun{}
theSearchStore_get
  ((*void*)): slistref(node)
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
  slistref_insert(theStore, nx)
)
//
end (* end of [theSearchStore_insert] *)
//
implement
{}(*tmp*)
theSearchStore_insert_lst(nxs) =
(
nxs
).rforeach()(lam nx => theSearchStore_insert(nx))
//
implement
theSearchStore_choose<>
  ((*void*)) = let
//
val
theStore = theSearchStore_get()
//
in
  slistref_takeout_opt(theStore)
end // end of [theSearchStore_choose]
//
(* ****** ****** *)
//
(*
extern
fun{}
GraphSearch_dfs(): void
implement
{}(*tmp*)
GraphSearch_dfs() = GraphSearch<>()
*)
//
(* ****** ****** *)

(* end of [GraphSearch_dfs.dats] *)
