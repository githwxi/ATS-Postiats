//
// An implementation of Gentzen's cut elimination for
// intuitionistic first-order predicate logic.
//

// March 2005:
// The code for the propositional part is completed by Sa Cui and
// partly modified by Hongwei Xi

// June 2005:
// The code for the quantification part is completed by Hongwei Xi.

// January 2007:
// The code is ported to ATS/Geizella by Hongwei Xi

(* ****** ****** *)
//
// June 12, 2012
// The code is ported to ATS2/Postiats by Hongwei Xi
//
(* ****** ****** *)

(* cut elimination for intuitionistic propositional logic *)

(* ****** ****** *)

(*
//
// HX: this feature is no longer supported
//
dataparasort iota = (* sort for individuals *)
*)

(* ****** ****** *)

nonfix land; nonfix lor

datasort form  = (* sort for formulas *)
  | land of (form, form) // conjunction
  | lor of (form, form) // disjunction
  | limp of (form, form) // implication
(*
  // Note the use of higher-order abstract syntax
  | luni of (iota -> form) // universal quantification
  | lexi of (iota -> form) // existential quantification
*)

datasort seq = (* sort for formula sequences *)
  | nil | :: of (form, seq)

dataprop FM (form, int) =
  | {A1,A2:form} {n1,n2:nat}
    FMand (land (A1, A2), n1+n2+1) of (FM (A1, n1), FM (A2, n2))
  | {A1,A2:form} {n1,n2:nat} 
    FMor (lor (A1, A2), n1+n2+1) of (FM (A1, n1), FM (A2, n2))
  | {A1,A2:form} {n1,n2:nat} 
    FMimp (limp (A1, A2), n1+n2+1) of (FM (A1, n1), FM (A2, n2))
(*
  | {A:iota->form} {n:nat} FMuni (luni A, n+1) of {a:iota} FM (A a, n)
  | {A:iota->form} {n:nat} FMexi (lexi A, n+1) of {a:iota} FM (A a, n)
*)

propdef FM0 (A : form) = [n:nat] FM (A, n)

dataprop IN (form, seq) =
  | {G:seq} {A:form} INone (A, A :: G)
  | {G:seq} {A,A':form} INshi (A, A' :: G) of IN (A, G)

//

dataprop DER (seq, form, int) =
  | {G:seq} {A:form} DERaxi (G, A, 0) of IN (A, G)

  | {G:seq} {A:form} {n:nat} DERleft (G, A, n+1) of DERL (G, A, n)

  | {G:seq} {A:form} {n:nat} DERright (G, A, n+1) of DERR (G, A, n)

and DERL (seq, form, int) = 
  | {G:seq} {A1,A2,A3:form} {n:nat}
    DERLand1 (G, A3, n+1) of (IN (land (A1, A2), G), DER (A1 :: G, A3, n))

  | {G:seq} {A1,A2,A3:form} {n:nat}
    DERLand2 (G, A3, n+1) of (IN (land (A1, A2), G), DER (A2 :: G, A3, n))

  | {G:seq} {A1,A2,A3:form} {n1,n2:nat}
      DERLimp (G, A3, n1+n2+1) of
        (IN (limp (A1, A2), G), DER (G, A1, n1), DER (A2 :: G, A3, n2))

  | {G:seq} {A1,A2,A3:form} {n1,n2:nat}
      DERLor (G, A3, n1+n2+1) of
        (IN (lor (A1, A2), G), DER (A1 :: G, A3, n1), DER (A2 :: G, A3, n2))

(*
  | {G:seq} {A1:iota->form; A2:form} {a:iota} {n:nat}
      DERLuni (G, A2, n+1) of (IN (luni A1, G), DER (A1 a :: G, A2, n))
  | {G:seq} {A1:iota->form; A2:form} {n:nat}
      DERLexi (G, A2, n+1) of (IN (lexi A1, G), {a:iota} DER (A1 a :: G, A2, n))
*)

and DERR (seq, form, int) =
  | {G:seq} {A1,A2:form} {n1,n2:nat}
      DERRand (G, land (A1, A2), n1+n2+1) of (DER (G, A1, n1), DER (G, A2, n2))
  | {G:seq} {A1,A2:form} {n:nat}
      DERRimp (G, limp (A1, A2), n+1) of DER (A1 :: G, A2, n)
  | {G:seq} {A1,A2:form} {n:nat} DERRor1 (G, lor (A1, A2), n+1) of DER (G, A1, n)
  | {G:seq} {A1,A2:form} {n:nat} DERRor2 (G, lor (A1, A2), n+1) of DER (G, A2, n)
(*
  | {G:seq} {A:iota->form} {n:nat} DERRuni (G, luni A, n+1) of {a:iota} DER (G, A a, n)
  | {G:seq} {A:iota->form} {a:iota} {n:nat} DERRexi (G, lexi A, n+1) of DER (G, A a, n)
*)

propdef DER0 (G:seq, A:form) = [n:nat] DER(G, A, n)

//

