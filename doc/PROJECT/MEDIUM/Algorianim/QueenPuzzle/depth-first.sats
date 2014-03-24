(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

abstype node_type = ptr
typedef node = node_type

(* ****** ****** *)

typedef nodelst = list0(node)

(* ****** ****** *)

fun
node_get_children (node): nodelst

(* ****** ****** *)
//
fun depth_search
  (path: nodelst, nx0: node): void
fun depth_search_list
  (path: nodelst, nxs: nodelst): void
//
(* ****** ****** *)
//
fun handle_node
  (path: nodelst, nx0: node): bool
//
(* ****** ****** *)

(* end of [depth-first.sats] *)
