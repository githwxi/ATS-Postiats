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

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"

(* ****** ****** *)

staload "libfloats/SATS/lavector.sats"
staload "libfloats/SATS/lamatrix.sats"

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
val () = fprintln! (out, "A = ", A)
val () = fprintln! (out, "B = ", B)
//
val AB_sum = A + B
val () = fprintln! (out, "A + B = ", AB_sum)
val () = LAgmat_decref (AB_sum)
//
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

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test_LAgmat.dats] *)
