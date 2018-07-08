(*
For testing GraphSearh_bfs
*)

(* ****** ****** *)
//
#define
ATS_STATIC_PREFIX"_QueenPuzzle_bfs_"
//
(* ****** ****** *)
//
#include "./../../../staloadall.hats"
//
(* ****** ****** *)
//
#staload
"./../../../DATS/BUCS320/GraphSearch/GraphSearch_bfs.dats"
//
(* ****** ****** *)

implement node_mark<>(nx) = ()
implement node_unmark<>(nx) = ()
implement node_is_marked<>(nx) = false

(* ****** ****** *)

#define N 8

(* ****** ****** *)

assume node_type = list0(int)
assume nodelst_vtype = stream_vt(node)

(* ****** ****** *)
//
implement
{}(*tmp*)
theSearchStore_insert_lst(nxs) =
(
nxs
).foreach()(lam nx => theSearchStore_insert(nx))
//
(* ****** ****** *)
//
implement
node_get_neighbors<>
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
process_node<>
  (nx) =
if
(length(nx) = N)
then let
//
val () = println! (list0_reverse(nx))
//
in
  true
end // end of [then]
else true // end of [else]
//
(* ****** ****** *)
//
extern
fun
QueenPuzzle_solve(): void = "mac#"
//
implement
QueenPuzzle_solve() =
{
val
store =
qlistref_make_nil{node}()
//
val () =
qlistref_insert(store, nil0)
//
val () = GraphSearch_bfs(store)
//
} (* end of [QueenPuzzle_solve] *)
//
(* ****** ****** *)

%{^
######
from libatscc2py3_all import *
######
sys.setrecursionlimit(1000000)
%} (* end of [%{^] *)

(* ****** ****** *)

%{$
//
if __name__ == '__main__': QueenPuzzle_solve();
//
%} (* end of [%{$] *)

(* ****** ****** *)

(* end of [QueenPuzzle_bfs.dats] *)
