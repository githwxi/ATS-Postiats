(*
//
// The simply typed lambda calculus (STLC) is strongly-normalizing
// This formalization uses first-order abstract syntax for lambda-terms.
// There are several unproven lemmas, which can certainly be finished
// but require significant effort that is uninspiring and tedious.
//
*)

(* ****** ****** *)
//
// April 2006:
// The code is written by Kevin Donnelly and Hongwei Xi.
//
// January 2007:
// The code is ported to ATS/Geizella by Hongwei Xi
//
// March 3rd, 2008
// The code is ported to ATS/Anairiats by Hongwei Xi
//
// June 13th, 2012
// The code is ported to ATS/Postiats by Hongwei Xi
//
(* ****** ****** *)

datasort tm =
  | tmvar of int
  | tmlam of tm
  | tmapp of (tm, tm)
// end of [tm]

dataprop
ISE (tm) = {t1:tm} {t2:tm} ISE (tmapp (t1, t2))

dataprop
tmshi (tm, tm, int) =
  | {i,l:nat | i < l}
    TMSHIvarlt (tmvar i, tmvar i, l)
  | {i,l:nat | i >= l}
    TMSHIvargte (tmvar i, tmvar (i+1), l)
  | {t,t':tm} {l:nat}
    TMSHIlam (
      tmlam t, tmlam t', l
    ) of tmshi (t, t', l+1)
  | {t1,t2,t1',t2':tm} {l:nat}
    TMSHIapp (
      tmapp (t1, t2), tmapp (t1', t2'), l
    ) of (tmshi (t1, t1', l), tmshi (t2, t2', l))
// end of [tmshi]

datasort tms = tmsnil | tmsmore of (tms, tm)

dataprop
subshi (tms, tms) =
  | SUBSHInil (tmsnil, tmsnil)
  | {ts,ts':tms} {t,t':tm}
    SUBSHImore (
      tmsmore (ts, t), tmsmore (ts', t')
    ) of (subshi (ts, ts'), tmshi (t, t', 0))
// end of [subshi]

dataprop
TMI (int, tm, tms) =
  | {ts:tms} {t:tm}
    TMIone (0, t, tmsmore (ts, t))
  | {ts:tms} {t,t':tm} {i:int | i > 0}
    TMIshi (i, t, tmsmore (ts, t')) of TMI (i-1, t, ts)
// end of [TMI]

dataprop
subst (tms, tm, tm) =
  | {ts:tms} {t:tm} {i:nat}
    SUBvar (ts, tmvar i, t) of TMI (i, t, ts)
  | {ts,ts':tms} {t,t':tm}
    SUBlam (ts, tmlam t, tmlam t') of
      (subshi (ts, ts'), subst (tmsmore (ts', tmvar 0), t, t'))
  | {ts:tms} {t1,t2,t1',t2':tm}
    SUBapp (
      ts, tmapp (t1, t2), tmapp (t1', t2')
    ) of (subst (ts, t1, t1'), subst (ts, t2, t2'))
propdef subst1
  (t1:tm, t2:tm, t3:tm) = subst (tmsmore (tmsnil, t1), t2, t3)
// end of [subst1]

(* ****** ****** *)

datasort tp = tpbas | tpfun of (tp, tp)

datasort tps = tpsnil | tpsmore of (tps, tp)

dataprop TP (tp, int) = 
  | TPbas (tpbas, 0)
  | {T1,T2:tp} {n1,n2:nat}
    TPfun (tpfun (T1, T2), n1+n2+1) of (TP (T1, n1), TP (T2, n2))
propdef TP0 (T:tp) = [n:nat] TP (T, n)

dataprop
TPI (int, tp, tps) =
  | {G:tps} {T:tp} TPIone (0, T, tpsmore (G, T))
  | {G:tps} {T,T':tp} {i:int | i > 0}
    TPIshi (i, T, tpsmore (G, T')) of TPI (i-1, T, G)
// end of [TPI]

dataprop
DER (tps, tm, tp, int) =
  | {G:tps} {T:tp} {i:nat}
    DERvar (G, tmvar i, T, 0) of TPI (i, T, G)
  | {G:tps} {T1,T2:tp} {t:tm} {s:nat}
    DERlam (
      G, tmlam t, tpfun (T1, T2), s+1
    ) of DER (tpsmore (G, T1), t, T2, s)
  | {G:tps} {T1,T2:tp} {t1,t2:tm} {s1,s2:nat}
    DERapp (
      G, tmapp (t1, t2), T2, s1+s2+1
    ) of (DER (G, t1, tpfun (T1, T2), s1), DER (G, t2, T1, s2))
propdef DER0 (G:tps, t:tm, T:tp) = [s:nat] DER (G, t, T, s)

dataprop
INS (tps, tp, int, tps) =
  | {G:tps} {T:tp} INSone (G, T, 0, tpsmore (G, T))
  | {G1,G2:tps} {T,T':tp} {i:nat}
    INSshi (tpsmore (G1, T'), T, i+1, tpsmore (G2, T')) of INS (G1, T, i, G2)
// end of [INS]

dataprop
RED (tm, tm, int) =
  | {t,t':tm} {s:nat}
    REDlam (tmlam t, tmlam t', s+1) of RED (t, t', s)
  | {t1,t2,t1':tm} {s:nat}
    REDapp1 (tmapp (t1, t2), tmapp (t1', t2), s+1) of RED (t1, t1', s)
  | {t1,t2,t2':tm} {s:nat}
    REDapp2 (tmapp (t1, t2), tmapp (t1, t2'), s+1) of RED (t2, t2', s)
  | {t,v,t':tm} REDapp3 (tmapp (tmlam t, v), t', 0) of subst1 (v, t, t')
propdef RED0 (t:tm, t':tm) = [s:nat] RED (t, t', s)

(* ****** ****** *)

(*
** Strong Normalization
*)
dataprop SN (tm, int) =
  | {t:tm} {n:nat}
    SN (t, n) of {t':tm} (RED0 (t, t') -<fun> [n':nat | n' < n] SN (t', n'))
propdef SN0 (t:tm) = [n:nat] SN (t, n)

// SN is closed under reduction
prfn forwardSN {t,t':tm} {n:nat}
  (sn:SN(t, n), red:RED0(t, t')) : [n':nat | n' < n] SN(t', n') =
  let prval SN fsn = sn in fsn red end

extern prval backwardSN : {t:tm} ({t':tm} RED0 (t, t') -<fun> SN0 t') -<fun> SN0 t

(* ****** ****** *)

(*
** Reducibility
*)
dataprop
R (tm, tp) = 
  | {t:tm} Rbas(t, tpbas) of SN0 t
  | {t:tm} {T1,T2:tp}
    Rfun (t, tpfun (T1, T2)) of ({t1:tm} R (t1, T1) -<fun> R (tmapp (t, t1), T2))
// end of [R]

// sequence of redubility predicates for a substitution
dataprop
RS (tms, tps, int) =
  | RSnil (tmsnil, tpsnil, 0)
  | {ts:tms} {t:tm} {G:tps} {T:tp} {n:nat} 
    RSmore (tmsmore (ts, t), tpsmore(G, T), n+1) of (RS(ts, G, n), R(t, T))
// end of [RS]

propdef RS0(ts:tms, G:tps) = [n:nat] RS(ts, G, n)

(* ****** ****** *)
//
// definition of neutral terms
//
dataprop NEU(tm) =
  {i:int} NEUvar(tmvar i) | {t1,t2:tm} NEUapp(tmapp(t1, t2))
//
(* ****** ****** *)

extern prval lamSN :
  {t1,t2,t3:tm} {n:nat} (subst1 (t1, t2, t3), SN (t3, n)) -> SN (t2, n)

prfun appSN1
  {t1,t2:tm}
  {n:nat} .<n>. (
  sn: SN(tmapp (t1, t2), n)
) : SN0 t1 = let
  prval SN fsn = sn
  prfn fsn1 {t1':tm} (
    red: RED0 (t1, t1')
  ) : SN0 (t1') =
    appSN1 (fsn (REDapp1 (red)))
  // end of [fsn1]
in
   backwardSN (fsn1)
end // end of [appSN1]

(* CR 2 *)
// R is preserved by forward reduction
prfun cr2
  {t,t':tm}
  {T:tp}
  {n:nat} .<n>. (
  tp: TP (T, n), r: R(t, T), rd : RED0(t, t')
) : R(t', T) = begin
  case+ r of
  | Rbas sn => Rbas (forwardSN (sn, rd))
  | Rfun {..} {T1,T2} fr => let
      prval TPfun (_, tp2) = tp
    in
      Rfun (lam (r) =<> cr2 (tp2, fr r, REDapp1 rd))
    end
end // end of [cr2]

(* CR 1 *)
prfun cr1
  {t:tm}
  {T:tp}
  {n:nat} .<n, 0>. (
  tp: TP (T, n), pf: R(t, T)
) : SN0 t = begin
  case+ pf of
  | Rbas sn => sn
  | Rfun fr => let
      prval TPfun (tp1, tp2) = tp
    in
      appSN1 (cr1 (tp2, fr (cr4 tp1)))
    end // end of [Rfun]
end // end of [cr1]

(* CR4 *)
and cr4 {T:tp} {n:nat} .<n, 2>.
  (tp: TP (T, n)): R (tmvar 0, T) = let
//
prfn fr{t:tm}
  (red: RED0 (tmvar 0, t)): R (t, T) = case+ red of REDlam _ =/=> ()
//
in
  cr3 (NEUvar (), tp, fr)
end // end of [cr4]

(* CR 3*)
and cr3 {t:tm} {T:tp} {n:nat} .<n, 1>. (
    neu: NEU(t)
  , tp: TP(T, n)
  , fr : {t':tm} RED0(t, t') -<fun> R(t', T)
  ) : R(t, T) = let 
  prval fsn = lam {t':tm} => lam (red:RED0(t, t')) =<> cr1 (tp, fr red)
  prval sn = backwardSN fsn
in
  case+ tp of
  | TPbas() => Rbas sn
  | TPfun {T1,T2} {n1,n2} (tp1, tp2) => let
      prfn fr {t1:tm} (r1: R (t1, T1)): R (tmapp (t, t1), T2) =
        cr3a (tp1, tp2, neu, r1, cr1 (tp1, r1), fr)
    in
      Rfun fr
    end
end // end of [cr3]

and cr3a
  {t,t1:tm}
  {T1,T2:tp}
  {m,n1,n2:nat} .<n2, m+2>. (
  tp1: TP (T1, n1)
, tp2: TP (T2, n2)
, neu: NEU t, r1: R (t1, T1)
, sn1: SN (t1, m)
, f: {t':tm} RED0 (t, t') -<fun> R (t', tpfun (T1, T2))
) : R (tmapp (t, t1), T2) = let
  prfn ff {tt:tm}
    (rd: RED0 (tmapp (t, t1), tt)): R (tt, T2) =
    case+ rd of
    | REDapp1 rd => let
        prval Rfun fr = f rd in fr (r1)
      end // end of [REDapp1]
    | REDapp2 rd => let
        prval SN fsn1 = sn1 in
        cr3a (tp1, tp2, neu, cr2 (tp1, r1, rd), fsn1 rd, f)
      end // end of [REDapp2]
    | REDapp3 _ =/=> begin
        case+ neu of NEUvar() => () | NEUapp() => ()
      end // end of [REDapp3]
  // end of [ff]
in
  cr3  (NEUapp, tp2, ff)
end // end of [cr3a]

(* ****** ****** *)

prfun mainLemmaVar
  {G:tps} {T:tp}
  {ts:tms} {t:tm}
  {i:nat} .<i>. (
  tpi: TPI (i, T, G), tmi: TMI (i, t, ts), rs: RS0 (ts, G)
) : R (t, T) =
  case+ (tpi, tmi) of
  | (TPIone (), TMIone ())  =>
       let prval RSmore (_, r) = rs in r end
    // end of [TPIone, TPIone]
  | (TPIshi tpi, TMIshi tmi) =>
      let prval RSmore (rs, _) = rs in mainLemmaVar (tpi, tmi, rs) end
    // end of [TPIshi, TPIshi]
// end of [mainLemmaVar]

extern prval der2tp
  : {G:tps} {T:tp} {t:tm} DER0 (G, t, T) -<fun> TP0 T

extern prval lemma10 : {t:tm} subst (tmsnil, t, t)

extern prval lemma20
  : {ts,ts':tms} {t,t1,t',t'':tm} (
  subshi (ts, ts'), subst (tmsmore (ts', tmvar 0), t, t'), subst1 (t1, t', t'')
) -<fun> subst (tmsmore (ts, t1), t, t'')

extern
prval reduceFun : {f,t:tm} {T1,T2:tp} (
  TP0 T1
, TP0 T2
, R(t, T1)
, {t1,t2:tm} (subst1 (t1, f, t2), R(t1, T1)) -<fun> R(t2, T2)
) -<fun> R(tmapp (tmlam f, t), T2)

prfun
mainLemma
  {G:tps} {T:tp}
  {ts:tms} {t,t':tm}
  {n:nat} .<n+1, 0>. (
  der: DER (G, t, T, n), rs: RS0 (ts, G), sub: subst (ts, t, t')
) : R (t', T) = let
in
//
case+ der of
| DERvar tpi => let
    prval SUBvar tmi = sub
  in
    mainLemmaVar (tpi, tmi, rs)
  end // end of [DERvar]
| DERapp (der1, der2) => let
    prval SUBapp (sub1, sub2) = sub
    prval r1 = mainLemma (der1, rs, sub1)
    prval Rfun fr1 = r1
    prval r2 = mainLemma (der2, rs, sub2)
  in
    fr1 r2
  end // end of [DERapp]
| DERlam (der0) => let 
    prval TPfun
      {T1,T2}{s1,s2}(tp1, tp2) = der2tp (der)
    // end of [prval]
    prval SUBlam {..} {f,f'} (pf, sublam) = sub
    prfun fr {t:tm}
      {m:nat} .<n, m+1>. (
      r: R(t,T1), sn2: SN(t,m)
    ) : R(tmapp (tmlam f', t), T2) = let
      prfn gr {t1,t2:tm} (
        sub1: subst1 (t1, f', t2), r: R(t1,T1)
      ) : R(t2, T2) = let
        prval rs' = RSmore (rs, r)
        prval sub0 = lemma20 (pf, sublam, sub1)
        prval r' = mainLemma (der0, rs', sub0)
      in
        r'
      end // end of [prfun]
    in
      reduceFun(tp1, tp2, r, gr)
    end // end of [fr]
    prfn f {t:tm}
     (r: R(t,T1)): R (tmapp (tmlam f', t), T2) =
     fr(r, cr1 (tp1, r))
  in
    Rfun f
  end // end of [DERlam]
//
end // end of [mainLemma]

(* ****** ****** *)
//
// every typable term is reducible
//
prfn IsReducible
  {t:tm} {T:tp} (
  der: DER0 (tpsnil,t,T)
) : R (t,T) = mainLemma(der, RSnil(), lemma10)

(* ****** ****** *)
//
// the final payoff: every typable term is SN
//
prfn StrongNormalizing
  {t:tm} {T:tp}
  (der: DER0 (tpsnil,t,T)): SN0 t = cr1 (der2tp der, IsReducible der)
// end of [StrongNormalizing]

(* ****** ****** *)

(* end of [STLC-SN-foas.dats] *)
