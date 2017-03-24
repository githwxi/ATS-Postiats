(*
For testing GraphSearh_dfs
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"

(* ****** ****** *)
//
#define GRAPHSEARCH_DFS 1
//
#include
"$PATSHOMELOCS\
/atscntrb-bucs320-graphsearch/mylibies.hats"
//
(* ****** ****** *)

#staload GS = $GraphSearch
#staload GS_dfs = $GraphSearch_dfs

(* ****** ****** *)

implement
$GS_dfs.node_mark<>(nx) = ()
implement
$GS_dfs.node_unmark<>(nx) = ()
implement
$GS_dfs.node_is_marked<>(nx) = false

(* ****** ****** *)

#define N 8

(* ****** ****** *)
//
assume
$GS.node_type = list0(int)
assume
$GS.nodelst_vtype = stream_vt($GS.node)
//
(* ****** ****** *)

typedef node = $GS.node

(* ****** ****** *)
//
implement
{}(*tmp*)
$GS.theSearchStore_insert_lst(nxs) =
(
nxs
).rforeach()(lam nx => $GS.theSearchStore_insert(nx))
//
(* ****** ****** *)
//
implement
$GS.node_get_neighbors<>
  (nx0) = 
(
(N).stream_vt_map(TYPE{node})(lam x => cons0(x, nx0))
).filter()
  (
    lam nx =>
    let
      val-cons0(x0, nx) = nx
    in
      nx.iforall()(lam(i, x) => x0 != x && abs(x0 - x) != i+1)
    end // end of [let] // end of [lam]
  )
//
(* ****** ****** *)
//
implement
$GS.process_node<>
  (nx) =
(
//
if
(length(nx) = N)
then let
//
val () =
  println! (list0_reverse(nx))
//
in
  true
end // end of [then]
else true // end of [else]
//
) (* end of [$GS.process_node] *)
//
(* ****** ****** *)
//
extern
fun
QueenPuzzle_solve(): void
//
implement
QueenPuzzle_solve() =
{
val
store =
slistref_make_nil{node}()
//
val () =
slistref_insert(store, nil0)
//
val () = $GS_dfs.GraphSearch_dfs(store)
//
} (* end of [QueenPuzzle_solve] *)
//
(* ****** ****** *)

implement
main0() = () where
{
//
val () = QueenPuzzle_solve()
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [QueenPuzzle.dats] *)
