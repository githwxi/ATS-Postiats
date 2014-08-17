(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: December, 2012 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)

#if(0)
//
// HX: in [basis.sats]
//
abstype
matrix0_vt0ype_type
  (a: vt@ype(*invariant*)) = ptr
stadef matrix0 = matrix0_vt0ype_type
//
#endif

(* ****** ****** *)

(*
typedef matrix0 (a: vt@ype) = mtrxszref (a)
*)

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)
//
fun{}
matrix0_of_mtrxszref
  {a:vt0p} (mtrxszref (a)):<> matrix0 (a)
//
fun{}
mtrxszref_of_matrix0
  {a:vt0p} (M: matrix0 (a)):<> mtrxszref (a)
//
(* ****** ****** *)

fun{a:t0p}
matrix0_make_elt
  (nrow: size_t, ncol: size_t, init: a):<!wrt> matrix0 (a)
// end of [matrix0_make_elt]

(* ****** ****** *)
//
fun{}
matrix0_get_ref{a:vt0p} (M: matrix0 a):<> Ptr1
//
fun{}
matrix0_get_nrow{a:vt0p} (M: matrix0 a):<> size_t
fun{}
matrix0_get_ncol{a:vt0p} (M: matrix0 a):<> size_t
//
fun{}
matrix0_get_refsize
  {a:vt0p}
(
  M: matrix0 (a)
) :<> [m,n:nat] (matrixref (a, m, n), size_t(m), size_t(n))
//
(* ****** ****** *)
//
fun{a:t0p}
matrix0_get_at_int
  (M: matrix0(a), i: int, j: int):<!exnref> a
//
fun{a:t0p}
matrix0_get_at_size
  (M: matrix0 (a), i: size_t, j: size_t):<!exnref> a
//
symintr matrix0_get_at
overload matrix0_get_at with matrix0_get_at_int
overload matrix0_get_at with matrix0_get_at_size
//
(* ****** ****** *)
//
fun{a:t0p}
matrix0_set_at_int
  (M: matrix0(a), i: int, j: int, x: a):<!exnrefwrt> void
//
fun{a:t0p}
matrix0_set_at_size
  (M: matrix0 (a), i: size_t, j: size_t, x: a):<!exnrefwrt> void
//
symintr matrix0_set_at
overload matrix0_set_at with matrix0_set_at_int
overload matrix0_set_at with matrix0_set_at_size
//
(* ****** ****** *)

(*
fprint_matrix$sep1 // col separation
fprint_matrix$sep2 // row separation
*)
fun{a:vt0p}
fprint_matrix0 (out: FILEref, M: matrix0 (a)): void
fun{a:vt0p}
fprint_matrix0_sep
  (out: FILEref, M: matrix0 (a), sep1: string, sep2: string): void
//
(* ****** ****** *)

fun{a:t0p}
matrix0_copy (M: matrix0 (a)): matrix0 (a)

(* ****** ****** *)

fun{a:vt0p}
matrix0_tabulate
(
  nrow: size_t, ncol: size_t, f: cfun (size_t, size_t, a)
) : matrix0 (a) // end-of-fun

(* ****** ****** *)

fun{a:vt0p}
matrix0_foreach
  (M: matrix0 (a), f: (&a >> _) -<cloref1> void): void
// end of [matrix0_foreach]

fun{a:vt0p}
matrix0_iforeach
  (M: matrix0 (a), f: (size_t, size_t, &a >> _) -<cloref1> void): void
// end of [matrix0_iforeach]

(* ****** ****** *)

fun{
res:vt0p}{a:vt0p
} matrix0_foldleft
(
  M: matrix0 (a), ini: res, f: (res, &a) -<cloref1> res
) : res // end of [matrix0_foldleft]

fun{
res:vt0p}{a:vt0p
} matrix0_ifoldleft
(
  M: matrix0 (a), ini: res, f: (res, size_t, size_t, &a) -<cloref1> res
) : res // end of [matrix0_ifoldleft]

(* ****** ****** *)
//
// overloading for certain symbols
//
(* ****** ****** *)

overload [] with matrix0_get_at_int of 0
overload [] with matrix0_get_at_size of 0
overload [] with matrix0_set_at_int of 0
overload [] with matrix0_set_at_size of 0

(* ****** ****** *)

overload .nrow with matrix0_get_nrow
overload .ncol with matrix0_get_ncol

(* ****** ****** *)

overload fprint with fprint_matrix0
overload fprint with fprint_matrix0_sep

(* ****** ****** *)

(* end of [matrix0.sats] *)
