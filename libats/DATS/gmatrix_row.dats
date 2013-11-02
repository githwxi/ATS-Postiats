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
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
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
staload "libats/SATS/gmatrix_row.sats"

(* ****** ****** *)

implement{a}
gmatrow_get_at
  (M, ld, i, j) = let
//
val pij =
  gmatrow_getref_at<a> (M, ld, i, j) in $UN.cptr_get<a> (pij)
//
end // end of [gmatrow_get_at]

implement{a}
gmatrow_set_at
  (M, ld, i, j, x) = let
//
val pij =
  gmatrow_getref_at<a> (M, ld, i, j) in $UN.cptr_set<a> (pij, x)
//
end // end of [gmatrow_set_at]

(* ****** ****** *)

implement{a}
gmatrow_getref_at
  (M, ld, i, j) = let
//
val p = $UN.cast2Ptr1(ptr_add<a> (addr@M, i*ld+j))
//
in
  $UN.ptr2cptr{a}(p)
end // end of [gmatrow_getref_at]

(* ****** ****** *)

implement{a}
gmatrow_getref_col_at
  {m,n}{ld}(M, ld, j) = let
//
val pcol = $UN.cast2Ptr1(ptr_add<a> (addr@M, j))
//
in
  $UN.ptr2cptr{GVT(a,m,ld)}(pcol)
end // end of [gmatrow_getref_col_at]

implement{a}
gmatrow_getref_row_at
  {m,n}{ld}(M, ld, i) = let
//
val prow = $UN.cast2Ptr1(ptr_add<a> (addr@M, i*ld))
//
in
  $UN.ptr2cptr{GVT(a,n,1(*d*))}(prow)
end // end of [gmatrow_getref_row_at]

(* ****** ****** *)

implement{a}
gmatrow_interchange_row
  {m,n}{ld}
(
  M, n, ld, i1, i2
) = let
in
//
if i1 != i2 then let
//
val cp1 =
  gmatrow_getref_row_at (M, ld, i1)
val cp2 =
  gmatrow_getref_row_at (M, ld, i2)
//
val
(pf1, fpf1 | p1) = $UN.cptr_vtake (cp1)
val
(pf2, fpf2 | p2) = $UN.cptr_vtake (cp2)
//
val () = gvector_exchange (!p1, !p2, n, 1, 1)
//
prval () = fpf1 (pf1) and () = fpf2 (pf2)
//
in
  // nothing
end else () // end of [if]
//
end (* end of [gmatrow_interchange_row] *)

(* ****** ****** *)

implement{a}
gmatrow_interchange_col
  {m,n}{ld}
(
  M, m, ld, j1, j2
) = let
in
//
if j1 != j2 then let
//
val cp1 =
  gmatrow_getref_col_at (M, ld, j1)
val cp2 =
  gmatrow_getref_col_at (M, ld, j2)
//
val
(pf1, fpf1 | p1) = $UN.cptr_vtake (cp1)
val
(pf2, fpf2 | p2) = $UN.cptr_vtake (cp2)
//
val () = gvector_exchange (!p1, !p2, m, ld, ld)
//
prval () = fpf1 (pf1) and () = fpf2 (pf2)
//
in
  // nothing
end else () // end of [if]
//
end (* end of [gmatrow_interchange_col] *)

(* ****** ****** *)

implement
{a}(*tmp*)
gmatrow_copyto
  {m,n}{ldx,ldy}
(
  X2, Y2, m, n, ldx, ldy
) = let
//
prval (
) = __initize (Y2) where
{
extern praxi
__initize (&GMR(a?, m, n, ldy) >> GMR(a, m, n, ldy)): void
} (* end of [where] *) // end of [prval]
//
implement(env)
gmatrow_foreachrow2$fwork<a,a><env>
  (X, Y, n, env) = let
  prval () = gvector_uninitize (Y) in gvector_copyto<a> (X, Y, n, 1, 1)
end // end of [gmatrow_foreachrow2$fwork]
//
val () = gmatrow_foreachrow2<a,a> (X2, Y2, m, n, ldx, ldy)
//
in
  // nothing
end // end of [gmatrow_copyto]

(* ****** ****** *)

implement
{a}(*tmp*)
gmatrow_transpto
  {m,n}{ldx,ldy}
