//
// A naive implementation of
// Strassen's matrix multiplication algorithm
//
(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
staload _ = "prelude/DATS/gnumber.dats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_row.sats"
//
staload _ = "libats/DATS/gvector.dats"
staload _ = "libats/DATS/gmatrix.dats"
staload _ = "libats/DATS/gmatrix_row.dats"
staload _ = "libats/DATS/gmatrix_col.dats"
staload _ = "libats/DATS/refcount.dats"
//
(* ****** ****** *)

staload "./../SATS/blas.sats"
staload "./../SATS/lavector.sats"
staload "./../SATS/lamatrix.sats"

(* ****** ****** *)

staload _ = "./../DATS/blas0.dats"
staload _ = "./../DATS/blas1.dats"
staload _ = "./../DATS/blas_gemv.dats"
staload _ = "./../DATS/blas_gemm.dats"
staload _ = "./../DATS/lavector.dats"
staload _ = "./../DATS/lamatrix.dats"

(* ****** ****** *)

#define incref LAgmat_incref
#define decref LAgmat_decref

extern
fun{a:t0p}
LAgmat_gemm_strassen
  {mo:mord}
  {l:addr}{p,q,r:int}
(
  alpha: a
, !LAgmat (a, mo, p, q)
, !LAgmat (a, mo, q, r)
, beta: a
, !LAgmat (a, mo, p, r) >> _
) : void // endfun

extern
fun{a:t0p}
LAgmat_gemm_strassen2
  {mo:mord}{p,q,r:nat}
(
  alpha: a
, !LAgmat (a, mo, p+p, q+q)
, !LAgmat (a, mo, q+q, r+r)
, beta: a
, !LAgmat (a, mo, p+p, r+r) >> _
, int p, int q, int r
) : void // endfun

(* ****** ****** *)

#define mul00 mul00_LAgmat_LAgmat
#define mul01 mul01_LAgmat_LAgmat
#define mul10 mul10_LAgmat_LAgmat
#define mul11 mul11_LAgmat_LAgmat

(* ****** ****** *)

implement{a}
mul11_LAgmat_LAgmat
  (A, B) = C where
{
//
val p = LAgmat_nrow (A)
val r = LAgmat_ncol (B)
val ord = LAgmat_mord (A)
//
prval () = lemma_LAgmat_param (A)
prval () = lemma_LAgmat_param (B)
//
val C = LAgmat_make_uninitized (ord, p, r)
//
val _1 = gnumber_int<a>(1)
val _0 = gnumber_int<a>(0)
prval () = LAgmat_initize (C)
//
local
implement
blas$_alpha_beta<a> (alpha, x, beta, y) = x
in (* in of [local] *)
val () = LAgmat_gemm_strassen (_1, A, B, _0, C)
end // end of [local]
//
} // end of [mul11_LAgmat_LAgmat]

(* ****** ****** *)

implement{a}
LAgmat_gemm_strassen
  {mo}{n}
(
  alpha, A, B, beta, C
) = let
//
val p = LAgmat_nrow (A)
val q = LAgmat_nrow (B)
val r = LAgmat_ncol (B)
//
prval (
) = lemma_LAgmat_param (A)
prval (
) = lemma_LAgmat_param (B)
//
in
//
if p >= 2 then let
  val p2 = p / 2
  val () = assertloc (p = 2*p2)
in
//
if q >= 2 then let
  val q2 = q / 2
  val () = assertloc (q = 2*q2)
in
//
if r >= 2 then let
  val r2 = r / 2
  val () = assertloc (r = 2*r2)
in
  LAgmat_gemm_strassen2 (alpha, A, B, beta, C, p2, q2, r2)
end else
(
  LAgmat_gemm_nn (alpha, A, B, beta, C)
) // end of [if]
//
end else
(
  LAgmat_gemm_nn (alpha, A, B, beta, C)
) // end of [if]
//
end else
(
  LAgmat_gemm_nn (alpha, A, B, beta, C)
) // end of [if]
//
end // end of [LAgmat_gemm_strassen]

(* ****** ****** *)

implement{a}
LAgmat_gemm_strassen2
  {mo}{p,q,r}
(
  alpha, A, B, beta, C, p, q, r
) = let
//
val A = incref (A)
val B = incref (B)
val C = incref (C)
//
val (A11, A12, A21, A22) = LAgmat_split_2x2 (A, p, q)
val (B11, B12, B21, B22) = LAgmat_split_2x2 (B, q, r)
val (C11, C12, C21, C22) = LAgmat_split_2x2 (C, p, r)
//
val M1 = (A11+A22) \mul00 (B11+B22)
val M2 = (A21+A22) \mul01 (B11    )
val M3 = (A11    ) \mul10 (B12-B22)
val M4 = (    A22) \mul10 (B21-B11)
val M5 = (A11+A12) \mul01 (    B22)
val M6 = (A21-A11) \mul00 (B11+B12)
val M7 = (A12-A22) \mul00 (B21+B22)
//
val () = LAgmat_decref4 (A11, A12, A21, A22)
val () = LAgmat_decref4 (B11, B12, B21, B22)
//
val _n1 = gnumber_int<a>(~1)
//
// C11 = M1+M4-M5+M7
//
val T = copy_LAgmat (M1)
val () = LAgmat_1x1y (M4, T)
val () = LAgmat_ax1y (_n1, M5, T)
val () = LAgmat_1x1y (M7, T)
val () = LAgmat_axby (alpha, T, beta, C11)
//
// C12 = M3+M5
//
prval (
) = LAgmat_uninitize (T)
val () = LAgmat_copy (M3, T)
val () = LAgmat_1x1y (M5, T)
val () = LAgmat_axby (alpha, T, beta, C12)
//
// C21 = M2+M4
//
prval (
) = LAgmat_uninitize (T)
val () = LAgmat_copy (M2, T)
val () = LAgmat_1x1y (M4, T)
val () = LAgmat_axby (alpha, T, beta, C21)
//
// C22 = M1-M2+M3+M6
//
prval (
) = LAgmat_uninitize (T)
val () = LAgmat_copy (M1, T)
val () = LAgmat_ax1y (_n1, M2, T)
val () = LAgmat_1x1y (M3, T)
val () = LAgmat_1x1y (M6, T)
val () = LAgmat_axby (alpha, T, beta, C22)
//
val () = LAgmat_decref (T)
val () = LAgmat_decref3 (M1, M2, M3)
val () = LAgmat_decref4 (M4, M5, M6, M7)
//
val () = LAgmat_decref4 (C11, C12, C21, C22)
//
in
  // nothing
end // end of [LAgmat_gemm_strassen2]

(* ****** ****** *)

val () =
{
//
typedef T = int
val out = stdout_ref
//
val ord = MORDcol
val nrow = 4 and ncol = 4
//
local
implement
LAgmat_tabulate$fopr<T>
  (i, j) = gnumber_int<T>(i+j)
in
val A = LAgmat_tabulate<T> (ord, nrow, ncol)
val B = LAgmat_tabulate<T> (ord, ncol, nrow)
end
//
val AB = A \mul11 B
//
implement
fprint_val<T> (out, x) =
ignoret (
  $extfcall (int, "fprintf", out, "%2.2d", x)
) // end of [fprint_val]
implement
fprint_LAgmat$sep2<> (out) = fprint_newline (out)
val () = fprintln! (out, "A =\n", A)
val () = fprintln! (out, "B =\n", B)
val () = fprintln! (out, "AB =\n", AB)
//
val () = decref (A)
val () = decref (B)
val () = decref (AB)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test_Strassen.dats] *)
