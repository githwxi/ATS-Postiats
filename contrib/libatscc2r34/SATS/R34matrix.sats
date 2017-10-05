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
R34matrix_ncol
{a:t0p}
{m,n:int}
(R34matrix(a, m, n)): int(n) = "mac#%"
fun
R34matrix_nrow
{a:t0p}
{m,n:int}
(R34matrix(a, m, n)): int(m) = "mac#%"
//
overload ncol with R34matrix_ncol
overload nrow with R34matrix_nrow
//
(* ****** ****** *)
//
fun
R34matrix_get_at
{a:t0p}
{m,n:int}
{i,j:pos
|i <= m; j <= n}
(R34matrix(a, m, n), i:int(i), j:int(j)): a = "mac#%"
//
overload [] with R34matrix_get_at
//
(* ****** ****** *)
//
fun
R34matrix_transpose
{a:t0p}
{m,n:pos}
(xss: R34matrix(a, m, n)): R34matrix(a, n, m) = "mac#%"
//
overload transpose with R34matrix_transpose
//
(* ****** ****** *)
//
fun
R34matrix_tabulate_fun
{a:t0p}
{m,n:pos}
( m: int(m)
, n: int(n)
, fopr: (natLt(m), natLt(n)) -<fun1> a): R34matrix(a, m, n) = "mac#%"
fun
R34matrix_tabulate_cloref
{a:t0p}
{m,n:pos}
( m: int(m)
, n: int(n)
, fopr: (natLt(m), natLt(n)) -<cloref1> a): R34matrix(a, m, n) = "mac#%"
//
(* ****** ****** *)

(* end of [R34matrix.sats] *)
