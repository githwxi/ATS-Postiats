(*
Queen-Puzzle
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
(*
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
*)

(* ****** ****** *)

staload
"{$LIBATSCC2JS}/SATS/print.sats"
staload _(*anon*) =
"{$LIBATSCC2JS}/DATS/print.dats"

(* ****** ****** *)
//
abstype node = ptr
typedef nodes = list0(node)
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
depth_first_search(nxs) =
(
if iseqz(nxs)
  then list0_nil()
  else let
    val nx0 = nxs.head()
  in
    list0_cons(nx0, depth_first_search(nx0.children() + nxs.tail()))
  end // end of [else]
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
) = (nx).iforall()(lam (d, j) => (i != j) && (abs(i-j) != d+1))
//
in
  g0ofg1(((N).list_map(TYPE{node})(lam(i) => list0_cons(i, nx))).filter()(lam nx => test(nx.head(), nx.tail())))
end // en of [node_get_children]

(* ****** ****** *)
//
val
theSolutions =
(depth_first_search
 (
   sing0(list0_nil())
 )
).filter()(lam nx => length(nx) = N)
//
(* ****** ****** *)
//
val () =
theSolutions.foreach()(lam nx => println!(nx))
//
(* ****** ****** *)

(* end of [queen-puzzle-dfs.dats] *)
