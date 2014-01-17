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
//
// HX-2013-09:
// A multi-set (mset) is like a set but elements can occur more than once
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
abstype
mset_type (a:t@ype+) = ptr
//
typedef mset (a:t0p) = mset_type (a)
//
(* ****** ****** *)

fun{a:t0p}
compare_elt_elt (x: a, y: a):<> int

(* ****** ****** *)

fun{a:t0p}
funmset_size (xs: mset(a), x: a): size_t

(* ****** ****** *)

fun{a:t0p}
funmset_insert (xs: mset(a), x: a): intGte(0)

(* ****** ****** *)

fun{a:t0p}
funmset_remove (xs: mset(a), x: a): intGte(0)

(* ****** ****** *)
//
// HX-2013-09:
// if an element occurs n times in [xs],
// then it occurs n times in the returned list
//
fun{a:t0p}
funmset_listize (xs: mset(a)): list0 (a)
//
(* ****** ****** *)

(* end of [funmset.dats] *)
