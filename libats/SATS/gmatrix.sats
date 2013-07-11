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
//
// HX: row-major
//
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
  {m:pos;n:nat}{ld:int | ld >= m} (): GMC (a, l, m, n, ld)
praxi
gmatcol_v_unnil
  {a:t0p}{l:addr}{m:int}{ld:int} (GMC (a, l, m, 0, ld)): void
praxi
gmatcol_v_unnil_nil
  {a1,a2:t0p}{l:addr}{m:int}{ld:int} (GMC (a1, l, m, 0, ld)): GMC (a2, l, m, 0, ld)
//
praxi
gmatcol_v_cons
  {a:t0p}{l:addr}{m,n:int}{ld:int}
  (array_v (a, l, m), GMC (INV(a), l+ld*sizeof(a), m, n, ld)): GMC (a, l, m, n+1, ld)
praxi
gmatcol_v_uncons
  {a:t0p}{l:addr}{m,n:int | n > 0}{ld:int}
  (GMC (INV(a), l, m, n, ld)): (array_v (a, l, m), GMC (a, l+ld*sizeof(a), m, n-1, ld))
//
(* ****** ****** *)
//
// HX: row-major
//
(* ****** ****** *)
//
typedef gmatrow
  (a:t@ype, m:int, n:int, ld:int) = gmatrix_t0ype (a, mrow, m, n, ld)
viewdef gmatrow_v
  (a:t@ype, l:addr, m:int, n:int, ld:int) = gmatrix_t0ype (a, mrow, m, n, ld) @ l
//
stadef GMR = gmatrow
stadef GMR = gmatrow_v
//
(* ****** ****** *)

praxi
lemma_gmatrow_param
  {a:t0p}{m,n:int}{ld:int}
  (M: &GMR (INV(a), m, n, ld)): [m >= 0; n >= 1; ld >= n] void
praxi
lemma_gmatrow_v_param
  {a:t0p}{l:addr}{m,n:int}{ld:int}
  (pf: !GMR (INV(a), l, m, n, ld)): [m >= 0; n >= 1; ld >= n] void

(* ****** ****** *)

fun{a:t0p}
gmatcol_getref_at
  {m,n:int}{ld:int}
  (M: &GMC (INV(a), m, n, ld), m: int(m), i: natLt(m), j:natLt(n)): cPtr1(a)
// end of [gmatcol_getref_at]

fun{a:t0p}
gmatrow_getref_at
  {m,n:int}{ld:int}
(
  M: &GMR (INV(a), m, n, ld), n: int(n), i: natLt(m), j:natLt(n)
) : cPtr1(a) // end of [gmatrow_getref_at]

(* ****** ****** *)

fun{a:t0p}
gmatcol_getref_col_at
  {m,n:int}{ld:int}
(
  M: &GMC (INV(a), m, n, ld), m: int(m), j:natLt(n)
) : cPtr1(array(a, m)) // end of [gmatcol_getref_col_at]

fun{a:t0p}
gmatrow_getref_row_at
  {m,n:int}{ld:int}
(
  M: &GMR (INV(a), m, n, ld), n: int(n), i: natLt(m)
) : cPtr1(array(a, n)) // end of [gmatrow_getref_row_at]

(* ****** ****** *)

fun{
a:t0p
} multo_gmatcol_gvector_gvector
  {m,n:int}{lda:int}{db,dc:int}
(
  A: &GMR (INV(a), m, n, lda)
, B: &GV (a, n, db)
, C: &GV (a?, m, dc) >> GV (a, m, dc)
, int(m), int(n), int(lda), int(db), int(dc)
) : void // end of [multo_gmatcol_gvector_gvector]

fun{
a:t0p
} multo_gmatrow_gvector_gvector
  {m,n:int}{lda:int}{db,dc:int}
(
  A: &GMR (INV(a), m, n, lda)
, B: &GV (a, n, db)
, C: &GV (a?, m, dc) >> GV (a, m, dc)
, int(m), int(n), int(lda), int(db), int(dc)
) : void // end of [multo_gmatrow_gvector_gvector]

(* ****** ****** *)

(*
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
*)

fun{
a:t0p
} multo_gmatcol_gmatcol_gmatcol
  {p,q,r:int}{lda,ldb,ldc:int}
(
  A: &GMC (INV(a), p, q, lda)
, B: &GMC (    a , q, r, ldb)
, C: &GMC (a?, p, r, ldc) >> GMC (a, p, r, ldc)
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [multo_gmatcol_gmatcol_gmatcol]

fun{
a:t0p
} multo_gmatrow_gmatrow_gmatrow
  {p,q,r:int}{lda,ldb,ldc:int}
(
  A: &GMR (INV(a), p, q, lda)
, B: &GMR (    a , q, r, ldb)
, C: &GMR (a?, p, r, ldc) >> GMR (a, p, r, ldc)
, int p, int q, int r, int lda, int ldb, int ldc
) : void // end of [multo_gmatrow_gmatrow_gmatrow]

(* ****** ****** *)
//
// BB: outer product
// BB: tensor product
//
fun{a:t0p}
tmulto_gvector_gvector_gmatcol
  {m,n:int}{d1,d2:int}{ld3:int}
(
  V1: &GV (INV(a), m, d1)
, V2: &GV (    a , n, d2)
, M3: &GMC (a?, m, n, ld3) >> GMC (a, m, n, ld3)
, m: int(m), n: int(n), d1: int(d1), d2: int(d2), ld3: int(ld3)
) : void (* end of [tmulto_gvector_gvector_gmatcol] *)

fun{a:t0p}
tmulto_gvector_gvector_gmatrow
  {m,n:int}{d1,d2:int}{ld3:int}
(
  V1: &GV (INV(a), m, d1)
, V2: &GV (    a , n, d2)
, M3: &GMR (a?, m, n, ld3) >> GMR (a, m, n, ld3)
, m: int(m), n: int(n), d1: int(d1), d2: int(d2), ld3: int(ld3)
) : void (* end of [tmulto_gvector_gvector_gmatrow] *)

(* ****** ****** *)

(* end of [gmatrix.sats] *)
