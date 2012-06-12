//
//
// A typeful implementation of CPS transformation
//
//

(* ****** ****** *)

// December 2004
// The code is written by Hongwei Xi

// January 2007
// The code is ported to ATS/Geizella by Hongwei Xi

// March 3rd, 2007
// The code is ported to ATS/Anairiats by Hongwei Xi

(* ****** ****** *)
//
// June 12, 2012
// The code is ported to ATS2/Postiats by Hongwei Xi
// There is actually no change needed for this porting.
//
(* ****** ****** *)
//
// HX-2012-06:
// the style of this code reflects a bit history of ATS;
// please leave it so when porting it.
//
(* ****** ****** *)

infixr ->> ::

datasort ty = int | ->> of (ty, ty) | bot | cont of ty
datasort env = nil | :: of (ty, env)

datatype VAR (env, ty) =
  | {G:env} {t:ty} VARone (t :: G, t)
  | {G:env} {t1,t2:ty} VARshi (t2 :: G, t1) of VAR (G, t1)

//

fun nat_of_var {G:env} {t:ty} (x: VAR (G, t)): Nat =
  case+ x of VARone () => 1 | VARshi x => 1 + nat_of_var x

//

datatype EXP (env, ty) =
  | {G:env} {t:ty} EXPvar (G, t) of VAR (G, t)
  | {G:env} {t1,t2:ty} EXPlam (G, t1 ->> t2) of EXP (t1 :: G, t2)
  | {G:env} {t1,t2:ty} EXPapp (G, t2) of (EXP (G, t1 ->> t2), EXP (G, t1))
  | {G:env} {t1,t2:ty} EXPlet (G, t2) of (EXP (G, t1), EXP (t1 :: G, t2))
  | {G:env} {t:ty} EXPcal (G, t) of EXP (G, cont(t) ->> t)
  | {G:env} {t1,t2:ty} EXPthr (G, t2) of (EXP (G, cont t1), EXP (G, t1))

typedef EXP0 (t: ty) = EXP (nil, t)

//