propdef SUP (G1: seq, G2: seq) = {A: form} IN (A, G2) -<prf> IN (A, G1)

prfn shiSup {G1,G2:seq} {A:form} (f : SUP (G1, G2)): SUP (A :: G1, A :: G2) =
  lam i => case+ i of INone () => INone | INshi i => INshi (f i)

prfn weakSup {G1,G2:seq} {A:form} (f : SUP (G1, G2)): SUP (A :: G1, G2) = 
  lam i => INshi (f i)

prfn exchSup {G1,G2:seq} {A1,A2:form}
    (f: SUP (G1, G2)): SUP (A1 :: A2 :: G1, A2 :: A1 :: G2) =
  lam i => case+ i of
    | INone () => INshi (INone)
    | INshi (INone ()) => INone
    | INshi (INshi i) => INshi (INshi (f i))

prfn ctrSup {G1,G2:seq} {A:form}
    (i0: IN (A, G1), f: SUP (G1, G2)): SUP (G1, A :: G2) =
  lam i => (case+ i of INone () => i0 | INshi i => f i)

prval idSup = lam {G:seq} => (lam i => i): SUP (G, G)

//

prfun supDer {G1,G2:seq} {A:form} {n:nat} .<n>. 
     (f: SUP (G1, G2)) (d: DER (G2, A, n)): DER (G1, A, n) =
  case d of
    | DERaxi i => DERaxi (f i)
    | DERleft (DERLand1 (i, d)) =>
        DERleft (DERLand1 (f i, supDer (shiSup f) d))
    | DERleft (DERLand2 (i, d)) =>
        DERleft (DERLand2 (f i, supDer (shiSup f) d))
    | DERleft (DERLimp (i, d1, d2)) =>
        DERleft (DERLimp (f i, supDer f d1, supDer (shiSup f) d2))
    | DERleft (DERLor (i, d1, d2)) =>
        DERleft (DERLor (f i, supDer (shiSup f) d1, supDer (shiSup f) d2))
(*
    | DERleft (DERLuni {..} {A1,A2} {a} {..} (i, d)) =>
        DERleft (DERLuni {..} {A1, A2} {a} {..} (f i, supDer (shiSup f) d))
    | DERleft (DERLexi {..} {Af1,A2} {..} (i, df)) =>
        DERleft (DERLexi {..} {Af1, A2} (f i, lam {a:iota} => supDer (shiSup f) (df {a})))
*)
    | DERright (DERRand (d1, d2)) => DERright (DERRand (supDer f d1, supDer f d2))
    | DERright (DERRimp d) => DERright (DERRimp (supDer (shiSup f) d))
    | DERright (DERRor1 d) => DERright (DERRor1 (supDer f d))
    | DERright (DERRor2 d) => DERright (DERRor2 (supDer f d))
(*
    | DERright (DERRuni {..} {Af} {..} df) =>
        DERright (DERRuni {..} {Af} {..} (lam {a:iota} => supDer {G1, G2} {Af a} f (df {a})))
    | DERright (DERRexi {..} {A} {a} {..} d) =>
        DERright (DERRexi {..} {A} {a} {..} (supDer f d))
*)
//

