//
// A naive implementation of LUP decomposition
//
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
//
(* ****** ****** *)
//
staload "./../SATS/blas.sats"
//
staload _ = "./../DATS/blas0.dats"
staload _ = "./../DATS/blas1.dats"
staload _ = "./../DATS/blas_gemv.dats"
staload _ = "./../DATS/blas_gemm.dats"
//
(* ****** ****** *)

extern
fun
{a:t0p}{a2:t0p}
lapack_LUPdec_row
  {m,n:int | m <= n}{ld:int}
  (M: &GMR(a, m, n, ld), int(m), int(n), int(ld)): void
// end of [lapack_LUPdec_row]

(* ****** ****** *)

implement
{a}{a2}(*tmp*)
lapack_LUPdec_row
  {m,n}{ld}
  (M, m, n, ld) = let
//
fun
auxpivot
  {m >= 1}
(
  M: &GMR(a, m, n, ld), m: int m, n: int n, ld: int ld
) : natLt(n) = let
//
val p = addr@M
//
prval
(pf1, pf2) = gmatrow_v_uncons0 (view@M)
val imax = blas_iamax<a><a2> (!p, n, 1)
prval () = view@M := gmatrow_v_cons0 (pf1, pf2)
//
val () = gmatrow_interchange_col (M, m, ld, 0, imax)
//
in
  imax
end // end of [auxpivot]
//
val pM = addr@M
//
in
//
if m >= 1 then let
//
val imax = auxpivot (M, m, n, ld)
//
val
(
  pf00, pf01
, pf10, pf11, fpf
| pM01, pM10, pM11
) = gmatrow_ptr_split_2x2 (view@M | pM, ld, 1, 1)
//
val M00 = gmatrow_get_at (!pM, ld, 0, 0)
val alpha = grecip_val<a> (M00)
val ((*void*)) = blas_scal2_row (alpha, !pM10, m-1, 1, ld)
val alpha2 = gnumber_int<a>(~1) and beta2 = gnumber_int<a>(1)
val (
) = blas_gemm_row_nn
(
  alpha2, !pM10, !pM01, beta2, !pM11, m-1, 1, n-1, ld, ld, ld
) (* end of [val] *)
//
val () = lapack_LUPdec_row<a><a2> (!pM11, m-1, n-1, ld)
//
prval () = (view@M := fpf (pf00, pf01, pf10, pf11))
//
in
  // nothing
end else () // end of [if]
//
end // end of [lapack_LUPdec_row]

(* ****** ****** *)

implement
main0 () =
{
//
val out = stdout_ref
//
val N = 9
val Nsz = i2sz(N)
//
typedef T = double
typedef T2 = double
//
implement
matrix_tabulate$fopr<T>
  (i, j) = N - $UN.cast{T}(max(i,j))
val (pfM, pfMgc | pM) = matrix_ptr_tabulate<T> (Nsz, Nsz)
//
implement
fprint_val<T> (out, x) =
  ignoret($extfcall (int, "fprintf", out, "%.2f", x))
//
val () = fprintln! (out, "M =")
val () = fprint_matrix_sep (out, !pM, Nsz, Nsz, ", ", "\n")
val () = fprint_newline (out)
//
prval () = matrix2gmatrow (!pM)
val () = lapack_LUPdec_row<T><T2> (!pM, N, N, N)
prval () = gmatrow2matrix (!pM)
//
val () = fprintln! (out, "L\\U =")
val () = fprint_matrix_sep (out, !pM, Nsz, Nsz, ", ", "\n")
val () = fprint_newline (out)
//
prval () = matrix2gmatrow (!pM)
local
implement // LU
gmatrix_imake$fopr<T>
  (i, j, x) =
(
  if i > j then x else
  (
    if i >= j then gnumber_int<T>(1) else gnumber_int<T>(0)
  )
)
in (* in of [local] *)
val L = gmatrix_imake_matrixptr (!pM, MORDrow, N, N, N)
end (* end of [local] *)
//
local
implement // UN
gmatrix_imake$fopr<T>
  (i, j, x) =
(
  if i <= j then x else gnumber_int<T>(0)
)
in (* in of [local] *)
val U = gmatrix_imake_matrixptr (!pM, MORDrow, N, N, N)
end (* end of [local] *)
//
prval () = gmatrow2matrix (!pM)
//
val () = fprintln! (out, "L =")
val () = fprint_matrixptr_sep (out, L, Nsz, Nsz, ", ", "\n")
val () = fprint_newline (out)
//
val () = fprintln! (out, "U =")
val () = fprint_matrixptr_sep (out, U, Nsz, Nsz, ", ", "\n")
val () = fprint_newline (out)
//
val pL = ptrcast (L)
val pU = ptrcast (U)
prval pfL = matrixptr_takeout (L)
prval pfU = matrixptr_takeout (U)
//
val (pfLU, pfLUgc | pLU) = matrix_ptr_alloc<T> (Nsz, Nsz)
//
prval () = matrix2gmatrow (!pL)
prval () = matrix2gmatrow (!pU)
prval () = matrix2gmatrow (!pLU)
prval () = gmatrix_initize (!pLU)
val () = blas_gemm_row_nn (gnumber_int<T>(1), !pL, !pU, gnumber_int<T>(0), !pLU, N, N, N, N, N, N)
prval () = gmatrow2matrix (!pL)
prval () = gmatrow2matrix (!pU)
prval () = gmatrow2matrix (!pLU)
//
val () = fprintln! (out, "LU =")
val () = fprint_matrix_sep (out, !pLU, Nsz, Nsz, ", ", "\n")
val () = fprint_newline (out)
//
prval () = matrixptr_addback (pfL | L)
prval () = matrixptr_addback (pfU | U)
//
val () = matrixptr_free (L)
val () = matrixptr_free (U)
val () = matrix_ptr_free (pfM, pfMgc | pM)
val () = matrix_ptr_free (pfLU, pfLUgc | pLU)
//
} // end of [main0]

(* ****** ****** *)

(* end of [test_LUPdec.dats] *)
