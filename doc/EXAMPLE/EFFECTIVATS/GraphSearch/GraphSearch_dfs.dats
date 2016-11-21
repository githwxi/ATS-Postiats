(*
For Effective ATS
*)

(* ****** ****** *)
//
staload
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
GraphSearch_dfs
  (nx0: node): void
//
(* ****** ****** *)
//
implement
{}(*tmp*)
GraphSearch_dfs
  (nx0) = let
//
val
theStore =
slistref_make_nil{node}()
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
  slistref_insert(theStore, nx)
)
//
) (* end of [theSearchStore_insert] *)
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
  ((*void*)) =
  slistref_takeout_opt(theStore)
//
in
//
let val () = theSearchStore_insert(nx0) in GraphSearch<>() end
//
end // end of [GraphSearch_dfs]
//
(* ****** ****** *)

(* end of [GraphSearch_dfs.dats] *)
