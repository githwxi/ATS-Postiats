(*
//
// For encoding
// propositional logic
//
*)

(* ****** ****** *)

infixr (->) ->>

(* ****** ****** *)

staload "./prop-logic.sats"

(* ****** ****** *)
//
(*
prfun
neg_elim2
  {A:prop}{B:prop}(A, ~A): B
*)
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
//
prfn
disj_commute
  {A,B:prop}(pf0: A || B): B || A =
  case+ pf0 of
  | disj_intr_l(pf0_l) => disj_intr_r(pf0_l)
  | disj_intr_r(pf0_r) => disj_intr_l(pf0_r)
//
(* ****** ****** *)
//
prfn
disj_elim{A,B:prop}{C:prop}
  (pf0: A || B, fpf1: A -> C, fpf2: B -> C): C =
  case+ pf0 of
  | disj_intr_l(pf0_l) => fpf1(pf0_l)
  | disj_intr_r(pf0_r) => fpf2(pf0_r)
//
(* ****** ****** *)

prfn
conj_disj_distribute
  {A,B,C:prop}
(
  pf0: A && (B || C)
) : (A && B) || (A && C) = let
//
val pf0_l = conj_elim_l(pf0)
val pf0_r = conj_elim_r(pf0)
//
in
//
case+ pf0_r of
| disj_intr_l(pf0_rl) =>
    disj_intr_l(conj_intr(pf0_l, pf0_rl))
  // end of [disj_intr_l]
| disj_intr_r(pf0_rr) =>
    disj_intr_r(conj_intr(pf0_l, pf0_rr))
  // end of [disj_intr_r]
//
end // end of [conj_disj_distribute]

(* ****** ****** *)

prfn
Subst{A,B,C:prop}
(
// argless
) : (A ->> (B ->> C)) ->> ((A ->> B) ->> (A ->> C)) =
impl_intr(
  lam pf1 =>
  impl_intr(
    lam pf2 =>
    impl_intr(
      lam pf3 =>
      impl_elim(impl_elim(pf1, pf3), impl_elim(pf2, pf3))
    )
  )
)

(* ****** ****** *)
//
prfn LEM_{A:prop}(): A || ~A =
  LDN(neg_intr(lam pfn => neg_elim(pfn, disj_intr_r(neg_intr(lam pf => neg_elim(pfn, disj_intr_l(pf)))))))
//
(* ****** ****** *)

(* end of [prop-logic.dats] *)
