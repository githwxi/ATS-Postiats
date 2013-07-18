(* ****** ****** *)
//
// Basic Linear Algebra Subprograms in ATS
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"
staload "libats/SATS/gmatrix_row.sats"

(* ****** ****** *)

staload "libfloats/SATS/blas.sats"

(* ****** ****** *)

staload "libfloats/SATS/lavector.sats"
staload "libfloats/SATS/lamatrix.sats"

(* ****** ****** *)

implement
{a}(*tmp*)
LAgmat_ax1y
(
  alpha, A, B
) = let
//
val beta = gnumber_int(1)
implement
blas$_alpha_beta<a>
  (alpha, x, beta, y) = blas$_alpha_1<a> (alpha, x, y)
//
in
  LAgmat_axby (alpha, A, beta, B)
end // end of [LAgmat_ax1y]

(* ****** ****** *)

implement
{a}(*tmp*)
LAgmat_axby
(
  alpha, A, beta, B
) = let
//
val mo = LAgmat_mord (A)
val nrow = LAgmat_nrow (A)
val ncol = LAgmat_ncol (A)
//
var lda: int and ldb
val (pfA, fpfA | pA) = LAgmat_takeout_matrix (A, lda)
val (pfB, fpfB | pB) = LAgmat_takeout_matrix (B, ldb)
//
val () =
(
case+ mo of
| MORDrow () =>
    blas_axby2_row (alpha, !pA, beta, !pB, nrow, ncol, lda, ldb)
| MORDcol () =>
    blas_axby2_col (alpha, !pA, beta, !pB, nrow, ncol, lda, ldb)
) : void // end of [val]
//
prval () = fpfA (pfA)
prval () = fpfB (pfB)
//
in
  // nothing
end // end of [LAgmat_axby]

(* ****** ****** *)

implement{a}
mul00_LAgmat_LAgmat
  (A, B) = AB where
{
val AB = A * B
val () = LAgmat_decref2 (A, B)
} // end of [mul00_LAgmat_LAgmat]

implement{a}
mul01_LAgmat_LAgmat
  (A, B) = AB where
{
val AB = A * B
val () = LAgmat_decref (A)
} // end of [mul00_LAgmat_LAgmat]

implement{a}
mul10_LAgmat_LAgmat
  (A, B) = AB where
{
val AB = A * B
val () = LAgmat_decref (B)
} // end of [mul00_LAgmat_LAgmat]

(* ****** ****** *)

(* end of [lamatrix.dats] *)
