(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)

staload "./utfpl.sats"

(* ****** ****** *)

fun
d2exp_make_node
(
  loc: location
, node: d2exp_node
) : d2exp = '{
  d2exp_loc= loc, d2exp_node= node
} (* end of [d2exp_make_node] *)

(* ****** ****** *)
//
implement
d2exp_app
  (loc, d2e1, d2es2) =
  d2exp_make_node (loc, D2Eapp (d2e1, d2es2))
//
(* ****** ****** *)

(* end of [utfpl_d2exp.dats] *)
