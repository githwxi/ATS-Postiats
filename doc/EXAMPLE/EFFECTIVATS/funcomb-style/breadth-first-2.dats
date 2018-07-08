(*
Breadth-first search
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
breadth_first_search(nxs: nodes): nodes
//
(* ****** ****** *)
//
implement
breadth_first_search
  (nxs) = $ldelay(
//
(
case+ !nxs of
| ~stream_vt_nil() =>
    stream_vt_nil((*void*))
| ~stream_vt_cons(nx0, nxs) =>
    stream_vt_cons(nx0, breadth_first_search(nxs + nx0.children()))
)
,
~(nxs) // HX: for freeing the stream!
//
) (* end of [breadth_first_search] *)
//
(* ****** ****** *)

(* end of [breadth-first-2.dats] *)
