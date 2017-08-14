(* ****** ****** *)
(*
** QueenPuzzle
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#staload
"libats/ML/SATS/basis.sats"
//
(*
#include
"share/atspre_staload_libats_ML.hats"
*)
//
(* ****** ****** *)

#staload "./../../MYLIB/mylib.dats"

(* ****** ****** *)
//
extern
fun
{a:t@ype}
int_list0_map
( n: int
, fopr: cfun(int, a)): list0(a)
//
implement
{a}(*tmp*)
int_list0_map
  (n, fopr) =
  auxmain(0) where
{
fun
auxmain(i: int): list0(a) =
  if i < n then list0_cons(fopr(i), auxmain(i+1)) else list0_nil()
} (* end of [int_list0_map] *)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
int_list0_mapopt
( n: int
, fopr: cfun(int, option0(a))): list0(a)
//
implement
{a}(*tmp*)
int_list0_mapopt
  (n, fopr) =
  auxmain(0) where
{
fun
auxmain(i: int): list0(a) =
  if i < n then
  (
    case+ fopr(i) of
    | None0() => auxmain(i+1)
    | Some0(x) => list0_cons(x, auxmain(i+1))
  ) else list0_nil((*void*))
} (* end of [int_list0_mapopt] *)
//
(* ****** ****** *)

#define N 8

(* ****** ****** *)

abstype node = ptr

(* ****** ****** *)

extern
fun
node_get_children(node): list0(node)

(* ****** ****** *)

extern
fun
node_enumerate_dfs(node): list0(node)

(* ****** ****** *)

implement
node_enumerate_dfs
  (nx0) = let
//
val nxs =
  node_get_children(nx0)
//
in
//
list0_cons
(
nx0
,
list0_concat
(
list0_map<node><list0(node)>
  (nxs, lam(nx) => node_enumerate_dfs(nx))
)
) (* list0_cons *)
//
end // end of [node_enumerate_dfs]

(* ****** ****** *)

extern
fun
node_init(): node

extern
fun
node_length(node): int

(* ****** ****** *)

extern
fun
QueenSolve(): list0(node)

(* ****** ****** *)

implement
QueenSolve() =
list0_filter<node>
(node_enumerate_dfs(node_init()), lam(nx) => node_length(nx) >= N)

(* ****** ****** *)

assume node = list0(int)

(* ****** ****** *)
//
implement
node_init() = list0_nil()
//
implement
node_length(nx) = list0_length(nx)
//
(* ****** ****** *)

fun
test_safety
(xs: list0(int)): bool = let
  val-list0_cons(x0, xs) = xs
in
  list0_iforall<int>(xs, lam(i, x) => (x0 != x && abs(x0-x) != (i+1)))
end // end of [test_safety]

(* ****** ****** *)
//
implement
node_get_children
  (nx) =
  list0_filter<node>
  (int_list0_map<node>(N, lam(x) => cons0(x, nx)), lam(nx) => test_safety(nx))
//
(* ****** ****** *)

implement main0() =
{
val
theSols = QueenSolve()
//
val () =
println! ("|theSols| = ", list0_length(theSols))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [QueenPuzzle.dats] *)
