(* ****** ****** *)
//
// HX: For StreamPar
//
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
GRAPHSTREAMIZE_DFS 1
//
#include
"libats/BUCS520/GraphStreamize/mylibies.hats"
//
#staload $GraphStreamize
#staload $GraphStreamize_dfs
//
(* ****** ****** *)

#staload
"libats/SATS/stklist.sats"
#staload
_(*STK*) =
"libats/DATS/stklist.dats"

(* ****** ****** *)

#define N 8

(* ****** ****** *)

macdef node_t = TYPE{node}()

(* ****** ****** *)

assume node_type = List0_vt(int)
assume nodelst_vtype = List0_vt(node)

(* ****** ****** *)

implement node_mark<>(nx) = ()
implement node_unmark<>(nx) = ()
implement node_is_marked<>(nx) = false

(* ****** ****** *)

implement node_free<>(nx) = free(nx)

(* ****** ****** *)
//
implement
{}(*tmp*)
theStreamizeStore_insert_lst
  (nxs) =
  auxlst(nxs) where
{
//
fun
auxlst(nxs: nodelst): void =
(
case+ nxs of
| ~list_vt_nil() => ()
| ~list_vt_cons(nx, nxs) =>
  (
    auxlst(nxs); theStreamizeStore_insert(nx)
  )
)
//
} // end of [theStreamizeStore_insert_lst]
//
(* ****** ****** *)
//
implement
node_get_neighbors<>
  (nx0) = let
//
fun
aux
( x: int
, nx0: !node
, nxs: nodelst): nodelst =
if
(x < N)
then let
//
val
nx1 = list_vt_copy(nx0)
val
nx2 = list_vt_cons(x, nx1)
//
in
  aux(x+1, nx0, list_vt_cons(nx2, nxs))
end // end of [then]
else nxs // end of [else]
//
val nxs =
aux(0, nx0, list_vt_nil())
//
in
(
list_vt_filterlin<node>(nxs)
) where
{
//
implement
list_vt_filterlin$pred<node>(nx) =
$effmask_all
(
let
  val nx =
  $UN.list_vt2t(nx)
  val-cons(x0, nx) = nx
in
  list_iforall_cloptr
  (nx, lam(i, x) => x0 != x && abs(x0 - x) != i+1)
end // end of [let] // end of [lam]
)
implement
list_vt_filterlin$clear<node>(nx) = $effmask_all(node_free(nx))
}
end // end of [node_get_neighbors]
//
(* ****** ****** *)
//
extern
fun
QueenPuzzle_streamize
(nx0: node): stream_vt(node)
//
implement
QueenPuzzle_streamize
  (nx0) = nxs where
{
//
val
store =
stklist_make_nil{node}()
//
val () =
stklist_insert(store, nx0)
//
val nxs = GraphStreamize_dfs(store)
//
} (* end of [QueenPuzzle_solve] *)
//
(* ****** ****** *)

implement
main0() = () where
{
//
val
nx0 = list_vt_nil()
val
nxs = QueenPuzzle_streamize(nx0)
//
val
((*void*)) =
nxs.foreach()
(
  lam(nx) =>
  if
  (length(nx) = N)
  then let
    val nx2 = list_vt_reverse(nx) in
    println!($UN.list_vt2t(nx2)); list_vt_free(nx2) 
  end // end of [then]
  else node_free<>(nx)
)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [QueenPuzzle.dats] *)
