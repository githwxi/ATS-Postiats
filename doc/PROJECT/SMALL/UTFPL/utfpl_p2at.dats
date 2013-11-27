(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)

staload "./utfpl.sats"

(* ****** ****** *)

fun
p2at_make_node
(
  loc: location
, node: p2at_node
) : p2at = '{
  p2at_loc= loc, p2at_node= node
} (* end of [p2at_make_node] *)

(* ****** ****** *)
//
implement
p2at_var (loc, d2v) =
  p2at_make_node (loc, P2Tvar (d2v))
//
(* ****** ****** *)

(* end of [utfpl_p2at.dats] *)
