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
//
typedef gmatcol
  (a:t@ype, m:int, n:int, ld:int) = gmatrix_t0ype (a, mcol, m, n, ld)
viewdef gmatcol_v
  (a:t@ype, l:addr, m:int, n:int, ld:int) = gmatrix_t0ype (a, mcol, m, n, ld) @ l
//
stadef GMC = gmatcol
stadef GMC = gmatcol_v
//
(* ****** ****** *)

praxi
lemma_gmatcol_param
  {a:t0p}{m,n:int}{ld:int}
  (M: &GMC (INV(a), m, n, ld)): [m >= 1; n >= 0; ld >= m] void
praxi
lemma_gmatcol_v_param
  {a:t0p}{l:addr}{m,n:int}{ld:int}
  (pf: !GMC (INV(a), l, m, n, ld)): [m >= 1; n >= 0; ld >= m] void

(* ****** ****** *)
//
praxi
gmatcol_v_nil
  {a:t0p}{l:addr}
  {m:pos}{ld:int | ld >= m} (): GMC (a, l, m, 0, ld)
praxi
gmatcol_v_unnil
  {a:t0p}{l:addr}{m:int}{ld:int} (GMC (a, l, m, 0, ld)): void
praxi
gmatcol_v_unnil_nil
  {a1,a2:t0p}
  {l:addr}{m:int}{ld:int} (GMC (a1, l, m, 0, ld)): GMC (a2, l, m, 0, ld)
//
praxi
gmatcol_v_cons
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
(
  array_v (a, l, m)
, GMC (INV(a), l+ld*sizeof(a), m, n, ld)
) : GMC (a, l, m, n+1, ld) // end of [gmatcol_v_cons]
praxi
gmatcol_v_uncons
  {a:t0p}{l:addr}
  {m,n:int | n > 0}{ld:int}
  (GMC (INV(a), l, m, n, ld))
: (array_v (a, l, m), GMC (a, l+ld*sizeof(a), m, n-1, ld))
//
(* ****** ****** *)
//
praxi
gmatcol_v_nil2
  {a:t0p}{l:addr}
  {n:nat}{ld:int | ld >= 1} (): GMC (a, l, 0, n, ld)
praxi
gmatcol_v_unnil2
  {a:t0p}{l:addr}{n:int}{ld:int} (GMC (a, l, 0, n, ld)): void
praxi
gmatcol_v_unnil2_nil2
  {a1,a2:t0p}
  {l:addr}{n:int}{ld:int} (GMC (a1, l, 0, n, ld)): GMC (a2, l, 0, n, ld)
//
praxi
gmatcol_v_cons2
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
(
  GV (a, l, n, ld)
, GMC (INV(a), l+sizeof(a), m, n, ld)
) : GMC (a, l, m+1, n, ld) // end of [gmatcol_v_cons2]
praxi
gmatcol_v_uncons2
  {a:t0p}{l:addr}
  {m,n:int | m > 0}{ld:int}
  (GMC (INV(a), l, m, n, ld))
: (GV (a, l, n, ld), GMC (a, l+sizeof(a), m-1, n, ld))
//
(* ****** ****** *)

praxi
gmatcol_v_split2x1
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
  {i,j:nat | i <= m}
(
  GMC (INV(a), l, m, n, ld), int i
) :
(
  GMC (a, l            , i  , n, ld)
, GMC (a, l+i*sizeof(a), m-i, n, ld)
) (* end of [gmatcol_v_split2x1] *)

praxi
gmatcol_v_unsplit2x1
  {a:t0p}{l:addr}
  {i,i2,n:int}{ld:int}
(
  GMC (INV(a), l            , i , n, ld)
, GMC (a     , l+i*sizeof(a), i2, n, ld)
) : GMC (a, l, i+i2, n, ld) // end of [praxi]

(* ****** ****** *)

praxi
gmatcol_v_split1x2
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
  {j:nat | j <= n}
(
  GMC (INV(a), l, m, n, ld), int j
) :
(
  GMC (a, l               , m, j  , ld)
, GMC (a, l+j*ld*sizeof(a), m, n-j, ld)
) (* end of [gmatcol_v_split1x2] *)

