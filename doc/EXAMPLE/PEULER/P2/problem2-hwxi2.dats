//
// ProjectEuler: Problem 2
// Finding the sum of all even Fibonacci numbers not exceeding 4M
//

(* ****** ****** *)
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: September, 2010
//
(* ****** ****** *)
//
// HX-2010-09: this is a fully verified solution!
//
(* ****** ****** *)
//
// HX-2013-06: ported to ATS2
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)

dataprop FIB (int, int) =
  | FIB0 (0, 0)
  | FIB1 (1, 1)
  | {n:nat} {r0,r1:nat} FIB2 (n+2, r0+r1) of (FIB (n, r0), FIB (n+1, r1))
// end of [FIB]

(* ****** ****** *)

dataprop SUM (int, int, int) =
  | {n:nat} {r,N:int | r >= N} SUM0 (n, N, 0) of FIB (n, r)
  | {n:nat} {r,N:int | r < N; r mod 2 == 0} {s:int} SUM10 (n, N, s+r) of (FIB (n, r), SUM (n+1, N, s))
  | {n:nat} {r,N:int | r < N; r mod 2 >  0} {s:int} SUM11 (n, N, s  ) of (FIB (n, r), SUM (n+1, N, s))
// end of [SUM]

(* ****** ****** *)

fun
p2 {N:int}
  (N: int N):<!ntm> [s:int] (SUM (2, N, s) | int s) = let
  prval pf0 = FIB2 (FIB0 (), FIB1 ()); prval pf1 = FIB2 (FIB1 (), pf0)
in
  p2_aux (pf0, pf1 | 2, N, 1, 2)
end // end of [p2]

and p2_aux
  {n:pos}{N:int}{r0,r1:nat}
(
  pf0: FIB (n, r0), pf1: FIB (n+1, r1)
| n: int n, N: int N, r0: int r0, r1: int r1
) :<!ntm> [s:int] (SUM (n, N, s) | int s) = let
in
//
if r0 < N then let
  val (pfr1 | s1) =
    p2_aux (pf1, FIB2 (pf0, pf1) | n+1, N, r1, r0+r1)
  val [q:int,m:int] (pf_mod | res) = g1int_nmod2 (r0, 2)
  prval () = mul_elim (divmod_elim (pf_mod))
  prval () = prop_verify_and_add {r0 mod 2 == m} ()
in
  if res = 0 then (SUM10 (pf0, pfr1) | s1 + r0) else (SUM11 (pf0, pfr1) | s1)
end else (SUM0 (pf0) | 0)
//
end // end of [p2_aux]

(* ****** ****** *)

#define _4M 4000000
implement
main0 () = () where {
  val (_pf | ans) = p2 (_4M)
  val () = assertloc (ans = 4613732)
  val () = println! "The sum of all even Fibonacci numbers < 4 million = " ans
} // end of [main]

(* ****** ****** *)

(* end of [problem2-hwxi2.dats] *)
