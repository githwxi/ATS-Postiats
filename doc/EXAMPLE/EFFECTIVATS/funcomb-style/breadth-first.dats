(*
bBreadth-first search
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

abstype node
typedef nodelst = list0(node)

(* ****** ****** *)

extern
fun
node_get_children
  (nx: node): nodelst

(* ****** ****** *)
//
extern
fun
bfsearch(nxs: nodelst): nodelst
//
(* ****** ****** *)

implement
bfsearch(nxs) =
(
if iseqz(nxs)
  then list0_nil()
  else let
    val nx0 = nxs.head() in list0_cons(nx0, nxs.tail() + bfsearch(node_get_children(nx0)))
  end // end of [else]
) (* end of [bfsearch] *)

(* ****** ****** *)

(* end of [breadth-first.dats] *)
