//
// A naive implementation
// of Strassen's matrix multiplication algorithm
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
  {mo:mord}{p,q,r:int}
(
  alpha: a
, !LAgmat (a, mo, p+p, q+q)
, !LAgmat (a, mo, q+q, r+r)
, beta: a
, !LAgmat (a, mo, p+p, r+r) >> _
, int p, int q, int r
) : void // endfun

(* ****** ****** *)

implement{a}
LAgmat_gemm_strassen2
  {mo}{p,q,r}
(
  alpha, A, B, beta, C, p, q, r
) = let
//
val (A11, A12, A21, A22) = LAgmat_split_2x2 (A, p, p)
val (B11, B12, B21, B22) = LAgmat_split_2x2 (B, q, q)
val (C11, C12, C21, C22) = LAgmat_split_2x2 (C, r, r)
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
val () = LBgmat_decref4 (B11, B12, B21, B22)
//
val () = LAgmat_copy (M1, C11)
val () = LAgmat_1x1p (M4, C11)
val () = LAgmat_ax1p (gint(~1), M5, C11)
val () = LAgmat_1x1p (M7, C11)
//
val () = LAgmat_copy (M3, C12)
val () = LAgmat_1x1p (M5, C12)
//
val () = LAgmat_copy (M2, C21)
val () = LAgmat_1x1p (M4, C21)
//
val () = LAgmat_copy (M1, C22)
val () = LAgmat_ax1p (gint(~1), M2, C22)
val () = LAgmat_1x1p (M4, C22)
val () = LAgmat_1x1p (M6, C22)
//
val () = LBgmat_decref3 (M1, M2, M3)
val () = LBgmat_decref4 (M4, M5, M6, M7)
//
val () = LAgmat_decref4 (C11, C12, C21, C22)
//
in
  // nothing
end // end of [LAgmat_gemm_strassen]

(* ****** ****** *)

(* end of [test_strassen.dats] *)
