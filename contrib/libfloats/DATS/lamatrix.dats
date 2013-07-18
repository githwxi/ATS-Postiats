(* ****** ****** *)
//
// Linear Algebra matrix operations
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
LAgmat_1x1y
(
  A, B
) = let
//
val _1 = gnumber_int<a>(1)
//
implement
blas$_alpha_beta<a>
  (alpha, x, beta, y) = gadd_val<a> (x, y)
//
in
  LAgmat_axby (_1, A, _1, B)
end // end of [LAgmat_1x1y]

(* ****** ****** *)

implement
{a}(*tmp*)
LAgmat_ax1y
(
  alpha, A, B
) = let
//
val _1 = gnumber_int<a>(1)
implement
blas$_alpha_beta<a>
  (alpha, x, beta, y) = blas$_alpha_1<a> (alpha, x, y)
//
in
  LAgmat_axby (alpha, A, _1, B)
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
add11_LAgmat_LAgmat
  (A, B) = res where
{
//
val res = copy_LAgmat (B)
val ((*void*)) = LAgmat_1x1y (A, res)
//
} // end of [add11_LAgmat_LAgmat]

(* ****** ****** *)

implement{a}
sub11_LAgmat_LAgmat
  (A, B) = res where
{
//
val _n1 = gnumber_int<a>(~1)
val res = scal_LAgmat (_n1, B)
val ((*void*)) = LAgmat_1x1y (A, res)
//
} // end of [sub11_LAgmat_LAgmat]

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
