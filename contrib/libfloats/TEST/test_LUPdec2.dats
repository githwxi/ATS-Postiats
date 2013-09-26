//
// A naive implementation of LUP decomposition
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
staload _ = "libats/DATS/gmatrix_col.dats"
staload _ = "libats/DATS/refcount.dats"
//
(* ****** ****** *)
//
staload "./../SATS/blas.sats"
staload "./../SATS/lavector.sats"
staload "./../SATS/lamatrix.sats"
//
staload _ = "./../DATS/blas0.dats"
staload _ = "./../DATS/blas1.dats"
staload _ = "./../DATS/blas_gemv.dats"
staload _ = "./../DATS/blas_gemm.dats"
staload _ = "./../DATS/lavector.dats"
staload _ = "./../DATS/lamatrix.dats"
//
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
end // end of [lapack_LUPdec]

(* ****** ****** *)

implement
main0 () =
{
//
typedef T = double
//
val out = stdout_ref
//
val n = 9
val ord = MORDcol // column-major
//
implement
fprint_val<T> (out, x) =
  ignoret($extfcall (int, "fprintf", out, "%.2f", x))
//
local
implement
LAgmat_tabulate$fopr<T>
  (i, j) = n - $UN.cast{T}(max(i,j))
in
val M = LAgmat_tabulate (ord, n, n)
val M2 = LAgmat_tabulate (ord, n, n)
end // end of [local]
//
val () = fprintln! (out, "M =")
val () = fprint_LAgmat_sep (out, M, ", ", "\n")
val () = fprint_newline (out)
//
val () = lapack_LUPdec<T><T> (M2)
//
val () = fprintln! (out, "L\\U =")
val () = fprint_LAgmat_sep (out, M2, ", ", "\n")
val () = fprint_newline (out)
//
val _0 = gnumber_int<T>(0)
val _1 = gnumber_int<T>(1)
//
local
implement
LAgmat_imake$fopr<T> (i, j, x) =
  if i > j then x else if i >= j then _1 else _0
in (* in of [local] *)
val L = LAgmat_make_arrayptr (ord, LAgmat_imake_arrayptr (M2), n, n)
end // end of [local]
//
local
implement
LAgmat_imake$fopr<T> (i, j, x) = if i <= j then x else _0
in (* in of [local] *)
val U = LAgmat_make_arrayptr (ord, LAgmat_imake_arrayptr (M2), n, n)
end // end of [local]
//
val LU = L * U
val () = fprintln! (out, "L =")
val () = fprint_LAgmat_sep (out, L, ", ", "\n")
val () = fprint_newline (out)
val () = fprintln! (out, "U =")
val () = fprint_LAgmat_sep (out, U, ", ", "\n")
val () = fprint_newline (out)
val () = fprintln! (out, "LU =")
val () = fprint_LAgmat_sep (out, LU, ", ", "\n")
val () = fprint_newline (out)
//
local
implement
LAgmat_iforeach$fwork<T><T>
  (_, _, x, env) = env := env + blas$gnorm2<T><T> (x)
val E = M-LU
var error: T = gnumber_int<T>(0)
val () = LAgmat_iforeach_env<T><T> (E, error)
val () = LAgmat_decref (E)
in (* in of [local] *)
val () = fprintln! (out, "|M-LU|^2 = ", error)
end // end of [local]
//
val () = LAgmat_decref2 (M, M2)
val () = LAgmat_decref3 (L, U, LU)
//
} // end of [main0]

(* ****** ****** *)

(* end of [test_LUPdec2.dats] *)
