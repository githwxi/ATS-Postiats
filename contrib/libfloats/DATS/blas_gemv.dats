(* ****** ****** *)
//
// Basic Linear Algebra Subprograms in ATS
//
(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"
staload "libats/SATS/gmatrix_row.sats"

(* ****** ****** *)

staload "./../SATS/blas.sats"

(* ****** ****** *)

(*
//
// HX-2013-07:
// This one works but it makes use of
// unsafe features.
//
local

staload UN = "prelude/SATS/unsafe.sats"

in (* in of [local] *)

implement
{a}(*tmp*)
blas_gemv_row
  {m,n}{ld1,d2,d3}
(
  alpha, M1, V2, beta, V3, m, n, ld1, d2, d3
) = let
val p2 = addr@V2
typedef tenv = ptr
implement
gmatrow_foreachrow$fwork<a><tenv>
  {n} (X, n, env) = let
//
prval
(
  pf2, fpf
) =
  $UN.ptr_vtake{gvector(a,n,d2)}(p2)
//
val x = blas_inner<a> (X, !p2, n, 1, d2)
prval () = fpf (pf2)
//
val p3 = env
val y = $UN.ptr0_get<a> (p3)
val () = $UN.ptr0_set<a> (p3, blas$_alpha_beta<a> (alpha, x, beta, y))
val () = env := ptr_add<a> (p3, d3)
//
in
  // nothing
end // end of [gmatrow_foreachrow$fwork]
//
var env: tenv = addr@V3
val () = gmatrow_foreachrow_env<a><tenv> (M1, m, n, ld1, env)
//
in
  // nothing
end // end of [blas_gemv_row]

end // end of [local]
*)

(* ****** ****** *)
(*
//
// HX-2013-07:
// looping is performed row-by-row
//
*)
implement
{a}(*tmp*)
blas_gemv_row_n
  {m,n}{ld1,d2,d3}
(
  alpha, M1, V2, beta, V3, m, n, ld1, d2, d3
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
prval
  (pf11, pf12) = gmatrow_v_uncons0 (pf1)
prval (pf31, pf32) = gvector_v_uncons (pf3)
//
val x = blas_inner<a> (!p1, !p2, n, 1, d2)
val (
) = (!p3 := blas$_alpha_beta<a> (alpha, x, beta, !p3))
val () = loop
(
  pf12, pf2, pf32
| ptr_add<a> (p1, ld1), p2, ptr_add<a> (p3, d3), pred(m)
) (* end of [val] *)
//
prval (
) = (pf1 := gmatrow_v_cons0 (pf11, pf12))
prval () = pf3 := gvector_v_cons (pf31, pf32)
//
in
  // nothing
end else let
//
(*
prval () = pf3 := gvector_v_renil{a,a}(pf3)
*)
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
end // end of [blas_gemv_row_n]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_gemv_row_t
  {m,n}{ld1,d2,d3}
(
  alpha, M1, V2, beta, V3, m, n, ld1, d2, d3
) = let
//
prval (
) = gmatrix_flipord (M1)
val () = blas_gemv_col_n (alpha, M1, V2, beta, V3, m, n, ld1, d2, d3)
prval (
) = gmatrix_flipord (M1)
//
in
  // nothing
end // end of [blas_gemv_row_t]

(* ****** ****** *)
(*
//
// HX-2013-07:
// looping is performed column-by-column 
//
*)
implement
{a}(*tmp*)
blas_gemv_col_n
  {m,n}{ld1,d2,d3}
(
  alpha, M1, V2, beta, V3, m, n, ld1, d2, d3
) = let
//
fun loop
  {l1,l2,lt:addr}{n:nat} .<n>.
(
  pf1: !GMC(a, l1, m, n, ld1)
, pf2: !GVT(a, l2, n, d2)
, pft: !array_v (a, lt, m) >> _
| p1: ptr(l1), p2: ptr(l2), pt: ptr(lt), n: int n
) : void = let
in
//
if n > 0
then let
//
prval (pf21, pf22) = gvector_v_uncons (pf2)
prval (pf11, pf12) = gmatcol_v_uncons1 (pf1)
//
prval () = array2gvector (!pt)
val () = blas_ax1y<a> (!p2, !p1, !pt, m, 1, 1)
prval () = gvector2array (!pt)
//
val () = loop
(
  pf12, pf22, pft
| ptr_add<a> (p1, ld1), ptr_add<a> (p2, d2), pt, pred(n)
) (* end of [val] *)
//
prval () = pf2 := gvector_v_cons (pf21, pf22)
prval () = pf1 := gmatcol_v_cons1 (pf11, pf12)
//
in
  // nothing
end else () // end of [if]
//
end // end of [loop]
//
prval () = lemma_gmatcol_param (M1)
//
val A = // temp
arrayptr_make_elt<a> (i2sz(m), gnumber_int<a>(0))
val pt = ptrcast(A)
prval
pft = arrayptr_takeout (A)
//
val () = loop (view@M1, view@V2, pft | addr@M1, addr@V2, pt, n)
//
prval () = array2gvector (!pt)
val () = blas_axby<a> (alpha, !pt, beta, V3, m, 1, d3)
prval () = gvector2array (!pt)
//
prval
(
) = arrayptr_addback (pft | A)
val ((*void*)) = arrayptr_free (A)
//
in
  // nothing
end // end of [blas_gemv_col]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_gemv_col_t
  {m,n}{ld1,d2,d3}
(
  alpha, M1, V2, beta, V3, m, n, ld1, d2, d3
) = let
//
prval (
) = gmatrix_flipord (M1)
val () = blas_gemv_row_n (alpha, M1, V2, beta, V3, m, n, ld1, d2, d3)
prval (
) = gmatrix_flipord (M1)
//
in
  // nothing
end // end of [blas_gemv_col_t]

(* ****** ****** *)

(* end of [blas_gemv.dats] *)
