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
  {m,n}{ld}(M, j) = let
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
gmatrow_ptr_split2x2
  (pf | p, ld, i, j) = let
//
val i_ld = i * ld
val p01 = ptr_add<a> (p, j     )
val p10 = ptr_add<a> (p, i_ld  )
val p11 = ptr_add<a> (p, i_ld+j)
prval (pf00, pf01, pf10, pf11) = gmatrow_v_split2x2 (pf, i, j)
//
in
  (pf00, pf01, pf10, pf11, gmatrow_v_unsplit2x2 | p01, p10, p11)
end // end of [gmatrow_ptr_split2x2]

(* ****** ****** *)

implement{a}
gmatrow_foreachrow
  (M, m, n, ld) = let
  var env: void = () in
  gmatrow_foreachrow_env<a><void> (M, m, n, ld, env)
end // end of [gmatrix_foreach]

(* ****** ****** *)

implement{a1,a2}
gmatrow_foreachrow2
  (M1, M2, m, n, ld1, ld2) = let
  var env: void = () in
  gmatrow_foreachrow2_env<a1,a2><void> (M1, M2, m, n, ld1, ld2, env)
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
  pfX: !GMR(a1, l1, m, n, lda)
, pfY: !GMR(a2, l2, m, n, ldb)
| p1: ptr l1, p2: ptr l2, m: int m, env: &env
) : void = let
in
//
if m > 0
then let
//
prval
  (pfX1, pfX2) = gmatrow_v_uncons0 (pfX)
prval
  (pfY1, pfY2) = gmatrow_v_uncons0 (pfY)
//
val () = gmatrow_foreachrow2$fwork<a1,a2><env> (!p1, !p2, n, env)
//
val () = loop
(
  pfX2, pfY2
| ptr_add<a1> (p1, lda), ptr_add<a2> (p2, ldb), pred(m), env
) (* end of [val] *)
//
prval () = pfX := gmatrow_v_cons0 (pfX1, pfX2)
prval () = pfY := gmatrow_v_cons0 (pfY1, pfY2)
//
in
  // nothing
end else let
//
(*
prval () = (pfY := gmatrow_v_renil0 {a,a} (pfY))
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
