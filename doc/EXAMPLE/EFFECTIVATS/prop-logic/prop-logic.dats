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
//
prfn
conj_commute
  {A,B:prop}(pf: A && B): B && A =
  conj_intr(conj_elim_r(pf), conj_elim_l(pf))
//
(* ****** ****** *)

(* end of [prop-logic.dats] *)
