/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
*) */

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: March, 2013 *)
*/

/* ****** ****** */

#ifndef ATSLIB_LIBATS_LIBC_CATS_MATH
#define ATSLIB_LIBATS_LIBC_CATS_MATH

/* ****** ****** */

#include <math.h>

/* ****** ****** */

#define \
atslib_libats_libc_isfinite_float isfinite
#define \
atslib_libats_libc_isfinite_double isfinite
#define \
atslib_libats_libc_isfinite_ldouble isfinite

/* ****** ****** */

#define \
atslib_libats_libc_isnormal_float isnormal
#define \
atslib_libats_libc_isnormal_double isnormal
#define \
atslib_libats_libc_isnormal_ldouble isnormal

/* ****** ****** */

#define atslib_libats_libc_isinf_float isinf
#define atslib_libats_libc_isinf_double isinf
#define atslib_libats_libc_isinf_ldouble isinf

/* ****** ****** */

#define atslib_libats_libc_isnan_float isnan
#define atslib_libats_libc_isnan_double isnan
#define atslib_libats_libc_isnan_ldouble isnan

/* ****** ****** */

#define atslib_libats_libc_fpclassify_float fpclassify
#define atslib_libats_libc_fpclassify_double fpclassify
#define atslib_libats_libc_fpclassify_ldouble fpclassify

/* ****** ****** */

#define atslib_libats_libc_ceil_float ceilf
#define atslib_libats_libc_ceil_double ceil
#define atslib_libats_libc_ceil_ldouble ceill

/* ****** ****** */

#define atslib_libats_libc_floor_float floorf
#define atslib_libats_libc_floor_double floor
#define atslib_libats_libc_floor_ldouble floorl

/* ****** ****** */

#define atslib_libats_libc_round_float roundf
#define atslib_libats_libc_round_double round
#define atslib_libats_libc_round_ldouble roundl

/* ****** ****** */

#define atslib_libats_libc_trunc_float truncf
#define atslib_libats_libc_trunc_double trunc
#define atslib_libats_libc_trunc_ldouble truncl

/* ****** ****** */

#define atslib_libats_libc_fmod_float fmodf
#define atslib_libats_libc_fmod_double fmod
#define atslib_libats_libc_fmod_ldouble fmodl

/* ****** ****** */

#define atslib_libats_libc_fmax_float fmaxf
#define atslib_libats_libc_fmax_double fmax
#define atslib_libats_libc_fmax_ldouble fmaxl

/* ****** ****** */

#define atslib_libats_libc_fmin_float fminf
#define atslib_libats_libc_fmin_double fmin
#define atslib_libats_libc_fmin_ldouble fminl

/* ****** ****** */

#define atslib_libats_libc_fdim_float fdimf
#define atslib_libats_libc_fdim_double fdim
#define atslib_libats_libc_fdim_ldouble fdiml

/* ****** ****** */

#define atslib_libats_libc_fma_float fmaf
#define atslib_libats_libc_fma_double fma
#define atslib_libats_libc_fma_ldouble fmal

/* ****** ****** */

#define atslib_libats_libc_sqrt_float sqrtf
#define atslib_libats_libc_sqrt_double sqrt
#define atslib_libats_libc_sqrt_ldouble sqrtl

/* ****** ****** */

#define atslib_libats_libc_cbrt_float cbrtf
#define atslib_libats_libc_cbrt_double cbrt
#define atslib_libats_libc_cbrt_ldouble cbrtl

/* ****** ****** */

#define atslib_libats_libc_pow_float powf
#define atslib_libats_libc_pow_double pow
#define atslib_libats_libc_pow_ldouble powl

/* ****** ****** */

#define atslib_libats_libc_exp_float expf
#define atslib_libats_libc_exp_double exp
#define atslib_libats_libc_exp_ldouble expl

/* ****** ****** */
//
#define atslib_libats_libc_log_float logf
#define atslib_libats_libc_log_double log
#define atslib_libats_libc_log_ldouble logl
//
#define atslib_libats_libc_log10_float log10f
#define atslib_libats_libc_log10_double log10
#define atslib_libats_libc_log10_ldouble log10l
//
/* ****** ****** */
//
#define atslib_libats_libc_sin_float sinf
#define atslib_libats_libc_sin_double sin
#define atslib_libats_libc_sin_ldouble sinl
//
#define atslib_libats_libc_cos_float cosf
#define atslib_libats_libc_cos_double cos
#define atslib_libats_libc_cos_ldouble cosl
//
#define atslib_libats_libc_tan_float tanf
#define atslib_libats_libc_tan_double tan
#define atslib_libats_libc_tan_ldouble tanl
//
/* ****** ****** */
//
#define atslib_libats_libc_asin_float asinf
#define atslib_libats_libc_asin_double asin
#define atslib_libats_libc_asin_ldouble asinl
//
#define atslib_libats_libc_acos_float acosf
#define atslib_libats_libc_acos_double acos
#define atslib_libats_libc_acos_ldouble cosl
//
#define atslib_libats_libc_atan_float atanf
#define atslib_libats_libc_atan_double atan
#define atslib_libats_libc_atan_ldouble atanl
//
#define atslib_libats_libc_atan2_float atan2f
#define atslib_libats_libc_atan2_double atan2
#define atslib_libats_libc_atan2_ldouble atan2l
//
/* ****** ****** */
//
#define atslib_libats_libc_sinh_float sinhf
#define atslib_libats_libc_sinh_double sinh
#define atslib_libats_libc_sinh_ldouble sinhl
//
#define atslib_libats_libc_cosh_float coshf
#define atslib_libats_libc_cosh_double cosh
#define atslib_libats_libc_cosh_ldouble coshl
//
#define atslib_libats_libc_tanh_float tanhf
#define atslib_libats_libc_tanh_double tanh
#define atslib_libats_libc_tanh_ldouble tanhl
//
/* ****** ****** */

#define atslib_libats_libc_asinh_float asinhf
#define atslib_libats_libc_asinh_double asinh
#define atslib_libats_libc_asinh_ldouble asinhl
//
#define atslib_libats_libc_acosh_float acoshf
#define atslib_libats_libc_acosh_double acosh
#define atslib_libats_libc_acosh_ldouble acoshl
//
#define atslib_libats_libc_atanh_float atanhf
#define atslib_libats_libc_atanh_double atanh
#define atslib_libats_libc_atanh_ldouble atanhl
//
/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_CATS_MATH

/* ****** ****** */

/* end of [math.cats] */
