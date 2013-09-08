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

implement{a}
blas_outer_row
  {m,n}{d1,d2,ld3}
(
  alpha, V1, V2, M3, m, n, d1, d2, ld3
) = let
//
fun loop
  {l1,l2,l3:addr}{m:nat} .<m>.
(
  pf1: !GVT(a, l1, m, d1)
, pf2: !GVT(a, l2, n, d2)
, pf3: !GMR(a, l3, m, n, ld3) >> _
| p1: ptr l1, p2: ptr l2, p3: ptr l3, m: int m, n: int n
) : void =
(
if m > 0
  then let
//
prval (pf11, pf12) = gvector_v_uncons (pf1)
prval (pf31, pf32) = gmatrow_v_uncons0 (pf3)
//
val k = !p1
val (
) = blas_ax1y<a> (k, !p2, !p3, n, d2, 1)
val (
) = loop
(
  pf12, pf2, pf32
| ptr_add<a> (p1, d1), p2, ptr_add<a> (p3, ld3), pred(m), n
) (* end of [val] *)
//
prval () = pf1 := gvector_v_cons (pf11, pf12)
prval () = pf3 := gmatrow_v_cons0 (pf31, pf32)
//
in
  // nothing
end else let
//
(*
prval () = (pf3 := gmatrow_v_renil0{a?,a}(pf3))
*)
//
in
  // nothing
end // end of [if]
)
//
prval () = lemma_gmatrow_param (M3)
//
in
  loop (view@V1, view@V2, view@M3 | addr@V1, addr@V2, addr@M3, m, n)
end // end of [blas_outer_row]

(* ****** ****** *)

implement{a}
blas_outer_col
  {m,n}{d1,d2,ld3}
(
  alpha, V1, V2, M3, m, n, d1, d2, ld3
) = let
//
fun loop
  {l1,l2,l3:addr}{n:nat} .<n>.
(
  pf1: !GVT(a, l1, m, d1)
, pf2: !GVT(a, l2, n, d2)
, pf3: !GMC(a, l3, m, n, ld3) >> _
| p1: ptr l1, p2: ptr l2, p3: ptr l3, m: int m, n: int n
) : void =
(
if n > 0 then let
//
prval (pf21, pf22) = gvector_v_uncons (pf2)
prval (pf31, pf32) = gmatcol_v_uncons1 (pf3)
//
val alpha2 = gmul_val<a> (alpha, !p2)
val (
) = blas_ax1y<a> (alpha2, !p1, !p3, m, d1, 1)
val (
) = loop
(
  pf1, pf22, pf32
| p1, ptr_add<a> (p2, d2), ptr_add<a> (p3, ld3), m, pred(n)
) (* end of [val] *)
//
prval () = pf2 := gvector_v_cons (pf21, pf22)
prval () = pf3 := gmatcol_v_cons1 (pf31, pf32)
//
in
  // nothing
end else let
//
(*
prval () = (pf3 := gmatcol_v_renil1{a,a}(pf3))
*)
//
in
  // nothing
end // end of [if]
)
//
prval () = lemma_gmatcol_param (M3)
//
in
  loop (view@V1, view@V2, view@M3 | addr@V1, addr@V2, addr@M3, m, n)
end // end of [blas_outer_col]

(* ****** ****** *)

(* end of [blas_outer.dats] *)
