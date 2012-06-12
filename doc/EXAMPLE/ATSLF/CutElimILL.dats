(*
 * An implementation of Gentzen's cut elimination for intuitionistic linear
 * propositional logic with:
 *
 * 1. linear implication,
 * 2. linear multiplicative conjunction,
 * 3. linear additive conjunction, and
 * 4. linear additive disjunction
 *
 *)

// March 2005:
// The code is completed by Sa Cui with some help from Hongwei Xi 

// January 2007:
// The code is ported to ATS/Geizella by Hongwei Xi

// March 5th, 2008
// It is verified by ATS/Anairiats (without any changes being made).

(* ****** ****** *)
//
// June 12, 2012
// The code is ported to ATS2/Postiats by Hongwei Xi
//
(* ****** ****** *)

sortdef two = {i:nat | i < 2}

(* ****** ****** *)

nonfix land; nonfix lor

datasort form  = (* sort for formulas *)
  | ltimes of (form, form) // linear multplicative and
  | land of (form, form)  // linear additive and
  | lor of (form, form) // linear additive or
  | limp of (form, form) // linear implicative

datasort seq = (* sort for sequents *)
  | none | more of (seq, form, int)

dataprop FM (form, int) =

  | {A1,A2:form} {n1,n2:nat} 
    FMand1 (ltimes (A1, A2), n1+n2+1) of (FM (A1, n1), FM (A2, n2))
  
  | {A1,A2:form} {n1,n2:nat} 
    FMand2 (land (A1, A2), n1+n2+1) of (FM (A1, n1), FM (A2, n2))

  | {A1,A2:form} {n1,n2:nat} 
    FMor (lor (A1, A2), n1+n2+1) of (FM (A1, n1), FM (A2, n2))   

  | {A1,A2:form} {n1,n2:nat} 
    FMimp (limp (A1, A2), n1+n2+1) of (FM (A1, n1), FM (A2, n2))

propdef FM0 (A : form) = [n:nat] FM (A, n)

dataprop SEQeq (seq, seq) = {G:seq} SEQeq (G, G)

dataprop SEQ (seq, int, int) =

  | SEQnone (none, 0, 0)

  | {G:seq} {A:form} {n,w,i:nat | i < 2}
      SEQmore (more (G, A, i), n+1, w+i) of SEQ (G, n, w)

propdef SEQ0 (G:seq, w:int) = [n:nat] SEQ (G, n, w)

