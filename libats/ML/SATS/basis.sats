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
//
// t0ype+: covariant
// vt0ype+: covariant
//
datatype
list0_t0ype_type
(
  a: t0ype+
) =
  | list0_nil of
      ((*void*))
  | list0_cons of
      (a, list0_t0ype_type(a))
    // end of [list0_cons]
//
datavtype
list0_vt0ype_vtype
(
  a: vt0ype+
) =
  | list0_vt_nil of
      ((*void*))
  | list0_vt_cons of
      (a, list0_vt0ype_vtype(a))
    // end of [list0_vt_cons]
//
#define nil0 list0_nil
#define cons0 list0_cons
#define nil0_vt list0_vt_nil
#define cons0_vt list0_vt_cons
//
typedef
list0(a:t0ype) = list0_t0ype_type(a)
vtypedef
list0_vt(a:vt0ype) = list0_vt0ype_vtype(a)
//
(* ****** ****** *)
//
// t0ype+: covariant
// vt0ype+: covariant
//
datatype
option0_t0ype_type
(
  a: t0ype+
) =
  | None0 of () | Some0 of (a)
//
datavtype
option0_vt0ype_vtype
(
  a: vt0ype+
) =
  | None0_vt of () | Some0_vt of (a)
//
typedef
option0(a:t0ype) = option0_t0ype_type(a)
vtypedef
option0_vt(a:vt0ype) = option0_vt0ype_vtype(a)
//
(* ****** ****** *)
//
abstype
array0_vt0ype_type
  (a: vt0ype(*invariant*)) = ptr
//
typedef
array0
(a:vt0ype) = array0_vt0ype_type(a)
//
(*
abstype
subarray0_vt0ype_type
  (a: vt0ype(*invariant*)) = ptr
stadef subarray0 = subarray0_vt0ype_type
*)
//
(* ****** ****** *)
//
abstype
matrix0_vt0ype_type
  (a: vt0ype(*invariant*)) = ptr
//
typedef
matrix0
(a:vt0ype) = matrix0_vt0ype_type(a)
//
(* ****** ****** *)
//
abstype strarr_type = ptr
typedef strarr = strarr_type
//
(*
abstype substrarr_type = ptr
typedef substrarr = substrarr_type
*)
//
(* ****** ****** *)
//
abstype
dynarray_type(a:vt0ype) = ptr
//
typedef
dynarray(a:vt0ype) = dynarray_type(a)
//
(* ****** ****** *)
//
// HX:
// for elements of type (a)
//
abstype
hashtbl_type
(key:t0ype, itm:t0ype+) = ptr
//
typedef
hashtbl
( key:t0ype
, itm:t0ype) = hashtbl_type(key, itm)
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
(*
typedef gvopt = Option(gvalue)
vtypedef gvopt_vt = Option_vt(gvalue)
*)
//
(* ****** ****** *)

(* end of [basis.sats] *)
