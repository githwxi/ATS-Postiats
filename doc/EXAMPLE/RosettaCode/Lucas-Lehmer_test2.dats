(* ****** ****** *)
//
// Author: HX-2017-01-03
//
(* ****** ****** *)
(*
//
Lucas-Lehmer Test: for p an odd prime, the Mersenne number 2^p − 1 is
prime if and only if 2^p − 1 divides S(p−1) where S(n+1) = (S(n))^2 − 2,
and S(1) = 4.
//
Task
//
Calculate all Mersenne primes up to the implementation's maximum precision,
or the 47th Mersenne prime (whichever comes first).
//
*)
(* ****** ****** *)
(*
//
Output after 8 hours:
//
M3
M5
M7
M13
M17
M19
M31
M61
M89
M107
M127
M521
M607
M1279
M2203
M2281
M3217
M4253
M4423
M9689
M9941
M11213
M19937
M21701
M23209
M44497
  C-c C-c
*)
(* ****** ****** *)
//
// This is a memory-clean implementation.
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#define
INTINF_targetloc
"\
$PATSHOME/contrib\
/atscntrb/atscntrb-hx-intinf"
//
#include "{$INTINF}/mylibies.hats"
//
(* ****** ****** *)
//
staload
$INTINF_vt // opening [INTINF_vt]
//
(*
overload >= with gte_intinf_int
overload compare with compare_intinf_int
*)
//
(* ****** ****** *)

typedef N2 = intGte(2)
typedef N3 = intGte(3)

(* ****** ****** *)
//
fun
fromBy2
{n:int}
(
  n: int n
) :<!laz>
  stream_vt(intGte(n)) =
  $ldelay(fromBy2_con(n))
and
fromBy2_con
{n:int}
(
  n: int n
) :<!laz>
  stream_vt_con(intGte(n)) =
  stream_vt_cons{intGte(n)}(n, fromBy2(n+2))
//
(* ****** ****** *)

fun sieve
(
ns: stream_vt(N3)
) : stream_vt(N3) = $ldelay(sieve_con ns, ~ns)

and
sieve_con
(
ns: stream_vt(N3)
) : stream_vt_con(N3) = let
//
val ns_con = !ns
val-@stream_vt_cons(n, ns2) = ns_con; val p = n
val ps = sieve
(
  stream_vt_filter_cloptr(ns2, lam x => g1int_nmod(x, p) > 0)
) (* end of [val] *)
val () = (ns2 := ps)
//
in
  fold@ ns_con; ns_con
end // end of [sieve_con]

(* ****** ****** *)

fun
LucasLehmer_test
  (p: N3): bool = let
//
vtypedef res = intinfGte(0)
//
fun
S{n:int}{i:int | 1 <= i; i <= n}
(
  n: int(n), i: int(i), d0: !intinfGte(1), res: res
) : res =
(
  if i < n
    then let
      val res =
        nmod_intinf0_intinf1(sub_intinf0_int(square_intinf0(res), 2), d0)
      // end of [val]
    in
      S(n, i+1, d0, res)
    end // end of [then]
    else res // end of [else]
  // end of [if]
)
//
val d0 =
  pred_intinf0(pow_int_int(2, p))
val () = assertloc(d0 >= 1)
val res = S(p-1, 1, d0, intinf_make_int(4))
val sgn = compare(res, 0)
val ((*void*)) = intinf_free(d0)
val ((*void*)) = intinf_free(res)
//
in
  if sgn = 0 then true else false
end // end of [LucasLehmer_test]
//
(* ****** ****** *)

implement
main0() = () where
{
//
val
thePrimes = sieve(fromBy2(3))
//
val
theMPrimes =
stream_vt_filter_cloptr(thePrimes, lam(p) => LucasLehmer_test(p))
//
val
theMPrimes = stream_vt_make_cons<N2>(2, theMPrimes)
//
val
theMPrimes_10 = stream_vt_takeLte(theMPrimes, 10) // the first 10 of them
//
val ((*void*)) = stream_vt_foreach_cloptr(theMPrimes_10, lam(p) => println! ("M", p))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [Lucas-Lehmer_test2.dats] *)
