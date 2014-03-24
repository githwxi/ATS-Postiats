(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

staload "./depth-first.sats"

(* ****** ****** *)

implement
depth_search
  (path, nx0) = let
//
val cont = handle_node (path, nx0)
//
in
//
if cont then let
  val nxs = node_get_children (nx0)
in
  depth_search_list (cons0 (nx0, path), nxs)
end // end of [if]
//
end // end of [depth_search]

(* ****** ****** *)

implement
depth_search_list
  (path, nxs) =
(
case+ nxs of
| nil0 () => ()
| cons0 (nx, nxs) => let
    val () =
      depth_search (path, nx)
    // end of [val]
  in
    depth_search_list (path, nxs)
  end (* end of [cons0] *)
) (* end of [depth_search_list] *)

(* ****** ****** *)

(* end of [depth-first.dats] *)
