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

staload "libats/SATS/gvector.sats"

(* ****** ****** *)
//
datasort mord =
  | mcol (* col major *) | mrow (* row major *)
datatype MORD (mord) =
  | MORDcol (mcol) of () | MORDrow (mrow) of ()
//
(* ****** ****** *)
//
// HX-2013-07:
// generic matrix:
// element, row, col, ord, ld
//
abst@ype
gmatrix_t0ype
  (a:t@ype+, mo:mord, m:int, n:int, ld:int) (* irregular *)
//
typedef gmatrix
  (a:t@ype, mo:mord, m:int, n:int, ld:int) = gmatrix_t0ype (a, mo, m, n, ld)
viewdef gmatrix_v
  (a:t0p, mo:mord, l:addr, m:int, n:int, ld:int) = gmatrix_t0ype (a, mo, m, n, ld) @ l
//
stadef GMX = gmatrix
stadef GMX = gmatrix_v
//
(* ****** ****** *)

fun{
a:t0p
} multo_gmatrix_gmatrix_gmatrix
  {mo:mord}{p,q,r:int}{lda,ldb,ldc:int}
(
  A: &GMX (INV(a), mo, p, q, lda)
, B: &GMX (    a , mo, q, r, ldb)
, C: &GMX (    a?, mo, p, r, ldc) >> GMX (a, mo, p, r, ldc)
, MORD (mo), int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [multo_gmatrix_gmatrix_gmatrix]

(* ****** ****** *)

(* end of [gmatrix.sats] *)