prfn weakDer {G:seq} {A,A':form} {n:nat} (d: DER (G, A, n))
   : DER (A' :: G, A, n) = supDer (weakSup idSup) d

prfn exchDer {G:seq} {A,A1,A2:form} { n:nat}
    (d: DER (A1 :: A2 :: G, A, n))
   : DER (A2 :: A1 :: G, A, n) = supDer (exchSup idSup) d

prfn weakExchDer {G:seq} {A,A1,A2:form} { n:nat}
    (d: DER (A1 :: G, A, n))
   : DER (A1 :: A2 :: G, A, n) = exchDer (weakDer d)

prfn ctrDer {G:seq} {A,A1,A2:form} { n:nat}
    (i: IN (A1, G), d: DER (A1 :: G, A2, n))
   : DER (G, A2, n) = supDer (ctrSup (i, idSup)) d

//

(*********************** cut elimination **************************)

prfun cut {G:seq} {A1,A2:form} {m,n1,n2:nat} .<m,n2,n1>. 
     (f: FM (A1, m), d1: DER (G, A1, n1), d2: DER (A1 :: G, A2, n2))
    : DER0 (G, A2) = begin case+ d2 of
    | DERaxi i => (case+ i of INone () => d1 | INshi i => DERaxi i)
    | DERleft (DERLand1 (i, d20)) => begin case+ i of
      | INone () => begin case+ d1 of 
        | DERaxi i => ctrDer (i, d2)
        | DERleft d1 => cutAux (f, d1, d2)
        | DERright (DERRand (d10, _)) => let
            prval FMand (f1, f2) = f
          in
            cut (f1, d10, cut (f, weakDer d1, exchDer d20))
          end
        end
      | INshi i => DERleft (DERLand1 (i, cut (f, weakDer d1, exchDer d20)))
      end
    | DERleft (DERLand2 (i, d20)) => begin case+ i of
      | INone () => begin case+ d1 of 
        | DERaxi i => ctrDer (i, d2)
        | DERleft d1 => cutAux (f, d1, d2)
        | DERright (DERRand (_, d11)) => let
            prval FMand (f1, f2) = f
          in
            cut (f2, d11, cut (f, weakDer d1, exchDer d20))
          end
        end
      | INshi i => DERleft (DERLand2 (i, cut (f, weakDer d1, exchDer d20)))
      end
    | DERleft (DERLimp (i, d20, d21)) => begin case+ i of
      | INone () => begin case+ d1 of
        | DERaxi i => ctrDer (i, d2)
        | DERleft d1 => cutAux (f, d1, d2)
        | DERright (DERRimp d10) => let prval
            FMimp (f1, f2) = f
          in
            cut (f2, cut (f1, cut (f, d1, d20), d10), cut (f, weakDer d1, exchDer d21))
          end
        end
      | INshi i => begin
          DERleft (DERLimp (i, cut (f, d1, d20), cut (f, weakDer d1, exchDer d21)))
        end
      end
    | DERleft (DERLor (i, d20, d21)) => begin case+ i of
      | INone () => begin case+ d1 of
        | DERaxi i => ctrDer (i, d2)
        | DERleft d1 => cutAux (f, d1, d2)
        | DERright (DERRor1 d10) => let
            prval FMor (f1, f2) = f
          in
            cut (f1, d10, cut (f, weakDer d1, exchDer d20))
          end
        | DERright (DERRor2 d10) => let
            prval FMor (f1, f2) = f
          in
            cut (f2, d10, cut (f, weakDer d1, exchDer d21))
          end
        end
      | INshi i => DERleft (
          DERLor (i, cut (f, weakDer d1, exchDer d20), cut (f, weakDer d1, exchDer d21))
        ) // end of [DERleft]
      end
(*
    | DERleft (DERLuni (i, d20)) => begin case+ i of
      | INone () => begin case+ d1 of 
        | DERaxi i => ctrDer (i, d2)
        | DERleft d1 => cutAux (f, d1, d2)
        | DERright (DERRuni df10) => let
            prval FMuni ff = f
          in
            cut (ff {...}, df10 {...}, cut (f, weakDer d1, exchDer d20))
          end
        end
      | INshi i => DERleft (DERLuni (i, cut (f, weakDer d1, exchDer d20)))
      end
    | DERleft (DERLexi (i, df20)) => begin case+ i of
      | INone () => begin case+ d1 of 
        | DERaxi i => ctrDer (i, d2)
        | DERleft d1 => cutAux (f, d1, d2)
        | DERright (DERRexi d10) => let
            prval FMexi ff = f
          in
            cut (ff {...}, d10, cut (f, weakDer d1, exchDer (df20 {...})))
          end
        end
      | INshi i => begin
          DERleft (DERLexi (i, lampara {a:iota} => cut (f, weakDer d1, exchDer (df20 {a}))))
        end // end of [INshi]
      end
*)
    | DERright (DERRand (d20, d21)) =>
      DERright (DERRand (cut (f, d1, d20), cut (f, d1, d21)))
    | DERright (DERRimp d20) => DERright (DERRimp (cut (f, weakDer d1, exchDer d20)))
    | DERright (DERRor1 d20) => DERright (DERRor1 (cut (f, d1, d20)))
    | DERright (DERRor2 d20) => DERright (DERRor2 (cut (f, d1, d20)))
(*
    | DERright (DERRuni {..} {Af} df20) => begin
        DERright (DERRuni {..} {Af} (lampara {a:iota} => cut (f, d1, df20 {a})))
      end // end of [DERright]
    | DERright (DERRexi {..} {Af} {a} df20) =>
        DERright (DERRexi {..} {Af} {a} (cut (f, d1, df20)))
*)
end // end of [cut]

and cutAux {G:seq} {A1,A2:form} {m,n1,n2:nat} .<m,n2,n1>. 
  (f: FM (A1, m), d1: DERL (G, A1, n1), d2: DER (A1 :: G, A2, n2))
  : DER0 (G, A2) = begin case+ d1 of
  | DERLand1 (i, d1) => DERleft (DERLand1 (i, cut (f, d1, weakExchDer d2)))
  | DERLand2 (i, d1) => DERleft (DERLand2 (i, cut (f, d1, weakExchDer d2)))
  | DERLimp (i, d11, d12) => DERleft (DERLimp (i, d11, cut (f, d12, weakExchDer d2)))
  | DERLor (i, d11, d12) => 
      DERleft (DERLor (i, cut (f, d11, weakExchDer d2), cut (f, d12, weakExchDer d2)))
(*
  | DERLuni (i, d1) => DERleft (DERLuni (i, cut (f, d1, weakExchDer d2)))
  | DERLexi (i, df1) => begin
      DERleft (DERLexi (i, lampara {a:iota} => cut (f, df1 {a}, weakExchDer d2)))
    end // end of [DERLexi]
*)
end // end of [cutAux]

(* ****** ****** *)

(* end of [CutElimIL.dats] *)
