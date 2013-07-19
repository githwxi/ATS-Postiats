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
staload "libats/SATS/gmatrix_row.sats"

(* ****** ****** *)

implement
{a}(*tmp*)
gmatrix_iforeach
  (M, mo, m, n, ld) = let
  var env: void = () in
  gmatrix_iforeach_env<a><void> (M, mo, m, n, ld, env)
end // end of [gmatrix_iforeach]

(* ****** ****** *)

implement
{a}{env}
gmatrix_iforeach_env
  (M, mo, m, n, ld, env) = let
//
in
//
case mo of
| MORDrow () => let
    var i: int = 0
    and j: int = 0
    var p_i: ptr = addr@(M)
    var p_ij: ptr = the_null_ptr
  in
    for (i := 0; i < m; i := i+1)
    {
      val () = p_ij := p_i
      val (
      ) = for (j := 0; j < n; j := j+1)
      {
        val (pf, fpf | p) = $UN.ptr0_vtake (p_ij)
        val () = gmatrix_iforeach$fwork<a><env> (i, j, !p, env)
        prval () = fpf (pf)
        val () = p_ij := ptr_succ<a> (p)
      }
      val () = p_i := ptr_add<a> (p_i, ld)
    } 
  end // end of [MORDrow]
| MORDcol () => let
    var i: int = 0
    and j: int = 0
    var p_j: ptr = addr@(M)
    var p_ij: ptr = the_null_ptr
  in
    for (j := 0; j < n; j := j+1)
    {
      val () = p_ij := p_j
      val (
      ) = for (i := 0; i < m; i := i+1)
      {
        val (pf, fpf | p) = $UN.ptr0_vtake (p_ij)
        val () = gmatrix_iforeach$fwork<a><env> (i, j, !p, env)
        prval () = fpf (pf)
        val () = p_ij := ptr_succ<a> (p)
      }
      val () = p_j := ptr_add<a> (p_j, ld)
    } 
  end // end of [MORDcol]
//
end // end of [gmatrix_iforeach_env]

(* ****** ****** *)

implement{a}
gmatrix_imake$fopr (i, j, x) = x
implement{a}
gmatrix_imake_matrixptr
  {mo}{m,n}{ld}
  (M, mo, m, n, ld) = let
//
prval (
) = lemma_gmatrix_param (M)
val (pf, pfgc | p) = matrix_ptr_alloc<a> (i2sz(m), i2sz(n))
prval () = matrix2gmatrow (!p)
//
implement(env)
gmatrix_iforeach$fwork<a><env>
  (i, j, x, env) = let
  val x2 = gmatrix_imake$fopr<a> (i, j, x)
  val p_ij = ptr_add<a> (p, i*n+j)
  val () = $UN.ptr0_set<a> (p_ij, x2)
in
  // nothing
end // end of [gmatrix_iforeach$fwork]
val () = gmatrix_iforeach<a> (M, mo, m, n, ld)
//
prval () = gmatrow2matrix (!p)
//
in
  $UN.castvwtp0{matrixptr(a,m,n)}((pf, pfgc | p))
end // end of [gmatrix_imake_matrixptr]

(* ****** ****** *)
//
implement{}
fprint_gmatrix$sep1 (out) = fprint (out, ", ")
implement{}
fprint_gmatrix$sep2 (out) = fprint (out, "; ")
//
implement{a}
fprint_gmatrix
  {mo}{m,n}{ld}
  (out, M, mo, m0, n0, ld) = let
//
implement
fprint_gvector$sep<> (out) = fprint_gmatrix$sep1 (out)
//
fun loop_row
  {l:addr}{m:nat}.<m>.
(
  pf: !GMR(a, l, m, n, ld) | p: ptr l, m: int m
) : void =
(
if m > 0
then let
//
val (
) = (
  if m < m0 then fprint_gmatrix$sep2 (out)
) (* end of [val] *)
//
prval
(pf1, pf2) = gmatrow_v_uncons0 (pf)
val () = fprint_gvector (out, !p, n0, 1)
val (
) = loop_row (pf2 | ptr_add<a> (p, ld), pred(m))
prval () = pf := gmatrow_v_cons0 (pf1, pf2)
//
in
  // nothing
end else () // end of [if]
)
//
fun loop_col
  {l:addr}{m:nat}.<m>.
(
  pf: !GMC(a, l, m, n, ld) | p: ptr l, m: int m
) : void =
(
if m > 0
then let
//
val (
) = (
  if m < m0 then fprint_gmatrix$sep2 (out)
) (* end of [val] *)
//
prval
(pf1, pf2) = gmatcol_v_uncons0 (pf)
val () = fprint_gvector (out, !p, n0, ld)
val () = loop_col (pf2 | ptr_succ<a> (p), pred(m))
prval () = pf := gmatcol_v_cons0 (pf1, pf2)
//
in
  // nothing
end else () // end of [if]
)
//
prval () = lemma_gmatrix_param (M)
//
in
//
case+ mo of
| MORDrow () => loop_row (view@M | addr@M, m0)
| MORDcol () => loop_col (view@M | addr@M, m0)
//
end // end of [fprint_gmatrix]

(* ****** ****** *)

(* end of [gmatrix.dats] *)
