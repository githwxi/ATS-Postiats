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
// HX-2013-07:
// For matrices
// (that is, 2D-arrays) of column-major style
//
(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"

(* ****** ****** *)

praxi
lemma_gmatrow_param
  {a:t0p}{m,n:int}{ld:int}
  (M: &GMR(INV(a), m, n, ld)): [m >= 0; n >= 1; ld >= n] void
praxi
lemma_gmatrow_v_param
  {a:t0p}{l:addr}{m,n:int}{ld:int}
  (pf: !GMR(INV(a), l, m, n, ld)): [m >= 0; n >= 1; ld >= n] void

(* ****** ****** *)

praxi
matrix2gmatrix
  {a:t0p}{l:addr}{m,n:int}
  (A: &matrix (INV(a), m, n) >> GMR(a, m, n, n)): void
praxi
matrix2gmatrix_v
  {a:t0p}{l:addr}{m,n:int}
  (pf: matrix_v (INV(a), l, m, n)):<prf> GMR(a, l, m, n, n)
// end [matrix2gmatrix_v]

(* ****** ****** *)

praxi
gmatrix2matrix
  {a:t0p}{l:addr}{m,n:int}
  (V: &GMR(INV(a), m, n, n) >> matrix (a, m, n)): void
// end [gmatrix2matrix]
praxi
gmatrix2matrix_v
  {a:t0p}{l:addr}{m,n:int}
  (pf: GMR(INV(a), l, m, n, n)):<prf> matrix_v (a, l, m, n)
// end [gmatrix2matrix_v]

(* ****** ****** *)
//
praxi
gmatrow_v_nil
  {a:t0p}{l:addr}
  {n:pos}{ld:int | ld >= n} (): GMR(a, l, 0, n, ld)
praxi
gmatrow_v_unnil
  {a:t0p}{l:addr}{n:int}{ld:int} (GMR(a, l, 0, n, ld)): void
praxi
gmatrow_v_unnil_nil
  {a1,a2:t0p}
  {l:addr}{n:int}{ld:int} (GMR(a1, l, 0, n, ld)): GMR(a2, l, 0, n, ld)
//
praxi
gmatrow_v_cons
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
(
  GVT(a, l, n, 1)
, GMR(INV(a), l+ld*sizeof(a), m, n, ld)
) : GMR(a, l, m+1, n, ld) // end of [gmatrow_v_cons]
praxi
gmatrow_v_uncons
  {a:t0p}{l:addr}
  {m,n:int | m > 0}{ld:int}
  (GMR(INV(a), l, m, n, ld))
: (GVT(a, l, n, 1), GMR(a, l+ld*sizeof(a), m-1, n, ld))
//
(* ****** ****** *)
//
praxi
gmatrow_v_nil2
  {a:t0p}{l:addr}
  {m:nat}{ld:int | ld >= 1} (): GMR(a, l, m, 0, ld)
praxi
gmatrow_v_unnil2
  {a:t0p}{l:addr}{m:int}{ld:int} (GMR(a, l, m, 0, ld)): void
praxi
gmatrow_v_unnil2_nil2
  {a1,a2:t0p}
  {l:addr}{m:int}{ld:int} (GMR(a1, l, m, 0, ld)): GMR(a2, l, m, 0, ld)
//
praxi
gmatrow_v_cons2
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
(
  GVT(a, l, m, ld)
, GMR(INV(a), l+sizeof(a), m, n, ld)
) : GMR(a, l, m, n+1, ld) // end of [gmatrow_v_cons2]
praxi
gmatrow_v_uncons2
  {a:t0p}{l:addr}
  {m,n:int | n > 0}{ld:int}
  (GMR(INV(a), l, m, n, ld))
: (GVT(a, l, m, ld), GMR(a, l+sizeof(a), m, n-1, ld))
//
(* ****** ****** *)

praxi
gmatrow_v_split1x2
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
  {j:nat | j <= n}
(
  GMR(INV(a), l, m, n, ld), int j
) :
(
  GMR(a, l            , m, j  , ld)
, GMR(a, l+j*sizeof(a), m, n-j, ld)
) (* end of [gmatrow_v_split1x2] *)

praxi
gmatrow_v_unsplit1x2
  {a:t0p}{l:addr}
  {m,j,j2:int}{ld:int}
(
  GMR(INV(a), l            , m, j , ld)
, GMR(a     , l+j*sizeof(a), m, j2, ld)
) : GMR(a, l, m, j+j2, ld) // end of [praxi]

(* ****** ****** *)

praxi
gmatrow_v_split2x1
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
  {i,j:nat | i <= m}
(
  GMR(INV(a), l, m, n, ld), int i
) :
(
  GMR(a, l               , i  , n, ld)
, GMR(a, l+i*ld*sizeof(a), m-i, n, ld)
) (* end of [gmatrow_v_split2x1] *)

praxi
gmatrow_v_unsplit2x1
  {a:t0p}{l:addr}
  {i,i2,n:int}{ld:int}
(
  GMR(INV(a), l               , i , n, ld)
, GMR(a     , l+i*ld*sizeof(a), i2, n, ld)
) : GMR(a, l, i+i2, n, ld) // end of [praxi]

(* ****** ****** *)

praxi
gmatrow_v_split2x2
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
  {i,j:nat | i <= m; j <= n}
(
  GMR(INV(a), l, m, n, ld), int i, int j
) :
(
  GMR(a, l                           , i  , j  , ld)
, GMR(a, l               +j*sizeof(a), i  , n-j, ld)
, GMR(a, l+i*ld*sizeof(a)            , m-i, j  , ld)
, GMR(a, l+i*ld*sizeof(a)+j*sizeof(a), m-i, n-j, ld)
) (* end of [gmatrow_v_split2x2] *)

praxi
gmatrow_v_unsplit2x2
  {a:t0p}{l:addr}
  {i,i2,j,j2:int}{ld:int}
(
  GMR(INV(a), l                           , i , j , ld)
, GMR(a     , l               +j*sizeof(a), i , j2, ld)
, GMR(a     , l+i*ld*sizeof(a)            , i2, j , ld)
, GMR(a     , l+i*ld*sizeof(a)+j*sizeof(a), i2, j2, ld)
) : GMR(a, l, i+i2, j+j2, ld) // end of [praxi]

(* ****** ****** *)

fun{a:t0p}
gmatrow_getref_at
  {m,n:int}{ld:int}
(
  M: &GMR(INV(a), m, n, ld), int(ld), i: natLt(m), j: natLt(n)
) : cPtr1(a) // end of [gmatrow_getref_at]

(* ****** ****** *)

fun{a:t0p}
gmatrow_getref_col_at
  {m,n:int}{ld:int}
(
  M: &GMR(INV(a), m, n, ld), j: natLt(n)
) : cPtr1(GVT(a, m, ld)) // end of [gmatrow_getref_col_at]

fun{a:t0p}
gmatrow_getref_row_at
  {m,n:int}{ld:int}
(
  M: &GMR(INV(a), m, n, ld), int(ld), i: natLt(m)
) : cPtr1(GVT(a, n, 1(*d*))) // end of [gmatrow_getref_row_at]

(* ****** ****** *)

fun{
a:t0p
} muladdto_gmatrow_gvector_gvector
  {m,n:int}{ld1,d2,d3:int}
(
  M1: &GMR(INV(a), m, n, ld1)
, V2: &GVT(    a , n, d2)
, V3: &GVT(    a , m, d3) >> _
, int(m), int(n), int(ld1), int(d2), int(d3)
) : void // end of [muladdto_gmatrow_gvector_gvector]

(* ****** ****** *)

fun{
a:t0p
} muladdto_gmatrow_gmatrow_gmatrow
  {p,q,r:int}{lda,ldb,ldc:int}
(
  A: &GMR(INV(a), p, q, lda)
, B: &GMR(    a , q, r, ldb)
, C: &GMR(    a , p, r, ldc) >> _
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [muladdto_gmatrow_gmatrow_gmatrow]

(* ****** ****** *)
//
// BB: outer product
// BB: tensor product
//
fun{a:t0p}
muladdto_gvector_gvector_gmatrow
  {m,n:int}{d1,d2,ld3:int}
(
  V1: &GVT(INV(a), m, d1)
, V2: &GVT(    a , n, d2)
, M3: &GMR(    a , m, n, ld3) >> _
, m: int(m), n: int(n), d1: int(d1), d2: int(d2), ld3: int(ld3)
) : void (* end of [muladdto_gvector_gvector_gmatrow] *)

(* ****** ****** *)

(* end of [gmatrix_row.sats] *)
