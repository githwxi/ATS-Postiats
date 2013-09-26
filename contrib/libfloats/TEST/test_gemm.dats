//
// Some testing code for gemm-functions
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

val () =
{
//
typedef T = float
//
val out = stdout_ref
//
macdef
gint = gnumber_int<T>
//
val M = 10 and N = 20
//
implement
matrix_tabulate$fopr<T> (i, j) = $UN.cast{T}(i*j)
val (pfM, pfMgc | pM) = matrix_ptr_tabulate<T> (i2sz(M), i2sz(N))
//
implement
matrix_tabulate$fopr<T> (i, j) = (    gint(0)    )
val (pfM2, pfM2gc | pM2) = matrix_ptr_tabulate<T> (i2sz(M), i2sz(M))
//
prval () = matrix2gmatrow (!pM)
prval () = matrix2gmatrow (!pM2)
//
val () = blas_gemm_row_nt (gint(1), !pM, !pM, gint(0), !pM2, M, N, M, N, N, M)
//
prval () = gmatrow2matrix (!pM)
prval () = gmatrow2matrix (!pM2)
//
implement
fprint_val<T> (out, x) =
  ignoret ($extfcall (int, "fprintf", out, "%.2f", x))
//
val () = fprintln! (out, "M =")
val () = fprint_matrix_sep (out, !pM, i2sz(M), i2sz(N), "; ", "\n")
val () = fprint_newline (out)
val () = fprintln! (out, "M2 =")
val () = fprint_matrix_sep (out, !pM2, i2sz(M), i2sz(M), "; ", "\n")
val () = fprint_newline (out)
//
val () = matrix_ptr_free (pfM, pfMgc | pM)
val () = matrix_ptr_free (pfM2, pfM2gc | pM2)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test_gemm.dats] *)
