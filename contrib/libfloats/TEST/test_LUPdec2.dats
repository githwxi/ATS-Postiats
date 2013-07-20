//
// A naive implementation of LUP decomposition
//
(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)
//
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
staload "libats/SATS/gmatrix_row.sats"
staload _ = "libats/DATS/gvector.dats"
staload _ = "libats/DATS/gmatrix.dats"
staload _ = "libats/DATS/gmatrix_row.dats"
staload _ = "libats/DATS/gmatrix_col.dats"
staload _ = "libats/DATS/refcount.dats"

(* ****** ****** *)

staload "libfloats/SATS/blas.sats"
staload _ = "libfloats/DATS/blas0.dats"
staload _ = "libfloats/DATS/blas1.dats"
staload _ = "libfloats/DATS/blas_gemv.dats"
staload _ = "libfloats/DATS/blas_gemm.dats"

(* ****** ****** *)

staload "libfloats/SATS/lavector.sats"
staload "libfloats/SATS/lamatrix.sats"
staload _ = "libfloats/DATS/lavector.dats"
staload _ = "libfloats/DATS/lamatrix.dats"

(* ****** ****** *)

extern
fun
{a:t0p}
{a2:t0p}
lapack_LUPdec
  {mo:mord}
  {m,n:int | m <= n}
  (M: !LAgmat(a, mo, m, n) >> _): void
// end of [lapack_LUPdec]

(* ****** ****** *)

implement
{a}{a2}
lapack_LUPdec
  {mo}{m,n} (M) = let
//
fun auxpivot
  {m,n:nat |
   1 <= m; m <= n}
(
  M: !LAgmat(a, mo, m, n), n: int n
) : natLt(n) = let
//
var d: int
val
(
  pf, fpf | p
) = LAgmat_vtakeout_row (M, 0, d)
val imax = blas_iamax<a><a2> (!p, n, d)
prval () = fpf (pf)
//
val () = LAgmat_interchange_col (M, 0, imax)
//
in
  imax
end // end of [auxpivot]
//
fun loop
  {m,n:nat | m <= n}
(
  M: LAgmat(a, mo, m, n), m: int m, n: int n
) : void = let
in
if m >= 1 then let
//
val imax = auxpivot (M, n)
(*
val () = println! ("auxpivot: imax = ", imax)
*)
//
val
(
  M00, M01, M10, M11
) = LAgmat_split_2x2 (M, 1, 1)
val a00 = M00[0,0]
val () = LAgmat_decref (M00)
val alpha = grecip_val<a> (a00)
val () = LAgmat_scal (alpha, M10)
val alpha2 = gnumber_int<a>(~1) and _1 = gnumber_int<a>(1)
val () = LAgmat_gemm_nn (alpha2, M10, M01, _1, M11)
//
val () = LAgmat_decref2 (M01, M10)
val () = loop (M11, m-1, n-1)
//
in
  // nothing
end else
(
  LAgmat_decref (M)
) // end of [if]
//
end // end of [loop]
//
prval () = lemma_LAgmat_param (M)
//
val m = LAgmat_nrow (M)
val n = LAgmat_ncol (M)
val () = loop (LAgmat_incref (M), m, n) 
//
in
  // nothing
end // end of [lapack_LUPdec2]

(* ****** ****** *)

implement
main0 () =
{
//
val out = stdout_ref
//
val N = 9
val ord = MORDcol
//
typedef T = double
//
implement
fprint_val<T> (out, x) =
  ignoret($extfcall (int, "fprintf", out, "%.2f", x))
//
implement
LAgmat_tabulate$fopr<T>
  (i, j) = N - $UN.cast{T}(max(i,j))
val M = LAgmat_tabulate (ord, N, N)
//
val () = fprintln! (out, "M =")
val () = fprint_LAgmat_sep (out, M, ", ", "\n")
val () = fprint_newline (out)
//
val () = lapack_LUPdec<T><T> (M)
//
val () = fprintln! (out, "L\\U =")
val () = fprint_LAgmat_sep (out, M, ", ", "\n")
val () = fprint_newline (out)
//
val () = LAgmat_decref (M)
//
} // end of [main0]

(* ****** ****** *)

(* end of [test_LUPdec2.dats] *)