dataprop RT1 (ty, ty, int) =
  | {t,t':ty} {n:nat} RT1 (t, (t' ->> bot) ->> bot, n+1) of RT2 (t, t', n)

and RT2 (ty, ty, int) =
  | RT2int (int(), int(), 0)
  | {t1,t2,t1',t2':ty} {n1,n2:nat}
      RT2fun (t1 ->> t2, t1' ->> t2',n1+n2+1) of (RT2(t1, t1',n1), RT1 (t2, t2',n2))
  | RT2bot (bot, bot, 0)
  | {t,t':ty} {n:nat} RT2cont(cont(t), t' ->> bot,n+1) of RT2 (t, t',n)

propdef RT10 (t1: ty, t2: ty) = [n:nat] RT1 (t1, t2, n)
propdef RT20 (t1: ty, t2: ty) = [n:nat] RT2 (t1, t2, n)

//

extern prval rt1fun: {t:ty} () -<> [t':ty] RT10 (t, t')
extern prval rt2fun: {t1:ty} () -<> [t2:ty] RT20 (t1, t2)

(*

prfun rt1fun {t:ty} .<t>. = RT1 (rt2fun {t})

and rt2fun {t:ty} .<t>. =
  scase t of
    | int => RT2int (int, int, 0)
    | t1 ->> t2 => RT2fun (rt2fun {t1}, rt1fun {t2})
    | bot -> RT2bot (bot, bot, 0)
    | cont t => RT2cont (rt2fun {t})

*)

dataprop TYEQ (ty, ty) = {t:ty} TYEQ (t, t)

//

prfun rt1eq {t,t1,t2:ty} {n1,n2:nat} .<n1>.
   (pf1: RT1 (t, t1, n1), pf2: RT1 (t, t2, n2))
  :<> TYEQ (t1, t2)  = begin case+ (pf1, pf2) of
    (RT1 pf1, RT1 pf2) => let prval TYEQ () = rt2eq (pf1, pf2) in TYEQ end
end // end of [rt1eq]

and rt2eq {t,t1,t2:ty} {n1,n2:nat} .<n1>.
   (pf1: RT2 (t, t1, n1), pf2: RT2 (t, t2, n2)):<> TYEQ (t1, t2) = begin
  case+ (pf1, pf2) of 
  | (RT2int (), RT2int ()) => TYEQ
  | (RT2fun (pf11, pf12), RT2fun (pf21, pf22)) => let
      prval TYEQ () = rt2eq (pf11, pf21) and TYEQ () = rt1eq (pf12, pf22)
    in
      TYEQ ()
    end
  | (RT2cont pf1, RT2cont pf2) => begin
      let prval TYEQ () = rt2eq (pf1, pf2) in TYEQ () end
    end
  | (RT2bot (), RT2bot ()) => TYEQ ()
end // end of [rt2eq]

//

datatype EXP' (env, ty) =
  | {G:env} {t:ty} EXPvar' (G, t) of VAR (G, t)
  | {G:env} {t1,t2:ty} EXPlam' (G, t1 ->> t2) of EXP' (t1 :: G, t2)
  | {G:env} {t1,t2:ty} EXPapp' (G, t2) of (EXP' (G, t1 ->> t2), EXP' (G, t1))
  | {G:env} {t1,t2:ty} EXPlet' (G, t2) of (EXP' (G, t1), EXP' (t1 :: G, t2))

typedef EXP0' (t:ty) = EXP' (nil, t)

typedef SUB (G1:env, G2:env) = {t:ty} VAR(G1,t) -> EXP' (G2,t)

//

extern
fun print_exp1 {G:env} {t:ty} (e0: EXP' (G, t)): void
overload print with print_exp1

implement print_exp1 e0 = begin case+ e0 of
  | EXPvar' x => let
      val n = nat_of_var x
    in
      print "EXPvar' ("; print n; print ")"
    end
  | EXPlam' e => begin
      print "EXPlam' ("; print e; print ")"
    end
  | EXPapp' (e1, e2) => begin
      print "EXPapp' ("; print e1; print ", "; print e2; print ")"
    end
  | EXPlet' (e1, e2) => begin
      print "EXPlet' ("; print e1; print ", "; print e2; print ")"
    end
end // end of [print_exp1]

//

val idSub = (lam x => EXPvar' x)
  : {G:env} SUB (G, G)

val shiSub = (lam x => EXPvar' (VARshi x))
  : {G:env} {t:ty} SUB (G, t :: G)

//

fun subst {G1,G2:env} {t:ty}
   (sub: SUB(G1,G2)) (e: EXP' (G1,t))
  : EXP' (G2,t) = begin case+ e of
  | EXPvar' x => sub (x)
  | EXPlam' e => EXPlam' (subst (subLam sub) e)
  | EXPapp' (e1, e2) => EXPapp' (subst sub e1, subst sub e2)
  | EXPlet' (e1, e2) => EXPlet' (subst sub e1, subst (subLam sub) e2)
end // end of [subst]

and subLam {G1,G2:env} {t:ty}
  (sub: SUB (G1,G2)): SUB (t::G1,t::G2) = begin
  lam x => case+ x of
    | VARone () => EXPvar' (VARone)
    | VARshi x' => subst (shiSub {..} {..}) (sub x')
end // end of [subLam]

//

fn EXPone1 {G:env} {t:ty} (): EXP' (t :: G, t) = EXPvar' (VARone)
fn EXPtwo1 {G:env} {t1,t2:ty} (): EXP' (t1 :: t2 :: G, t2) =
  EXPvar' (VARshi VARone)

//

fn expShi {G:env} {t1,t2:ty} (e: EXP' (G, t1)): EXP' (t2 :: G, t1) =
  subst (shiSub {..} {..}) e

//

typedef VM (G1: env, G2: env) =
  {t1:ty} VAR (G1, t1) -> [t2: ty] (RT20 (t1, t2) | VAR (G2, t2))

val vmNil =
  (lam x => case+ x of VARone _ =/=> () | VARshi _ =/=> ())
  : VM (nil, nil)

//

fn vmShi {G1,G2:env} {t:ty} (vm: VM (G1, G2)) =
  (lam x1 => let val (pf | x2) = vm x1 in (pf | VARshi x2) end)
  : VM (G1, t :: G2)

fn vmLam {G1,G2:env} {t1,t2:ty}
   (pf: RT20 (t1, t2) | vm: VM (G1, G2)): VM (t1 :: G1, t2 :: G2) =
  lam x1 => case+ x1 of
    | VARone () => (pf | VARone)
    | VARshi x1 => let val (pf | x2) = vm x1 in (pf | VARshi x2) end

//

fun cps {G1,G2:env} {t1,t2:ty}
   (pf: RT10 (t1, t2) | vm: VM (G1, G2), e: EXP (G1, t1)): EXP' (G2, t2) =
  let prval RT1 (pf) = pf in EXPlam' (cpsw (pf | vmShi vm, EXPone1 (), e)) end

and cpsw {G1,G2:env} {t1,t2:ty}
   (pf: RT20 (t1, t2) | vm: VM (G1, G2), k: EXP' (G2, t2 ->> bot), e: EXP (G1, t1))
  : EXP' (G2, bot) = begin case+ e of
  | EXPvar x1 => let
      val (pf' | x2) = vm x1
      prval TYEQ () = rt2eq (pf, pf')
    in
      EXPapp' (k, EXPvar' x2)
    end

  | EXPlam e => let
      prval RT2fun (pf1, pf2) = pf
    in
      EXPapp' (k, EXPlam' (cps (pf2 | vmLam (pf1 | vm), e)))
    end

  | EXPapp {..} {t, _} (e1, e2) => let
      prval pf1 = rt2fun {t} ()
      val k = EXPlam' (EXPapp' (EXPapp' (EXPtwo1 (), EXPone1 ()), expShi (expShi k)))
      val k = EXPlam' (cpsw (pf1 | vmShi vm, k, e2))
    in
      cpsw (RT2fun (pf1, RT1 pf) | vm, k, e1)
    end

  | EXPlet {..} {t, _} (e1, e2) => let
      prval pf1 = rt2fun {t} ()
      val k = EXPlam' (
        EXPlet' (EXPone1 (), expShi (cpsw (pf | vmLam (pf1 | vm), expShi k, e2)))
      )
    in
       cpsw (pf1 | vm, k, e1)
    end

  | EXPcal e => let
      val k = expShi k
      val k = EXPlam' (EXPapp' (EXPapp' (EXPone1 (), k), k))
    in
      cpsw (RT2fun (RT2cont pf, RT1 pf) | vm, k, e)
    end

  | EXPthr {..} {t,_} (e1, e2) => let
      prval pf1 = rt2fun {t} ()
      val k = EXPlam' (cpsw (pf1 | vmShi vm, EXPone1 (), e2))
    in
      cpsw (RT2cont pf1 | vm, k, e1)
    end
end // end of [cpsw]

//

fn cps0 {t1,t2:ty} (pf: RT10 (t1, t2) | e: EXP0 t1): EXP0' t2 =
  cps (pf | vmNil, e)

// Some examples

val ans1: [t:ty] EXP0' t = let
  prval [t2:ty] pf = rt1fun {int() ->> int()} ()
in
  cps0 {int()->>int(),t2} (pf | EXPlam {nil} {int(),int()} (EXPvar VARone))
end

(* ****** ****** *)

implement main (argc, argv) = let

in

print "ans1 = "; print ans1; print_newline (); 0(*normal*)

end

(* ****** ****** *)

(* end of [CPS.dats] *)
