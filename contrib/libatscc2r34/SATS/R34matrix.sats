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
cbind_R34vector_R34vector
{a:t@ype}{n:pos}
( xs: R34vector(a, n)
, ys: R34vector(a, n)): R34matrix(a, n, 2) = "mac#%"
//
fun
rbind_R34vector_R34vector
{a:t@ype}{n:pos}
( xs: R34vector(a, n)
, ys: R34vector(a, n)): R34matrix(a, 2, n) = "mac#%"
//
(* ****** ****** *)
//
fun
cbind_R34matrix_R34vector
{a:t@ype}
{m,n:pos}
(xss: R34matrix(a, m, n), ys: R34vector(a, m)): R34matrix(a, m, n+1) = "mac#%"
fun
cbind_R34vector_R34matrix
{a:t@ype}
{m,n:pos}
(ys: R34vector(a, m), xss: R34matrix(a, m, n)): R34matrix(a, m, n+1) = "mac#%"
//
fun
cbind_R34matrix_R34matrix
{a:t@ype}
{m,n1,n2:pos}
(xss: R34matrix(a, m, n1), yss: R34matrix(a, m, n2)): R34matrix(a, m, n1+n2) = "mac#%"
//
overload cbind with cbind_R34vector_R34vector
overload cbind with cbind_R34vector_R34matrix
overload cbind with cbind_R34matrix_R34vector
overload cbind with cbind_R34matrix_R34matrix
//
(* ****** ****** *)
//
fun
rbind_R34matrix_R34vector
{a:t@ype}
{m,n:pos}
(xss: R34matrix(a, m, n), ys: R34vector(a, n)): R34matrix(a, m+1, n) = "mac#%"
fun
rbind_R34vector_R34matrix
{a:t@ype}
{m,n:pos}
(ys: R34vector(a, n), xss: R34matrix(a, m, n)): R34matrix(a, m+1, n) = "mac#%"
//
fun
rbind_R34matrix_R34matrix
{a:t@ype}
{m1,m2,n:pos}
(xss: R34matrix(a, m1, n), yss: R34matrix(a, m2, n)): R34matrix(a, m1+m2, n) = "mac#%"
//
overload rbind with rbind_R34vector_R34vector
overload rbind with rbind_R34vector_R34matrix
overload rbind with rbind_R34matrix_R34vector
overload rbind with rbind_R34matrix_R34matrix
//
(* ****** ****** *)
//
fun
R34vector_transpose
{a:t0p}
{n:pos}
(xss: R34vector(a, n)): R34matrix(a, 1, n) = "mac#%"
//
fun
R34matrix_transpose
{a:t0p}
{m,n:pos}
(xss: R34matrix(a, m, n)): R34matrix(a, n, m) = "mac#%"
//
overload transpose with R34vector_transpose
overload transpose with R34matrix_transpose
//
(* ****** ****** *)
//
fun
add_R34matrix_R34matrix
{a:t0p}
{m,n:pos}
( xss: R34matrix(a, m, n)
, yss: R34matrix(a, m, n)): R34matrix(a, m, n) = "mac#%"
fun
mul_R34matrix_R34matrix
{a:t0p}
{m,n:pos}
( xss: R34matrix(a, m, n)
, yss: R34matrix(a, m, n)): R34matrix(a, m, n) = "mac#%"
//
overload + with add_R34matrix_R34matrix
overload * with mul_R34matrix_R34matrix
//
(* ****** ****** *)
//
fun
matmult_R34vector_R34matrix
{a:t0p}
{q,r:pos}
(xs: R34vector(a, q), yss: R34matrix(a, q, r)): R34matrix(a, 1, r) = "mac#%"
fun
matmult_R34matrix_R34vector
{a:t0p}
{p,q:pos}
(xss: R34matrix(a, p, q), ys: R34vector(a, q)): R34matrix(a, p, 1) = "mac#%"
//
fun
matmult_R34matrix_R34matrix
{a:t0p}
{p,q,r:pos}
(xss: R34matrix(a, p, q), yss: R34matrix(a, q, r)): R34matrix(a, p, r) = "mac#%"
//
overload matmult with matmult_R34vector_R34matrix
overload matmult with matmult_R34matrix_R34vector
overload matmult with matmult_R34matrix_R34matrix
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
