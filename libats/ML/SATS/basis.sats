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
// For supporting ML-style of functional programming
//
(* ****** ****** *)
//
// Author of the file: Hongwei Xi (gmhwxiATgmailDOTcom)
// Start Time: June, 2012
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats"

(* ****** ****** *)
//
typedef
cfun0(b:vt0p) = ((*void*)) -<cloref1> b
typedef
cfun1(a:vt0p, b:vt0p) = (a) -<cloref1> b
typedef
cfun2(a1:vt0p, a2:vt0p, b:vt0p) = (a1, a2) -<cloref1> b
//
(* ****** ****** *)
//
typedef
cfun3 (
  a1:vt0p, a2:vt0p, a3:vt0p, b:vt0p
) = (a1, a2, a3) -<cloref1> b
typedef
cfun4 (
  a1:vt0p, a2:vt0p, a3:vt0p, a4:vt0p, b:vt0p
) = (a1, a2, a3, a4) -<cloref1> b
typedef
cfun5 (
  a1:vt0p, a2:vt0p, a3:vt0p, a4:vt0p, a5:vt0p, b:vt0p
) = (a1, a2, a3, a4, a5) -<cloref1> b
typedef
cfun6 (
  a1:vt0p, a2:vt0p, a3:vt0p, a4:vt0p, a5:vt0p, a6:vt0p, b:vt0p
) = (a1, a2, a3, a4, a5, a6) -<cloref1> b
typedef
cfun7 (
  a1:vt0p, a2:vt0p, a3:vt0p, a4:vt0p, a5:vt0p, a6:vt0p, a7:vt0p, b:vt0p
) = (a1, a2, a3, a4, a5, a6, a7) -<cloref1> b
typedef
cfun8 (
  a1:vt0p, a2:vt0p, a3:vt0p, a4:vt0p, a5:vt0p, a6:vt0p, a7:vt0p, a8:vt0p, b:vt0p
) = (a1, a2, a3, a4, a5, a6, a7, a8) -<cloref1> b
typedef
cfun9 (
  a1:vt0p, a2:vt0p, a3:vt0p, a4:vt0p, a5:vt0p, a6:vt0p, a7:vt0p, a8:vt0p, a9:vt0p, b:vt0p
) = (a1, a2, a3, a4, a5, a6, a7, a8, a9) -<cloref1> b
//
(* ****** ****** *)

stadef cfun = cfun0
stadef cfun = cfun1
stadef cfun = cfun2
stadef cfun = cfun3
stadef cfun = cfun4
stadef cfun = cfun5
stadef cfun = cfun6
stadef cfun = cfun7
stadef cfun = cfun8
stadef cfun = cfun9

(* ****** ****** *)

datatype // t@ype+: covariant
list0_t0ype_type (a: t@ype+) =
  | list0_nil of () | list0_cons of (a, list0_t0ype_type a)
stadef list0 = list0_t0ype_type

#define nil0 list0_nil
#define cons0 list0_cons

(* ****** ****** *)

datatype // t@ype+: covariant
option0_t0ype_type
  (a: t@ype+) = Some0 of (a) | None0 of ()
stadef option0 = option0_t0ype_type

(* ****** ****** *)
//
abstype
array0_vt0ype_type
  (a: vt@ype(*invariant*)) = ptr
stadef array0 = array0_vt0ype_type
(*
abstype
subarray0_vt0ype_type
  (a: vt@ype(*invariant*)) = ptr
stadef subarray0 = subarray0_vt0ype_type
*)
//
(* ****** ****** *)
//
abstype
matrix0_vt0ype_type
  (a: vt@ype(*invariant*)) = ptr
stadef matrix0 = matrix0_vt0ype_type
//
(* ****** ****** *)
//
abstype strarr_type = ptr
typedef strarr = strarr_type
(*
abstype substrarr_type = ptr
typedef substrarr = substrarr_type
*)
//
(* ****** ****** *)
//
abstype
dynarray_type(a:vt@ype) = ptr
//
typedef
dynarray(a:vt@ype) = dynarray_type(a)
//
(* ****** ****** *)
//
// HX: for maps of elements of type (a)
//
abstype
hashtbl_type
  (key:t@ype, itm:t@ype) = ptr
//
typedef
hashtbl(key:t@ype, itm:t@ype) = hashtbl_type(key, itm)
//
(* ****** ****** *)
//
// HX-2015-12-01:
// G-values for generic programming
//
(* ****** ****** *)
//
datatype gvalue =
//
  | GVnil of ()
//
  | GVint of (int)
//
  | GVptr of (ptr)
//
  | GVbool of (bool)
  | GVchar of (char)
//
  | GVfloat of (double)
//
  | GVstring of (string)
//
  | GVref of (gvref)
//
  | GVlist of (gvlist)
//
  | GVarray of (gvarray)
//
  | GVdynarr of (gvdynarr)
//
  | GVhashtbl of (gvhashtbl)
//
  | GVfunclo_fun of ((gvalue) -<fun1> gvalue)
  | GVfunclo_clo of ((gvalue) -<cloref1> gvalue)
//
where
gvref = ref(gvalue)
and
gvlist = list0(gvalue)
and
gvarray = array0(gvalue)
and
gvdynarr = dynarray(gvalue)
and
gvhashtbl = hashtbl(string, gvalue)
//
(* ****** ****** *)

(* end of [basis.sats] *)
