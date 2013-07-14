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
//
// gemm-functions of col-major
//
(* ****** ****** *)

implement{a}
blas_gemm_row
(
  pfa, pfb
| alpha, A, tra, B, trb, beta, C, p, q, r, lda, ldb, ldc
) = let
in
//
case+ tra of
//
| TPN () => let
    prval TPDIM_N () = pfa
    val (
    ) = case+ trb of
    | TPN () =>
      {
        prval TPDIM_N () = pfb
        val () = blas_gemm_row_nn (alpha, A, B, beta, C, p, q, r, lda, ldb, ldc)
      }
    | TPT () =>
      {
        prval TPDIM_T () = pfb
        val () = blas_gemm_row_nt (alpha, A, B, beta, C, p, q, r, lda, ldb, ldc)
      }
    | TPC () => let
        val () = prerrln! ("blas_gemm: [TPC] not yet supported.") in assertloc (false)
      end // end of [TPC]
  in
    // nothing
  end // end of [TPN]
//
| TPT () => let
    prval TPDIM_T () = pfa
    val (
    ) = case+ trb of
    | TPN () =>
      {
        prval TPDIM_N () = pfb
        val () = blas_gemm_row_tn (alpha, A, B, beta, C, p, q, r, lda, ldb, ldc)
      }
    | TPT () =>
      {
        prval TPDIM_T () = pfb
        val () = blas_gemm_row_tt (alpha, A, B, beta, C, p, q, r, lda, ldb, ldc)
      }
    | TPC () => let
        val () = prerrln! ("blas_gemm: [TPC] not yet supported.") in assertloc (false)
      end // end of [TPC]
  in
    // nothing
  end // end of [TPT]
//
| TPC () => let
    val () = prerrln! ("blas_gemm: [TPC] not yet supported.") in assertloc (false)
  end // end of [TPC]
//
end // end of [blas_gemm_row]

(* ****** ****** *)

implement{a}
blas_gemm_row_nn
  {p,q,r}{lda,ldb,ldc}
