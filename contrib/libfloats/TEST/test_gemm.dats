//
// Some testing code for gemm-functions
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
staload _ = "prelude/DATS/gnumber.dats"
//
(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_row.sats"
staload _ = "libats/DATS/gvector.dats"
staload _ = "libats/DATS/gmatrix.dats"
staload _ = "libats/DATS/gmatrix_row.dats"

(* ****** ****** *)

staload "libfloats/SATS/blas.sats"
staload _ = "libfloats/DATS/blas0.dats"
staload _ = "libfloats/DATS/blas1.dats"
staload _ = "libfloats/DATS/blas_gemv.dats"
staload _ = "libfloats/DATS/blas_gemm.dats"

(* ****** ****** *)

val () =
{
//
typedef T = int
val M = 10 and N = 20
//
val out = stdout_ref
//
implement
matrix_tabulate$fopr<T> (i, j) = g0u2i(i*j)
val (pfM, pfMgc | pM) = matrix_ptr_tabulate<T> (i2sz(M), i2sz(N))
//
implement
matrix_tabulate$fopr<T> (i, j) = (    0    )
val (pfM2, pfM2gc | pM2) = matrix_ptr_tabulate<T> (i2sz(M), i2sz(M))
//
prval () = matrix2gmatrow (!pM)
prval () = matrix2gmatrow (!pM2)
//
local
implement
blas$alphabeta<T> (alpha, x, beta, y) = gmul_val<T> (alpha, x)
in (* in of [local] *)
val () = blas_gemm_row_nt (1, !pM, !pM, 0, !pM2, M, N, M, N, N, M)
end // end of [local]
//
prval () = gmatrow2matrix (!pM)
prval () = gmatrow2matrix (!pM2)
//
val () = fprintln! (out, "M =")
val () = fprint_matrix_sep (out, !pM, i2sz(M), i2sz(N), "; ", "\n")
val () = fprintln! (out)
val () = fprintln! (out, "M2 =")
val () = fprint_matrix_sep (out, !pM2, i2sz(M), i2sz(M), "; ", "\n")
val () = fprintln! (out)
//
val () = matrix_ptr_free (pfM, pfMgc | pM)
val () = matrix_ptr_free (pfM2, pfM2gc | pM2)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test_gemm.dats] *)