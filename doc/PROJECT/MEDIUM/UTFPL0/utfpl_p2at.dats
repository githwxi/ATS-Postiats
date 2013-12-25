(*
** Implementing UTFPL
** with closure-based evaluation
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
| P2Tempty () => fprint! (out, "P2Tempty(", ")")
//
| P2Tpat (p2t) => fprint! (out, "P2Tpat(", p2t, ")")
//
| P2Trec (lp2ts) => fprint! (out, "P2Trec(", lp2ts, ")")
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
fprint_labp2at
  (out, lp2t) = let
in
//
case+ lp2t of
| LABP2ATnorm
    (lab, p2t) =>
  (
    fprint! (
      out, "LABP2ATnorm(", lab, "->", p2t, ")"
    ) (* end of [fprint!] *)
  )
| LABP2ATomit () => fprint (out, "LABP2ATomit()")
//
end // end of [fprint_labp2at]

(* ****** ****** *)

implement
fprint_labp2atlst
  (out, lp2ts) = let
//
implement
fprint_val<labp2at> = fprint_labp2at
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<labp2at> (out, lp2ts)
end // end of [fprint_labp2atlst]

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
p2at_rec (loc, lp2ts) =
  p2at_make_node (loc, P2Trec (lp2ts))
//
(* ****** ****** *)

implement
p2at_ignored (loc) = p2at_make_node (loc, P2Tignored())

(* ****** ****** *)

(* end of [utfpl_p2at.dats] *)
