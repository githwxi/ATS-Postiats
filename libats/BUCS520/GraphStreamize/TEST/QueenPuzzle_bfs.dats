(* ****** ****** *)
(*
For testing GraphStreamize_bfs
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#define
GRAPHSTREAMIZE_BFS 1
//
#include "./../mylibies.hats"
//
#staload $GraphStreamize
#staload $GraphStreamize_bfs
//
(* ****** ****** *)
//
#staload "libats/SATS/qlist.sats"
#staload
_(*QUE*) = "libats/DATS/qlist.dats"
//
(* ****** ****** *)

#define N 8

(* ****** ****** *)

assume node_type = List0(int)
assume nodelst_vtype = stream_vt(node)

(* ****** ****** *)

implement node_free<>(nx) = ()

(* ****** ****** *)

implement node_mark<>(nx) = ()
implement node_unmark<>(nx) = ()
implement node_is_marked<>(nx) = false

(* ****** ****** *)
//
implement
{}(*tmp*)
theStreamizeStore_insert_lst(nxs) =
(
nxs
).foreach()(lam nx => theStreamizeStore_insert(nx))
//
(* ****** ****** *)
//
implement
node_get_neighbors<>
  (nx0) = 
(
(N).stream_vt_map(TYPE{node})(lam x => cons(x, nx0))
).filter()
  (
    lam nx =>
    let
      val-cons(x0, nx) = nx
    in
      (g0ofg1(nx)).iforall()(lam(i, x) => x0 != x && abs(x0 - x) != i+1)
    end // end of [let] // end of [lam]
  )
//
(* ****** ****** *)
//
extern
fun
QueenPuzzle_streamize
(
  // argmentless
) : stream_vt(node)
//
implement
QueenPuzzle_streamize
  () = nxs where
{
//
val
root = list_nil()
//
val
store =
qlist_make_nil{node}()
//
val () =
qlist_insert(store, root)
//
val nxs = GraphStreamize_bfs(store)
//
} (* end of [QueenPuzzle_streamize] *)
//
(* ****** ****** *)

implement
main0() = () where
{
//
val
nxs = QueenPuzzle_streamize()
val
nxs =
(nxs).filter()(lam(nx) => length(nx) >= N)
//
val
((*void*)) =
nxs.foreach()
(
  lam(nx) =>
  let
    val nx2 = list_reverse(nx) in
    println!($UN.list_vt2t(nx2)); list_vt_free(nx2) 
  end
)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [QueenPuzzle_bfs.dats] *)
