(*
**
** [infprime] proves that for any given natural number [n],
** there exists a prime number [p] that is greater than [n]
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: October 7, 2009
**
*)

(*
** The code is ported to ATS2 on 2012-06-11 by Hongwei Xi
*)

propdef PRIME (p:int) = // if p >= 2
  {x,y:nat | x <= y} MUL (x, y, p) -<> [x==1] void
// end of [propdef]

(*

extern prval prime2: PRIME (2)
extern prval prime3: PRIME (3)
extern prval prime5: PRIME (5)
extern prval prime7: PRIME (7)

*)

extern // this one is not proven
prfun lemma10 {n:nat | n >= 2} (): [p,q:int | p >= 2] (PRIME p, MUL (p, q, n))

(* ****** ****** *)

dataprop FACT (int, int) = 
  | FACTbas (0, 1)
  | {n:nat} {r,r1:int} FACTind (n+1, r) of (FACT (n, r1), MUL (n+1, r1, r))
// end of [FACT]

prfun fact_istot
  {n:nat} .<n>. (): [r:nat] FACT (n, r) =
  sif n == 0 then FACTbas ()
  else let
    prval pf_fac = fact_istot {n-1} ()
    prval pf_mul = mul_istot (); prval () = mul_nat_nat_nat (pf_mul)
  in
    FACTind (pf_fac, pf_mul)
  end // end of [sif]
// end of [fact_istot]

prfun fact_isfun {n:nat} {r1,r2:int} .<n>.
  (pf1: FACT (n, r1), pf2: FACT (n, r2)): [r1==r2] void =
  case+ (pf1, pf2) of
  | (FACTbas (), FACTbas ()) => ()
  | (FACTind (pf11, pf12), FACTind (pf21, pf22)) => let
      prval () = fact_isfun (pf11, pf21); prval () = mul_isfun (pf12, pf22)
    in
      // nothing
    end // end of [FACTind, FACTind]
// end of [fact_isfun]

(* ****** ****** *)

prfun lemma20 {n,r:int}
  {i:pos | i <= n} .<n>.
  (pf_fac: FACT (n, r)): [k:nat] MUL (k, i, r) = let
  prval FACTind (pf1_fac, pf2_mul) = pf_fac // r = n*r1
in
//
sif i < n then let
  prval [k1:int] pf3_res =
    lemma20 {..} {i} (pf1_fac) // pf3_res: k1 * i = r1
  prval [k:int] pf4_mul = mul_istot {n,k1} () // k = n*k1
  prval () = mul_nat_nat_nat (pf4_mul)
  prval pf5_res = mul_istot {k,i} ()
  prval () = mul_nat_nat_nat (pf5_res)
  prval () = mul_is_associative (pf4_mul, pf3_res, pf5_res, pf2_mul)
in
  pf5_res
end else let
  prval pf1_fac_another = fact_istot {n-1} ()
  prval () = fact_isfun (pf1_fac, pf1_fac_another)
in
  mul_commute (pf2_mul)
end // end of [sif]
//
end (* end of [lemma20] *)

(* ****** ****** *)

extern
prfun infprime {n:int | n >= 1} (): [p:int | p > n] PRIME p

primplmnt
infprime {n} () = let
  prval [r:int] pf_fac = fact_istot {n} ()
  prval () = lemma (pf_fac) where {
    prfun lemma {n,r:int | n >= 1} .<n>. (pf_fac: FACT (n, r)): [r >= n] void =
      sif n >= 2 then let
        prval FACTind (pf1_fac, pf2_mul) = pf_fac
        prval () = lemma (pf1_fac)
        prval pf2_mul = mul_commute (pf2_mul)
        prval MULind (pf3_mul) = pf2_mul
        prval () = mul_nat_nat_nat (pf3_mul)
      in
        // nothing
      end else let
        prval FACTind (pf1_fac, pf1_mul) = pf_fac
        prval FACTbas () = pf1_fac
        prval () = mul_elim {1,1} (pf1_mul)
      in
        // nothing
      end // end of [sif]
   // end of [lemma]
  } // end of [prval]
  prval [p,q:int]
    (pf_prime, pf1_mul) = lemma10 {r+1} () // pf1_mul: p * q = r+1
  prval () = (sif p <= n then let
    prval [k:int] pf2_mul = lemma20 {n,r} {p} (pf_fac) // pf2_mul: k * p = r
    prval pf2_mul = mul_negate (pf2_mul) // pf2_mul: ~k * p = ~r
    prval pf2_mul = mul_commute (pf2_mul) // pf2_mul: p * ~k = ~r
    prval pf3_mul = mul_distribute (pf1_mul, pf2_mul) // pf3_mul: p * (q-k) = 1
    prval pf3_mul = mul_commute (pf3_mul) // pf3_mul : (q-k) * p = 1
  in
    sif q > k then let
      prval MULind pf4_mul = pf3_mul
      prval () = mul_nat_nat_nat (pf4_mul)
    in
      // nothing
    end else sif q < k then let
      prval pf3_mul = mul_negate (pf3_mul) // pf3_mul: (k-q) * p = 1
      prval MULind pf4_mul = pf3_mul
      prval () = mul_nat_nat_nat (pf4_mul)
    in
      // nothing
    end else let // q = k
      prval MULbas () = pf3_mul in ()
    end // end of [sif]
  end else begin
    // nothing
  end) : [p > n] void // end of [prval]
in
  #[p | pf_prime]
end // end of [infprime]

(* ****** ****** *)

(* end of [infprime.dats] *)
