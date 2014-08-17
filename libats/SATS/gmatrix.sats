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

#define ATS_PACKNAME "ATSLIB.libats.gmatrix"

(* ****** ****** *)

staload "libats/SATS/gvector.sats"

(* ****** ****** *)
//
sortdef mord = int
//
stadef mrow: mord = 0 // row-major
stadef mcol: mord = 1 // col-major
//
datatype MORD (int) =
  | MORDrow (mrow) of () | MORDcol (mcol) of ()
//
typedef MORD = [mo:mord] MORD(mo)
//
(* ****** ****** *)
//
datasort transp = tpn | tpt | tpc
datatype TRANSP (transp) =
  | TPN (tpn) of () | TPT (tpt) of () | TPC (tpc) of ()
//
typedef TRANSP = [tp:transp] TRANSP(tp)
//
(* ****** ****** *)

dataprop
transpdim
(
  transp
, int // row
, int // col
, int // row_new
, int // col_new
) =
  | {m,n:int} TPDIM_N (tpn, m, n, m, n) of ()
  | {m,n:int} TPDIM_T (tpt, m, n, n, m) of ()
  | {m,n:int} TPDIM_C (tpc, m, n, n, m) of ()
// end of [transpdim]

(* ****** ****** *)
//
// HX: [transp] is inverse
//
prfun
transpdim_transp
  {tp:transp}{m1,n1:int}{m2,n2:int}
  (pf: transpdim (tp, m1, n1, m2, n2)): transpdim (tp, n1, m1, n2, m2)
// end of [transpdim_transp]

(* ****** ****** *)

sortdef uplo = int
stadef uplo_l: uplo = 0 // lo
stadef uplo_u: uplo = 1 // up
datatype UPLO (uplo) = UPLO_L (uplo_l) | UPLO_U (uplo_u) of ()

(* ****** ****** *)

sortdef diag = int
stadef diag_n: diag = 0 // non
stadef diag_u: diag = 1 // unit
datatype DIAG (diag) = DIAG_N (diag_n) | DIAG_U (diag_u) of ()

(* ****** ****** *)

sortdef side = int
stadef side_l: side = 0 // left
stadef side_r: side = 1 // right
datatype SIDE (side) = SIDE_L (side_l) | SIDE_R (side_r) of ()

(* ****** ****** *)
//
// HX-2013-07:
// generic matrix:
// element, row, col, ord, ld
//
abst@ype
gmatrix_t0ype
  (a:t@ype, mo:mord, m:int, n:int, ld:int) (* irregular *)
//
typedef gmatrix
  (a:t0p, mo:mord, m:int, n:int, ld:int) = gmatrix_t0ype (a, mo, m, n, ld)
viewdef gmatrix_v
  (a:t0p, mo:mord, l:addr, m:int, n:int, ld:int) = gmatrix_t0ype (a, mo, m, n, ld) @ l
//
stadef GMX = gmatrix
stadef GMX = gmatrix_v
//
(* ****** ****** *)
//
typedef gmatrow
  (a:t0p, m:int, n:int, ld:int) = gmatrix_t0ype (a, mrow, m, n, ld)
viewdef gmatrow_v
  (a:t0p, l:addr, m:int, n:int, ld:int) = gmatrix_t0ype (a, mrow, m, n, ld) @ l
//
stadef GMR = gmatrow
stadef GMR = gmatrow_v
//
(* ****** ****** *)
//
typedef gmatcol
  (a:t0p, m:int, n:int, ld:int) = gmatrix_t0ype (a, mcol, m, n, ld)
viewdef gmatcol_v
  (a:t0p, l:addr, m:int, n:int, ld:int) = gmatrix_t0ype (a, mcol, m, n, ld) @ l
//
stadef GMC = gmatcol
stadef GMC = gmatcol_v
//
(* ****** ****** *)

praxi
lemma_gmatrix_param
  {a:t0p}{mo:mord}
  {m,n:int}{ld:int}
  (M: &GMX (a, mo, m, n, ld))
: [0 <= mo; mo <= 1; 0 <= m; 0 <= n; 0 <= ld] void
praxi
lemma_gmatrix_v_param
  {a:t0p}{mo:mord}
  {l:addr}{m,n:int}{ld:int}
  (pf: !GMX (a, mo, l, m, n, ld))
: [0 <= mo; mo <= 1; 0 <= m; 0 <= n; 0 <= ld] void

(* ****** ****** *)
//
(*
// HX-2013-07:
// Don't use [gmatrix_initize]
// unless you know what you are doing
*)
praxi
gmatrix_initize
  {a:t0p}{mo:mord}{m,n:int}{ld:int}
  (&GMX(a?, mo, m, n, ld) >> GMX(a, mo, m, n, ld)): void
