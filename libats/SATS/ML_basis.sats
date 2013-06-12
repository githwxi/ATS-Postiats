(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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
//
// For supporting ML-style of functional programming
//
(* ****** ****** *)
//
// Author of the file: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: June, 2012
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats"
#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

typedef cfun0
  (b:vt0p) = ((*void*)) -<cloref1> b
typedef cfun1
  (a:vt0p, b:vt0p) = (a) -<cloref1> b
typedef cfun2
  (a1:vt0p, a2:vt0p, b:vt0p) = (a1, a2) -<cloref1> b

(* ****** ****** *)

typedef cfun3
(
  a1:vt0p, a2:vt0p, a3:vt0p, b:vt0p
) = (a1, a2, a3) -<cloref1> b
typedef cfun4
(
  a1:vt0p, a2:vt0p, a3:vt0p, a4:vt0p, b:vt0p
) = (a1, a2, a3, a4) -<cloref1> b
typedef cfun5
(
  a1:vt0p, a2:vt0p, a3:vt0p, a4:vt0p, a5:vt0p, b:vt0p
) = (a1, a2, a3, a4, a5) -<cloref1> b
typedef cfun6
(
  a1:vt0p, a2:vt0p, a3:vt0p, a4:vt0p, a5:vt0p, a6:vt0p, b:vt0p
) = (a1, a2, a3, a4, a5, a6) -<cloref1> b
typedef cfun7
(
  a1:vt0p, a2:vt0p, a3:vt0p, a4:vt0p, a5:vt0p, a6:vt0p, a7:vt0p, b:vt0p
) = (a1, a2, a3, a4, a5, a6, a7) -<cloref1> b
typedef cfun8
(
  a1:vt0p, a2:vt0p, a3:vt0p, a4:vt0p, a5:vt0p, a6:vt0p, a7:vt0p, a8:vt0p, b:vt0p
) = (a1, a2, a3, a4, a5, a6, a7, a8) -<cloref1> b
typedef cfun9
(
  a1:vt0p, a2:vt0p, a3:vt0p, a4:vt0p, a5:vt0p, a6:vt0p, a7:vt0p, a8:vt0p, a9:vt0p, b:vt0p
) = (a1, a2, a3, a4, a5, a6, a7, a8, a9) -<cloref1> b

(* ****** ****** *)

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

(* ****** ****** *)

datatype // t@ype+: covariant
option0_t0ype_type
  (a: t@ype+) = Some0 of (a) | None0 of ()
stadef option0 = option0_t0ype_type

(* ****** ****** *)
//
abstype
array0_vt0ype_type
  (a: vt@ype(*invariant*)) = ptr // = arrszref (a)
//
stadef array0 = array0_vt0ype_type
//
(* ****** ****** *)

(* end of [ML_basics.sats] *)
