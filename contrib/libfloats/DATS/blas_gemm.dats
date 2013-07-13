(* ****** ****** *)
//
// Basic Linear Algebraic System in ATS
//
(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"
staload "libats/SATS/gmatrix_row.sats"

(* ****** ****** *)

staload "libfloats/SATS/blas.sats"

(* ****** ****** *)

implement{a}
blas_gemm_row_row_row
  {p,q,r}{lda,ldb,ldc}
(
  A, B, C, p, q, r, lda, ldb, ldc
) = let
//
prval () = lemma_gmatrow_param (A)
prval () = lemma_gmatrow_param (B)
prval () = lemma_gmatrow_param (C)
//
fun loop
  {la,lb,lc,lt:addr}{r:nat} .<r>.
(
  pfa: !GMR (a, la, p, q, lda)
, pfb: !GMR (a, lb, q, r, ldb)
, pfc: !GMR (a, lc, p, r, ldc) >> _
, pft: !array_v(a?, lt, q) >> _
| pa: ptr la, pb: ptr lb, pc: ptr lc, pt: ptr lt, r: int r
) : void =
(
if r > 0 then let
//
prval
(
  pfb1, pfb2
) = gmatrow_v_uncons2 (pfb)
prval
(
  pfc1, pfc2
) = gmatrow_v_uncons2 (pfc)
//
prval () = array2gvector (!pt)
val () = blas_copy (!pb, !pt, q, ldb, 1)
//
local
implement
blas_gemv$ab<a> (x, y) = blas_gemm$ab<a> (x, y)
in (* in of [local] *)
val () = blas_gemv_row (!pa, !pt, !pc, p, q, lda, 1, ldc)
end (* end of [local] *)
//
prval () = gvector2array (!pt)
//
val (
) = loop (
  pfa, pfb2, pfc2, pft
| pa, ptr_succ<a> (pb), ptr_succ<a> (pc), pt, pred(r)
) (* end of [val] *)
//
prval () = pfb := gmatrow_v_cons2 (pfb1, pfb2)
prval () = pfc := gmatrow_v_cons2 (pfc1, pfc2)
//
in
  // nothing
end else let
//
(*
prval () = (pfc := gmatrow_v_unnil2_nil2{a?,a}(pfc))
*)
//
in
  // nothing
end // end of [if]
)
//
val qsz = i2sz(q)
val [lt:addr]
  (pft, pftgc | pt) = array_ptr_alloc<a> (qsz)
//
val (
) = loop (
  view@A, view@B, view@C, pft | addr@A, addr@B, addr@C, pt, r
) (* end of [val] *)
//
val ((*void*)) = array_ptr_free (pft, pftgc | pt)
//
in
  // nothing
end // end of [blas_gemm_row_row_row]

(* ****** ****** *)

implement{a}
blas_gemm_col_col_col
  {p,q,r}{lda,ldb,ldc}
(
  A, B, C, p, q, r, lda, ldb, ldc
) = let
//
prval () = lemma_gmatcol_param (A)
prval () = lemma_gmatcol_param (B)
prval () = lemma_gmatcol_param (C)
//
fun loop
  {la,lb,lc,lt:addr}{p:nat} .<p>.
(
  pfa: !GMC (a, la, p, q, lda)
, pfb: !GMC (a, lb, q, r, ldb)
, pfc: !GMC (a, lc, p, r, ldc) >> _
, pft: !array_v(a?, lt, q) >> _
| pa: ptr la, pb: ptr lb, pc: ptr lc, pt: ptr lt, p: int p
) : void =
(
if p > 0 then let
//
prval
(
  pfa1, pfa2
) = gmatcol_v_uncons2 (pfa)
prval
(
  pfc1, pfc2
) = gmatcol_v_uncons2 (pfc)
//
prval () = array2gvector (!pt)
val () = blas_copy (!pa, !pt, q, lda, 1)
//
local
implement
blas_gemv$ab<a> (x, y) = blas_gemm$ab<a> (x, y)
in (* in of [local] *)
val () = blas_gemv_colt (!pb, !pt, !pc, q, r, ldb, 1, ldc)
end (* end of [local] *)
//
prval () = gvector2array (!pt)
//
val (
) = loop (
  pfa2, pfb, pfc2, pft
| ptr_succ<a> (pa), pb, ptr_succ<a> (pc), pt, pred(p)
) (* end of [val] *)
//
prval () = pfa := gmatcol_v_cons2 (pfa1, pfa2)
prval () = pfc := gmatcol_v_cons2 (pfc1, pfc2)
//
in
  // nothing
end else let
//
prval () = (pfc := gmatcol_v_unnil2_nil2{a?,a}(pfc))
//
in
  // nothing
end // end of [if]
)
//
val qsz = i2sz(q)
val [lt:addr]
  (pft, pftgc | pt) = array_ptr_alloc<a> (qsz)
//
val (
) = loop (
  view@A, view@B, view@C, pft | addr@A, addr@B, addr@C, pt, p
) (* end of [val] *)
//
val ((*void*)) = array_ptr_free (pft, pftgc | pt)
//
in
  // nothing
end // end of [blas_gemm_col_col_col]

(* ****** ****** *)

(* end of [blas_gemm.dats] *)
