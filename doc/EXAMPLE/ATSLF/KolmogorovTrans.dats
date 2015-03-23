//
//
// Implementing Kolmogorov's translation on propositional logic
//
//
// February 2005: It is completed by Sa Cui and Hongwei Xi
// January 2007: It is ported to ATS/Geizella by Hongwei Xi
//
// March 5th, 2008:
// It is verified by ATS/Anairiats (without any changes being made).
//
(* ****** ****** *)
//
// HX-2012-06-13: the code typechecks in ATS2 without any changes
//
(* ****** ****** *)

// Infix operators

infixl land // left associative
infixl lor // left associative
infixr limp // right associative

// Types for formulas 

datasort form =
  | ltrue
  | lfalse
  | lnot of form
  | land of (form, form)
  | lor of (form, form)
  | limp of (form, form)
// end of [datasort]

// Types for contexts

datasort forms = nil | :: of (form, forms)

// [IN (A, G)] : The formula A is in the context G

dataprop IN (form, forms) =
  | {G:forms} {A:form} INone (A, A :: G)
  | {G:forms} {A,B:form} INshi (A, B :: G) of IN (A, G)

// Double negation

stadef dneg (f: form): form = lnot (lnot f)

// KOLM (A, A'): Kolmogrov's translation

dataprop KOLM (form, form, int) =
  | KOLMtrue (ltrue, dneg (ltrue), 0)
  | KOLMfalse (lfalse, dneg (lfalse), 0)
  | {A,A':form} {n:nat}
    KOLMnot (lnot A, dneg (lnot (dneg A')), n+1) of KOLM (A, dneg A', n)
  | {A,A',B,B':form} {n1,n2:nat}
    KOLMand (A land B, dneg ((dneg A') land (dneg B')), n1+n2+1) of
      (KOLM (A, dneg A', n1), KOLM (B, dneg B', n2))
  | {A,A',B,B':form} {n1,n2:nat}
    KOLMor (A lor B, dneg ((dneg A') lor (dneg B')), n1+n2+1) of
      (KOLM (A, dneg A', n1), KOLM (B, dneg B', n2))
  | {A,A',B,B':form} {n1,n2:nat}
    KOLMimp (A limp B, dneg ((dneg A') limp (dneg B')), n1+n2+1) of
      (KOLM (A, dneg A', n1), KOLM (B, dneg B', n2))
propdef KOLM0 (A:form, A':form) = [n:nat] KOLM (A, A', n)

dataprop FMEQ (form, form) = {A:form} FMEQ (A, A)

prfun fmeq
  {A,A',A'':form}
  {n1,n2:nat} .<n1>. (
  pf1: KOLM (A, A', n1), pf2: KOLM (A, A'', n2)
) : FMEQ (A', A'') = let
in
//
case+ (pf1, pf2) of
| (KOLMtrue (), KOLMtrue ()) => FMEQ
| (KOLMfalse (), KOLMfalse ()) => FMEQ
| (KOLMnot pf11, KOLMnot pf21) => let 
    prval FMEQ () = fmeq (pf11, pf21)
  in
    FMEQ ()
  end
| (KOLMand (pf11, pf12), KOLMand (pf21, pf22)) => let
    prval FMEQ () = fmeq (pf11, pf21)
    prval FMEQ () = fmeq (pf12, pf22)
  in
    FMEQ ()
  end
| (KOLMor (pf11, pf12), KOLMor (pf21, pf22)) => let
    prval FMEQ () = fmeq (pf11, pf21)
    prval FMEQ () = fmeq (pf12, pf22)
  in
    FMEQ ()
  end
| (KOLMimp (pf11, pf12), KOLMimp (pf21, pf22)) => let
    prval FMEQ () = fmeq (pf11, pf21)
    prval FMEQ () = fmeq (pf12, pf22)
  in
    FMEQ ()
  end
//
end // end of [fmeq]

(* ****** ****** *)
//
// Existence of Kolmogorov's translation 
// Given a formula A, there exists A', such that KOLM (A, A')
//
(*
extern
prfun KOLMfun {A:form} (): [A':form] KOLM0 (A, dneg A')
*)
prfun KOLMfun
  {A:form} .<A>.
  (): [A':form] KOLM0 (A, dneg A') =
  scase A of
  | ltrue () => KOLMtrue ()
  | lfalse () => KOLMfalse ()
  | lnot (A1) => KOLMnot (KOLMfun {A1} ())
  | land (A1, A2) => KOLMand (KOLMfun {A1} (), KOLMfun {A2} ())
  | lor (A1, A2) => KOLMor (KOLMfun {A1} (), KOLMfun {A2} ())
  | limp (A1, A2) => KOLMimp (KOLMfun {A1} (), KOLMfun {A2} ())
// end of [KOLMfun]

(* ****** ****** *)
//
// Kolmogrov's translation on contexts
//
dataprop
KOLMS (forms, forms, int) =
  | KOLMSnil (nil, nil, 0)
  | {G,G':forms} {A,A':form} {n:nat}
    KOLMScons (A :: G, dneg A' :: G', n+1) of (KOLM0 (A, dneg A'), KOLMS (G, G',n))
propdef KOLMS0 (G:forms, G':forms) = [n:nat] KOLMS (G, G', n)
  
// Classical natural deduction 

dataprop NK (forms, form, int) =
  | {G:forms} NKtrue (G, ltrue, 0)
  | {G:forms} {A:form} {n:nat}
    NKfalse (G, A, n+1) of NK (G, lfalse, n)
  | {G:forms} {A:form} NKhyp (G, A, 0) of IN (A, G)
  | {G:forms} {A,B:form} {n1,n2:nat} 
    NKandi (G, A land B, n1+n2+1) of (NK (G, A, n1), NK (G, B, n2))
  | {G:forms} {A,B:form} {n:nat} NKandel (G, A, n+1) of NK(G, A land B, n)
  | {G:forms} {A,B:form} {n:nat} NKander (G, B, n+1) of NK(G, A land B, n)
  | {G:forms} {A,B:form} {n:nat} NKoril (G, A lor B, n+1) of NK (G, A, n)
  | {G:forms} {A,B:form} {n:nat} NKorir (G, A lor B, n+1) of NK (G, B, n)
  | {G:forms} {A,B,C:form} {n1,n2,n3:nat}
    NKore (G, C, n1+n2+n3+1) of
      (NK (G, A lor B, n1), NK (A :: G, C, n2), NK (B :: G, C, n3))
  | {G:forms} {A,B:form} {n:nat}
    NKimpi (G, A limp B, n+1) of NK (A :: G, B, n)
  | {G:forms} {A,B:form} {n1,n2:nat}
    NKimpe (G, B, n1+n2+1) of (NK (G, A limp B, n1), NK (G, A, n2))
  | {G:forms} {A:form} {n:nat} NKnoti (G, lnot A, n+1) of NK (A :: G, lfalse, n)
  | {G:forms} {A:form} {n1,n2:nat} 
    NKnote (G, lfalse, n1+n2+1) of (NK (G, lnot A, n1), NK (G, A, n2))
  | {G:forms} {A:form} {n:nat} NKdneg (G, A, n+1) of NK (G, lnot (lnot A), n)
propdef NK0 (G:forms, A:form) = [n:nat] NK (G, A, n)

// Intuitionistic Natural Deduction

dataprop NJ (forms, form, int) =
  | {G:forms} NJtrue (G, ltrue, 0)
  | {G:forms} {A:form} {n:nat} NJfalse (G, A, n+1) of NJ (G, lfalse, n)
  | {G:forms} {A:form} NJhyp (G, A, 0) of IN (A, G)
  | {G:forms} {A,B:form} {n1,n2:nat} 
    NJandi (G, A land B, n1+n2+1) of (NJ (G, A, n1), NJ (G, B, n2))
  | {G:forms} {A,B:form} {n:nat} NJandel (G, A, n+1) of NJ(G, A land B, n)
  | {G:forms} {A,B:form} {n:nat} NJander (G, B, n+1) of NJ(G, A land B, n)
  | {G:forms} {A,B:form} {n:nat} NJoril (G, A lor B, n+1) of NJ (G, A, n)
  | {G:forms} {A,B:form} {n:nat} NJorir (G, A lor B, n+1) of NJ (G, B, n)
  | {G:forms} {A,B,C:form} {n1,n2,n3:nat}
    NJore (G, C, n1+n2+n3+1) of (NJ (G, A lor B, n1), NJ (A :: G, C, n2), NJ (B :: G, C, n3))
  | {G:forms} {A,B:form} {n:nat} NJimpi (G, A limp B, n+1) of NJ (A :: G, B, n)
  | {G:forms} {A,B:form} {n1,n2:nat}
    NJimpe (G, B, n1+n2+1) of (NJ (G, A limp B, n1), NJ (G, A, n2))
  | {G:forms} {A,B:form} {n:nat} NJnoti (G, lnot A, n+1) of NJ (A :: G, lfalse, n)
  | {G:forms} {A:form} {n1,n2:nat}
    NJnote (G, lfalse, n1+n2+1) of (NJ (G, lnot A, n1), NJ (G, A, n2))
propdef NJ0 (G:forms, A:form) = [n:nat] NJ (G, A, n)

// Given a KOLMS (G, G', n) on contexts with a metric, and a prop IN (A, G),
// there exists a formula A', such that KOLM (A, A') and IN (A', G').

prfun
proposition10
  {G,G':forms}
  {A:form} {n:nat} .<n>. (
  ks: KOLMS (G, G',n), i: IN (A, G)
) : [A':form] (
  KOLM0 (A, dneg A'), IN (dneg A', G')
) = begin
  case+ i of
  | INone () => let 
      prval KOLMScons (k, ks) = ks 
    in 
      (k, INone ()) 
    end
  | INshi i' => let 
      prval KOLMScons (k, ks) = ks
      prval (k, i') = proposition10 (ks, i')
    in
      (k, INshi i')
    end
end // end of [proposition10]

// Double negation rule

prfn
proposition20
  {G:forms}
  {A:form} (
) : NJ0 (
  G, A limp (lnot (lnot A))
) =
  NJimpi (NJnoti (NJnote (NJhyp INone, NJhyp (INshi INone))))
// end of [proposition20]

prfn
proposition21
  {G:forms}
  {A:form} (
  pf: NJ0 (G, A)
) : NJ0 (G, lnot (lnot A)) = NJimpe (proposition20 (), pf)

// Double false rule

prfn
proposition30
  {G:forms} ()
  : NJ0 (G, (lnot (lnot lfalse)) limp lfalse) =
  NJimpi (NJnote ((NJhyp INone), NJnoti (NJhyp INone)))

prfn proposition31 {G:forms} (pf: NJ0 (G, dneg lfalse)): NJ0 (G, lfalse) =
  NJimpe (proposition30 (), pf)

// not not not R

prfn
proposition35
  {G:forms} {A:form} ()
  : NJ0 (
  G, (lnot (dneg A)) limp (lnot A)
) = let
  stadef G1:forms = lnot (dneg A) :: G
  prval pf = proposition21 (NJhyp (INone {G1} {A} ()))
in
  NJimpi (NJnoti (NJnote (NJhyp (INshi INone), pf)))
end // end of [proposition35]

prfn
proposition36
  {G:forms} {A:form} (
  pf: NJ0 (G, lnot (dneg A))
) : NJ0 (G, lnot A) =
  NJimpe (proposition35 (), pf)
// end of [proposition36]

(* ****** ****** *)

propdef
SUP (G2:forms, G1:forms) =
  {A: form} IN (A, G1) -<prf> IN (A, G2)
// end of [SUP]

// Weakening

prfn proposition40 {G1,G2:forms} {A:form}
  (f: SUP (G2, G1)) : SUP (A :: G2, G1) = lam i => INshi (f i) 

// Exchange

prfn
proposition41
  {G1,G2:forms}
  {A1,A2:form} (
  f: SUP (G2, G1)
) : SUP (A1 :: A2 :: G2, A2 :: A1 :: G1) = (
  lam i => case+ i of
    | INone () => INshi (INone)
    | INshi (INone ()) => INone
    | INshi (INshi i) => INshi (INshi (f i))
) // end of [proposition41]

// Shift

prfn
proposition42
  {G1,G2:forms}
  {A:form} (
  f: SUP (G2, G1)
) : SUP (A :: G2, A :: G1) = (
  lam i => case+ i of
    | INone () => INone | INshi i => INshi (f i)
) // end of [proposition42]

//

prfun
proposition43
  {G1,G2:forms}
  {A:form} {n:nat} .<n>. (
  f: SUP (G2, G1)) (pf: NJ (G1, A, n)
) : NJ (G2, A, n) = let
in
//
case+ pf of
| NJhyp i => NJhyp (f i)
| NJtrue () => NJtrue
| NJfalse pf => NJfalse (proposition43 f pf)
| NJandi (pf1, pf2) =>
    NJandi (proposition43 f pf1, proposition43 f pf2)
| NJandel pf => NJandel (proposition43 f pf)
| NJander pf => NJander (proposition43 f pf)
| NJoril pf => NJoril (proposition43 f pf)
| NJorir pf => NJorir (proposition43 f pf)
| NJore (pf, pf1, pf2) => NJore (
    proposition43 f pf
  , proposition43 (proposition42 f) pf1
  , proposition43 (proposition42 f) pf2
  ) // end of [NJore]
| NJimpi pf => NJimpi (proposition43 (proposition42 f) pf)
| NJimpe (pf1, pf2) => NJimpe (proposition43 f pf1, proposition43 f pf2)
| NJnoti pf => NJnoti (proposition43 (proposition42 f) pf)
| NJnote (pf1, pf2) => NJnote (proposition43 f pf1, proposition43 f pf2) 
//
end // end of [proposition43]

// Weakening rule

prfn
proposition44
  {G:forms}
  {A,A':form}
  (pf: NJ0 (G, A)) : NJ0 (A' :: G, A) = 
  (proposition43 (proposition40 (lam i => i)) pf)

// Exchanging rule

prfn
proposition45
  {G:forms}
  {A1,A2,A3:form}
  (pf: NJ0 (A1 :: A2 :: G, A3)) : NJ0 (A2 :: A1 :: G, A3) = 
  (proposition43 (proposition41 (lam i => i)) pf)

(* ****** ****** *)
//
// Soundness:
// whenever a formula A is provable in NK, its translation A' is provable in NJ
//
prfun
trans
  {G,G':forms}
  {A:form}
  {n:nat} .<n>. (
  ks: KOLMS0 (G, G'), kpf: NK (G, A, n)
) : [A':form] (
  KOLM0 (A, dneg A'), NJ0 (G', dneg A')
) = let
in
//
case+ kpf of
| NKhyp i => let 
    prval (k, i) = proposition10 (ks, i) 
  in 
    (k, NJhyp i) 
  end
| NKtrue () => (KOLMtrue, proposition21 NJtrue)
| NKfalse kpf => let
    prval (KOLMfalse (), jpf) = trans (ks, kpf)
    prval k' = KOLMfun ()
  in
    (k', NJfalse (proposition31 jpf))
  end
| NKandi (kpf1, kpf2) => let
    prval (k1, jpf1) = trans (ks, kpf1)
    prval (k2, jpf2) = trans (ks, kpf2)
  in
    (KOLMand (k1, k2), proposition21 (NJandi (jpf1, jpf2)))
  end
| NKandel kpf => let
    prval (KOLMand (k1, k2), jpf) = trans (ks, kpf)
    prval pf1 = NJhyp (INshi INone)
    prval pf2 = NJandel (NJhyp INone) 
    prval pf3 = NJnote (pf2, pf1)
    prval pf4 = NJnoti pf3 
    prval pf5 = NJnote (proposition44 jpf, pf4)
    prval pf6 = NJnoti pf5
  in
    (k1, pf6)
  end
| NKander kpf => let
    prval (KOLMand (k1, k2), jpf) = trans (ks, kpf)
    prval pf1 = NJhyp (INshi INone)
    prval pf2 = NJander (NJhyp INone) 
    prval pf3 = NJnote (pf2, pf1)
    prval pf4 = NJnoti pf3 
    prval pf5 = NJnote (proposition44 jpf, pf4)
    prval pf6 = NJnoti pf5
  in
    (k2, pf6)
  end 
| NKoril kpf => let
    prval (k1, jpf) = trans (ks, kpf)
    prval k2 = KOLMfun ()
  in
    (KOLMor (k1, k2), proposition21 (NJoril jpf))
  end
| NKorir kpf => let
    prval (k2, jpf) = trans (ks, kpf)
    prval k1 = KOLMfun ()
  in
    (KOLMor (k1, k2), proposition21 (NJorir jpf))
  end
| NKore {..} {A1,A2,A3} {..} (kpf1, kpf2, kpf3) => let
    prval [A':form] (KOLMor (k11, k12), jpf1) = trans (ks, kpf1)
    prval (k2, jpf2) = trans (KOLMScons (k11, ks), kpf2)
    prval (k3, jpf3) = trans (KOLMScons (k12, ks), kpf3)
    prval FMEQ () = fmeq (k2, k3)
    prval [A3':form] k4 = KOLMfun {A3} ()
    prval jpf4 = proposition45 (proposition44 jpf2)
    prval jpf4 = proposition45 (proposition44 jpf4)
    prval jpf5 = proposition45 (proposition44 jpf3)
    prval jpf5 = proposition45 (proposition44 jpf5)
    prval FMEQ () = fmeq (k2, k4)
    prval pf1 = NJore (NJhyp (INone {lnot A3' :: G'} {A'}), jpf4, jpf5)
    prval pf2 = NJnote (pf1, NJhyp (INshi INone))
    prval pf3 = NJnoti pf2
    prval pf4 = NJnote (proposition44 jpf1, pf3)
    prval pf5 = NJnoti pf4
  in
    (k4, pf5)
  end
| NKnoti kpf => let (* kpf: NK (A::G, lfalse) *)
    prval k1 = KOLMfun ()
    prval (KOLMfalse (), jpf) = trans (KOLMScons (k1, ks), kpf)
    prval pf1 = proposition31 jpf
    prval pf2 = NJnoti pf1
    prval pf3 = proposition21 pf2
  in  
    (KOLMnot k1, pf3)
  end
| NKnote (kpf1, kpf2) => let
    prval (KOLMnot k1, jpf1) = trans (ks, kpf1) 
    prval (k2, jpf2) = trans (ks, kpf2)
    prval FMEQ () = fmeq (k1, k2)
    prval jpf1' = (proposition36) jpf1 
    prval pf1 = NJnote (jpf1', jpf2) 
    prval pf2 = proposition21 pf1
  in
    (KOLMfalse(), pf2)
  end   
| NKimpi kpf => let
    prval k1 = KOLMfun ()
    prval (k2, jpf) = trans (KOLMScons (k1, ks), kpf)
  in
    (KOLMimp (k1, k2), proposition21 (NJimpi jpf))
  end
| NKimpe {..} {A1,A2} {..} (kpf1, kpf2) => let
    prval [A':form] (KOLMimp (k1, k2), jpf1) = trans (ks, kpf1)
    prval (k3, jpf2) = trans (ks, kpf2)
    prval FMEQ () = fmeq (k1, k3)
    prval [A2':form] k4 = KOLMfun {A2} ()
    prval pf0 = proposition44 (proposition44 jpf2)
    prval FMEQ () = fmeq (k2, k4)
    prval pf1 = NJimpe (NJhyp (INone {lnot A2' :: G'} {A'}), pf0)
    prval pf2 = NJnote (pf1, NJhyp (INshi INone))
    prval pf3 = NJnoti pf2
    prval pf4 = NJnote (proposition44 jpf1, pf3)
    prval pf5 = NJnoti pf4
  in
    (k2, pf5)
  end
| NKdneg kpf => let
    prval (KOLMnot (KOLMnot k), jpf) = trans (ks, kpf)
    prval pf = proposition36 (proposition36 (proposition36 jpf))
  in
    (k, pf)
  end
end // end of [trans]

(* ****** ****** *)

(* end of [KolmogorovTrans.dats] *)
