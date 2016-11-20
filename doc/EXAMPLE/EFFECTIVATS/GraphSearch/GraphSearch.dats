(*
For Effective ATS
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

abstype node
abstype nodelst

(* ****** ****** *)
//
extern
fun{}
node_mark(node): void
extern
fun{}
node_unmark(node): void
//
extern
fun{}
node_is_marked(node): bool
//
overload
.is_marked with node_is_marked
//
(* ****** ****** *)
//
extern
fun{}
process_node(nx: node): void
//
(* ****** ****** *)
//
extern
fun{}
streamize_nodelst
  (nxs: nodelst): stream_vt(node)
//
(* ****** ****** *)
//
extern
fun{}
node_get_neighbors(nx: node): nodelst
//
(* ****** ****** *)
//
extern
fun{}
theStore_insert(node): void
extern
fun{}
theStore_insert_lst(nodelst): void
//
extern
fun{}
theStore_choose((*void*)): Option_vt(node)
//
(* ****** ****** *)

implement
{}(*tmp*)
theStore_insert_lst(nxs) =
  (streamize_nodelst(nxs)).foreach()(lam nx => theStore_insert(nx))

(* ****** ****** *)
//
extern
fun{}
GraphSearch(): void
//
(* ****** ****** *)

implement
{}(*tmp*)
GraphSearch
  ((*void*)) = let
//
fun
search
(
// argless
): void = let
//
val
opt = theStore_choose()
//
in
//
case+ opt of
| ~None_vt() => ()
| ~Some_vt(nx) =>
    search((*void*)) where
  {
    val () = process_node(nx)
    val () = theStore_insert_lst(node_get_neighbors(nx))
  } (* end of [Some_vt] *)
//
end (* end of [theStore_search] *)
//
in
  search((*void*))
end // end of [GraphSearch]

(* ****** ****** *)

(* end of [GraphSearch.dats] *)
