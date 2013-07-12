(* ****** ****** *)
//
// Basic Linear Algebraic System in ATS
//
(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

(* Author: ... *)
(* Authoremail: ... *)
(* Start time: ... *)

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"
staload "libats/SATS/gmatrix_row.sats"

(* ****** ****** *)
//
// BLAS: level 1
// 
(* ****** ****** *)
//
// HX: inner product
//
fun{a:t0p}
blas_dot
  {n:int}{d1,d2:int}
(
  V1: &GVT(INV(a), n, d1)
, V2: &GVT(    a , n, d2), int(n), int(d1), int(d2)
) : (a) // end of [blas_dot]

(* ****** ****** *)

fun{a:t0p}
blas_swap
  {n:int}{d1,d2:int}
(
  V1: &GVT(INV(a), n, d1)
, V2: &GVT(    a , n, d2), int(n), int(d1), int(d2)
) : void // end of [blas_swap]

(* ****** ****** *)
//
// BLAS: level 2
// 
(* ****** ****** *)

fun{a:t0p}
blas_gemv$alphabeta (x: a, y: a): a

fun{a:t0p}
blas_gemv_row
  {m,n:int}{lda,dx,dy:int}
(
  A: &GMR(INV(a), m, n, lda)
, X: &GVT(    a , n, dx)
, Y: &GVT(    a , m, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_row]

fun{a:t0p}
blas_gemv_col
  {m,n:int}{lda,dx,dy:int}
(
  A: &GMC(INV(a), m, n, lda)
, X: &GVT(    a , n, dx)
, Y: &GVT(    a , m, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_col]

fun{a:t0p}
blas_gemv_rowt
  {m,n:int}{lda,dx,dy:int}
(
  A: &GMR(INV(a), m, n, lda)
, X: &GVT(    a , m, dx)
, Y: &GVT(    a , n, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_rowt]

fun{a:t0p}
blas_gemv_colt
  {m,n:int}{lda,dx,dy:int}
(
  A: &GMC(INV(a), m, n, lda)
, X: &GVT(    a , m, dx)
, Y: &GVT(    a , n, dy) >> _
, int(m), int(n), int(lda), int(dx), int(dy)
) : void // end of [blas_gemv_colt]

(* ****** ****** *)
//
// BLAS: level 3
// 
(* ****** ****** *)

(* end of [blas.sats] *)
