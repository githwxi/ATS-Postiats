(* ****** ****** *)
//
// Basic Linear Algebraic System in ATS
//
(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

(* Author: ... *)
(* Authoremail: ... *)
(* Start time: ... *)

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"
staload "libats/SATS/gmatrix_row.sats"

(* ****** ****** *)

staload "libfloats/SATS/blas.sats"

(* ****** ****** *)

implement
{a}(*tmp*)
blas_gemv_row
  {m,n}{ld1,d2,d3}
(
  M1, V2, V3, m, n, ld1, d2, d3
) = let
//
fun loop
  {l1,l2,l3:addr}{m:nat} .<m>.
(
  pf1: !GMR(a, l1, m, n, ld1)
, pf2: !GVT(a, l2, n, d2)
, pf3: !GVT(a, l3, m, d3) >> _
| p1: ptr(l1), p2: ptr(l2), p3: ptr(l3), m: int m
) : void = let
in
//
if m > 0 then let
//
prval (pf11, pf12) = gmatrow_v_uncons (pf1)
prval (pf31, pf32) = gvector_v_uncons (pf3)
//
val (
) = !p3 :=
  blas_gemv$alphabeta (blas_dot (!p1, !p2, n, 1, d2), !p3)
val () = loop
(
  pf12, pf2, pf32 | ptr_add<a> (p1, ld1), p2, ptr_add<a> (p3, d3), m-1
) (* end of [val] *)
//
prval () = pf1 := gmatrow_v_cons (pf11, pf12)
prval () = pf3 := gvector_v_cons (pf31, pf32)
//
in
  // nothing
end else let
//
prval () = pf3 := gvector_v_unnil_nil{a?,a}(pf3)
//
in
  // nothing
end // end of [if]
//
end // end of [loop]
//
prval () = lemma_gmatrow_param (M1)
//
in
  loop (view@M1, view@V2, view@V3 | addr@M1, addr@V2, addr@V3, m)
end // end of [blas_gemv_row]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_gemv_col
  {m,n}{ld1,d2,d3}
(
  M1, V2, V3, m, n, ld1, d2, d3
) = let
//
fun loop
  {l1,l2,l3:addr}{m:nat} .<m>.
(
  pf1: !GMC(a, l1, m, n, ld1)
, pf2: !GVT(a, l2, n, d2)
, pf3: !GVT(a, l3, m, d3) >> _
| p1: ptr(l1), p2: ptr(l2), p3: ptr(l3), m: int m
) : void = let
in
//
if m > 0 then let
//
prval
  (pf11, pf12) = gmatcol_v_uncons2 (pf1)
prval (pf31, pf32) = gvector_v_uncons (pf3)
//
val (
) = !p3 :=
  blas_gemv$alphabeta (blas_dot (!p1, !p2, n, ld1, d2), !p3)
val () = loop
(
  pf12, pf2, pf32 | ptr_succ<a> (p1), p2, ptr_add<a> (p3, d3), m-1
) (* end of [val] *)
//
prval
  () = pf1 := gmatcol_v_cons2 (pf11, pf12)
prval () = pf3 := gvector_v_cons (pf31, pf32)
//
in
  // nothing
end else let
//
prval () = pf3 := gvector_v_unnil_nil{a?,a}(pf3)
//
in
  // nothing
end // end of [if]
//
end // end of [loop]
//
prval () = lemma_gmatcol_param (M1)
//
in
  loop (view@M1, view@V2, view@V3 | addr@M1, addr@V2, addr@V3, m)
end // end of [blas_gemv_col]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_gemv_rowt
  {m,n}{ld1,d2,d3}
(
  M1, V2, V3, m, n, ld1, d2, d3
) = let
  prval () = gmatrix_trans (M1)
  val () = blas_gemv_col (M1, V2, V3, n, m, ld1, d2, d3)
  prval () = gmatrix_trans (M1)
in
  // nothing
end // end of [blas_gemv_rowt]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_gemv_colt
  {m,n}{ld1,d2,d3}
(
  M1, V2, V3, m, n, ld1, d2, d3
) = let
  prval () = gmatrix_trans (M1)
  val () = blas_gemv_row (M1, V2, V3, n, m, ld1, d2, d3)
  prval () = gmatrix_trans (M1)
in
  // nothing
end // end of [blas_gemv_colt]

(* ****** ****** *)

(* end of [blas_gemv.dats] *)
