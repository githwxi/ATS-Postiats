//usr/bin/env myatscc "$0"; exit
(* ****** ****** *)
(*
** A verfied implementation of the integer sqare root function
** that is non-tail-recursive and of logarithmic time complexity
**
** Author: Hongwei Xi
** Authoremail: hwxi AT cs DOT bu DOT edu
** Time: November, 2009
*)
(* ****** ****** *)
//
// The code is ported to ATS2 by Hongwei Xi on Friday, July 20, 2012
//
(* ****** ****** *)
//
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -
*)
//
(* ****** ****** *)

staload _ = "prelude/DATS/integer.dats"

(* ****** ****** *)

propdef
INTSQRT (x: int, n: int) =
  [x0,x1:nat | x0 <= x; x < x1] (MUL (n, n, x0), MUL (n+1, n+1, x1))
// end of [SQRT]

extern
prfun INTSQRT_4_lemma {x:nat} {n2:nat}
  (pf: INTSQRT (x/4, n2)): [n:int | 2*n2 <= n; n <= 2*n2+1] INTSQRT (x, n)
// end of [INTSQRT_4_lemma]

primplmnt
INTSQRT_4_lemma // nonrec
  {x} {n2} ([x0:int,x1:int] pf) = let
  prval pf0 = pf.0 // MUL (n2, n2, x0) // x0 <= x/4
  prval pf1 = pf.1 // MUL (n2+1, n2+1, x1) // x/4 < x1
  prval pf1_alt = mul_expand_linear {1,1} {1,1} (pf0)
  prval () = mul_isfun (pf1, pf1_alt)
  stadef n_1 = n2 + n2
  stadef n_2 = n_1 + 1 and n_3 = n_1 + 2
  prval pf0_1 = mul_expand_linear {2,0} {2,0} (pf0)
  stadef x_2 = 4 * x0 + 4 * n2 + 1
  prval pf0_2 = mul_expand_linear {1,1} {1,1} (pf0_1)
  prval pf0_3 = mul_expand_linear {1,2} {1,2} (pf0_1)
in
  sif (x < x_2) then #[n_1 | (pf0_1, pf0_2)] else #[n_2 | (pf0_2, pf0_3)]
end // end of [ISORT_4_lemma]

(* ****** ****** *)

extern // 10 points
fun intsqrt {x:nat}
  (x: int x):<> [n:nat] (INTSQRT (x, n) | int n)
// end of [intsqrt]

implement intsqrt (x) = let
//
fun aux {x:nat}.<x>. // non-tail-recursive
  (x: int x):<> [n:nat] (INTSQRT (x, n) | int n) =
  if x > 0 then let
    val x4 = x \ndiv 4
    val [n2:int] (pf4 | n2) = aux (x4)
    prval [n:int] pf = INTSQRT_4_lemma {x} {n2} (pf4)
    val n_1 = n2 + n2
    val n_2 = n_1 + 1
    val (pf_mul | x1) = g1int_mul2 (n_2, n_2)
  in
    if x < x1 then let
      prval () = (
        sif (n==2*n2) then () else let
          prval () = mul_isfun (pf_mul, pf.0) in (*nothing*)
        end // end of [sif]
      ) : [n==2*n2] void
    in
      (pf | n_1)
    end else let
      prval () = (
        sif (n==2*n2+1) then () else let
          prval () = mul_isfun (pf_mul, pf.1) in (*nothing*)
        end // end of [sif]
      ) : [n==2*n2+1] void
    in
      (pf | n_2)
    end // end of [if]
  end else let
    prval pf0_mul = mul_make {0,0} ()
    prval pf1_mul = mul_make {1,1} ()
  in
    ((pf0_mul, pf1_mul) | 0)
  end // end of [if]
in
  aux (x)
end // end of [intsqrt]
      
(* ****** ****** *)

implement
main0 ((*void*)) =
{
  val () = assertloc ( (intsqrt(1023)).1 = 31 )
  val () = assertloc ( (intsqrt(1024)).1 = 32 )
  val () = assertloc ( (intsqrt(1025)).1 = 32 )
} // end of [main0]

(* ****** ****** *)

(* end of [intsqrt.dats] *)
