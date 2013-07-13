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
staload "libats/SATS/gmatrix_row.sats"

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

(* end of [gmatrix_row.dats] *)
