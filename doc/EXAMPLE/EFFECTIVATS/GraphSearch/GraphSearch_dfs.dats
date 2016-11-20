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
theStore_insert<>
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
) (* end of [theStore_insert] *)
//
implement
{}(*tmp*)
theStore_insert_lst(nxs) =
(
nxs
).rforeach()(lam nx => theStore_insert(nx))
//
implement
theStore_choose<>
  ((*void*)) =
  slistref_takeout_opt(theStore)
//
in
//
let val () = theStore_insert(nx0) in GraphSearch<>() end
//
end // end of [GraphSearch_dfs]
//
(* ****** ****** *)

(* end of [GraphSearch_dfs.dats] *)
