(*
For testing GraphStreamize_dfs
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#define
GRAPHSTREAMIZE_DFS 1
//
#include "./../mylibies.hats"
//
#staload $GraphStreamize
#staload $GraphStreamize_dfs
//
(* ****** ****** *)
//
#define N 8; #define NN %(N * N)
//
(* ****** ****** *)
//
extern
fun
KnightsTour_solve(): stream(node)
//
(* ****** ****** *)

assume node_type = list0(int)
assume nodelst_type = list0(node)

(* ****** ****** *)
//
implement
node_mark<>(nx) = ()
implement
node_unmark<>(nx) = ()
implement
node_is_marked<>(nx) = false
//
(* ****** ****** *)
//
implement
{}(*tmp*)
theStreamizeStore_insert_lst
  (nxs) =
(
nxs
).rforeach()
(
lam nx => theStreamizeStore_insert(nx)
) (* theStreamizeStore_insert_lst *)
//
(* ****** ****** *)

fun
node_eval
(nx0: node): int =
(score - 1) where
{
//
val-cons0(xy0,xys) = nx0
//
val x0 = xy0 / N and y0 = xy0 % N
//
fun{}
fxy(x: int, y: int): int = x*N+y
fun{}
test(x: int, y: int): bool =
  (0 <= x && x < N)&&(0 <= y && y < N)
&&
  (nx0).forall()(lam(xy) => xy != fxy(x, y))
//
var score: int = 0
//
val x_ = x0+1
val y_ = y0+2
val () =
if test(x_, y_) then score := score + 1
val y_ = y0-2
val () =
if test(x_, y_) then score := score + 1
//
val x_ = x0-1
val y_ = y0+2
val () =
if test(x_, y_) then score := score + 1
val y_ = y0-2
val () =
if test(x_, y_) then score := score + 1
//
val x_ = x0+2
val y_ = y0+1
val () =
if test(x_, y_) then score := score + 1
val y_ = y0-1
val () =
if test(x_, y_) then score := score + 1
//
val x_ = x0-2
val y_ = y0+1
val () =
if test(x_, y_) then score := score + 1
val y_ = y0-1
val () =
if test(x_, y_) then score := score + 1
//
} (* end of [node_eval] *)

(* ****** ****** *)
//
fun
nodelst_sort
(nxs: nodelst): nodelst =
list0_mergesort
( nxs
, lam(nx1, nx2) =>
  $effmask_all(compare(node_eval(nx1), node_eval(nx2)))
) (* end of [list0_mergesort] *)
//
(* ****** ****** *)

implement
node_get_neighbors<>
  (nx0) =
  nodelst_sort(nxs) where
{
//
#define :: list0_cons
//
val-cons0(xy0,xys) = nx0
//
val x0 = xy0 / N and y0 = xy0 % N
//
fun{}
fxy(x: int, y: int): int = x*N+y
fun{}
test(x: int, y: int): bool =
  (0 <= x && x < N)&&(0 <= y && y < N)
&&
  (nx0).forall()(lam(xy) => xy != fxy(x, y))
//
var nxs: nodelst = nil0()
//
val x_ = x0+1
val y_ = y0+2
val () =
if test(x_, y_) then
  nxs := cons0(fxy(x_, y_), nx0) :: nxs
// end of [val]
val y_ = y0-2
val () =
if test(x_, y_) then
  nxs := cons0(fxy(x_, y_), nx0) :: nxs
// end of [val]
//
val x_ = x0-1
val y_ = y0+2
val () =
if test(x_, y_) then
  nxs := cons0(fxy(x_, y_), nx0) :: nxs
// end of [val]
val y_ = y0-2
val () =
if test(x_, y_) then
  nxs := cons0(fxy(x_, y_), nx0) :: nxs
// end of [val]
//
val x_ = x0+2
val y_ = y0+1
val () =
if test(x_, y_) then
  nxs := cons0(fxy(x_, y_), nx0) :: nxs
// end of [val]
val y_ = y0-1
val () =
if test(x_, y_) then
  nxs := cons0(fxy(x_, y_), nx0) :: nxs
// end of [val]
//
val x_ = x0-2
val y_ = y0+1
val () =
if test(x_, y_) then
  nxs := cons0(fxy(x_, y_), nx0) :: nxs
// end of [val]
val y_ = y0-1
val () =
if test(x_, y_) then
  nxs := cons0(fxy(x_, y_), nx0) :: nxs
// end of [val]
//
} (* end of [node_get_neighbors] *)

(* ****** ****** *)
//
implement
KnightsTour_solve
  () = nxs where
{
//
val
root = list0_sing(0)
//
val
store =
slistref_make_nil{node}()
//
val () =
slistref_insert(store, root)
//
val nxs = GraphStreamize_dfs(store)
//
} (* end of [KnightsTour_solve] *)
//
(* ****** ****** *)

implement
main0() = () where
{
//
(*
val () =
println! ("N = ", N)
*)
//
val
nxs =
KnightsTour_solve()
//
val
nxs =
(nxs).filter()(lam nx => length(nx) >= NN)
//
val-stream_cons(nx0, nxs) = !nxs
val () = println! ("The 1st solution: ", reverse(nx0))
//
val-stream_cons(nx0, nxs) = !nxs
val () = println! ("The 2nd solution: ", reverse(nx0))
//
val-stream_cons(nx0, nxs) = !nxs
val () = println! ("The 3rd solution: ", reverse(nx0))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [KnightsTour_dfs.dats] *)
