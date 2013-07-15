//
// A naive implementation of LU decomposition
//
(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"

(* ****** ****** *)

staload "libfloats/SATS/blas.sats"

(* ****** ****** *)

extern
fun{a:t0p}
lapack_LUdec_col
  {m,n:int | m <= n}{ld:int}
  (M: &GMC(a, m, n, ld), int(m), int(n), int(ld)): void
// end of [lapack_LUdec_col]

(* ****** ****** *)

(*
//
// This is by Prof. Shivkumar Chandrasekran
//
#define lu(type, stype)					    \
void lu_ ## stype (int n, int lda, type a[]) {  	    \
                                                            \
  if (n <= 1) return;                                       \
                                                            \
  /* a[1:n-1;0] = a[1:n-1;0] / a[0,0] */                    \
  {                                                         \
    int i;                                                  \
    for (i = 1; i < n; i++) a[i*lda] /= a[0];               \
  };                                                        \
                                                            \
  /* a[1:n-1, 1:n-1] -= a[1:n-1,0] * a[0,1:n-1] / a[0,0] */ \
  cblas_ ## stype ## gemm (                                 \
               CblasRowMajor, CblasNoTrans, CblasNoTrans,   \
	       n-1, n-1, 1, -1, a+lda, lda, a+1, lda,       \
	       1, a+lda+1, lda);                            \
                                                            \
  lu_ ## stype (n-1, lda, a+lda+1);     		    \
  return;                                                   \
}
*)

(* ****** ****** *)

implement
{a}(*tmp*)
lapack_LUdec_col
  (M, m, n, ld) = let
//
val pM = addr@M
//
in
//
if m >= 2 then let
//
val
(
  pf00, pf01
, pf10, pf11, fpf
| pM01, pM10, pM11
) = gmatcol_ptr_split2x2 (view@M | pM, 1, 1)
//
val M00 = gmatcol_get_at (!pM, ld, 0, 0)
val alpha = grecip_val<a> (M00)
val ((*void*)) = blas_scal2_col (alpha, !pM01, 1, n-1, ld)
val alpha2 = gnumber_int(~1) and beta2 = gnumber_int<a> (1)
val (
) = blas_gemm_col_nn
(
  alpha2, !pM10, !pM01, beta2, !pM11, m-1, 1, n-1, ld, ld, ld
) (* end of [val] *)
//
val () = lapack_LUdec_col (!pM11, m-1, n-1, ld)
//
prval () = (view@M := fpf (pf00, pf01, pf10, pf11))
//
in
  // nothing
end else () // end of [if]
//
end // end of [lapack_LUdec]

(* ****** ****** *)

(* end of [test_LUdec.dats] *)
