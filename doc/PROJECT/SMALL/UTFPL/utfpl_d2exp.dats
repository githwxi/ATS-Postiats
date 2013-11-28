(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./utfpl.sats"

(* ****** ****** *)

implement
fprint_d2exp
  (out, d2e0) = let
in
//
case+ d2e0.d2exp_node of
//
| D2Evar (d2v) => fprint! (out, "D2Evar(", d2v, ")")
//
| D2Eerr ((*void*)) => fprint! (out, "D2Eerr(", ")")
//
| _ (*temporary*) => fprint! (out, "D2E...(", "...", ")")
//
end // end of [fprint_d2exp]

(* ****** ****** *)

implement
fprint_d2explst
  (out, d2es) = let
//
implement
fprint_val<d2exp> = fprint_d2exp
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<d2exp> (out, d2es)
end // end of [fprint_d2explst]

(* ****** ****** *)

implement
d2exp_make_node
  (loc, node) = '{
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

implement
d2exp_err (loc) = d2exp_make_node (loc, D2Eerr())

(* ****** ****** *)

(* end of [utfpl_d2exp.dats] *)
