(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)

staload "./utfpl.sats"

(* ****** ****** *)

implement
fprint_p2at
  (out, p2t0) = let
in
//
case+ p2t0.p2at_node of
//
| P2Tvar (d2v) => fprint! (out, "P2Tvar(", d2v, ")")
//
| P2Terr ((*void*)) => fprint! (out, "P2Terr(", ")")
//
end // end of [fprint_p2at]

(* ****** ****** *)

implement
p2at_make_node
  (loc, node) = '{
  p2at_loc= loc, p2at_node= node
} (* end of [p2at_make_node] *)

(* ****** ****** *)
//
implement
p2at_var (loc, d2v) =
  p2at_make_node (loc, P2Tvar (d2v))
//
(* ****** ****** *)

implement
p2at_err (loc) = p2at_make_node (loc, P2Terr())

(* ****** ****** *)

(* end of [utfpl_p2at.dats] *)
