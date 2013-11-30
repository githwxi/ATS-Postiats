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
fprint_p2at
  (out, p2t0) = let
in
//
case+ p2t0.p2at_node of
//
| P2Tany () => fprint! (out, "P2Tany(", ")")
| P2Tvar (d2v) => fprint! (out, "P2Tvar(", d2v, ")")
//
| P2Tpat (p2t) => fprint! (out, "P2Tpat(", p2t, ")")
//
| P2Tignored ((*void*)) => fprint! (out, "P2Tignored(", ")")
//
end // end of [fprint_p2at]

(* ****** ****** *)

implement
fprint_p2atlst
  (out, p2ts) = let
//
implement
fprint_val<p2at> = fprint_p2at
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<p2at> (out, p2ts)
end // end of [fprint_p2atlst]

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
p2at_ignored (loc) = p2at_make_node (loc, P2Tignored())

(* ****** ****** *)

(* end of [utfpl_p2at.dats] *)
