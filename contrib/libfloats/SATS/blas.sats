(* ****** ****** *)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)
//
// Basic Linear Algebra Subprograms in ATS
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

#define
ATS_PACKNAME "ATSLIB.libfloats.blas"
#define
ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"
staload "libats/SATS/gmatrix_row.sats"

(* ****** ****** *)

fun
{a:t0p}
{a2:t0p} blas$gnorm (x: a): a2
fun
{a:t0p}
{a2:t0p} blas$gnorm2 (x: a): a2

(* ****** ****** *)

fun{a:t0p}
blas$_alpha_0 (alpha: a, x: a): a
fun{a:t0p}
blas$_alpha_1 (alpha: a, x: a, y: a): a
fun{a:t0p}
blas$_alpha_beta (alpha: a, x: a, beta: a, y: a): a

(* ****** ****** *)
//
// BLAS: level 1
// 
(* ****** ****** *)

fun
{a:t0p}
{a2:t0p}
blas_nrm2
  {n:int}{d:int}
  (V: &GVT(a, n, d), int n, int d): (a2)
// end of [blas_nrm2]

(* ****** ****** *)

fun
{a:t0p}
{a2:t0p}
blas_iamax
  {n:int | n > 0}{d:int}
  (V: &GVT(a, n, d), int n, int d): natLt(n)
// end of [blas_iamax]

(* ****** ****** *)
//
// HX: inner product (dot)
//
fun{a:t0p}
blas_inner$fmul (x: a, y: a): a

fun{a:t0p}
blas_inner
  {n:int}{d1,d2:int}
(
  V1: &GVT(a, n, d1)
, V2: &GVT(a, n, d2), int(n), int(d1), int(d2)
) : (a) // end of [blas_inner]

fun{a:t0p}
blas_inner_u
  {n:int}{d1,d2:int}
(
  V1: &GVT(a, n, d1)
, V2: &GVT(a, n, d2), int(n), int(d1), int(d2)
) : (a) // end of [blas_inner_u]
fun{a:t0p}
blas_inner_c
  {n:int}{d1,d2:int}
(
  V1: &GVT(a, n, d1)
, V2: &GVT(a, n, d2), int(n), int(d1), int(d2)
) : (a) // end of [blas_inner_c]

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
blas_scal2
  {mo:mord}
  {m,n:int}{ld:int}
(
  MORD(mo)
, a(*alpha*)
, X2: &GMX(a, mo, m, n, ld) >> _, int m, int n, int ld
) : void // end of [blas_scal2]
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
// Y <- alpha*X + Y
//
fun{a:t0p}
blas_ax1y
  {n:int}{dx,dy:int}
(
  alpha: a
, X: &GVT(a, n, dx)
, Y: &GVT(a, n, dy) >> _, int n, int dx, int dy
) : void // end of [blas_ax1y]

fun{
a:t0p
} blas_ax1y2
  {mo:mord}
  {m,n:int}{lda,ldb:int}
(
  MORD (mo)
, a(*alpha*)
, X2: &GMX(a, mo, m, n, lda)
, Y2: &GMX(a, mo, m, n, ldb) >> _, int m, int n, int lda, int ldb
) : void // end of [blas_ax1y2]
fun{
a:t0p
} blas_ax1y2_row
  {m,n:int}{lda,ldb:int}
(
  alpha: a
, X2: &GMR(a, m, n, lda)
, Y2: &GMR(a, m, n, ldb) >> _, int m, int n, int lda, int ldb
) : void // end of [blas_ax1y2_row]
fun{
a:t0p
} blas_ax1y2_col
  {m,n:int}{lda,ldb:int}
(
  alpha: a
, X2: &GMC(a, m, n, lda)
, Y2: &GMC(a, m, n, ldb) >> _, int m, int n, int lda, int ldb
) : void // end of [blas_ax1y2_col]

(* ****** ****** *)
//
// Y <- alpha*X + beta*Y
//
fun{a:t0p}
blas_axby
  {n:int}{dx,dy:int}
(
  alpha: a
, X: &GVT(a, n, dx)
, beta: a
, Y: &GVT(a, n, dy) >> _, int n, int dx, int dy
) : void // end of [blas_axby]

fun{
a:t0p
} blas_axby2_row
  {m,n:int}{lda,ldb:int}
(
  alpha: a
, X2: &GMR(a, m, n, lda)
, beta: a
, Y2: &GMR(a, m, n, ldb) >> _, int m, int n, int lda, int ldb
) : void // end of [blas_axby2_row]
fun{
a:t0p
} blas_axby2_col
  {m,n:int}{lda,ldb:int}
(
  alpha: a
, X2: &GMC(a, m, n, lda)
, beta: a
, Y2: &GMC(a, m, n, ldb) >> _, int m, int n, int lda, int ldb
) : void // end of [blas_axby2_col]

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
  {m,n:int}
  {tp:transp}
  {ma,na:int}
  {lda,dx,dy:int}
(
  pf: transpdim (tp, ma, na, m, n)
| alpha: a
, A: &GMR(a, m, n, lda), tp: TRANSP(tp)
, X: &GVT(a, n, dx)
, beta: a
, Y: &GVT(a, m, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_row]

fun{a:t0p}
blas_gemv_row_n
  {m,n:int}{lda,dx,dy:int}
(
  alpha: a
, A: &GMR(a, m, n, lda)
, X: &GVT(a, n, dx)
, beta: a
, Y: &GVT(a, m, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_row_n]
fun{a:t0p}
blas_gemv_row_t
  {m,n:int}{lda,dx,dy:int}
(
  alpha: a
, A: &GMR(a, n, m, lda)
, X: &GVT(a, n, dx)
, beta: a
, Y: &GVT(a, m, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_row_t]

(* ****** ****** *)

fun{a:t0p}
blas_gemv_col
  {m,n:int}
  {tp:transp}
  {ma,na:int}
  {lda,dx,dy:int}
(
  pf: transpdim (tp, ma, na, m, n)
| alpha: a
, A: &GMC(a, ma, na, lda), tp: TRANSP(tp)
, X: &GVT(a, n, dx)
, beta: a
, Y: &GVT(a, m, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_col]

fun{a:t0p}
blas_gemv_col_n
  {m,n:int}{lda,dx,dy:int}
(
  alpha: a
, A: &GMC(a, m, n, lda)
, X: &GVT(a, n, dx)
, beta: a
, Y: &GVT(a, m, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_col_n]
fun{a:t0p}
blas_gemv_col_t
  {m,n:int}{lda,dx,dy:int}
(
  alpha: a
, A: &GMC(a, n, m, lda)
, X: &GVT(a, n, dx)
, beta: a
, Y: &GVT(a, m, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_col_t]

(* ****** ****** *)
//
// HX: outer product (ger)
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
  {p,q,r:int}
  {tra,trb:transp}
  {ma,na:int}{mb,nb:int}
  {lda,ldb,ldc:int}
(
  pfa: transpdim (tra, ma, na, p, q)
, pfb: transpdim (trb, mb, nb, q, r)   
| alpha: a
, A: &GMR(a, ma, na, lda), TRANSP(tra)
, B: &GMR(a, mb, nb, ldb), TRANSP(trb)
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
  {p,q,r:int}
  {tra,trb:transp}
  {ma,na:int}{mb,nb:int}
  {lda,ldb,ldc:int}
(
  pfa: transpdim (tra, ma, na, p, q)
, pfb: transpdim (trb, mb, nb, q, r)   
| alpha: a
, A: &GMC(a, ma, na, lda), TRANSP(tra)
, B: &GMC(a, mb, nb, ldb), TRANSP(trb)
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
