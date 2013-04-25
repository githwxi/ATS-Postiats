(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: March, 2013
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

staload "libc/SATS/math.sats"

(* ****** ****** *)

implement ceil<float> = ceil_float
implement ceil<double> = ceil_double
implement ceil<ldouble> = ceil_ldouble

(* ****** ****** *)

implement floor<float> = floor_float
implement floor<double> = floor_double
implement floor<ldouble> = floor_ldouble

(* ****** ****** *)

implement round<float> = round_float
implement round<double> = round_double
implement round<ldouble> = round_ldouble

(* ****** ****** *)

implement trunc<float> = trunc_float
implement trunc<double> = trunc_double
implement trunc<ldouble> = trunc_ldouble

(* ****** ****** *)

(* end of [math.dats] *)
