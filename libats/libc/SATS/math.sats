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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: April, 2013
//
(* ****** ****** *)

%{#
#include \
"libats/libc/CATS/math.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
#define
ATS_EXTERN_PREFIX "atslib_libc_" // prefix for external names
//
(* ****** ****** *)

#define RD(x) x // for commenting: read-only
#define NSH(x) x // for commenting: no sharing
#define SHR(x) x // for commenting: it is shared

(* ****** ****** *)

macdef M_E = 2.7182818284590452354	// e
macdef M_PI = 3.14159265358979323846	// pi
macdef M_PI_2 = 1.57079632679489661923	// pi/2
macdef M_PI_4 = 0.78539816339744830962	// pi/4

(* ****** ****** *)

macdef INFINITY = $extval (float, "INFINITY")

(* ****** ****** *)
//
// _XOPEN_SOURCE >= 600 || ...
//
fun{a:t0p} isfinite (x: INV(a)):<> int
fun isfinite_float (x: float):<> int = "mac#%"
fun isfinite_double (x: double):<> int = "mac#%"
fun isfinite_ldouble (x: ldouble):<> int = "mac#%"
//
fun{a:t0p} isnormal (x: INV(a)):<> int
fun isnormal_float (x: float):<> int = "mac#%"
fun isnormal_double (x: double):<> int = "mac#%"
fun isnormal_ldouble (x: ldouble):<> int = "mac#%"
//
fun{a:t0p} fpclassify (x: INV(a)):<> int
fun fpclassify_float (x: float):<> int = "mac#%"
fun fpclassify_double (x: double):<> int = "mac#%"
fun fpclassify_ldouble (x: ldouble):<> int = "mac#%"

(* ****** ****** *)
//
// _BSD_SOURCE || _XOPEN_SOURCE || ...
//
fun{a:t0p} isnan (x: INV(a)):<> int
fun isnan_float (x: float):<> int = "mac#%"
fun isnan_double (x: double):<> int = "mac#%"
fun isnan_ldouble (x: ldouble):<> int = "mac#%"
//
(* ****** ****** *)
//
// _BSD_SOURCE || _XOPEN_SOURCE >= 600 || ...
//
fun{a:t0p} isinf (x: INV(a)):<> int
fun isinf_float (x: float):<> int = "mac#%"
fun isinf_double (x: double):<> int = "mac#%"
fun isinf_ldouble (x: ldouble):<> int = "mac#%"
//
(* ****** ****** *)
//
fun{a:t0p} ceil (x: INV(a)):<> a
//
fun ceil_float (x: float):<> float = "mac#%"
fun ceil_double (x: double):<> double = "mac#%"
fun ceil_ldouble (x: ldouble):<> ldouble = "mac#%"
//
(* ****** ****** *)
//
fun{a:t0p} floor (x: INV(a)):<> a
//
fun floor_float (x: float):<> float = "mac#%"
fun floor_double (x: double):<> double = "mac#%"
fun floor_ldouble (x: ldouble):<> ldouble = "mac#%"
//
(* ****** ****** *)
//
fun{a:t0p} round (x: INV(a)):<> a
//
fun round_float (x: float):<> float = "mac#%"
fun round_double (x: double):<> double = "mac#%"
fun round_ldouble (x: ldouble):<> ldouble = "mac#%"
//
(* ****** ****** *)
//
fun{a:t0p} trunc (x: INV(a)):<> a
//
fun trunc_float (x: float):<> float = "mac#%"
fun trunc_double (x: double):<> double = "mac#%"
fun trunc_ldouble (x: ldouble):<> ldouble = "mac#%"
//
(* ****** ****** *)

fun{
a:t0p
} fmod (x1: INV(a), x2: a):<> a
fun fmod_float (x1: float, x2: float):<> float = "mac#%"
fun fmod_double (x1: double, x2: double):<> double = "mac#%"
fun fmod_ldouble (x1: ldouble, x2: ldouble):<> ldouble = "mac#%"

(* ****** ****** *)
//
fun{
a:t0p
} fmax (x1: INV(a), x2: a):<> a
fun fmax_float (x1: float, x2: float):<> float = "mac#%"
fun fmax_double (x1: double, x2: double):<> double = "mac#%"
fun fmax_ldouble (x1: ldouble, x2: ldouble):<> ldouble = "mac#%"
//
fun{
a:t0p
} fmin (x1: INV(a), x2: a):<> a
fun fmin_float (x1: float, x2: float):<> float = "mac#%"
fun fmin_double (x1: double, x2: double):<> double = "mac#%"
fun fmin_ldouble (x1: ldouble, x2: ldouble):<> ldouble = "mac#%"
//
(* ****** ****** *)

fun{
a:t0p
} fdim (x1: INV(a), x2: a):<> a
fun fdim_float (x1: float, x2: float):<> float = "mac#%"
fun fdim_double (x1: double, x2: double):<> double = "mac#%"
fun fdim_ldouble (x1: ldouble, x2: ldouble):<> ldouble = "mac#%"

(* ****** ****** *)
//
// HX: fma (x, y, z) = x * y + z
//
fun{a:t0p} fma (x1: INV(a), x2: a, x3: a):<> a
fun fma_float (x1: float, x2: float, x3: float):<> float = "mac#%"
fun fma_double (x1: double, x2: double, x3: double):<> double = "mac#%"
fun fma_ldouble (x1: ldouble, x2: ldouble, x3: ldouble):<> ldouble = "mac#%"
//
(* ****** ****** *)

fun{a:t0p} sqrt (x: INV(a)):<> a
fun sqrt_float (f: float):<> float = "mac#%"
fun sqrt_double (d: double):<> double = "mac#%"
fun sqrt_ldouble (ld: ldouble):<> ldouble = "mac#%"

(* ****** ****** *)

fun{a:t0p} cbrt (x: INV(a)):<> a
fun cbrt_float (f: float):<> float = "mac#%"
fun cbrt_double (d: double):<> double = "mac#%"
fun cbrt_ldouble (ld: ldouble):<> ldouble = "mac#%"

(* ****** ****** *)

fun{a:t0p} pow (x1: INV(a), x2: a):<> a
fun pow_float (x1: float, x2: float):<> float = "mac#%"
fun pow_double (x1: double, x2: double):<> double = "mac#%"
fun pow_ldouble (x1: ldouble, x2: ldouble):<> ldouble = "mac#%"

(* ****** ****** *)

fun{a:t0p} exp (x: INV(a)):<> a
fun exp_float (f: float):<> float = "mac#%"
fun exp_double (d: double):<> double = "mac#%"
fun exp_ldouble (ld: ldouble):<> ldouble = "mac#%"

(* ****** ****** *)

fun{a:t0p} log (x: INV(a)):<> a
fun log_float (f: float):<> float = "mac#%"
fun log_double (d: double):<> double = "mac#%"
fun log_ldouble (ld: ldouble):<> ldouble = "mac#%"

fun{a:t0p} log10 (x: INV(a)):<> a
fun log10_float (f: float):<> float = "mac#%"
fun log10_double (d: double):<> double = "mac#%"
fun log10_ldouble (ld: ldouble):<> ldouble = "mac#%"

(* ****** ****** *)

fun{a:t0p} sin (x: INV(a)):<> a
fun sin_float (x: float):<> float = "mac#%"
fun sin_double (x: double):<> double = "mac#%"
fun sin_ldouble (x: ldouble):<> ldouble = "mac#%"

fun{a:t0p} cos (x: INV(a)):<> a
fun cos_float (x: float):<> float = "mac#%"
fun cos_double (x: double):<> double = "mac#%"
fun cos_ldouble (x: ldouble):<> ldouble = "mac#%"

fun{a:t0p} tan (x: INV(a)):<> a
fun tan_float (x: float):<> float = "mac#%"
fun tan_double (x: double):<> double = "mac#%"
fun tan_ldouble (x: ldouble):<> ldouble = "mac#%"

(* ****** ****** *)

fun{a:t0p} asin (x: INV(a)):<> a
fun asin_float (x: float):<> float = "mac#%"
fun asin_double (x: double):<> double = "mac#%"
fun asin_ldouble (x: ldouble):<> ldouble = "mac#%"

fun{a:t0p} acos (x: INV(a)):<> a
fun acos_float (x: float):<> float = "mac#%"
fun acos_double (x: double):<> double = "mac#%"
fun acos_ldouble (x: ldouble):<> ldouble = "mac#%"

fun{a:t0p} atan (x: INV(a)):<> a
fun atan_float (x: float):<> float = "mac#%"
fun atan_double (x: double):<> double = "mac#%"
fun atan_ldouble (x: ldouble):<> ldouble = "mac#%"

fun{a:t0p} atan2 (x1: INV(a), x2: a):<> a
fun atan2_float (x1: float, x2: float):<> float = "mac#%"
fun atan2_double (x1: double, x2: double):<> double = "mac#%"
fun atan2_ldouble (x1: ldouble, x2: ldouble):<> ldouble = "mac#%"

(* ****** ****** *)

fun{a:t0p} sinh (x: INV(a)):<> a
fun sinh_float (x: float):<> float = "mac#%"
fun sinh_double (x: double):<> double = "mac#%"
fun sinh_ldouble (x: ldouble):<> ldouble = "mac#%"

fun{a:t0p} cosh (x: INV(a)):<> a
fun cosh_float (x: float):<> float = "mac#%"
fun cosh_double (x: double):<> double = "mac#%"
fun cosh_ldouble (x: ldouble):<> ldouble = "mac#%"

fun{a:t0p} tanh (x: INV(a)):<> a
fun tanh_float (x: float):<> float = "mac#%"
fun tanh_double (x: double):<> double = "mac#%"
fun tanh_ldouble (x: ldouble):<> ldouble = "mac#%"

(* ****** ****** *)

fun{a:t0p} asinh (x: INV(a)):<> a
fun asinh_float (x: float):<> float = "mac#%"
fun asinh_double (x: double):<> double = "mac#%"
fun asinh_ldouble (x: ldouble):<> ldouble = "mac#%"

fun{a:t0p} acosh (x: INV(a)):<> a
fun acosh_float (x: float):<> float = "mac#%"
fun acosh_double (x: double):<> double = "mac#%"
fun acosh_ldouble (x: ldouble):<> ldouble = "mac#%"

fun{a:t0p} atanh (x: INV(a)):<> a
fun atanh_float (x: float):<> float = "mac#%"
fun atanh_double (x: double):<> double = "mac#%"
fun atanh_ldouble (x: ldouble):<> ldouble = "mac#%"

(* ****** ****** *)

(* end of [math.sats] *)
