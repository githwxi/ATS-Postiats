(*
Depth-first search
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
(*
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
staload
"{$LIBATSCC2JS}/SATS/print.sats"
staload _(*anon*) =
"{$LIBATSCC2JS}/DATS/print.dats"
//
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

abstype node = ptr
typedef nodes = list0(node)

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

(* end of [depth-first.dats] *)
