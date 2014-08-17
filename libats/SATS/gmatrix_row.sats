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

#define ATS_PACKNAME "ATSLIB.libats.gmatrow"

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"

(* ****** ****** *)

praxi
lemma_gmatrow_param
  {a:t0p}{m,n:int}{ld:int}
  (M: &GMR(a, m, n, ld)): [m >= 0; n >= 1; ld >= n] void
praxi
lemma_gmatrow_v_param
  {a:t0p}{l:addr}{m,n:int}{ld:int}
  (pf: !GMR(a, l, m, n, ld)): [m >= 0; n >= 1; ld >= n] void

(* ****** ****** *)

praxi
matrix2gmatrow
  {a:t0p}{l:addr}{m,n:int}
  (A: &matrix (INV(a), m, n) >> GMR(a, m, n, n)): void
praxi
matrix2gmatrow_v
  {a:t0p}{l:addr}{m,n:int}
  (pf: matrix_v (INV(a), l, m, n)):<prf> GMR(a, l, m, n, n)
// end [matrix2gmatrow_v]

(* ****** ****** *)

praxi
gmatrow2matrix
  {a:t0p}{l:addr}{m,n:int}
  (V: &GMR(a, m, n, n) >> matrix (a, m, n)): void
// end [gmatrow2matrix]
praxi
gmatrow2matrix_v
  {a:t0p}{l:addr}{m,n:int}
  (pf: GMR(a, l, m, n, n)):<prf> matrix_v (a, l, m, n)
// end [gmatrow2matrix_v]

(* ****** ****** *)
//
// HX: 0 for row
//
praxi
gmatrow_v_renil0
  {a1,a2:t0p}
  {l:addr}{n:int}{ld:int} (GMR(a1, l, 0, n, ld)): GMR(a2, l, 0, n, ld)
//
praxi
gmatrow_v_cons0
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
(
  GVT(a, l, n, 1)
, GMR(a, l+ld*sizeof(a), m, n, ld)
) : GMR(a, l, m+1, n, ld)
praxi
gmatrow_v_uncons0
  {a:t0p}{l:addr}
  {m,n:int | m > 0}{ld:int}
  (GMR(a, l, m, n, ld))
:
(
  GVT(a, l, n, 1), GMR(a, l+ld*sizeof(a), m-1, n, ld)
) (* end of [gmatrow_v_uncons0] *)
//
(* ****** ****** *)
//
// HX: 1 for col
//
praxi
gmatrow_v_renil1
  {a1,a2:t0p}
  {l:addr}{m:int}{ld:int} (GMR(a1, l, m, 0, ld)): GMR(a2, l, m, 0, ld)
//
praxi
gmatrow_v_cons1
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
(
  GVT(a, l, m, ld)
, GMR(a, l+sizeof(a), m, n, ld)
) : GMR(a, l, m, n+1, ld) // end of [gmatrow_v_cons2]
praxi
gmatrow_v_uncons1
  {a:t0p}{l:addr}
  {m,n:int | n > 0}{ld:int}
  (GMR(a, l, m, n, ld))
: (GVT(a, l, m, ld), GMR(a, l+sizeof(a), m, n-1, ld))
//
(* ****** ****** *)

praxi
gmatrow_v_split1x2
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
  {j:nat | j <= n}
(
  GMR(a, l, m, n, ld), int j
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
  GMR(a, l            , m, j , ld)
, GMR(a, l+j*sizeof(a), m, j2, ld)
) : GMR(a, l, m, j+j2, ld) // end of [praxi]

(* ****** ****** *)

praxi
gmatrow_v_split_2x1
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
  {i,j:nat | i <= m}
(
  GMR(a, l, m, n, ld), int i
) :
(
  GMR(a, l               , i  , n, ld)
, GMR(a, l+i*ld*sizeof(a), m-i, n, ld)
) (* end of [gmatrow_v_split_2x1] *)

praxi
gmatrow_v_unsplit_2x1
  {a:t0p}{l:addr}
  {i,i2,n:int}{ld:int}
(
  GMR(a, l               , i , n, ld)
, GMR(a, l+i*ld*sizeof(a), i2, n, ld)
) : GMR(a, l, i+i2, n, ld) // end of [praxi]

(* ****** ****** *)

praxi
gmatrow_v_split_2x2
  {a:t0p}{l:addr}
  {m,n:int}{ld:int}
  {i,j:nat | i <= m; j <= n}
(
  GMR(a, l, m, n, ld), int i, int j
) :
(
  GMR(a, l                           , i  , j  , ld)
, GMR(a, l               +j*sizeof(a), i  , n-j, ld)
, GMR(a, l+i*ld*sizeof(a)            , m-i, j  , ld)
, GMR(a, l+i*ld*sizeof(a)+j*sizeof(a), m-i, n-j, ld)
) (* end of [gmatrow_v_split_2x2] *)

praxi
gmatrow_v_unsplit_2x2
  {a:t0p}{l:addr}
  {i,i2,j,j2:int}{ld:int}
(
  GMR(a, l                           , i , j , ld)
, GMR(a, l               +j*sizeof(a), i , j2, ld)
, GMR(a, l+i*ld*sizeof(a)            , i2, j , ld)
, GMR(a, l+i*ld*sizeof(a)+j*sizeof(a), i2, j2, ld)
) : GMR(a, l, i+i2, j+j2, ld) // end of [praxi]

(* ****** ****** *)

fun{a:t0p}
gmatrow_get_at
  {m,n:int}{ld:int}
