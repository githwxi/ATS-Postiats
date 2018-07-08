(*
Queen-Puzzle
*)

(* ****** ****** *)
//
#include
"./breadth-first.dats"
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
  ((N).list0_map(TYPE{node})(lam(i) => list0_cons(i, nx))).filter()(lam nx => test(nx.head(), nx.tail()))
end // en of [node_get_children]

(* ****** ****** *)

#define
sing0(x)
list0_cons(x, list0_nil())

(* ****** ****** *)
//
val
theSolutions =
(breadth_first_search
 (
   sing0(list0_nil())
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

(* end of [queen-puzzle-bfs.dats] *)
