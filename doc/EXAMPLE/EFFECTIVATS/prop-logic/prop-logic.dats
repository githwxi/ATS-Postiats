(*
//
// For encoding
// propositional logic
//
*)

(* ****** ****** *)

staload "./prop-logic.sats"

(* ****** ****** *)
//
primplmnt
neg_elim2(pf1, pf2) =
  false_elim(neg_elim(pf1, pf2))
//
(* ****** ****** *)

(* end of [prop-logic.dats] *)