(
  M: &GMR(a, m, n, ld), int(ld), i: natLt(m), j: natLt(n)
) : (a) // end of [gmatrow_get_at]
fun{a:t0p}
gmatrow_set_at
  {m,n:int}{ld:int}
(
  M: &GMR(a, m, n, ld), int(ld), i: natLt(m), j: natLt(n), x: a
) : void // end of [gmatrow_set_at]

(* ****** ****** *)

fun{a:t0p}
gmatrow_getref_at
  {m,n:int}{ld:int}
(
  M: &GMR(a, m, n, ld), int(ld), i: natLt(m), j: natLt(n)
) : cPtr1(a) // end of [gmatrow_getref_at]

(* ****** ****** *)

fun{a:t0p}
gmatrow_getref_row_at
  {m,n:int}{ld:int}
(
  M: &GMR(a, m, n, ld), int(ld), i: natLt(m)
) : cPtr1(GVT(a, n, 1(*d*))) // endfun

fun{a:t0p}
gmatrow_getref_col_at
  {m,n:int}{ld:int}
(
  M: &GMR(a, m, n, ld), int(ld), j: natLt(n)
) : cPtr1(GVT(a, m, ld)) // endfun

(* ****** ****** *)

fun{a:t0p}
gmatrow_interchange_row
  {m,n:int}{ld:int}
(
  M: &GMR(a, m, n, ld)
, n: int n, int(ld), i1: natLt(m), i2: natLt(m)
) : void // end of [gmatrow_interchange_row]
fun{a:t0p}
gmatrow_interchange_col
  {m,n:int}{ld:int}
(
  M: &GMR(a, m, n, ld)
, m: int m, int(ld), j1: natLt(n), j2: natLt(n)
) : void // end of [gmatrow_interchange_col]

(* ****** ****** *)

fun{a:t0p}
gmatrow_copyto
  {m,n:int}{ld1,ld2:int}
(
  M1: &GMR(a, m, n, ld1)
, M2: &GMR(a?, m, n, ld2) >> GMR(a, m, n, ld2)
, int(m), int(n), int(ld1), int(ld2)
) : void // end of [gmatrow_copyto]

fun{a:t0p}
gmatrow_transpto
  {m,n:int}{ld1,ld2:int}
(
  M1: &GMR(a, m, n, ld1)
, M2: &GMR(a?, n, m, ld2) >> GMR(a, n, m, ld2)
, int(m), int(n), int(ld1), int(ld2)
) : void // end of [gmatrow_transpto]

(* ****** ****** *)

fun{a:t0p}
gmatrow_ptr_split_2x2
  {l:addr}
  {m,n:int}{ld:int}
  {i,j:nat | i <= m; j <= n}
(
  pf: GMR(a, l, m, n, ld) | ptr(l), int(ld), int(i), int(j)
) : [l01,l10,l11:addr]
(
  GMR(a, l  , i  , j  , ld)
, GMR(a, l01, i  , n-j, ld)
, GMR(a, l10, m-i, j  , ld)
, GMR(a, l11, m-i, n-j, ld)
, (
  GMR(a, l  , i  , j  , ld)
, GMR(a, l01, i  , n-j, ld)
, GMR(a, l10, m-i, j  , ld)
, GMR(a, l11, m-i, n-j, ld)
) -<prf> GMR(a, l, m, n, ld)
| ptr(l01), ptr(l10), ptr(l11)
) (* end of [gmatrow_ptr_split_2x2] *)

(* ****** ****** *)

fun{
a:t0p}{env:vt0p
} gmatrow_foreachrow$fwork{n:int}
(
  row: &GVT (a, n, 1) >> _, n: int n, env: &(env) >> _
) : void // end of [gmatrow_foreachrow$fwork]

fun{
a:t0p
} gmatrow_foreachrow{m,n:int}{ld:int}
(
  M: &gmatrow(a, m, n, ld) >> _, int(m), int(n), int(ld)
) : void // end of [gmatrow_foreachrow]
fun{
a:t0p}{env:vt0p
} gmatrow_foreachrow_env{m,n:int}{ld:int}
(
  M: &gmatrow(a, m, n, ld) >> _, int(m), int(n), int(ld), env: &(env) >> _
) : void // end of [gmatrow_foreachrow_env]

(* ****** ****** *)

fun{
a1,a2:t0p}{env:vt0p
} gmatrow_foreachrow2$fwork{n:int}
(
  row1: &GVT (a1, n, 1) >> _
, row2: &GVT (a2, n, 1) >> _
, n: int (n), env: &(env) >> _
) : void // end of [gmatrow_foreachrow$fwork]

fun{
a1,a2:t0p
} gmatrow_foreachrow2
  {m,n:int}{ld1,ld2:int}
(
  M1: &gmatrow(a1, m, n, ld1) >> _
, M2: &gmatrow(a2, m, n, ld2) >> _
, int(m), int(n), int(ld1), int(ld2)
) : void // end of [gmatrow_foreachrow]
fun{
a1,a2:t0p}{env:vt0p
} gmatrow_foreachrow2_env
  {m,n:int}{ld1,ld2:int}
(
  M1: &gmatrow(a1, m, n, ld1) >> _
, M2: &gmatrow(a2, m, n, ld2) >> _
, int(m), int(n), int(ld1), int(ld2)
, env: &(env) >> _
) : void // end of [gmatrow_foreachrow2_env]

(* ****** ****** *)

(* end of [gmatrix_row.sats] *)