(
  X2, Y2, m, n, ldx, ldy
) = let
typedef tenv = ptr
implement
gmatrow_foreachrow$fwork<a><tenv>
  {n} (X, n, env) = () where
{
//
typedef tYcol = gvector(a,n,ldy)
//
val pY = env
val () = env := ptr_succ<a> (env)
//
val (pf, fpf | pY) = $UN.ptr_vtake{tYcol}(pY)
//
prval (
) = gvector_uninitize{a}(!pY)
val () = gvector_copyto<a> (X, !pY, n, 1, ldy)
//
prval ((*void*)) = fpf (pf)
//
} // end of [gmatrow_foreachrow$fwork]
//
var env: ptr = addr@Y2
val () = gmatrow_foreachrow_env<a><tenv> (X2, m, n, ldx, env)
//
prval () = gmatrix_initize{a}(Y2)
//
in
  // nothing
end // end of [gmatrow_transpto]

(* ****** ****** *)

implement{a}
gmatrow_ptr_split_2x2
  (pf | p, ld, i, j) = let
//
val i_ld = i * ld
val p01 = ptr_add<a> (p, j     )
val p10 = ptr_add<a> (p, i_ld  )
val p11 = ptr_add<a> (p, i_ld+j)
prval (pf00, pf01, pf10, pf11) = gmatrow_v_split_2x2 (pf, i, j)
//
in
  (pf00, pf01, pf10, pf11, gmatrow_v_unsplit_2x2 | p01, p10, p11)
end // end of [gmatrow_ptr_split_2x2]

(* ****** ****** *)

implement
{a}(*tmp*)
gmatrow_foreachrow
  (M, m, n, ld) = let
  var env: void = () in
  gmatrow_foreachrow_env<a><void> (M, m, n, ld, env)
end // end of [gmatrix_foreachrow]

(* ****** ****** *)

implement
{a}{env}
gmatrow_foreachrow_env
  {m,n}{ld}
  (M, m, n, ld, env) = let
fun loop
  {l:addr}{m:nat} .<m>.
(
  pfM: !GMR(a, l, m, n, ld) | p: ptr l, m: int m, env: &env
) : void = let
in
//
if m > 0
then let
//
prval (pfM1, pfM2) = gmatrow_v_uncons0 (pfM)
val () = gmatrow_foreachrow$fwork<a><env> (!p, n, env)
val () = loop (pfM2 | ptr_add<a> (p, ld), pred(m), env)
prval ((*void*)) = pfM := gmatrow_v_cons0 (pfM1, pfM2)
//
in
  // nothing
end else let
//
(*
prval () = (pfM := gmatrow_v_renil0 {a,a} (pfM))
*)
//
in
  // nothing
end // end of [if]
//
end // end of [loop]
//
prval () = lemma_gmatrow_param (M)
//
in
  loop (view@M | addr@M, m, env)
end // end of [gmatrow_foreachrow_env]

(* ****** ****** *)

implement
{a1,a2}
gmatrow_foreachrow2
  (A, B, m, n, ld1, ld2) = let
  var env: void = () in
  gmatrow_foreachrow2_env<a1,a2><void> (A, B, m, n, ld1, ld2, env)
end // end of [gmatrix_foreachrow2]

implement
{a1,a2}{env}
gmatrow_foreachrow2_env
  {m,n}{lda,ldb}
(
  A, B, m, n, lda, ldb, env
) = let
//
fun loop
  {l1,l2:addr}{m:nat} .<m>.
(
  pfA: !GMR(a1, l1, m, n, lda)
, pfB: !GMR(a2, l2, m, n, ldb)
| p1: ptr l1, p2: ptr l2, m: int m, env: &env
) : void = let
in
//
if m > 0
then let
//
prval
  (pfA1, pfA2) = gmatrow_v_uncons0 (pfA)
prval
  (pfB1, pfB2) = gmatrow_v_uncons0 (pfB)
//
val () = gmatrow_foreachrow2$fwork<a1,a2><env> (!p1, !p2, n, env)
//
val () = loop
(
  pfA2, pfB2
| ptr_add<a1> (p1, lda), ptr_add<a2> (p2, ldb), pred(m), env
) (* end of [val] *)
//
prval () = pfA := gmatrow_v_cons0 (pfA1, pfA2)
prval () = pfB := gmatrow_v_cons0 (pfB1, pfB2)
//
in
  // nothing
end else let
//
(*
prval () = (pfA := gmatrow_v_renil0 {a,a} (pfA))
prval () = (pfB := gmatrow_v_renil0 {a,a} (pfB))
*)
//
in
  // nothing
end // end of [if]
//
end // end of [loop]
//
prval () = lemma_gmatrow_param (A)
prval () = lemma_gmatrow_param (B)
//
in
  loop (view@A, view@B | addr@A, addr@B, m, env)
end // end of [gmatrow_foreachrow2]

(* ****** ****** *)

(* end of [gmatrix_row.dats] *)
