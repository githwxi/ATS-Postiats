(*
Queen-Puzzle
*)

(* ****** ****** *)
//
#include
"./depth-first-2.dats"
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
) = (nx).iforall()(lam (d, j) => (i != j) && (abs(i-j) != d+1))
//
in
  ((N).stream_vt_map(TYPE{node})(lam(i) => list0_cons(i, nx))).filter()(lam nx => $effmask_all(test(nx.head(), nx.tail())))
end // en of [node_get_children]

(* ****** ****** *)
//
val
theSolutions =
(depth_first_search
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
  lam i => ((N).foreach()(lam j => (print(ifval(i = j, "Q ", ". "):string))); println!())
)
//
(* ****** ****** *)
//
val _(*int*) =
theSolutions.iforeach()(lam(n, nx) => (println!("Solution#", n+1); print_node(nx); println!()))
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [queen-puzzle-dfs-2.dats] *)