dataprop IN (form, int, seq, int) =

  | {G:seq} {A:form} {i:two} INone (A, i, more (G, A, i), 0)

  | {G:seq} {A,A':form} {k,i,i':nat | i < 2; i' < 2}
      INshi (A, i, more (G, A', i'), k+1) of IN (A, i, G, k)

propdef IN0 (A:form,i:int,G:seq) = [k:nat] IN (A, i, G, k)

dataprop COMB (seq, seq, seq, int) =

  | COMBnone (none, none, none, 0)

  | {G1,G2,G3:seq} {A:form} {n,i1,i2:nat | i1+i2 < 2}
      COMBmore (more (G1, A, i1), more (G2, A, i2), more (G3, A, i1+i2), n+1) of
        COMB (G1, G2, G3, n)

propdef COMB0 (G1:seq, G2:seq, G3:seq) = [n:nat] COMB (G1, G2, G3, n)

dataprop ADD (seq, form, seq, int) =

  | {G:seq} {A:form} ADDone (more (G, A, 0), A, more (G, A, 1), 0)

  | {G,G':seq} {A,A':form} {k,i:nat | i < 2}
    ADDshi (more (G, A', i), A, more (G', A', i), k+1) of ADD (G, A, G', k)

propdef ADD0 (G:seq, A:form, G':seq) = [k:nat] ADD (G, A, G', k)

dataprop DER (seq, form, int) =

  | {G:seq} {A:form} DERaxi (G, A, 0) of (SEQ0 (G, 1), IN0 (A, 1, G))

  | {G:seq} {A:form} {n:nat} DERleft (G, A, n+1) of DERL (G, A, n)

  | {G:seq} {A:form} {n:nat} DERright (G, A, n+1) of DERR (G, A, n)

and DERL (seq, form, int) =

  | {G1,G2:seq} {A1,A2,A3:form} {n:nat}
      DERLtimes (G2, A3, n+1) of
        (DER (more (more (G1, A1, 1), A2, 1), A3, n), 
              ADD0 (G1, ltimes (A1, A2), G2))

  | {G1,G2:seq} {A1,A2,A3:form} {n:nat}
      DERLand1 (G2, A3, n+1) of
        (DER (more (G1, A1, 1), A3, n), ADD0 (G1, land (A1, A2), G2))

  | {G1,G2:seq} {A1,A2,A3:form} {n:nat}
      DERLand2 (G2, A3, n+1) of
        (DER (more (G1, A2, 1), A3, n), ADD0 (G1, land (A1, A2), G2))

  | {G1,G2:seq} {A1,A2,A3:form} {n1,n2:nat}
      DERLor (G2, A3, n1+n2+1) of
        (DER (more (G1, A1, 1), A3, n1), DER (more (G1, A2, 1), A3, n2), 
         ADD0 (G1, lor (A1, A2), G2))

  | {G1,G2,G3,G4:seq} {A1,A2,A3:form} {n1,n2:nat}
      DERLimp (G4, A3, n1+n2+1) of
        (DER (G1, A1, n1), DER (more (G2, A2, 1), A3, n2),
         COMB0 (G1, G2, G3), ADD0 (G3, limp (A1, A2), G4))

and DERR (seq, form, int) =

  | {G1,G2,G3:seq} {A1,A2:form} {n1,n2:nat}
      DERRand1 (G3, ltimes (A1, A2), n1+n2+1) of
        (DER (G1, A1, n1), DER (G2, A2, n2), COMB0 (G1, G2, G3))
  
  | {G:seq} {A1,A2:form} {n1,n2:nat}
      DERRand2 (G, land (A1, A2), n1+n2+1) of
        (DER (G, A1, n1), DER (G, A2, n2))

  | {G:seq} {A1,A2:form} {n:nat}
      DERRor1 (G, lor (A1, A2), n+1) of DER (G, A1, n)

  | {G:seq} {A1,A2:form} {n:nat}
      DERRor2 (G, lor (A1, A2), n+1) of DER (G, A2, n)

  | {G:seq} {A1,A2:form} {n:nat}
      DERRimp (G, limp (A1, A2), n+1) of DER (more (G, A1, 1), A2, n)

propdef DER0 (G:seq, A:form) = [n:nat] DER(G, A, n)

//

dataprop EXCH (seq, seq, int) =

  | {G:seq} {A1,A2:form} {i1,i2:two} 
    EXCHone (more (more (G, A1, i1), A2, i2), more (more (G, A2, i2), A1, i1), 0)

  | {G1,G2:seq} {A:form} {n,i:nat | i < 2}
    EXCHshi (more (G1, A, i), more (G2, A, i), n+1) of EXCH (G1, G2, n)

propdef EXCH0 (G1:seq, G2:seq) = [n:nat] EXCH (G1, G2, n)

//

prfun lemma01 {G:seq} {A:form} {n,w,k,i:nat | i < 2} .<k>.
  (g: SEQ (G, n, w), i: IN (A, i, G, k)): [n >= k; w >= i] void =
  case+ i of
    | INone () => let prval SEQmore g' = g in () end
    | INshi i' => let
         prval SEQmore g' = g
         prval () = lemma01 (g', i')
      in
         ()
      end

//

prfun lemma02 {G,G':seq} {n,w:nat} .<n>.
  (g: SEQ (G, n, w), ex: EXCH0 (G, G')): [n >= 2] void =
  case+ ex of
    | EXCHone () => let prval SEQmore (SEQmore g') = g in () end
    | EXCHshi ex' => let
         prval SEQmore g' = g
         prval () = lemma02 (g', ex')
      in
         ()
      end

//

prfun lemma03 {G1,G2,G3,G3':seq} {n:nat} .<n>.
  (c: COMB (G1, G2, G3, n), ex: EXCH0 (G3, G3')): [n >= 2] void = 
  case+ ex of
    | EXCHone () => let prval COMBmore (COMBmore c') = c in () end
    | EXCHshi ex' => let
         prval COMBmore c' = c
         prval () = lemma03 (c', ex')
      in
         ()
      end

// [COMB] is functional

prfun lemma10 {G1,G2,G12,G21:seq} {n1,n2:nat} .<n1>.
  (c12: COMB (G1, G2, G12, n1), c21: COMB (G2, G1, G21, n2))
  : [n1 == n2] SEQeq (G12, G21) =
  case+ (c12, c21) of
    | (COMBnone (), COMBnone ()) => SEQeq
    | (COMBmore c12, COMBmore c21) =>
      let prval SEQeq () = lemma10 (c12, c21) in SEQeq end

// [COMB] is commutative

prfun lemma11 {G1,G2,G3:seq} {n:nat} .<n>.
  (c: COMB (G1, G2, G3, n)): COMB (G2, G1, G3, n) =
  case+ c of
    | COMBnone () => COMBnone
    | COMBmore c' => COMBmore (lemma11 c')

// [COMB] is associative

prfun lemma12 {G1,G2,G12,G3,G123:seq} {n:nat} .<n>.
  (c12: COMB (G1, G2, G12, n), c123: COMB0 (G12, G3, G123))
  : [G23:seq] (COMB0 (G2, G3, G23), COMB0 (G1, G23, G123)) = 
  case+ (c12, c123) of
    | (COMBnone (), COMBnone ()) => (COMBnone, COMBnone)

    | (COMBmore (c1), COMBmore (c2)) => 
      let
         prval (pf1, pf2) = lemma12 (c1, c2)
      in
	 (COMBmore (pf1), COMBmore (pf2))
      end

prfn lemma13 {G1,G2,G3,G21,G22:seq}
  (c1: COMB0 (G1, G2, G3), c2: COMB0 (G21, G22, G2))
  : [G:seq] (COMB0 (G1, G22, G), COMB0 (G21, G, G3)) = let 
     prval (c3, c4) = lemma12 (c2, lemma11 c1) 
  in
     (lemma11 c3, c4)
  end

prfn lemma14 {G1,G2,G3,G21,G22:seq}
  (c1: COMB0 (G1, G2, G3), c2: COMB0 (G21, G22, G2))
  : [G:seq] (COMB0 (G1, G21, G), COMB0 (G, G22, G3)) = let 
     prval (c3, c4) = lemma13 (c1, lemma11 c2) 
  in
     (c3, lemma11 c4)
  end

prfn lemma15 {G1,G2,G3,G21,G22:seq}
  (c1: COMB0 (G1, G2, G3), c2: COMB0 (G21, G22, G2))
  : [G:seq] (COMB0 (G21, G1, G), COMB0 (G, G22, G3)) = let 
     prval (c3, c4) = lemma14 (c1, c2) 
  in
     (lemma11 c3, c4)
  end

//

prfun lemma20 {G1,G2,G3:seq} {m:nat} .<m>.
  (c: COMB0 (G1, G2, G3), g: SEQ (G2, m, 0)): SEQeq (G1, G3) =
  case+ (c, g) of
  | (COMBnone (), SEQnone ()) => SEQeq
  | (COMBmore c', SEQmore g') => let
      prval SEQeq () = lemma20 (c', g')
    in
      SEQeq ()
    end

prfun lemma21 {G1,G2,G3:seq} {m:nat} .<m>.
  (c: COMB0 (G1, G2, G3), g: SEQ (G1, m, 0)): SEQeq (G2, G3) =
  lemma20 (lemma11 c, g)

//

prfun lemma30 {G1,G2:seq} {n,w:nat} .<n>.
  (g: SEQ (G1, n, w), ex: EXCH0 (G1, G2)) : SEQ (G2, n, w) =
  case+ g of
  | SEQnone () =/=> let prval () = lemma02 (g, ex) in () end 
  | SEQmore (SEQnone ()) =/=> let prval () = lemma02 (g, ex) in () end
  | SEQmore (SEQmore g') => begin case+ ex of
    | EXCHone () =>  SEQmore (SEQmore g')
    | EXCHshi ex' => SEQmore (lemma30 (SEQmore g', ex'))
    end

//

prfun lemma31 {G1,G2:seq} {A:form} {k:nat} .<k>.
  (i: IN (A, 1, G1, k), ex: EXCH0 (G1, G2)): IN0 (A, 1, G2) =
  case+ i of
  | INone () => begin case+ ex of
    | EXCHone () => INshi INone | EXCHshi ex' => INone
    end
  | INshi i' => begin case+ ex of
    | EXCHone () => begin case+ i' of
      | INone () => INone | INshi i1 => INshi (INshi i1)
      end
    | EXCHshi ex' => INshi (lemma31 (i', ex'))
  end

//

prfun lemma32 {G1,G2,G1',G2':seq} {A:form} {n:nat} .<n>.
  (add: ADD0 (G1', A, G1), ex: EXCH (G1, G2, n))
  : [G2':seq] (EXCH (G1', G2', n), ADD0 (G2', A, G2)) =
  case+ (ex, add) of
  | (EXCHone (), ADDone ()) => (EXCHone, ADDshi ADDone)
  | (EXCHone (), ADDshi (ADDone ())) => (EXCHone, ADDone)
  | (EXCHone (), ADDshi (ADDshi add')) => 
      (EXCHone, ADDshi (ADDshi add'))	
  | (EXCHshi ex', ADDone ()) => (EXCHshi ex', ADDone)
  | (EXCHshi ex', ADDshi add') => let
      prval (ex1, add1) = lemma32 (add', ex')
    in
      (EXCHshi ex1, ADDshi add1)
    end 

//

prfun lemma33 {G1,G2,G3,G3':seq} {n:nat} .<n>.
  (c: COMB (G1, G2, G3, n), ex: EXCH0 (G3, G3'))
  : [G1',G2':seq] 
      (EXCH0 (G1, G1'), EXCH0 (G2, G2'), COMB (G1', G2', G3', n)) =
  case+ c of
  | COMBnone () =/=> let prval () = lemma03 (c, ex) in () end
  | COMBmore (COMBnone ()) =/=> let prval () = lemma03 (c, ex) in () end
  | COMBmore (COMBmore c') => begin case+ ex of
    | EXCHone () => (EXCHone, EXCHone, COMBmore (COMBmore c'))
    | EXCHshi ex' => let
        prval (ex1, ex2, c1) = lemma33 (COMBmore c', ex')
      in
        (EXCHshi ex1, EXCHshi ex2, COMBmore c1)
       end
    end

//

prfun exchGeneral {G1,G2:seq} {A:form} {n:nat} .<n>.
     (d: DER (G1, A, n), ex: EXCH0 (G1, G2)) : DER (G2, A, n) =
  case+ d of
  | DERaxi (g, i) => DERaxi (lemma30 (g, ex), lemma31 (i, ex))
  | DERleft (DERLtimes (d1, add)) => let
      prval (ex1, add1) = lemma32 (add, ex)
      prval d1' = exchGeneral (d1, EXCHshi (EXCHshi ex1))
    in
      DERleft (DERLtimes (d1', add1))
    end
     
  | DERleft (DERLand1 (d1, add)) => let
      prval (ex1, add1) = lemma32 (add, ex)
      prval d1' = exchGeneral (d1, EXCHshi ex1)
    in
      DERleft (DERLand1 (d1', add1))
    end
    
  | DERleft (DERLand2 (d1, add)) => let
      prval (ex1, add1) = lemma32 (add, ex)
      prval d1' = exchGeneral (d1, EXCHshi ex1)
    in
      DERleft (DERLand2 (d1', add1))
    end

  | DERleft (DERLor (d1, d2, add)) => let
      prval (ex1, add1) = lemma32 (add, ex)
      prval d1' = exchGeneral (d1, EXCHshi ex1)
      prval d2' = exchGeneral (d2, EXCHshi ex1)
    in
      DERleft (DERLor (d1', d2', add1))
    end

  | DERleft (DERLimp (d1, d2, c, add)) => let
      prval (ex1, add1) = lemma32 (add, ex) 
      prval (ex11, ex21, c1) = lemma33 (c, ex1)
      prval d1' = exchGeneral (d1, ex11)
      prval d2' = exchGeneral (d2, EXCHshi ex21)
    in
      DERleft (DERLimp (d1', d2', c1, add1))
    end

  | DERright (DERRand1 (d1, d2, c)) => let
      prval (ex1, ex2, c1) = lemma33 (c, ex)
      prval d1' = exchGeneral (d1, ex1)
      prval d2' = exchGeneral (d2, ex2)
    in
      DERright (DERRand1 (d1', d2', c1))
    end

  | DERright (DERRand2 (d1, d2)) => let
      prval d1' = exchGeneral (d1, ex)
      prval d2' = exchGeneral (d2, ex)
    in
      DERright (DERRand2 (d1', d2'))
    end

  | DERright (DERRor1 d1) => let
      prval d1' = exchGeneral (d1, ex)
    in
      DERright (DERRor1 d1')
    end

  | DERright (DERRor2 d1) => let
      prval d1' = exchGeneral (d1, ex)
    in
      DERright (DERRor2 d1')
    end

  | DERright (DERRimp d1) => let
      prval d1' = exchGeneral (d1, EXCHshi ex)
    in 
      DERright (DERRimp d1')
    end

//

prfn exch {G:seq} {A1,A2,A3:form} {n,i1,i2:nat | i1 < 2; i2 < 2}
  (d: DER (more (more (G, A1, i1), A2, i2), A3, n))
  : DER (more (more (G, A2, i2), A1, i1), A3, n) =
  exchGeneral (d, EXCHone)

//

prfun thin {G:seq} {A,A':form} {n:nat} .<n>.
  (d: DER (G, A, n)) : DER (more (G, A', 0), A, n) = 
  case+ d of
  | DERaxi (g, i) => DERaxi (SEQmore g, INshi i)

  | DERleft (DERLtimes (d1, add)) => let
      prval d1' = exchGeneral (exch (thin d1), EXCHshi EXCHone)
      prval add' = ADDshi add
    in
      DERleft (DERLtimes (d1', add'))
    end

  | DERleft (DERLand1 (d1, add)) => let
      prval d1' = exch (thin d1)
      prval add' = ADDshi add
    in
      DERleft (DERLand1 (d1', add'))
    end
  
  | DERleft (DERLand2 (d1, add)) => let
      prval d1' = exch (thin d1)
      prval add' = ADDshi add
    in
      DERleft (DERLand2 (d1', add'))
    end

  | DERleft (DERLor (d1, d2, add)) => let
      prval d1' = exch (thin d1)
      prval d2' = exch (thin d2)
      prval add' = ADDshi add
    in
      DERleft (DERLor (d1', d2', add'))
    end

  | DERleft (DERLimp (d1, d2, c, add)) => let
      prval d1' = thin d1
      prval d2' = exch (thin d2) 
      prval c' = COMBmore c
      prval add' = ADDshi add 
    in
      DERleft (DERLimp (d1', d2', c', add'))
    end

  | DERright (DERRand1 (d1, d2, c)) => 
      DERright (DERRand1 (thin d1, thin d2, COMBmore c))

  | DERright (DERRand2 (d1, d2)) => DERright (DERRand2 (thin d1, thin d2))

  | DERright (DERRor1 d1) => DERright (DERRor1 (thin d1))

  | DERright (DERRor2 d1) => DERright (DERRor2 (thin d1))

  | DERright (DERRimp d1) => DERright (DERRimp (exch (thin d1)))

//

prfun thick {G:seq} {A,A1:form} {n:nat} .<n>. 
  (d: DER (more (G, A1, 0), A, n)) : DER (G, A, n) = begin
  case+ d of
  | DERaxi (g, i) => let
      prval SEQmore g' = g and INshi i' = i
    in
      DERaxi (g', i')
    end

  | DERleft (DERLtimes (d1, add)) => let
      prval ADDshi add' = add	
      prval d1' = thick (exch (exchGeneral (d1, EXCHshi EXCHone)))
    in
      DERleft (DERLtimes (d1', add'))
    end
 
  | DERleft (DERLand1 (d1, add)) => let
      prval ADDshi add' = add
      prval d1' = thick (exch d1)
    in
      DERleft (DERLand1 (d1', add'))
    end  

  | DERleft (DERLand2 (d1, add)) => let
      prval ADDshi add' = add
      prval d1' = thick (exch d1)
    in
      DERleft (DERLand2 (d1', add'))
    end

  | DERleft (DERLor (d1, d2, add)) => let
      prval ADDshi add' = add
      prval d1' = thick (exch d1)
      prval d2' = thick (exch d2)
    in
      DERleft (DERLor (d1', d2', add'))
    end

  | DERleft (DERLimp (d1, d2, c, add)) => let
      prval ADDshi add' = add
      prval COMBmore c' = c 
      prval d1' = thick d1
      prval d2' = thick (exch d2)
    in 
      DERleft (DERLimp (d1', d2', c', add')) 
    end

  | DERright (DERRand1 (d1, d2, c)) => let
      prval COMBmore c' = c
      prval d1' = thick d1
      prval d2' = thick d2 
    in
      DERright (DERRand1 (d1', d2', c'))
    end
    
 | DERright (DERRand2 (d1, d2)) => DERright (DERRand2 (thick d1, thick d2))
 | DERright (DERRor1 d1) => DERright (DERRor1 (thick d1))
 | DERright (DERRor2 d1) => DERright (DERRor2 (thick d1))
 | DERright (DERRimp d') => DERright (DERRimp (thick (exch d')))
end // end of [thick]

//

prfun lemma40 {G1,G2,G3,G21:seq} {A:form} {n:nat} .<n>.
  (c: COMB (G1, G2, G3, n), add: ADD0 (G21, A, G2))
  : [G4:seq] (COMB (G1, G21, G4, n), ADD0 (G4, A, G3)) = begin
  case+ add of
  | ADDone () => let 
      prval COMBmore c' = c 
    in 
      (COMBmore c', ADDone)
    end
     
  | ADDshi add' => let
      prval COMBmore c' = c
      prval (c1, add1) = lemma40 (c', add')
    in
      (COMBmore c1, ADDshi add1)
    end 
end // end of [lemma40]

//

prfun lemma41
  {G11,G22,G33,G1,G2,G3:seq} {A1,A2:form} {n:nat} .<n>.
  (c1: COMB0 (G11, G22, G33), add: ADD (G33, limp (A1, A2), G1, n), c2: COMB0 (G1, G2, G3))
  : [Gtmp1,Gtmp2:seq] 
      (COMB0 (G22, G2, Gtmp1), COMB0 (G11, Gtmp1, Gtmp2), ADD0 (Gtmp2, limp (A1, A2), G3)) =   
  case+ add of
  | ADDone () => let
      prval COMBmore c1' = c1
      prval COMBmore c2' = c2
      prval (c3, c4) = lemma12 (c1', c2')
    in
      (COMBmore c3, COMBmore c4, ADDone)
    end

  | ADDshi add' => let
      prval COMBmore c1' = c1
      prval COMBmore c2' = c2
      prval (c3, c4, add1) = lemma41 (c1', add', c2')
    in
      (COMBmore c3, COMBmore c4, ADDshi add1)
    end

prfun lemma42 {G1,G2,G3:seq} {A:form} {k:nat} .<k>.
  (i: IN (A, 1, G1, k), g: SEQ0 (G1, 1), c: COMB0 (G1, G2, G3))
  : ADD (G2, A, G3, k) = begin case+ i of
  | INone () => let
      prval SEQmore g' = g
      prval COMBmore c' = c
      prval SEQeq () = lemma21 (c', g')
    in
      ADDone
    end
   
  | INshi i' => let
      prval SEQmore g' = g
      prval () = lemma01 (g', i')
      prval COMBmore c' = c
      prval i1 = lemma42 (i', g', c')
    in
      ADDshi i1
    end
end // end of [lemma42]

prfun lemma43 {G1,G2,G3,G11:seq} {A:form} {n:nat} .<n>.
  (c: COMB (G1, G2, G3, n), add: ADD0 (G11, A, G1))
  : [G4:seq] (COMB (G11, G2, G4, n), ADD0 (G4, A, G3)) = let
  prval (c1, add1) = lemma40 (lemma11 c, add)
in
  (lemma11 c1, add1)
end // end of [lemma43]

(***** cut elimination in intuitionistic linear logic *****)

prfun cut
  {G1,G2,G3:seq} {A1,A2:form} {m,n1,n2:nat} .<m, n2, n1>. (
    a: FM (A1, m)
  , d1: DER (G1, A1, n1)
  , d2: DER (more (G2, A1, 1), A2, n2)
  , c: COMB0 (G1, G2, G3)
  ) : DER0 (G3, A2) = begin case+ d2 of
  | DERaxi (g, i) => let
      prval SEQmore g' = g
      prval SEQeq () = lemma20 (c, g')
    in
      case+ i of
      | INone () => d1
      | INshi i' =/=> let prval () = lemma01 (g', i') in () end
    end

  | DERleft (DERLtimes (d21, add2)) => begin case+ add2 of
    | ADDone () => begin case+ d1 of
      | DERaxi (g, i) => let
          prval d = exchGeneral (d21, EXCHshi EXCHone)
          prval d21' = thick (exch d)
          prval add2' = lemma42 (i, g, c)
        in
          DERleft (DERLtimes (d21', add2'))
        end

      | DERleft d1 => cutAux (a, d1, d2, c)

      | DERright (DERRand1 (d11, d12, c1)) => let
          prval (c2, c3) = lemma12 (c1, c)
          prval FMand1 (a1, a2) = a
          prval d = exch (exchGeneral (d21, EXCHshi EXCHone))
          prval d21' = thick d
          prval d12' = thin d12
          prval d3 = cut (a2, d12', d21', COMBmore c2) 
        in
          cut (a1, d11, d3, c3)
        end
      end
    | ADDshi add2' => let
        prval d1' = thin (thin d1)
        prval d21' = exch (exchGeneral (d21, EXCHshi EXCHone))
        prval (c3, add3) = lemma40 (c, add2')
        prval d3 = cut (a, d1', d21', COMBmore (COMBmore c3))
      in
        DERleft (DERLtimes (d3, add3))
      end
    end

  | DERleft (DERLand1 (d21, add2)) => begin case+ add2 of
    | ADDone () => begin case+ d1 of
      | DERaxi (g, i) => let
          prval d21' = thick (exch d21)
          prval add2' = lemma42 (i, g, c)
        in
          DERleft (DERLand1 (d21', add2'))
        end

      | DERleft d1 => cutAux (a, d1, d2, c)

      | DERright (DERRand2 (d11, d12)) => let
          prval d21' = thick (exch d21)
          prval FMand2 (a1, a2) = a
        in
          cut (a1, d11, d21', c)
        end
      end

    | ADDshi add2' => let
        prval d1' = thin d1
        prval d21' = exch d21
        prval (c2, add3) = lemma40 (c, add2')
        prval d3 = cut (a, d1', d21', COMBmore c2)
      in
        DERleft (DERLand1 (d3, add3))
      end
    end

  | DERleft (DERLand2 (d21, add2)) => begin case+ add2 of
    | ADDone () => begin case+ d1 of
      | DERaxi (g, i) => let
          prval d21' = thick (exch d21)
          prval add2' = lemma42 (i, g, c)
        in
          DERleft (DERLand2 (d21', add2'))
        end

      | DERleft d1 => cutAux (a, d1, d2, c)

      | DERright (DERRand2 (d11, d12)) => let
          prval d21' = thick (exch d21)
          prval FMand2 (a1, a2) = a
        in
          cut (a2, d12, d21', c)
        end
      end

    | ADDshi add2' => let
        prval d1' = thin d1
        prval d21' = exch d21
        prval (c2, add3) = lemma40 (c, add2')
        prval d3 = cut (a, d1', d21', COMBmore c2)
      in
        DERleft (DERLand2 (d3, add3))
      end
    end

  | DERleft (DERLor (d21, d22, add2)) => begin case+ add2 of
    | ADDone () => begin case+ d1 of
      | DERaxi (g, i) => let
          prval d21' = thick (exch d21)
          prval d22' = thick (exch d22)
          prval add2' = lemma42 (i, g, c)
        in
          DERleft (DERLor (d21', d22', add2'))
        end

      | DERleft d1 => cutAux (a, d1, d2, c)

      | DERright (DERRor1 d11) => let
          prval d21' = thick (exch d21)
          prval FMor (a1, a2) = a
        in
          cut (a1, d11, d21', c)
        end

      | DERright (DERRor2 d11) => let
          prval d22' = thick (exch d22)
          prval FMor (a1, a2) = a
        in
          cut (a2, d11, d22', c)
        end
      end

    | ADDshi add2' => let
        prval (c2, add3) = lemma40 (c, add2')
        prval d11' = thin d1 
        prval d21' = cut (a, d11', exch d21, COMBmore c2)
        prval d12' = thin d1
        prval d22' = cut (a, d12', exch d22, COMBmore c2)
      in
        DERleft (DERLor (d21', d22', add3))
      end
    end

  | DERleft (DERLimp (d21, d22, c2, add2)) => begin case+ add2 of
    | ADDone () => begin case+ d1 of
      | DERaxi (g, i) => let
          prval COMBmore c2' = c2
          prval d21' = thick d21
          prval d22' = thick (exch d22)
          prval add3 = lemma42 (i, g, c)
        in
          DERleft (DERLimp (d21', d22', c2', add3))
        end

      | DERleft d1 => cutAux (a, d1, d2, c) 
                  
      | DERright (DERRimp d1') => let
          prval COMBmore c2' = c2
          prval (c3, c4) = lemma15 (c, c2')
          prval FMimp (a1, a2) = a
          prval d3 = cut (a1, thick d21, d1', c3) 
        in
          cut (a2, d3, thick (exch d22), c4)
        end
      end

    | ADDshi add2' => let
        prval COMBmore {..} {..} {_n,i1,_i2} c2' = c2
      in
        sif (i1 == 0) then let
          prval d1' = thin d1
          prval d22' = exch d22
          prval (c3, add3) = lemma40 (c, add2')
          prval (c4, c5) = lemma13 (c3, c2')	            
          prval d3 = cut (a, d1', d22', COMBmore c4)
          prval d21' = thick d21
        in 
          DERleft (DERLimp (d21', d3, c5, add3))
        end else let
          prval (c3, add3) = lemma40 (c, add2')
          prval (c4, c5) = lemma14 (c3, c2')
          prval d3 = cut (a, d1, d21, c4)
          prval d22' = thick (exch d22)
        in
          DERleft (DERLimp (d3, d22', c5, add3))
        end
      end
    end

  | DERright (DERRand1 (d21, d22, c2)) => let
      prval COMBmore {..} {..} {_n,i1,_i2} c2' = c2
    in
      sif (i1 == 0) then let
        prval (c3, c4) = lemma13 (c, c2')
        prval d3 = cut (a, d1, d22, c3)
      in
        DERright (DERRand1 (thick d21, d3, c4))
      end else let
        prval (c3, c4) = lemma14 (c, c2')
        prval d3 = cut (a, d1, d21, c3)
      in
        DERright (DERRand1 (d3, thick d22, c4))
      end
    end

  | DERright (DERRand2 (d21, d22)) => let
      prval d21' = cut (a, d1, d21, c)
      prval d22' = cut (a, d1, d22, c)
    in
      DERright (DERRand2 (d21', d22'))
    end

  | DERright (DERRor1 d21) =>
      DERright (DERRor1 (cut (a, d1, d21, c)))

  | DERright (DERRor2 d22) =>
      DERright (DERRor2 (cut (a, d1, d22, c))) 

  | DERright (DERRimp d2') => let
      prval d1' = thin d1 and d3 = exch d2'
    in 
      DERright (DERRimp (cut (a, d1', d3, COMBmore c)))
    end
end // end of [cut]

and cutAux
  {G1,G2,G3:seq} {A1,A2:form} {m,n1,n2:nat} .<m, n2, n1>. (
    a: FM (A1, m)
  , d1: DERL (G1, A1, n1)
  , d2: DER (more (G2, A1, 1), A2, n2)
  , c: COMB0 (G1, G2, G3)
  ) : DER0 (G3, A2) = begin case+ d1 of
  | DERLtimes (d1', add) => let
      prval (c1, add1) = lemma43 (c, add)
      prval d2' = exch (thin (exch (thin d2)))
      prval d = cut (a, d1', d2', COMBmore (COMBmore c1))  
    in
      DERleft (DERLtimes (d, add1)) 
    end

  | DERLand1 (d1', add) => let
      prval (c1, add1) = lemma43 (c, add)
      prval d2' = exch (thin d2)
      prval d = cut (a, d1', d2', COMBmore c1)
    in
      DERleft (DERLand1 (d, add1))
    end

  | DERLand2 (d1', add) => let
      prval (c1, add1) = lemma43 (c, add)
      prval d2' = exch (thin d2)
      prval d = cut (a, d1', d2', COMBmore c1)
    in
      DERleft (DERLand2 (d, add1))
    end

  | DERLor (d11, d12, add) => let
      prval (c1, add1) = lemma43 (c, add)
      prval d21' = exch (thin d2)
      prval d11' = cut (a, d11, d21', COMBmore c1)
      prval d22' = exch (thin d2)
      prval d12' = cut (a, d12, d22', COMBmore c1)
    in
      DERleft (DERLor (d11', d12', add1))
    end

  | DERLimp (d11, d12, c1, add1) => let
      prval (c3, c4, add3) = lemma41 (c1, add1, c)
      prval d2' = exch (thin d2)
      prval d3 = cut (a, d12, d2', COMBmore c3)
    in
      DERleft (DERLimp (d11, d3, c4, add3))
    end
end // end of [cutAux]

(* ****** ****** *)

(* end of [CutElimILL.dats] *)
