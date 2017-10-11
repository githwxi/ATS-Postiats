(* ****** ****** *)
(*
** For writing ATS code
** that translates into R(stat)
*)
(* ****** ****** *)
//
// HX-2017-10:
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
R34vector_rep
{a:t0p}{n:nat}
(
x0: a, n: int(n)
) : R34vector(a, n) = "mac#%"
//
overload rep with R34vector_rep
//
(* ****** ****** *)
//
fun
R34vector_make_1
{a:t0p}
(x1: a): R34vector(a, 1) = "mac#%"
fun
R34vector_make_2
{a:t0p}
(x1: a, x2: a): R34vector(a, 2) = "mac#%"
fun
R34vector_make_3
{a:t0p}
(x1: a, x2: a, x3: a): R34vector(a, 3) = "mac#%"
//
fun
R34vector_make_4
{a:t0p}
( x1: a, x2: a
, x3: a, x4: a): R34vector(a, 4) = "mac#%"
fun
R34vector_make_5
{a:t0p}
( x1: a, x2: a
, x3: a, x4: a, x5: a): R34vector(a, 5) = "mac#%"
fun
R34vector_make_6
{a:t0p}
( x1: a, x2: a, x3: a
, x4: a, x5: a, x6: a): R34vector(a, 6) = "mac#%"
//
overload R34vector_make with R34vector_make_1
overload R34vector_make with R34vector_make_2
overload R34vector_make with R34vector_make_3
overload R34vector_make with R34vector_make_4
overload R34vector_make with R34vector_make_5
overload R34vector_make with R34vector_make_6
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
(*
fun
R34vector_set_at
{a:t0p}
{n:int}{i:pos|i <= n}
(R34vector(a, n), i: int(i), x0: a): void = "mac#%"
*)
//
overload [] with R34vector_get_at
(*
overload [] with R34vector_set_at
*)
//
(* ****** ****** *)
//
fun
R34vector_extend
{a:t0p}
{n:int}{i:pos|i <= n}
(xs: R34vector(a, n), x0: a): R34vector(a, n+1) = "mac#%"
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
R34vector_median
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
overload median with R34vector_median
overload variance with R34vector_variance
//
(* ****** ****** *)
//
fun
R34vector_sample_rep
{a:t0p}
{m:int}
{n:nat}
(R34vector(a, m), int(n)): R34vector(a, n) = "mac#%"
fun
R34vector_sample_norep
{a:t0p}
{m:int}
{n:nat|n <= m}
(R34vector(a, m), int(n)): R34vector(a, n) = "mac#%"
//
overload sample_rep with R34vector_sample_rep
overload sample_norep with R34vector_sample_norep
//
(* ****** ****** *)
//
fun
dotprod_R34vector_R34vector
{a:t0p}
{n:pos}
(R34vector(a, n), R34vector(a, n)): (a) = "mac#%"
//
overload dotprod with dotprod_R34vector_R34vector
//
(* ****** ****** *)
//
fun
tcrossprod_R34vector_R34vector
{a:t0p}
{n:pos}
(R34vector(a, n), R34vector(a, n)): R34matrix(a, n, n) = "mac#%"
//
overload tcrossprod with tcrossprod_R34vector_R34vector
//
(* ****** ****** *)
//
fun
R34vector_map_fun
{a:t0p}
{b:t0p}
{n:int}
( xs: R34vector(a, n)
, fopr: (a) -<fun1> b): R34vector(b, n) = "mac#%"
fun
R34vector_map_cloref
{a:t0p}
{b:t0p}
{n:int}
( xs: R34vector(a, n)
, fopr: (a) -<cloref1> b): R34vector(b, n) = "mac#%"
//
(*
overload map with R34vector_map_fun
*)
overload map with R34vector_map_cloref
//
(* ****** ****** *)
//
fun
R34vector_tabulate_fun
{a:t0p}
{n:nat}
( int(n)
, fopr: (natLt(n)) -<fun1> a): R34vector(a, n) = "mac#%"
fun
R34vector_tabulate_cloref
{a:t0p}
{n:nat}
( int(n)
, fopr: (natLt(n)) -<cloref1> a): R34vector(a, n) = "mac#%"
//
(* ****** ****** *)

(* end of [R34vector.sats] *)