(
  alpha, A, B, beta, C, p, q, r, lda, ldb, ldc
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
prval (pfb1, pfb2) = gmatrow_v_uncons1 (pfb)
prval (pfc1, pfc2) = gmatrow_v_uncons1 (pfc)
//
prval () = array2gvector (!pt)
val () = blas_copy<a> (!pb, !pt, q, ldb, 1)
val () = blas_gemv_row (alpha, !pa, !pt, beta, !pc, p, q, lda, 1, ldc)
//
prval () = gvector2array (!pt)
//
val (
) = loop (
  pfa, pfb2, pfc2, pft | pa, ptr_succ<a> (pb), ptr_succ<a> (pc), pt, pred(r)
) (* end of [val] *)
//
prval () = pfb := gmatrow_v_cons1 (pfb1, pfb2)
prval () = pfc := gmatrow_v_cons1 (pfc1, pfc2)
//
in
  // nothing
end else let
//
(*
prval () = (pfc := gmatrow_v_renil1{a,a}(pfc))
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
end // end of [blas_gemm_row_nn]

(* ****** ****** *)

implement{a}
blas_gemm_row_nt
  {p,q,r}{lda,ldb,ldc}
(
  alpha, A, B, beta, C, p, q, r, lda, ldb, ldc
) = let
//
prval () = lemma_gmatrow_param (A)
prval () = lemma_gmatrow_param (B)
prval () = lemma_gmatrow_param (C)
//
fun loop
  {la,lb,lc:addr}{r:nat} .<r>.
(
  pfa: !GMR (a, la, p, q, lda)
, pfb: !GMR (a, lb, r, q, ldb)
, pfc: !GMR (a, lc, p, r, ldc) >> _
| pa: ptr la, pb: ptr lb, pc: ptr lc, r: int r
) : void =
(
if r > 0 then let
//
prval
(
  pfb1, pfb2
) = gmatrow_v_uncons0 (pfb)
prval
(
  pfc1, pfc2
) = gmatrow_v_uncons1 (pfc)
//
val () = blas_gemv_row (alpha, !pa, !pb, beta, !pc, p, q, lda, 1, ldc)
//
val (
) = loop (
  pfa, pfb2, pfc2 | pa, ptr_add<a> (pb, ldb), ptr_succ<a> (pc), pred(r)
) (* end of [val] *)
//
prval () = pfb := gmatrow_v_cons0 (pfb1, pfb2)
prval () = pfc := gmatrow_v_cons1 (pfc1, pfc2)
//
in
  // nothing
end else let
//
(*
prval () = (pfc := gmatrow_v_renil1{a,a}(pfc))
*)
//
in
  // nothing
end // end of [if]
)
//
val (
) = loop (
  view@A, view@B, view@C | addr@A, addr@B, addr@C, r
) (* end of [val] *)
//
in
  // nothing
end // end of [blas_gemm_row_nt]

(* ****** ****** *)

implement{a}
blas_gemm_row_tn
  {p,q,r}{lda,ldb,ldc}
(
  alpha, A, B, beta, C, p, q, r, lda, ldb, ldc
) = let
//
prval () = lemma_gmatrow_param (A)
prval () = lemma_gmatrow_param (B)
prval () = lemma_gmatrow_param (C)
//
fun loop
  {la,lb,lc,lt:addr}{r:nat} .<r>.
(
  pfa: !GMR (a, la, q, p, lda)
, pfb: !GMR (a, lb, q, r, ldb)
, pfc: !GMR (a, lc, p, r, ldc) >> _
, pft: !array_v(a?, lt, q) >> _
| pa: ptr la, pb: ptr lb, pc: ptr lc, pt: ptr lt, r: int r
) : void =
(
if r > 0 then let
//
prval (pfb1, pfb2) = gmatrow_v_uncons1 (pfb)
prval (pfc1, pfc2) = gmatrow_v_uncons1 (pfc)
//
prval () = array2gvector (!pt)
val () = blas_copy<a> (!pb, !pt, q, ldb, 1)
val () = blas_gemv_trow (alpha, !pa, !pt, beta, !pc, p, q, lda, 1, ldc)
//
prval () = gvector2array (!pt)
//
val (
) = loop (
  pfa, pfb2, pfc2, pft | pa, ptr_succ<a> (pb), ptr_succ<a> (pc), pt, pred(r)
) (* end of [val] *)
//
prval () = pfb := gmatrow_v_cons1 (pfb1, pfb2)
prval () = pfc := gmatrow_v_cons1 (pfc1, pfc2)
//
in
  // nothing
end else let
//
(*
prval () = (pfc := gmatrow_v_renil1{a,a}(pfc))
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
end // end of [blas_gemm_row_tn]

(* ****** ****** *)

implement{a}
blas_gemm_row_tt
  {p,q,r}{lda,ldb,ldc}
(
  alpha, A, B, beta, C, p, q, r, lda, ldb, ldc
) = let
//
prval () = lemma_gmatrow_param (A)
prval () = lemma_gmatrow_param (B)
prval () = lemma_gmatrow_param (C)
//
fun loop
  {la,lb,lc:addr}{r:nat} .<r>.
(
  pfa: !GMR (a, la, q, p, lda)
, pfb: !GMR (a, lb, r, q, ldb)
, pfc: !GMR (a, lc, p, r, ldc) >> _
| pa: ptr la, pb: ptr lb, pc: ptr lc, r: int r
) : void =
(
if r > 0 then let
//
prval (pfb1, pfb2) = gmatrow_v_uncons0 (pfb)
prval (pfc1, pfc2) = gmatrow_v_uncons1 (pfc)
//
val () = blas_gemv_trow (alpha, !pa, !pb, beta, !pc, p, q, lda, 1, ldc)
//
val (
) = loop (
  pfa, pfb2, pfc2 | pa, ptr_add<a> (pb, ldb), ptr_succ<a> (pc), pred(r)
) (* end of [val] *)
//
prval () = pfb := gmatrow_v_cons0 (pfb1, pfb2)
prval () = pfc := gmatrow_v_cons1 (pfc1, pfc2)
//
in
  // nothing
end else let
//
(*
prval () = (pfc := gmatrow_v_renil1{a,a}(pfc))
*)
//
in
  // nothing
end // end of [if]
)
//
val (
) = loop (
  view@A, view@B, view@C | addr@A, addr@B, addr@C, r
) (* end of [val] *)
//
in
  // nothing
end // end of [blas_gemm_row_tt]

(* ****** ****** *)
//
// gemm-functions of col-major
//
(* ****** ****** *)

implement{a}
blas_gemm_col
(
  pfa, pfb
| alpha, A, tra, B, trb, beta, C, p, q, r, lda, ldb, ldc
) = let
//
val pfa = transpdim_transp (pfa)
val pfb = transpdim_transp (pfb)
//
prval () = gmatrix_transp (A)
prval () = gmatrix_transp (B)
prval () = gmatrix_transp (C)
val () = blas_gemm_row (pfb, pfa | alpha, B, trb, A, tra, beta, C, r, q, p, ldb, lda, ldc)
prval () = gmatrix_transp (A)
prval () = gmatrix_transp (B)
prval () = gmatrix_transp (C)
//
in
  // nothing
end // end of [blas_gemm_col]

(* ****** ****** *)

implement{a}
blas_gemm_col_nn
  {p,q,r}{lda,ldb,ldc}
(
  alpha, A, B, beta, C, p, q, r, lda, ldb, ldc
) = let
//
prval () = gmatrix_transp (A)
prval () = gmatrix_transp (B)
prval () = gmatrix_transp (C)
//
val () = blas_gemm_row_nn (alpha, B, A, beta, C, r, q, p, ldb, lda, ldc)
//
prval () = gmatrix_transp (A)
prval () = gmatrix_transp (B)
prval () = gmatrix_transp (C)
//
in
  // nothing
end // end of [blas_gemm_col_nn]

(* ****** ****** *)

implement{a}
blas_gemm_col_nt
  {p,q,r}{lda,ldb,ldc}
(
  alpha, A, B, beta, C, p, q, r, lda, ldb, ldc
) = let
//
prval () = gmatrix_transp (A)
prval () = gmatrix_transp (B)
prval () = gmatrix_transp (C)
//
val () = blas_gemm_row_tn (alpha, B, A, beta, C, r, q, p, ldb, lda, ldc)
//
prval () = gmatrix_transp (A)
prval () = gmatrix_transp (B)
prval () = gmatrix_transp (C)
//
in
  // nothing
end // end of [blas_gemm_col_nt]

(* ****** ****** *)

implement{a}
blas_gemm_col_tn
  {p,q,r}{lda,ldb,ldc}
(
  alpha, A, B, beta, C, p, q, r, lda, ldb, ldc
) = let
//
prval () = gmatrix_transp (A)
prval () = gmatrix_transp (B)
prval () = gmatrix_transp (C)
//
val () = blas_gemm_row_nt (alpha, B, A, beta, C, r, q, p, ldb, lda, ldc)
//
prval () = gmatrix_transp (A)
prval () = gmatrix_transp (B)
prval () = gmatrix_transp (C)
//
in
  // nothing
end // end of [blas_gemm_col_tn]

(* ****** ****** *)

implement{a}
blas_gemm_col_tt
  {p,q,r}{lda,ldb,ldc}
(
  alpha, A, B, beta, C, p, q, r, lda, ldb, ldc
) = let
//
prval () = gmatrix_transp (A)
prval () = gmatrix_transp (B)
prval () = gmatrix_transp (C)
//
val () = blas_gemm_row_tt (alpha, B, A, beta, C, r, q, p, ldb, lda, ldc)
//
prval () = gmatrix_transp (A)
prval () = gmatrix_transp (B)
prval () = gmatrix_transp (C)
//
in
  // nothing
end // end of [blas_gemm_col_tt]

(* ****** ****** *)

(* end of [blas_gemm.dats] *)
