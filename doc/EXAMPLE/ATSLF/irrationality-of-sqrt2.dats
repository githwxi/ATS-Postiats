(*
//
// A proof of the irrationality of the square root of 2 in ATS/LF
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: Nov 1, 2007
//
*)

//
// Aaron Stump mentioned the problem during his visit at BU on Nov 1, 2007.
// This solution is self-contained.
//

//
// March 6th, 2008
// The code is ported to ATS/Anairiats by Hongwei Xi. This example involves
// an interesting use of manual splitting on an integer variable. See below.
//

(* ****** ****** *)
//
// HX-2012-06-12: this code typechecks in ATS2 without any changes.
//
(* ****** ****** *)

dataprop
MUL1 (int, int, int) =
| {n:int}
  MUL1bas (0, n, 0)
| {m:nat;n:int}{p:int}
  MUL1ind (m+1, n, p+n) of MUL1 (m, n, p)
| {m:pos;n:int}{p:int}
  MUL1neg (~m, n, ~p) of MUL1 (m, n, p)
// end of [MUL1]

(* ****** ****** *)
//
// m * 0 = x implies x = 0
//
prfun
lemma00
  {m:nat}{x:int} .<m>.
  (pf: MUL1 (m, 0, x)): [x == 0] void =
  sif m > 0 then begin
    let prval MUL1ind pf1 = pf in lemma00 pf1 end
  end else begin
    let prval MUL1bas () = pf in () end
  end // end of [sif]
// end of [lemma00]

(* ****** ****** *)
//
// m * n = x implies m * (n-1) = x - m
//
prfun lemma01 {m,n:nat} {x:int} .<m>. (pf: MUL1 (m, n, x))
  : MUL1 (m, n-1, x-m) =
  sif m > 0 then begin
    let prval MUL1ind pf1 = pf in MUL1ind (lemma01 pf1) end
  end else begin
    let prval MUL1bas () = pf in MUL1bas () end
  end // end of [sif]
// end of [lemma01]

(* ****** ****** *)
//
// commutativity of multiplication
// m * n = x implies n * m = x
prfun
lemma_commute
  {m,n:nat}{x:int} .<n>.
  (pf: MUL1 (m, n, x)):<prf> MUL1 (n, m, x) =
(
  sif n > 0 then begin
    let prval pf1 = lemma01 (pf) in
      MUL1ind (lemma_commute {m,n-1} (pf1))
    end
  end else begin
    let prval () = lemma00 (pf) in MUL1bas () end
  end // end of [sif]
) (* end of [lemma_commute] *)

(* ****** ****** *)
//
// (p + p) * (p + p) = x implies x = 4 * x4 for some x4
//
prfun
lemma1
  {p:nat}{x:int} .<p>.
(
  pf: MUL1 (p+p, p+p, x)
) :<prf> [x4:int | x == 4*x4] MUL1 (p, p, x4) =
  sif p > 0 then let
    prval MUL1ind pf1 = pf
    prval MUL1ind pf2 = pf1
    prval pf2' = lemma_commute {p+p-2,p+p} (pf2)
    prval MUL1ind pf21' = pf2'
    prval MUL1ind pf22' = pf21'
    prval [x41:int] pf_1 = lemma1 {p-1} {x-8*p+4} (pf22')
    // prval () = verify_constraint {x-8*p+4==4*x41} ()
    prval pf_2 = MUL1ind (pf_1)
    prval pf_3 = lemma_commute (pf_2)
    prval pf_4 = MUL1ind (pf_3)
  in
    #[x41+2*p-1 | pf_4]
  end else let
    prval MUL1bas () = pf
  in
    #[0 | pf]
  end // end of [sif]
// end of [lemma1]

(* ****** ****** *)
//
// [x <= 0 || x >= 1]
// is an example of manual splitting!
// p * p = x + x implies p = 2 * p2 for some p2
//
prfun
lemma2
  {p:nat}{x:int} .<p>.
(
  pf: MUL1 (p, p, x+x)
) :<prf> [p2:int | p == 2*p2] void =
  sif p >= 2 then let
    prval MUL1ind pf1 = pf
    prval MUL1ind pf2 = pf1
    prval pf2' = lemma_commute {p-2,p} (pf2)
    prval MUL1ind pf21' = pf2'
    prval MUL1ind pf22' = pf21'
    prval [p21:int] () = lemma2 {p-2}{x-2*p+2} (pf22')
  in
    #[p21+1 | ()]
  end else sif p == 1 then let
(*
    prval () = (): [x <= 0 || x >= 1] void // an example of manual splitting!
*)
    prval MUL1ind pf1 = pf
    prval MUL1bas () = pf1
  in
    #[0 | ()] // impossible
  end else let
    prval MUL1bas () = pf
  in
    #[0 | ()]
  end // end of [sif]

(* ****** ****** *)

(*
(q/p) * (q/p) = 2 => contradiction
if p * p = x and q * q = 2x, then x = 0
*)
//
// (p * p = x and q * q = x + x) implies x = 0
//
prfun
lemma_main
  {p,q:nat}{x:int} .<p>.
(
  pf1: MUL1 (p, p, x), pf2: MUL1 (q, q, x+x)
) : [x == 0] void = let
in
//
sif p > 0 then let
  prval [q2:int] () = lemma2 {q} {x} (pf2) // q = 2*q2
  prval [x2:int] pf2' = lemma1 {q2} {x+x} (pf2) // x+x = 4*x2
  prval [p2:int] () = lemma2 {p} {x2} (pf1) // p = 2*p2
  prval [x4:int] pf1' = lemma1 {p2} {x2+x2} (pf1) // x2+x2 = 4*x4
in
  lemma_main {p2,q2} {x4} (pf1', pf2')
end else begin
  let prval MUL1bas () = pf1 in () end
end // end of [sif]
//
end // end of [lemma_main]

(* ****** ****** *)

(* end of [irrationality_of_sqrt2.dats] *)
