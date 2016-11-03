(*
Queen-Puzzle
Depth-first search
*)

(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "theSearch_start"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
staload
"{$LIBATSCC2JS}/SATS/print.sats"
staload _(*anon*) =
"{$LIBATSCC2JS}/DATS/print.dats"
//
(* ****** ****** *)
//
abstype node
//
vtypedef nodes = stream_vt(node)
//
(* ****** ****** *)
//
overload + with stream_vt_append
//
(* ****** ****** *)
//
extern
fun
node_get_children(nx: node): nodes
//
overload .children with node_get_children
//
(* ****** ****** *)
//
extern
fun
depth_first_search(nxs: nodes): nodes
//
(* ****** ****** *)
//
implement
depth_first_search
  (nxs) = $ldelay(
//
(
case+ !nxs of
| ~stream_vt_nil() =>
    stream_vt_nil((*void*))
| ~stream_vt_cons(nx0, nxs) =>
    stream_vt_cons(nx0, depth_first_search(nx0.children() + nxs))
)
,
~(nxs) // HX: for freeing the stream!
//
) (* end of [depth_first_search] *)
//
(* ****** ****** *)

#define N 8

(* ****** ****** *)

assume node = list0(int)

(* ****** ****** *)

implement
node_get_children(nx) = let
//
fn
test
(
  i: int, nx: node
) =
(
nx
).iforall()
  (lam (d, j) => (i != j) && (abs(i-j) != d+1))
//
in
(
(
N
).stream_vt_map(TYPE{node})
  (lam(i) => list0_cons(i, nx))
).filter()(lam nx => test(nx.head(), nx.tail()))
end // end of [node_get_children]

(* ****** ****** *)

#define
sing0(x)
list0_cons(x, list0_nil())

(* ****** ****** *)
//
val
theSolutions =
(
depth_first_search
(
stream_vt_make_sing(list0_nil())
)
).filter()(lam nx => length(nx) = N)
//
(* ****** ****** *)
//
fun
print_node
(
  nx: node
) : void =
(nx).rforeach()
(
//
lam i =>
  ((N).foreach()(lam j => (print(ifval(i = j, "Q ", ". "):string))); println!())
//
)
//
(* ****** ****** *)
//
val _(*int*) =
(
theSolutions.takeLte(2)
).iforeach()(lam(n, nx) => (println!("Solution#", n+1); print_node(nx); println!()))
//
(* ****** ****** *)
//
%{$
//
ats2jspre_the_print_store_clear();
theSearch_start();
alert(ats2jspre_the_print_store_join());
//
%} // end of [%{$]
//
(* ****** ****** *)

(* end of [queen-puzzle-dfs-2.dats] *)
