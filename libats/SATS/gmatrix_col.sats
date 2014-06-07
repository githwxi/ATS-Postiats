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
//
// HX-2013-07:
// For matrices
// (that is, 2D-arrays) of column-major style
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.gmatcol"

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"

(* ****** ****** *)

praxi
lemma_gmatcol_param
  {a:t0p}{m,n:int}{ld:int}
  (M: &GMC(a, m, n, ld)): [m >= 1; n >= 0; ld >= m] void
praxi
lemma_gmatcol_v_param
  {a:t0p}{l:addr}{m,n:int}{ld:int}
  (pf: !GMC(a, l, m, n, ld)): [m >= 1; n >= 0; ld >= m] void

(* ****** ****** *)
//
// HX: 0 for row
//
praxi
gmatcol_v_renil0
  {a1,a2:t0p}
  {l:addr}{n:int}{ld:int} (GMC(a1, l, 0, n, ld)): GMC(a2, l, 0, n, ld)
//
praxi
gmatcol_v_cons0
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
(
  GVT(a, l, n, ld)
, GMC(a, l+sizeof(a), m, n, ld)
) : GMC(a, l, m+1, n, ld)
praxi
gmatcol_v_uncons0
  {a:t0p}{l:addr}
  {m,n:int | m > 0}{ld:int}
(
  pf: GMC(a, l, m, n, ld)
) :
(
  GVT(a, l, n, ld), GMC(a, l+sizeof(a), m-1, n, ld)
) (* end of [gmatcol_v_uncons0] *)
//
(* ****** ****** *)
//
// HX: 1 for col
//
praxi
gmatcol_v_renil1
  {a1,a2:t0p}
  {l:addr}{m:int}{ld:int} (GMC(a1, l, m, 0, ld)): GMC(a2, l, m, 0, ld)
//
praxi
gmatcol_v_cons1
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
(
  GVT(a, l, m, 1)
, GMC(a, l+ld*sizeof(a), m, n, ld)
) : GMC(a, l, m, n+1, ld)
praxi
gmatcol_v_uncons1
  {a:t0p}{l:addr}
  {m,n:int | n > 0}{ld:int}
(
  pf: GMC(a, l, m, n, ld)
) :
(
  GVT(a, l, m, 1), GMC(a, l+ld*sizeof(a), m, n-1, ld)
) (* end of [gmatcol_v_uncons1] *)
//
(* ****** ****** *)

praxi
gmatcol_v_split_2x1
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
  {i,j:nat | i <= m}
(
  GMC(a, l, m, n, ld), int i
) :
(
  GMC(a, l            , i  , n, ld)
, GMC(a, l+i*sizeof(a), m-i, n, ld)
) (* end of [gmatcol_v_split_2x1] *)

praxi
gmatcol_v_unsplit_2x1
  {a:t0p}{l:addr}
  {i,i2,n:int}{ld:int}
(
  GMC(a, l            , i , n, ld)
, GMC(a, l+i*sizeof(a), i2, n, ld)
) : GMC(a, l, i+i2, n, ld) // end of [praxi]

(* ****** ****** *)

praxi
gmatcol_v_split1x2
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
  {j:nat | j <= n}
(
  GMC(a, l, m, n, ld), int j
) :
(
  GMC(a, l               , m, j  , ld)
, GMC(a, l+j*ld*sizeof(a), m, n-j, ld)
) (* end of [gmatcol_v_split1x2] *)

praxi
gmatcol_v_unsplit1x2
  {a:t0p}{l:addr}
  {m,j,j2:int}{ld:int}
(
  GMC(a, l               , m, j , ld)
, GMC(a, l+j*ld*sizeof(a), m, j2, ld)
) : GMC(a, l, m, j+j2, ld) // end of [praxi]

(* ****** ****** *)

praxi
gmatcol_v_split_2x2
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
  {i,j:nat | i <= m; j <= n}
(
  GMC(a, l, m, n, ld), int i, int j
) :
(
  GMC(a, l                           , i  , j  , ld)
, GMC(a, l            +j*ld*sizeof(a), i  , n-j, ld)
, GMC(a, l+i*sizeof(a)               , m-i, j  , ld)
, GMC(a, l+i*sizeof(a)+j*ld*sizeof(a), m-i, n-j, ld)
) (* end of [gmatcol_v_split_2x2] *)

praxi
gmatcol_v_unsplit_2x2
  {a:t0p}{l:addr}
  {i,i2,j,j2:int}{ld:int}
(
  GMC(a, l                           , i , j , ld)
, GMC(a, l            +j*ld*sizeof(a), i , j2, ld)
, GMC(a, l+i*sizeof(a)               , i2, j , ld)
, GMC(a, l+i*sizeof(a)+j*ld*sizeof(a), i2, j2, ld)
) : GMC(a, l, i+i2, j+j2, ld) // end of [praxi]

(* ****** ****** *)

fun{a:t0p}
gmatcol_get_at
  {m,n:int}{ld:int}
(
  M: &GMC(a, m, n, ld), int(ld), i: natLt(m), j: natLt(n)
) : (a) // end of [gmatcol_get_at]
fun{a:t0p}
gmatcol_set_at
  {m,n:int}{ld:int}
