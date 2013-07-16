(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"

(* ****** ****** *)

implement{a}
gmatcol_get_at
  (M, ld, i, j) = let
//
val pij =
  gmatcol_getref_at<a> (M, ld, i, j) in $UN.cptr_get<a> (pij)
//
end // end of [gmatcol_get_at]

implement{a}
gmatcol_set_at
  (M, ld, i, j, x) = let
//
val pij =
  gmatcol_getref_at<a> (M, ld, i, j) in $UN.cptr_set<a> (pij, x)
//
end // end of [gmatcol_set_at]

(* ****** ****** *)

implement{a}
gmatcol_getref_at
  (M, ld, i, j) = let
//
val p = $UN.cast2Ptr1(ptr_add<a> (addr@M, i+j*ld))
//
in
  $UN.ptr2cptr{a}(p)
end // end of [gmatcol_getref_at]

(* ****** ****** *)

implement{a}
gmatcol_getref_row_at
  {m,n}{ld}(M, ld, i) = let
//
val prow = $UN.cast2Ptr1(ptr_add<a> (addr@M, i))
//
in
  $UN.ptr2cptr{GVT(a,n,ld)}(prow)
end // end of [gmatcol_getref_row_at]

implement{a}
gmatcol_getref_col_at
  {m,n}{ld}(M, ld, j) = let
//
val pcol = $UN.cast2Ptr1(ptr_add<a> (addr@M, j*ld))
//
in
  $UN.ptr2cptr{GVT(a,m,1(*d*))}(pcol)
end // end of [gmatcol_getref_col_at]

(* ****** ****** *)

implement{a}
gmatcol_interchange_row
  {m,n}{ld}
(
  M, n, ld, i1, i2
) = let
in
//
if i1 != i2 then let
//
val cp1 =
  gmatcol_getref_row_at (M, ld, i1)
val cp2 =
  gmatcol_getref_row_at (M, ld, i2)
//
prval
(pf1, fpf1 | p1) = $UN.cptr_vtake (cp1)
prval
(pf2, fpf2 | p2) = $UN.cptr_vtake (cp2)
//
val () = gvector_exchange (!p1, !p2, n, ld, ld)
//
prval () = fpf1 (pf1) and () = fpf2 (pf2)
//
in
  // nothing
end else () // end of [if]
//
end (* end of [gmatcol_interchange_row] *)

(* ****** ****** *)

implement{a}
gmatcol_interchange_col
  {m,n}{ld}
(
  M, m, ld, j1, j2
) = let
in
//
if j1 != j2 then let
//
val cp1 =
  gmatcol_getref_col_at (M, ld, j1)
val cp2 =
  gmatcol_getref_col_at (M, ld, j2)
//
prval
(pf1, fpf1 | p1) = $UN.cptr_vtake (cp1)
prval
(pf2, fpf2 | p2) = $UN.cptr_vtake (cp2)
//
val () = gvector_exchange (!p1, !p2, m, 1, 1)
//
prval () = fpf1 (pf1) and () = fpf2 (pf2)
//
in
  // nothing
end else () // end of [if]
//
end (* end of [gmatcol_interchange_col] *)

(* ****** ****** *)

implement
{a}(*tmp*)
gmatcol_copyto
  {m,n}{ldx,ldy}
(
  X2, Y2, m, n, ldx, ldy
) = let
//
prval (
) = __initize (Y2) where
{
extern praxi
__initize (&GMC(a?, m, n, ldy) >> GMC(a, m, n, ldy)): void
} (* end of [where] *) // end of [prval]
//
implement(env)
gmatcol_foreachcol2$fwork<a,a><env>
  (X, Y, m, env) = gvector_copyto (X, Y, m, 1, 1)
//
val () = gmatcol_foreachcol2<a,a> (X2, Y2, m, n, ldx, ldy)
//
in
  // nothing
end // end of [gmatcol_copyto]

(* ****** ****** *)

implement
{a}(*tmp*)
gmatcol_imake_matrixptr
  (M, m, n, ld) = let
//
prval () = gmatrix_flipord (M)
val matres = gmatrow_imake_matrixptr (M, n, m, ld)
prval () = gmatrix_flipord (M)
//
in
  matres
end // end of [gmatcol_imake_matrixptr]

(* ****** ****** *)

implement{a}
gmatcol_ptr_split2x2
  (pf | p, ld, i, j) = let
//
val j_ld = j * ld
val p01 = ptr_add<a> (p, j_ld  )
val p10 = ptr_add<a> (p, i     )
val p11 = ptr_add<a> (p, i+j_ld)
prval (pf00, pf01, pf10, pf11) = gmatcol_v_split2x2 (pf, i, j)
//
in
  (pf00, pf01, pf10, pf11, gmatcol_v_unsplit2x2 | p01, p10, p11)
end // end of [gmatcol_ptr_split2x2]

(* ****** ****** *)

implement{a}
gmatcol_foreachcol
  (M, m, n, ld) = let
  var env: void = () in
  gmatcol_foreachcol_env<a><void> (M, m, n, ld, env)
end // end of [gmatcol_foreach]

(* ****** ****** *)

implement{a1,a2}
gmatcol_foreachcol2
  (M1, M2, m, n, ld1, ld2) = let
  var env: void = () in
  gmatcol_foreachcol2_env<a1,a2><void> (M1, M2, m, n, ld1, ld2, env)
end // end of [gmatrix_foreachcol2]

implement
{a1,a2}{env}
gmatcol_foreachcol2_env
  {m,n}{lda,ldb}
(
  A, B, m, n, lda, ldb, env
) = let
//
fun loop
  {l1,l2:addr}{n:nat} .<n>.
(
  pfX: !GMC(a1, l1, m, n, lda)
, pfY: !GMC(a2, l2, m, n, ldb)
| p1: ptr l1, p2: ptr l2, m: int m, env: &env
) : void = let
in
//
if n > 0
then let
//
prval
  (pfX1, pfX2) = gmatcol_v_uncons1 (pfX)
prval
  (pfY1, pfY2) = gmatcol_v_uncons1 (pfY)
//
val () = gmatcol_foreachcol2$fwork<a1,a2><env> (!p1, !p2, n, env)
//
val () = loop
(
  pfX2, pfY2
| ptr_add<a1> (p1, lda), ptr_add<a2> (p2, ldb), pred(n), env
) (* end of [val] *)
//
prval () = pfX := gmatcol_v_cons1 (pfX1, pfX2)
prval () = pfY := gmatcol_v_cons1 (pfY1, pfY2)
//
in
  // nothing
end else let
//
(*
prval () = (pfY := gmatcol_v_renil1 {a,a} (pfY))
*)
//
in
  // nothing
end // end of [if]
//
end // end of [loop]
//
prval () = lemma_gmatcol_param (A)
prval () = lemma_gmatcol_param (B)
//
in
  loop (view@A, view@B | addr@A, addr@B, n, env)
end // end of [gmatcol_foreachcol2]

(* ****** ****** *)

(* end of [gmatrix_col.dats] *)
