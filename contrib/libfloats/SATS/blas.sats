(* ****** ****** *)
//
// Basic Linear Algebraic Subprograms in ATS
//
(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

(* Author: Brandon Barker *)
(* Authoremail: brandon.barker AT gmail DOT com *)
(* Start time: July, 2013 *)

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"
staload "libats/SATS/gmatrix_row.sats"

(* ****** ****** *)

fun{a:t0p}
blas$alpha (alpha: a, x: a, y: a): a
fun{a:t0p}
blas$alphabeta (alpha: a, x: a, beta: a, y: a): a

(* ****** ****** *)
//
// BLAS: level 1
// 
(* ****** ****** *)
//
// HX: inner product
//
fun{a:t0p}
blas_inner$mul (x: a, y: a): a

fun{a:t0p}
blas_inner
  {n:int}{d1,d2:int}
(
  V1: &GVT(a, n, d1)
, V2: &GVT(a, n, d2), int(n), int(d1), int(d2)
) : (a) // end of [blas_inner]

(* ****** ****** *)

fun{a:t0p}
blas_copy
  {n:int}{d1,d2:int}
(
  V1: &GVT(a, n, d1)
, V2: &GVT(a?, n, d2) >> GVT(a, n, d2)
, int(n), int(d1), int(d2)
) : void // end of [blas_copy]

fun{a:t0p}
blas_copy2_row
  {m,n:int}{ld1,ld2:int}
(
  M1: &GMR(a, m, n, ld1)
, M2: &GMR(a?, m, n, ld2) >> GMR(a, m, n, ld2)
, int(m), int(n), int(ld1), int(ld2)
) : void // end of [blas_copy2_row]

fun{a:t0p}
blas_copy2_col
  {m,n:int}{ld1,ld2:int}
(
  M1: &GMC(a, m, n, ld1)
, M2: &GMC(a?, m, n, ld2) >> GMC(a, m, n, ld2)
, int(m), int(n), int(ld1), int(ld2)
) : void // end of [blas_copy2_col]

(* ****** ****** *)

fun{a:t0p}
blas_swap
  {n:int}{d1,d2:int}
(
  V1: &GVT(a, n, d1)
, V2: &GVT(a, n, d2), int(n), int(d1), int(d2)
) : void // end of [blas_swap]

(* ****** ****** *)
//
// X <- alpha*X
//
fun{a:t0p}
blas_scal
  {n:int}{dx:int}
(
  alpha: a
, X: &GVT(a, n, dx) >> _, int n, int dx
) : void // end of [blas_scal]

fun{a:t0p}
blas_scal2_row
  {m,n:int}{ld:int}
(
  alpha: a
, X2: &GMR(a, m, n, ld) >> _, int m, int n, int ld
) : void // end of [blas_scal2_row]
fun{a:t0p}
blas_scal2_col
  {m,n:int}{ld:int}
(
  alpha: a
, X2: &GMC(a, m, n, ld) >> _, int m, int n, int ld
) : void // end of [blas_scal2_col]

(* ****** ****** *)
//
// Y <- alpha*X + Y
//
fun{a:t0p}
blas_axpy
  {n:int}{dx,dy:int}
(
  alpha: a
, X: &GVT(a, n, dx)
, Y: &GVT(a, n, dy) >> _, int n, int dx, int dy
) : void // end of [blas_axpy]

fun{
a:t0p
} blas_axpy2_row
  {m,n:int}{lda,ldb:int}
(
  alpha: a
, X2: &GMR(a, m, n, lda)
, Y2: &GMR(a, m, n, ldb) >> _, int m, int n, int lda, int ldb
) : void // end of [blas_axpy2_row]
fun{
a:t0p
} blas_axpy2_col
  {m,n:int}{lda,ldb:int}
(
  alpha: a
, X2: &GMC(a, m, n, lda)
, Y2: &GMC(a, m, n, ldb) >> _, int m, int n, int lda, int ldb
) : void // end of [blas_axpy2_col]

(* ****** ****** *)
//
// BLAS: level 2
// 
(* ****** ****** *)
//
// Y <- alpha*(AX) + beta*Y
//
fun{a:t0p}
blas_gemv_row
  {m,n:int}{lda,dx,dy:int}
(
  alpha: a
, A: &GMR(a, m, n, lda)
, X: &GVT(a, n, dx)
, beta: a
, Y: &GVT(a, m, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_row]

fun{a:t0p}
blas_gemv_col
  {m,n:int}{lda,dx,dy:int}
(
  alpha: a
, A: &GMC(a, m, n, lda)
, X: &GVT(a, n, dx)
, beta: a
, Y: &GVT(a, m, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_col]

fun{a:t0p}
blas_gemv_trow
  {m,n:int}{lda,dx,dy:int}
(
  alpha: a
, A: &GMR(a, n, m, lda)
, X: &GVT(a, n, dx)
, beta: a
, Y: &GVT(a, m, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_trow]

fun{a:t0p}
blas_gemv_tcol
  {m,n:int}{lda,dx,dy:int}
(
  alpha: a
, A: &GMC(a, n, m, lda)
, X: &GVT(a, n, dx)
, beta: a
, Y: &GVT(a, m, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_tcol]

(* ****** ****** *)
//
// M3 <- alpha(V1(X)V2) + M3
//
fun{
a:t0p
} blas_outer_row
  {m,n:int}{d1,d2,ld3:int}
(
  alpha: a
, V1: &GVT(a, m, d1)
, V2: &GVT(a, n, d2)
, M3: &GMR(a, m, n, ld3) >> _
, int(m), int(n), int(d1), int(d2), int(ld3)
) : void (* end of [blas_outer_row] *)

fun{
a:t0p
} blas_outer_col
  {m,n:int}{d1,d2,ld3:int}
(
  alpha: a
, V1: &GVT(a, m, d1)
, V2: &GVT(a, n, d2)
, M3: &GMC(a , m, n, ld3) >> _
, int(m), int(n), int(d1), int(d2), int(ld3)
) : void (* end of [blas_outer_col] *)

(* ****** ****** *)
//
// BLAS: level 3
// 
(* ****** ****** *)
//
// C <- alpha*(AB)+beta*C
//
fun{
a:t0p
} blas_gemm_row
  {moa,mob:mord}
  {p,q,r:int}{lda,ldb,ldc:int}
(
  alpha: a
, A: &GMX(a, moa, p, q, lda), MORD(moa)
, B: &GMX(a, mob, q, r, ldb), MORD(mob)
, beta: a
, C: &GMR(a, p, r, ldc) >> _
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [blas_gemm_row]
fun{
a:t0p
} blas_gemm_row_nn
  {p,q,r:int}{lda,ldb,ldc:int}
(
  alpha: a
, A: &GMR(a, p, q, lda)
, B: &GMR(a, q, r, ldb)
, beta: a
, C: &GMR(a, p, r, ldc) >> _
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [blas_gemm_row_nn]
fun{
a:t0p
} blas_gemm_row_nt
  {p,q,r:int}{lda,ldb,ldc:int}
(
  alpha: a
, A: &GMR(a, p, q, lda)
, B: &GMR(a, r, q, ldb)
, beta: a
, C: &GMR(a, p, r, ldc) >> _
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [blas_gemm_row_nt]
fun{
a:t0p
} blas_gemm_row_tn
  {p,q,r:int}{lda,ldb,ldc:int}
(
  alpha: a
, A: &GMR(a, q, p, lda)
, B: &GMR(a, q, r, ldb)
, beta: a
, C: &GMR(a, p, r, ldc) >> _
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [blas_gemm_row_tn]
fun{
a:t0p
} blas_gemm_row_tt
  {p,q,r:int}{lda,ldb,ldc:int}
(
  alpha: a
, A: &GMR(a, q, p, lda)
, B: &GMR(a, r, q, ldb)
, beta: a
, C: &GMR(a, p, r, ldc) >> _
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [blas_gemm_row_tt]

(* ****** ****** *)

fun{
a:t0p
} blas_gemm_col
  {moa,mob:mord}
  {p,q,r:int}{lda,ldb,ldc:int}
(
  alpha: a
, A: &GMX(a, moa, p, q, lda), MORD(moa)
, B: &GMX(a, mob, q, r, ldb), MORD(mob)
, beta: a
, C: &GMC(a, p, r, ldc) >> _
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [blas_gemm_col]
fun{
a:t0p
} blas_gemm_col_nn
  {p,q,r:int}{lda,ldb,ldc:int}
(
  alpha: a
, A: &GMC(a, p, q, lda)
, B: &GMC(a, q, r, ldb)
, beta: a
, C: &GMC(a, p, r, ldc) >> _
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [blas_gemm_col_nn]
fun{
a:t0p
} blas_gemm_col_nt
  {p,q,r:int}{lda,ldb,ldc:int}
(
  alpha: a
, A: &GMC(a, p, q, lda)
, B: &GMC(a, r, q, ldb)
, beta: a
, C: &GMC(a, p, r, ldc) >> _
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [blas_gemm_col_nt]
fun{
a:t0p
} blas_gemm_col_tn
  {p,q,r:int}{lda,ldb,ldc:int}
(
  alpha: a
, A: &GMC(a, q, p, lda)
, B: &GMC(a, q, r, ldb)
, beta: a
, C: &GMC(a, p, r, ldc) >> _
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [blas_gemm_col_tn]
fun{
a:t0p
} blas_gemm_col_tt
  {p,q,r:int}{lda,ldb,ldc:int}
(
  alpha: a
, A: &GMC(a, q, p, lda)
, B: &GMC(a, r, q, ldb)
, beta: a
, C: &GMC(a, p, r, ldc) >> _
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [blas_gemm_col_tt]

(* ****** ****** *)

(* end of [blas.sats] *)
