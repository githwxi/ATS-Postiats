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
// HX-2016-05:
//
(* ****** ****** *)
//
#staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload
Math =
"libats/libc/SATS/math.sats"
//
(* ****** ****** *)
//
#staload
"libats/SATS/Number/real.sats"
//
(* ****** ****** *)
//
abst@ype
real_real_t0ype(real) = double
//
typedef
real(r:real) = real_real_t0ype(r)
//
typedef
real0 = [r:real] real_real_t0ype(r)
//
(* ****** ****** *)
//
#include "./SHARE/real.dats"
//
(* ****** ****** *)
//
assume
real_real_t0ype(r:real) = double
//
(* ****** ****** *)
//
implement
neg_real<> = g0float_neg_double
//
(* ****** ****** *)
//
implement
abs_real<> = g0float_abs_double
//
(* ****** ****** *)
//
implement
add_real_real<> = g0float_add_double
implement
sub_real_real<> = g0float_sub_double
implement
mul_real_real<> = g0float_mul_double
implement
div_real_real<> = g0float_div_double
//
(* ****** ****** *)
//
implement
{}(*tmp*)
add_int_real(i, x) =
  add_real_real(int2real(i), x)
implement
{}(*tmp*)
add_real_int(x, i) =
  add_real_real(x, int2real(i))
//
implement
{}(*tmp*)
sub_int_real(i, x) =
  sub_real_real(int2real(i), x)
implement
{}(*tmp*)
sub_real_int(x, i) =
  sub_real_real(x, int2real(i))
//
implement
{}(*tmp*)
mul_int_real(i, x) =
  mul_real_real(int2real(i), x)
implement
{}(*tmp*)
div_real_int(x, i) =
  div_real_real(x, int2real(i))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
lt_real_real(x, y) =
  $UN.cast(g0float_lt(x, y))
implement
{}(*tmp*)
lte_real_real(x, y) =
  $UN.cast(g0float_lte(x, y))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
gt_real_real(x, y) =
  $UN.cast(g0float_gt(x, y))
implement
{}(*tmp*)
gte_real_real(x, y) =
  $UN.cast(g0float_gte(x, y))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
eq_real_real(x, y) =
  $UN.cast(g0float_eq(x, y))
implement
{}(*tmp*)
neq_real_real(x, y) =
  $UN.cast(g0float_neq(x, y))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
lt_real_int(x, i) =
  $UN.cast(g0float_lt(x, int2real(i)))
implement
{}(*tmp*)
lte_real_int(x, i) =
  $UN.cast(g0float_lte(x, int2real(i)))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
gt_real_int(x, i) =
  $UN.cast(g0float_gt(x, int2real(i)))
implement
{}(*tmp*)
gte_real_int(x, i) =
  $UN.cast(g0float_gte(x, int2real(i)))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
eq_real_int(x, i) =
  $UN.cast(g0float_eq(x, int2real(i)))
implement
{}(*tmp*)
neq_real_int(x, i) =
  $UN.cast(g0float_neq(x, int2real(i)))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
int2real(i) =
  g0int2float_int_double(i)
//
(* ****** ****** *)

implement
{}(*tmp*)
sqrt_real(r) = $Math.sqrt_double(r)

(* ****** ****** *)
//
implement
{}(*tmp*)
sin_real(x) = $Math.sin(x)
implement
{}(*tmp*)
cos_real(x) = $Math.cos(x)
//
implement
{}(*tmp*)
tan_real(x) = $Math.tan(x)
//
(* ****** ****** *)

implement
{}(*tmp*)
print_real0(r) = fprint_real0(stdout_ref, r)
implement
{}(*tmp*)
prerr_real0(r) = fprint_real0(stderr_ref, r)

(* ****** ****** *)

implement
{}(*tmp*)
fprint_real0(out, r) = fprint_double(out, r)

(* ****** ****** *)

(* end of [real_double.dats] *)
