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
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: March, 2013
//
(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
#define
ATS_DYNLOADFLAG 0 // no dynloading at run-time
#define
ATS_EXTERN_PREFIX
"atslib_libats_libc_" // prefix for external names
//
(* ****** ****** *)

staload "libats/libc/SATS/math.sats"

(* ****** ****** *)

implement
isfinite<float> = isfinite_float
implement
isfinite<double> = isfinite_double
implement
isfinite<ldouble> = isfinite_ldouble

(* ****** ****** *)

implement
isnormal<float> = isnormal_float
implement
isnormal<double> = isnormal_double
implement
isnormal<ldouble> = isnormal_ldouble

(* ****** ****** *)

implement
fpclassify<float> = fpclassify_float
implement
fpclassify<double> = fpclassify_double
implement
fpclassify<ldouble> = fpclassify_ldouble

(* ****** ****** *)
//
implement isinf<float> = isinf_float
implement isinf<double> = isinf_double
implement isinf<ldouble> = isinf_ldouble
//
implement isnan<float> = isnan_float
implement isnan<double> = isnan_double
implement isnan<ldouble> = isnan_ldouble
//
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

implement fmod<float> = fmod_float
implement fmod<double> = fmod_double
implement fmod<ldouble> = fmod_ldouble

(* ****** ****** *)
//
implement fmax<float> = fmax_float
implement fmax<double> = fmax_double
implement fmax<ldouble> = fmax_ldouble
//
implement fmin<float> = fmin_float
implement fmin<double> = fmin_double
implement fmin<ldouble> = fmax_ldouble
//
(* ****** ****** *)

implement fdim<float> = fdim_float
implement fdim<double> = fdim_double
implement fdim<ldouble> = fdim_ldouble

(* ****** ****** *)

implement fma<float> = fma_float
implement fma<double> = fma_double
implement fma<ldouble> = fma_ldouble

(* ****** ****** *)
//
implement sqrt<float> = sqrt_float
implement sqrt<double> = sqrt_double
implement sqrt<ldouble> = sqrt_ldouble
//
implement cbrt<float> = cbrt_float
implement cbrt<double> = cbrt_double
implement cbrt<ldouble> = cbrt_ldouble
//
(* ****** ****** *)

implement pow<float> = pow_float
implement pow<double> = pow_double
implement pow<ldouble> = pow_ldouble

(* ****** ****** *)

implement exp<float> = exp_float
implement exp<double> = exp_double
implement exp<ldouble> = exp_ldouble

(* ****** ****** *)

implement log<float> = log_float
implement log<double> = log_double
implement log<ldouble> = log_ldouble
implement log10<float> = log10_float
implement log10<double> = log10_double
implement log10<ldouble> = log10_ldouble

(* ****** ****** *)
//
implement sin<float> = sin_float
implement sin<double> = sin_double
implement sin<ldouble> = sin_ldouble
//
implement cos<float> = cos_float
implement cos<double> = cos_double
implement cos<ldouble> = cos_ldouble
//
implement tan<float> = tan_float
implement tan<double> = tan_double
implement tan<ldouble> = tan_ldouble
//
(* ****** ****** *)
//
implement asin<float> = asin_float
implement asin<double> = asin_double
implement asin<ldouble> = asin_ldouble
//
implement acos<float> = acos_float
implement acos<double> = acos_double
implement acos<ldouble> = acos_ldouble
//
implement atan<float> = atan_float
implement atan<double> = atan_double
implement atan<ldouble> = atan_ldouble
//
implement atan2<float> = atan2_float
implement atan2<double> = atan2_double
implement atan2<ldouble> = atan2_ldouble
//
(* ****** ****** *)
//
implement sinh<float> = sinh_float
implement sinh<double> = sinh_double
implement sinh<ldouble> = sinh_ldouble
//
implement cosh<float> = cosh_float
implement cosh<double> = cosh_double
implement cosh<ldouble> = cosh_ldouble
//
implement tanh<float> = tanh_float
implement tanh<double> = tanh_double
implement tanh<ldouble> = tanh_ldouble
//
(* ****** ****** *)
//
implement asinh<float> = asinh_float
implement asinh<double> = asinh_double
implement asinh<ldouble> = asinh_ldouble
//
implement acosh<float> = acosh_float
implement acosh<double> = acosh_double
implement acosh<ldouble> = acosh_ldouble
//
implement atanh<float> = atanh_float
implement atanh<double> = atanh_double
implement atanh<ldouble> = atanh_ldouble
//
(* ****** ****** *)

(* end of [math.dats] *)
