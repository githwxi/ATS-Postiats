(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)

dataprop
FIB(int, int) =
  | FIB0(0, 0) of () // [of ()] can be dropped
  | FIB1(1, 1) of () // [of ()] can be dropped
  | {n:nat}{r0,r1:int}
    FIB2(n+2, r0+r1) of (FIB(n, r0), FIB(n+1, r1))
// end of [FIB]

(* ****** ****** *)

prval fib21 = FIB2 (FIB0 (), FIB1 ())

(* ****** ****** *)

extern
prfun fib_istot {n:nat} (): [r:int] FIB(n, r)

extern
prfun
fib_isfun
  {n:nat}{r1,r2:int}
  (pf1: FIB (n, r1), pf2: FIB (n, r2)): [r1==r2] void
// end of [fib_isfun]

(* ****** ****** *)

extern
prfun mut_istot {m,n:int} (): [p:int] MUL(m, n, p)

primplmnt
mul_istot{m,n}() = let
//
prfun
istot
{m:nat;n:int} .<m>. (): [p:int] MUL(m, n, p) =
  sif m > 0 then MULind (istot {m-1,n} ()) else MULbas ()
// end of [istot]
//
in
  sif m >= 0 then istot {m,n} () else MULneg (istot {~m,n} ())
end // end of [mul_istot]  

(* ****** ****** *)

prfn
mul_isfun
{m,n:int}
{p1,p2:int}
(
  pf1: MUL(m, n, p1)
, pf2: MUL(m, n, p2)
) : [p1==p2] void = let
  prfun
  isfun
  {m:nat;n:int}
  {p1,p2:int} .<m>.
  (
    pf1: MUL(m, n, p1)
  , pf2: MUL(m, n, p2)
  ) : [p1==p2] void =
    case+ pf1 of
    | MULbas () => let
        prval MULbas() = pf2 in ()
      end // end of [MULbas]
    | MULind (pf1prev) => let
        prval MULind(pf2prev) = pf2 in isfun (pf1prev, pf2prev)
      end // end of [MULind]
  // end of [isfun]
in
  case+ pf1 of
  | MULneg(pf1nat) => let
      prval
      MULneg(pf2nat) = pf2
    in
      isfun (pf1nat, pf2nat)
    end // end of [MULneg]
  | _ (*non-MULneg*) =>> isfun (pf1, pf2)
end // end of [mul_isfun]

(* ****** ****** *)
//
extern
prfun
mul_distribute
  {m,n1,n2:int}{p1,p2:int}
  (MUL(m, n1, p1), MUL(m, n2, p2)): MUL(m, n1+n2, p1+p2)
//
(* ****** ****** *)

primplmnt
mul_distribute
{m,n1,n2}{p1,p2}
  (pf1, pf2) = let
//
prfun
auxnat
{m:nat}
{p1,p2:int} .<m>.
(
  pf1: MUL(m, n1, p1)
, pf2: MUL(m, n2, p2)
) : MUL(m, n1+n2, p1+p2) =
(
  case+ (pf1, pf2) of
  | (MULbas(), MULbas()) => MULbas()
  | (MULind pf1, MULind pf2) => MULind(auxnat (pf1, pf2))
) (* end of [auxnat] *)
//
in
//
sif
m >= 0
then (
  auxnat (pf1, pf2)
) // end of [then]
else let
  prval MULneg(pf1) = pf1
  prval MULneg(pf2) = pf2
in
  MULneg(auxnat (pf1, pf2))
end // end of [else]
//
end // end of [mul_distribute]

(* ****** ****** *)
//
extern
prfun
mul_commute
  {m,n:int}{p:int}(MUL(m, n, p)): MUL(n, m, p)
//
(* ****** ****** *)

extern
prfun
mul_nx0_0{n:int}(): MUL(n, 0, 0)
extern
prfun
mul_nx1_n{n:int}(): MUL(n, 1, n)
extern
prfun
mul_neg_2{m,n:int}{p:int}(MUL(m,n,p)): MUL(m,~n,~p)

primplmnt
mul_commute
  {m,n}{p}(pf0) = let
//
prfun
auxnat
{m:nat}
{p:int} .<m>.
(
pf: MUL(m, n, p)
) : MUL(n, m, p) =
(
  case+ pf of
  | MULbas() => mul_nx0_0{n}()
  | MULind(pf1) =>
      mul_distribute(auxnat(pf1), mul_nx1_n{n}())
    // end of [MULind]
) (* end of [auxnat] *)
//
in
//
sif
m >= 0
then auxnat(pf0)
else let
  prval MULneg(pf1) = pf0 in mul_neg_2(auxnat(pf1))
end // end of [else]
//
end // end of [mul_commute]
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [misc.dats] *)
