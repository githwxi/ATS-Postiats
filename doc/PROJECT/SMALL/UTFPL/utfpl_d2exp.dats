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
d2exp_cst
  (loc, d2c) =
  d2exp_make_node (loc, D2Ecst (d2c))
//
implement
d2exp_var
  (loc, d2v) =
  d2exp_make_node (loc, D2Evar (d2v))
//
(* ****** ****** *)
//
implement
d2exp_app
  (loc, d2e1, d2es2) =
  d2exp_make_node (loc, D2Eapp (d2e1, d2es2))
//
(* ****** ****** *)
//
implement
d2exp_ifopt
  (loc, _test, _then, _else) =
  d2exp_make_node (loc, D2Eifopt (_test, _then, _else))
//
(* ****** ****** *)
//
implement
d2exp_lam
  (loc, p2ts_arg, d2e_body) =
  d2exp_make_node (loc, D2Elam (p2ts_arg, d2e_body))
//
implement
d2exp_fix
  (loc, d2v, p2ts_arg, d2e_body) =
  d2exp_make_node (loc, D2Efix (d2v, p2ts_arg, d2e_body))
//
(* ****** ****** *)

(* end of [utfpl_d2exp.dats] *)