praxi
gmatrix_uninitize
  {a:t0p}{mo:mord}{m,n:int}{ld:int}
  (&GMX(a, mo, m, n, ld) >> GMX(a?, mo, m, n, ld)): void
//
(* ****** ****** *)
//
praxi
gmatrix_flipord
  {a:t0p}{mo:mord}
  {m,n:int}{ld:int}
  (M: &GMX(a, mo, m, n, ld) >> GMX(a, 1-mo, n, m, ld)): void
praxi
gmatrix_v_flipord
  {a:t0p}{mo:mord}
  {l:addr}{m,n:int}{ld:int}
  (pf: !GMX(a, mo, l, m, n, ld) >> GMX(a, 1-mo, l, n, m, ld)): void
//
(* ****** ****** *)

fun{}
fprint_gmatrix$sep1 (out: FILEref): void
fun{}
fprint_gmatrix$sep2 (out: FILEref): void
fun{a:t0p}
fprint_gmatrix
  {mo:mord}{m,n:int}{ld:int}
(
  FILEref
, V: &GMX(a, mo, m, n, ld), MORD(mo), int(m), int(n), int(ld)
) : void // end of [fprint_gmatrix]

fun{a:t0p}
fprint_gmatrix_sep
  {mo:mord}{m,n:int}{ld:int}
(
  FILEref
, V: &GMX(a, mo, m, n, ld)
, MORD(mo), int(m), int(n), int(ld), sep1: string, sep: string
) : void // end of [fprint_gmatrix_sep]

(* ****** ****** *)

fun{
a:t0p}{env:vt0p
} gmatrix_iforeach$fwork{n:int}
(
  i: int, j: int, x: &(a) >> _, env: &(env) >> _
) : void // end of [gmatrix_iforeach$fwork]

fun{
a:t0p
} gmatrix_iforeach
  {mo:mord}{m,n:int}{ld:int}
(
  M: &GMX(a, mo, m, n, ld) >> _, MORD(mo), int m, int n, int ld
) : void // end of [gmatrix_iforeach]
fun{
a:t0p}{env:vt0p
} gmatrix_iforeach_env
  {mo:mord}{m,n:int}{ld:int}
(
  M: &GMX(a, mo, m, n, ld) >> _, MORD(mo), int m, int n, int ld, env: &(env) >> _
) : void // end of [gmatrix_iforeach_env]

(* ****** ****** *)

fun{a:t0p}
gmatrix_imake$fopr
  (i: int, j: int, x: a): a

fun{a:t0p}
gmatrix_imake_arrayptr
  {mo:mord}{m,n:int}{ld:int}
(
  M: &GMX(a, mo, m, n, ld), mo: MORD(mo), int m, int n, int(ld)
) : arrayptr (a, m*n) // end of [gmatrix_imake_arrayptr]
fun{a:t0p}
gmatrix_imake_matrixptr
  {mo:mord}{m,n:int}{ld:int}
(
  M: &GMX(a, mo, m, n, ld), mo: MORD(mo), int m, int n, int(ld)
) : matrixptr (a, m, n) // end of [gmatrix_imake_matrixptr]

(* ****** ****** *)

abst@ype
trmatrix_t0ype
(
  a:t@ype
, mo: mord, ul: uplo, dg: diag, n:int, ld: int
)
typedef trmatrix
(
  a:t0p, mo:mord, ul: uplo, dg: diag, n:int, ld:int
) = trmatrix_t0ype (a, mo, ul, dg, n, ld)
viewdef trmatrix_v
(
  a:t0p, mo:mord, ul: uplo, dg: diag, l:addr, n:int, ld:int
) = trmatrix_t0ype (a, mo, ul, dg, n, ld) @ l
//
stadef TRMX = trmatrix
stadef TRMX = trmatrix_v
//
(* ****** ****** *)
//
praxi
trmatrix_flipord
  {a:t0p}
  {mo:mord}
  {ul:uplo}
  {dg:diag}
  {n:int}{ld:int}
  (M: &TRMX(a, mo, ul, dg, n, ld) >> TRMX(a, 1-mo, 1-ul, dg, n, ld)): void
praxi
trmatrix_v_flipord
  {a:t0p}
  {mo:mord}
  {ul:uplo}
  {dg:diag}
  {l:addr}
  {n:int}{ld:int}
  (pf: !TRMX(a, mo, ul, dg, l, n, ld) >> TRMX(a, 1-mo, 1-ul, dg, l, n, ld)): void
//
(* ****** ****** *)

(* end of [gmatrix.sats] *)