praxi
gmatcol_v_unsplit1x2
  {a:t0p}{l:addr}
  {m,j,j2:int}{ld:int}
(
  GMC (INV(a), l               , m, j , ld)
, GMC (a     , l+j*ld*sizeof(a), m, j2, ld)
) : GMC (a, l, m, j+j2, ld) // end of [praxi]

(* ****** ****** *)

praxi
gmatcol_v_split2x2
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
  {i,j:nat | i <= m; j <= n}
(
  GMC (INV(a), l, m, n, ld), int i, int j
) :
(
  GMC (a, l                           , i  , j  , ld)
, GMC (a, l            +j*ld*sizeof(a), i  , n-j, ld)
, GMC (a, l+i*sizeof(a)               , m-i, j  , ld)
, GMC (a, l+i*sizeof(a)+j*ld*sizeof(a), m-i, n-j, ld)
) (* end of [gmatcol_v_split2x2] *)

praxi
gmatcol_v_unsplit2x2
  {a:t0p}{l:addr}
  {i,i2,j,j2:int}{ld:int}
(
  GMC (INV(a), l                           , i , j , ld)
, GMC (a     , l            +j*ld*sizeof(a), i , j2, ld)
, GMC (a     , l+i*sizeof(a)               , i2, j , ld)
, GMC (a     , l+i*sizeof(a)+j*ld*sizeof(a), i2, j2, ld)
) : GMC (a, l, i+i2, j+j2, ld) // end of [praxi]

(* ****** ****** *)

fun{a:t0p}
gmatcol_getref_at
  {m,n:int}{ld:int}
(
  M: &GMC (INV(a), m, n, ld), int(ld), i: natLt(m), j: natLt(n)
) : cPtr1(a) // end of [gmatcol_getref_at]

(* ****** ****** *)

fun{a:t0p}
gmatcol_getref_row_at
  {m,n:int}{ld:int}
(
  M: &GMC (INV(a), m, n, ld), i: natLt(m)
) : cPtr1(GV(a, n, ld)) // end of [gmatcol_getref_row_at]
fun{a:t0p}
gmatcol_getref_col_at
  {m,n:int}{ld:int}
(
  M: &GMC (INV(a), m, n, ld), int(ld), j: natLt(n)
) : cPtr1(GV(a, m,  1)) // end of [gmatcol_getref_col_at]

(* ****** ****** *)

fun{
a:t0p
} muladdto_gvector_gmatcol_gvector
  {m,n:int}{d1,ld2,d3:int}
(
  V1: &GV (a, m, d1)
, M2: &GMC (INV(a), m, n, ld2)
, V3: &GV (a, n, d3) >> _
, int(m), int(n), int(d1), int(ld2), int(d3)
) : void // end of [muladdto_gvector_gmatcol_gvector]

(* ****** ****** *)

fun{
a:t0p
} muladdto_gmatcol_gmatcol_gmatcol
  {p,q,r:int}{lda,ldb,ldc:int}
(
  A: &GMC (INV(a), p, q, lda)
, B: &GMC (    a , q, r, ldb)
, C: &GMC (    a , p, r, ldc) >> _
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [muladdto_gmatcol_gmatcol_gmatcol]

fun{
a:t0p
} sumaddto_gmatcol_gmatcol_gmatcol
  {m,n:int}{lda,ldb,ldc:int}
(
  A: &GMC (INV(a), m, n, lda)
, B: &GMC (    a , m, n, ldb)
, C: &GMC (    a , m, n, ldc) >> _
, int m, int m, int lda, int ldb, int ldc
) : void // end of [muladdto_gmatcol_gmatcol_gmatcol]


(* ****** ****** *)
//
// BB: outer product
// BB: tensor product
//
// M3 := M3 + V1(X)V2
//
fun{a:t0p}
muladdto_gvector_gvector_gmatcol
  {m,n:int}{d1,d2,ld3:int}
(
  V1: &GV (INV(a), m, d1)
, V2: &GV (    a , n, d2)
, M3: &GMC (a, m, n, ld3) >> _
, m: int(m), n: int(n), d1: int(d1), d2: int(d2), ld3: int(ld3)
) : void (* end of [muladdto_gvector_gvector_gmatcol] *)

(* ****** ****** *)

(* end of [gmatrix_col.sats] *)
