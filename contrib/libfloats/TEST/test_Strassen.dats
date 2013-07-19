//
// A naive implementation of
// Strassen's matrix multiplication algorithm
//
(* ****** ****** *)

staload "libats/SATS/gmatrix.sats"
staload "libfloats/SATS/lamatrix.sats"

(* ****** ****** *)

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

#define gint gnumber_int
#define mul00 mul00_LAgmat_LAgmat
#define mul01 mul01_LAgmat_LAgmat
#define mul10 mul10_LAgmat_LAgmat
#define mul11 mul11_LAgmat_LAgmat

(* ****** ****** *)

implement{a}
LAgmat_gemm_strassen2
  {mo}{p,q,r}
(
  alpha, A, B, beta, C, p, q, r
) = let
//
val A = LAgmat_incref (A)
val B = LAgmat_incref (B)
val C = LAgmat_incref (C)
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
val T = copy_LAgmat (M1)
val () = LAgmat_1x1y (M4, T)
val () = LAgmat_ax1y (gint(~1), M5, T)
val () = LAgmat_1x1y (M7, T)
val () = LAgmat_axby (alpha, T, beta, C11)
//
prval (
) = LAgmat_uninitize (T)
val () = LAgmat_copy (M3, T)
val () = LAgmat_1x1y (M5, T)
val () = LAgmat_axby (alpha, T, beta, C12)
//
prval (
) = LAgmat_uninitize (T)
val () = LAgmat_copy (M2, T)
val () = LAgmat_1x1y (M4, T)
val () = LAgmat_axby (alpha, T, beta, C21)
//
prval (
) = LAgmat_uninitize (T)
val () = LAgmat_copy (M1, T)
val () = LAgmat_ax1y (gint(~1), M2, T)
val () = LAgmat_1x1y (M4, T)
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

(* end of [test_Strassen.dats] *)
