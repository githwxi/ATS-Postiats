(*
//
// For encoding
// propositional logic
//
*)

(* ****** ****** *)

absprop PTRUE
absprop PFALSE

(* ****** ****** *)

praxi true_intr(): PTRUE
praxi false_elim{A:prop}(PFALSE): A

(* ****** ****** *)

absprop PNEG(A: prop) // negation
propdef ~(A: prop) = PNEG(A) // shorthand

(* ****** ****** *)

praxi neg_intr{A:prop}(pf: A -> PFALSE): ~A
praxi neg_elim{A:prop}(pf1: ~A, pf2: A): PFALSE

(* ****** ****** *)

prfun neg_elim2{A:prop}{B:prop}(pf1: ~A, pf2: A): B

(* ****** ****** *)
//
absprop
PCONJ(A: prop, B: prop)
//
propdef &&(A: prop, B: prop) = PCONJ(A, B)
//
praxi
conj_intr
  {A,B:prop} : (A, B) -> A && B
//
praxi
conj_elim_l{A,B:prop} : (A && B) -> A
praxi
conj_elim_r{A,B:prop} : (A && B) -> B
//
(* ****** ****** *)
(*
absprop
PDISJ(A: prop, B: prop)
*)
dataprop
PDISJ(A: prop, B: prop) =
  | disj_intr_l(A, B) of (A)
  | disj_intr_r(A, B) of (B)
//
propdef ||(A: prop, B: prop) = PDISJ(A, B)
//
prfun
disj_elim{A,B:prop}{C:prop}
  (pf0: A || B, fpf1: A -> C, fpf2: B -> C): C
//
(* ****** ****** *)
//
absprop
PIMPL(A: prop, B: prop)
//
infixr (->) ->>
//
propdef ->>(A: prop, B: prop) = PIMPL(A, B)
//
(* ****** ****** *)
//
praxi
impl_intr{A,B:prop}(pf: A -> B): A ->> B
//
praxi
impl_elim{A,B:prop}(pf1: A ->> B, pf2: A): B
//
(* ****** ****** *)
//
absprop
PEQUIV(A: prop, B: prop)
//
propdef == (A: prop, B: prop) = PEQUIV(A, B)
//
(* ****** ****** *)
//
praxi
equiv_intr
  {A,B:prop}(A ->> B, B ->> A): A == B
//
praxi
equiv_elim_l{A,B:prop}(pf: A == B): A ->> B
praxi
equiv_elim_r{A,B:prop}(pf: A == B): B ->> A
//
(* ****** ****** *)

praxi LDN{A:prop}(~(~A)): A
praxi LEM{A:prop}((*void*)): A || ~A

(* ****** ****** *)
//
praxi
Peirce{P,Q:prop}((*void*)): ((P ->> Q) ->> P) ->> P
//
(* ****** ****** *)

(* end of [prop-logic.sats] *)
