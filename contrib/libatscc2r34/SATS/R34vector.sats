(* ****** ****** *)
(*
** For writing ATS code
** that translates into R(stat)
*)
(* ****** ****** *)
//
// HX:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2r34pre_"
//
(* ****** ****** *)
//
#staload "./../basics_r34.sats"
//
(* ****** ****** *)
//
fun
R34vector_length
{a:t0p}{n:int}
(R34vector(a, n)): int(n) = "mac#%"
//
overload length with R34vector_length
//
(* ****** ****** *)
//
fun
R34vector_get_at
{a:t0p}
{n:int}{i:pos|i <= n}
(R34vector(a, n), i: int(i)): a = "mac#%"
fun
R34vector_set_at
{a:t0p}
{n:int}{i:pos|i <= n}
(R34vector(a, n), i: int(i), x0: a): void = "mac#%"
//
overload [] with R34vector_get_at
overload [] with R34vector_set_at
//
(* ****** ****** *)
//
fun
R34vector_match
{a:t0p}{n:int}
(
x0: a,
xs: R34vector(a, n)
) : intBtwe(0, n) = "mac#%" // endfun
//
overload match with R34vector_match
//
(* ****** ****** *)
//
fun
{a:t0p}
R34vector_mean
{n:pos}
(xs: R34vector(a, n)): double = "mac#%"
//
fun
{a:t0p}
R34vector_variance
{n:pos}
(xs: R34vector(a, n)): double = "mac#%"
//
overload mean with R34vector_mean
overload variance with R34vector_variance
//
(* ****** ****** *)

(* end of [R34vector.sats] *)
