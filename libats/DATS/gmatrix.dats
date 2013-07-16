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
      ) = for (i := 0; i < n; i := i+1)
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
  val x2 = gmatrix_imake$fopr (i, j, x)
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

(* end of [gmatrix.dats] *)
