//
// A naive implementation of LU decomposition
//
(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_row.sats"

(* ****** ****** *)

staload "libfloats/SATS/blas.sats"

(* ****** ****** *)

extern
fun
{a:t0p}{a2:t0p}
lapack_LUdec_row
  {m,n:int | m <= n}{ld:int}
  (M: &GMR(a, m, n, ld), int(m), int(n), int(ld)): void
// end of [lapack_LUdec_row]

(* ****** ****** *)

local

fun
{a:t0p}
{a2:t0p}
auxpivot
  {m,n:int | 1 <= m; m <= n}{ld:int}
(
  M: &GMR(a, m, n, ld), m: int m, n: int n, ld: int ld
) : natLt (n) = let
//
val p = addr@M
//
prval
(pf1, pf2) = gmatrow_v_uncons0 (view@M)
val imax = blas_isamax<a><a2> (!p, n, 1)
prval () = view@M := gmatrow_v_cons0 (pf1, pf2)
//
val () = gmatrow_interchange_col (M, ld, 0, imax)
//
in
  imax
end // end of [auxpivot]

in (* in of [local] *)

implement
{a}{a2}(*tmp*)
lapack_LUdec_row
  (M, m, n, ld) = let
//
val pM = addr@M
//
in
//
if m >= 1 then let
//
val imax = auxpivot<a><a2> (M, m, n, ld)
//
val
(
  pf00, pf01
, pf10, pf11, fpf
| pM01, pM10, pM11
) = gmatrow_ptr_split2x2 (view@M | pM, ld, 1, 1)
//
val M00 = gmatrow_get_at (!pM, ld, 0, 0)
val alpha = grecip_val<a> (M00)
val ((*void*)) = blas_scal2_row (alpha, !pM01, 1, n-1, ld)
val alpha2 = gnumber_int(~1) and beta2 = gnumber_int<a> (1)
val (
) = blas_gemm_row_nn
(
  alpha2, !pM10, !pM01, beta2, !pM11, m-1, 1, n-1, ld, ld, ld
) (* end of [val] *)
//
val () = lapack_LUdec_row (!pM11, m-1, n-1, ld)
//
prval () = (view@M := fpf (pf00, pf01, pf10, pf11))
//
in
  // nothing
end else () // end of [if]
//
end // end of [lapack_LUdec]

end (* end of [local] *)

(* ****** ****** *)

(* end of [test_LUdec.dats] *)
