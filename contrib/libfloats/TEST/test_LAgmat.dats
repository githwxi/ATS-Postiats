(* ****** ****** ****** ****** ****** ****** ****** ****** *)
//
// Some test for Linear Algebra vector and matrix operations
//
(* ****** ****** ****** ****** ****** ****** ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

(* Author: Brandon Barker *)
(* Authoremail: brandon.barker AT gmail DOT com *)
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

staload "libats/SATS/gmatrix.sats"
staload _ = "libats/DATS/gvector.dats"
staload _ = "libats/DATS/gmatrix.dats"
staload _ = "libats/DATS/gmatrix_row.dats"
staload _ = "libats/DATS/gmatrix_col.dats"
staload _ = "libats/DATS/refcount.dats"

(* ****** ****** *)

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
//
// HX: a hackery of a little fun
//
#define t 't'
infixr ^
macdef ^ (M, t) = transp_LAgmat (,(M))
//
(* ****** ****** *)

val () =
{
//
typedef T = double
//
val out = stdout_ref
//
macdef
gint = gnumber_int<T>
//
implement
fprint_val<T> (out, x) = ignoret
(
  $extfcall (int, "fprintf", out, "%.2f", x)
)
//
val ord = MORDcol
val M = 3 and N = 5
//
//
local
implement
LAgmat_tabulate$fopr<T> (i, j) = $UN.cast{T}(i+j)
in
val A = LAgmat_tabulate<T> (ord, M, N)
end // end of [local]
//
local
implement
LAgmat_tabulate$fopr<T> (i, j) = $UN.cast{T}(i+j)
in
val B = LAgmat_tabulate<T> (ord, M, N)
end // end of [local]
//
val () = fprint (out, "A =\n")
val () = fprint_LAgmat_sep (out, A, ", ", "\n")
val () = fprint_newline (out)
//
val () = fprint (out, "B =\n")
val () = fprint_LAgmat_sep (out, B, ", ", "\n")
val () = fprint_newline (out)
//
val AB_sum = A + B
val () = fprint (out, "A + B =\n")
val () = fprint_LAgmat_sep (out, AB_sum, ", ", "\n")
val () = fprint_newline (out)
val () = LAgmat_decref (B)
val () = LAgmat_decref (AB_sum)
//
val A_t = A^t
val () = fprint (out, "A' =\n")
val () = fprint_LAgmat_sep (out, A_t, ", ", "\n")
val () = fprint_newline (out)
val AAt = A * A_t
val () = fprint (out, "A * A' =\n")
val () = fprint_LAgmat_sep (out, AAt, ", ", "\n")
val () = fprint_newline (out)
val () = LAgmat_decref (AAt)
val AtA = A_t * A
val () = fprint (out, "A' * A =\n")
val () = fprint_LAgmat_sep (out, AtA, ", ", "\n")
val () = fprint_newline (out)
val () = LAgmat_decref (AtA)
//
val () = LAgmat_decref (A_t)
//
val (Af2, Al3) = LAgmat_split_1x2(A, 2)
//
val () = fprintln! (out, "First two columns of A: ")
val () = fprint_LAgmat_sep (out, Af2, ", ", "\n")
val () = fprint_newline (out)
//
val () = fprintln! (out, "Last three columns of A: ")
val () = fprint_LAgmat_sep (out, Al3, ", ", "\n")
val () = fprint_newline (out)
//
val () = LAgmat_decref (Af2)
val () = LAgmat_decref (Al3)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test_LAgmat.dats] *)
