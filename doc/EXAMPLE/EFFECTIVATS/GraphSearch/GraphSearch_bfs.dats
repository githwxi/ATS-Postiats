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
theStore_insert<>
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
) (* end of [theStore_insert] *)
//
implement
{}(*tmp*)
theStore_insert_lst(nxs) =
(
nxs
).foreach()(lam nx => theStore_insert(nx))
//
implement
theStore_choose<>
  ((*void*)) =
  qlistref_takeout_opt(theStore)
//
in
//
let val () = theStore_insert(nx0) in GraphSearch<>() end
//
end // end of [GraphSearch_bfs]
//
(* ****** ****** *)

(* end of [GraphSearch_bfs.dats] *)