(
  M: &GMC(a, m, n, ld), int(ld), i: natLt(m), j: natLt(n), x: a
) : void // end of [gmatcol_set_at]

(* ****** ****** *)

fun{a:t0p}
gmatcol_getref_at
  {m,n:int}{ld:int}
(
  M: &GMC(a, m, n, ld), int(ld), i: natLt(m), j: natLt(n)
) : cPtr1(a) // end of [gmatcol_getref_at]

(* ****** ****** *)

fun{a:t0p}
gmatcol_getref_row_at
  {m,n:int}{ld:int}
(
  M: &GMC(a, m, n, ld), int(ld), i: natLt(m)
) : cPtr1(GVT(a, n, ld)) // endfun

fun{a:t0p}
gmatcol_getref_col_at
  {m,n:int}{ld:int}
(
  M: &GMC(a, m, n, ld), int(ld), j: natLt(n)
) : cPtr1(GVT(a, m, 1(*d*))) // endfun

(* ****** ****** *)

fun{a:t0p}
gmatcol_interchange_row
  {m,n:int}{ld:int}
(
  M: &GMC(a, m, n, ld)
, n: int n, int(ld), i1: natLt(m), i2: natLt(m)
) : void // end of [gmatcol_interchange_row]
fun{a:t0p}
gmatcol_interchange_col
  {m,n:int}{ld:int}
(
  M: &GMC(a, m, n, ld)
, m: int m, int(ld), j1: natLt(n), j2: natLt(n)
) : void // end of [gmatcol_interchange_col]

(* ****** ****** *)

fun{a:t0p}
gmatcol_copyto
  {m,n:int}{ld1,ld2:int}
(
  M1: &GMC(a, m, n, ld1)
, M2: &GMC(a?, m, n, ld2) >> GMC(a, m, n, ld2)
, int(m), int(n), int(ld1), int(ld2)
) : void // end of [gmatcol_copyto]

fun{a:t0p}
gmatcol_transpto
  {m,n:int}{ld1,ld2:int}
(
  M1: &GMC(a, m, n, ld1)
, M2: &GMC(a?, n, m, ld2) >> GMC(a, n, m, ld2)
, int(m), int(n), int(ld1), int(ld2)
) : void // end of [gmatcol_transpto]

(* ****** ****** *)

fun{a:t0p}
gmatcol_ptr_split_2x2
  {l:addr}
  {m,n:int}{ld:int}
  {i,j:nat | i <= m; j <= n}
(
  pf: GMC(a, l, m, n, ld) | ptr(l), int(ld), int(i), int(j)
) : [l01,l10,l11:addr]
(
  GMC(a, l  , i  , j  , ld)
, GMC(a, l01, i  , n-j, ld)
, GMC(a, l10, m-i, j  , ld)
, GMC(a, l11, m-i, n-j, ld)
, (
  GMC(a, l  , i  , j  , ld)
, GMC(a, l01, i  , n-j, ld)
, GMC(a, l10, m-i, j  , ld)
, GMC(a, l11, m-i, n-j, ld)
) -<prf> GMC(a, l, m, n, ld)
| ptr(l01), ptr(l10), ptr(l11)
) (* end of [gmatcol_ptr_split_2x2] *)

(* ****** ****** *)

fun{
a:t0p}{env:vt0p
} gmatcol_foreachcol$fwork{m:int}
(
  col: &GVT (a, m, 1) >> _, m: int m, env: &(env) >> _
) : void // end of [gmatcol_foreachcol$fwork]

fun{
a:t0p
} gmatcol_foreachcol{m,n:int}{ld:int}
(
  M: &gmatcol(a, m, n, ld) >> _, int(m), int(n), int(ld)
) : void // end of [gmatcol_foreachcol]
fun{
a:t0p}{env:vt0p
} gmatcol_foreachcol_env{m,n:int}{ld:int}
(
  M: &gmatcol(a, m, n, ld) >> _, int(m), int(n), int(ld), env: &(env) >> _
) : void // end of [gmatcol_foreachcol_env]

(* ****** ****** *)

fun{
a1,a2:t0p}{env:vt0p
} gmatcol_foreachcol2$fwork{m:int}
(
  col1: &GVT (a1, m, 1) >> _
, col2: &GVT (a2, m, 1) >> _
, m: int (m), env: &(env) >> _
) : void // end of [gmatcol_foreachcol$fwork]

fun{
a1,a2:t0p
} gmatcol_foreachcol2
  {m,n:int}{ld1,ld2:int}
(
  M1: &gmatcol(a1, m, n, ld1) >> _
, M2: &gmatcol(a2, m, n, ld2) >> _
, int(m), int(n), int(ld1), int(ld2)
) : void // end of [gmatcol_foreachcol]
fun{
a1,a2:t0p}{env:vt0p
} gmatcol_foreachcol2_env
  {m,n:int}{ld1,ld2:int}
(
  M1: &gmatcol(a1, m, n, ld1) >> _
, M2: &gmatcol(a2, m, n, ld2) >> _
, int(m), int(n), int(ld1), int(ld2)
, env: &(env) >> _
) : void // end of [gmatcol_foreachcol2_env]

(* ****** ****** *)

(* end of [gmatrix_col.sats] *)
