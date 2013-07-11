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
//
datasort mord =
  | mrow (* row major *)
  | mcol (* column major *)
datatype MORD (mord) =
  | MORDrow (mrow) of () | MORDcol (mcol) of ()
//
(* ****** ****** *)
//
// HX-2013-07:
// generic matrix:
// element, row, col, ord, ld
//
abst@ype
gmatrix_t0ype
  (a:t@ype+, mo:mord, m:int, n:int, ld:int)
//
typedef gmatrix
  (a:t@ype, mo:mord, m:int, n:int, ld:int) = gmatrix_t0ype (a, mo, m, n, ld)
//
stadef GM = gmatrix
//
(* ****** ****** *)

fun{
a:t0p
} multo_gmatrix_gmatrix_gmatrix
  {mo:mord}{p,q,r:int}{lda,ldb,ldc:int}
(
  A: &GM (INV(a), mo, p, q, lda)
, B: &GM (    a , mo, q, r, ldb)
, C: &GM (a?, mo, p, r, ldc) >> GM (a, mo, p, r, ldc)
, MORD (mo), int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [multo_gmatrix_gmatrix_gmatrix]

fun{
a:t0p
} multo_gmatrix_gmatrix_gmatrix_row
  {p,q,r:int}{lda,ldb,ldc:int}
(
  A: &GM (INV(a), mrow, p, q, lda)
, B: &GM (    a , mrow, q, r, ldb)
, C: &GM (a?, mrow, p, r, ldc) >> GM (a, mrow, p, r, ldc)
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [multo_gmatrix_gmatrix_gmatrix_row]

fun{
a:t0p
} multo_gmatrix_gmatrix_gmatrix_col
  {p,q,r:int}{lda,ldb,ldc:int}
(
  A: &GM (INV(a), mcol, p, q, lda)
, B: &GM (    a , mcol, q, r, ldb)
, C: &GM (a?, mcol, p, r, ldc) >> GM (a, mcol, p, r, ldc)
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [multo_gmatrix_gmatrix_gmatrix_col]

(* ****** ****** *)

(* end of [gmatrix.sats] *)
