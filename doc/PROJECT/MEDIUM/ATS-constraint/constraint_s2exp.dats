(*
** ATS constaint-solving
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./constraint.sats"

(* ****** ****** *)

implement
fprint_s2exp
  (out, s2e0) = let
in
//
case+ s2e0.s2exp_node of
//
| S2Eignored () => fprint! (out, "S2Eignored(", ")")
//
| _ (*temporary*) => fprint! (out, "D2E...(", "...", ")")
//
end // end of [fprint_d2exp]

(* ****** ****** *)

implement
fprint_s2explst
  (out, d2es) = let
//
implement
fprint_val<s2exp> = fprint_s2exp
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<s2exp> (out, d2es)
end // end of [fprint_s2explst]

(* ****** ****** *)

implement
s2exp_make_node
  (s2t, node) = '{
  s2exp_srt= s2t, s2exp_node= node
} (* end of [s2exp_make_node] *)

(* ****** ****** *)
//
implement
s2exp_cst (s2t, s2c) =
  s2exp_make_node (s2t, S2Ecst(s2c))
//
implement
s2exp_var (s2t, s2v) =
  s2exp_make_node (s2t, S2Evar(s2v))
//
(* ****** ****** *)

implement
s2exp_ignored (s2t) =
  s2exp_make_node (s2t, S2Eignored())
//
(* ****** ****** *)

(* end of [constraint_s2exp.dats] *)
