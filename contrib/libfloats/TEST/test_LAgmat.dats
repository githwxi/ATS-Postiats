(* ****** ****** ****** ****** ****** ****** ****** ****** *)
//
// Some test for Linear Algebra vector and matrix operations
//
(* ****** ****** ****** ****** ****** ****** ****** ****** *)

#include
"share/atspre_staload_tmpdef.hats"
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

staload "libfloats/SATS/lavector.sats"
staload "libfloats/SATS/lamatrix.sats"

(* ****** ****** *)

staload _ = "libfloats/DATS/blas0.dats"
staload _ = "libfloats/DATS/blas1.dats"
staload _ = "libfloats/DATS/lavector.dats"
staload _ = "libfloats/DATS/lamatrix.dats"

(* ****** ****** *)

#define t 't'

(* ****** ****** *)

infixr ^
macdef ^ (M, t) = LAgmat_transp (,(M))

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
val M = 3 and N = 5
//
//
local
implement
LAgmat_tabulate$fopr<T> (i, j) = $UN.cast{T}(i+j)
in
val A = LAgmat_tabulate<T> (MORDcol, M, N)
end // end of [local]
//
local
implement
LAgmat_tabulate$fopr<T> (i, j) = $UN.cast{T}(i-j)
in
val B = LAgmat_tabulate<T> (MORDcol, M, N)
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
//
val () = LAgmat_decref (AB_sum)
//
val () = LAgmat_decref2 (A, B)
//
} (* end of [val] *)

(* ****** ****** *)

(*
val () = 
{
val At = A^t
val AAt = A * At
val () = fprintln! (out, "A' = ", At)
val () = fprintln! (out, "A * A' = ", AAt)
val () = LAgmat_decref (At)
val () = LAgmat_decref (AAt)
//
val (Af2, Al3) = LAgmat_split_1x2(A, 1)
//
val () = fprintln! (out, "First two columns of A: ")
val () = fprint (out, Af2)
val () = fprint_newline (out)
//
val () = fprintln! (out, "Last three columns of A: ")
val () = fprint (out, Al3)
val () = fprint_newline (out)
//
val () = LAgmat_decref (B)
val () = LAgmat_decref (Af2)
val () = LAgmat_decref (Al3)
//
} (* end of [val] *)
*)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test_LAgmat.dats] *)
