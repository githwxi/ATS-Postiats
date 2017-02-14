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
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"./../../SATS/float.sats"
//
staload
"libats/SATS/Number/real.sats"
//
(* ****** ****** *)
//
abst@ype
real_real_t0ype(real) = double
//
typedef real(r:real) = real_real_t0ype(r)
//
(* ****** ****** *)

typedef real0 = [r:real] real_real_t0ype(r)

(* ****** ****** *)
//
staload "./../../SATS/JSmath.sats"
//
#include
"libats/DATS/Number/SHARE/real.dats"
//
(* ****** ****** *)
//
assume
real_real_t0ype(r:real) = double
//
(* ****** ****** *)

implement
{}(*tmp*)
neg_real(x) = neg_double(x)

(* ****** ****** *)
//
implement
{}(*tmp*)
add_real_real(x, y) = add_double_double(x, y)
implement
{}(*tmp*)
sub_real_real(x, y) = sub_double_double(x, y)
implement
{}(*tmp*)
mul_real_real(x, y) = mul_double_double(x, y)
implement
{}(*tmp*)
div_real_real(x, y) = div_double_double(x, y)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
add_int_real(i, x) = add_real_real(int2real(i), x)
implement
{}(*tmp*)
add_real_int(x, i) = add_real_real(x, int2real(i))
//
implement
{}(*tmp*)
mul_int_real(i, x) = mul_real_real(int2real(i), x)
implement
{}(*tmp*)
div_real_int(x, i) = div_real_real(x, int2real(i))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
lt_real_real(x, y) = $UN.cast(lt_double_double(x, y))
implement
{}(*tmp*)
lte_real_real(x, y) = $UN.cast(lte_double_double(x, y))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
gt_real_real(x, y) = $UN.cast(gt_double_double(x, y))
implement
{}(*tmp*)
gte_real_real(x, y) = $UN.cast(gte_double_double(x, y))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
eq_real_real(x, y) = $UN.cast(eq_double_double(x, y))
implement
{}(*tmp*)
neq_real_real(x, y) = $UN.cast(neq_double_double(x, y))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
lt_real_int(x, i) =
  $UN.cast(lt_real_real(x, int2real(i)))
implement
{}(*tmp*)
lte_real_int(x, i) =
  $UN.cast(lte_real_real(x, int2real(i)))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
gt_real_int(x, i) =
  $UN.cast(gt_real_real(x, int2real(i)))
implement
{}(*tmp*)
gte_real_int(x, i) =
  $UN.cast(gte_real_real(x, int2real(i)))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
eq_real_int(x, i) =
  $UN.cast(eq_real_real(x, int2real(i)))
implement
{}(*tmp*)
neq_real_int(x, i) =
  $UN.cast(neq_real_real(x, int2real(i)))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
int2real(i) = int2double(i)
//
(* ****** ****** *)

implement
{}(*tmp*)
abs_real(r) = abs_double(r)

(* ****** ****** *)

implement
{}(*tmp*)
sin_real(r) = JSmath_sin(r)
implement
{}(*tmp*)
cos_real(r) = JSmath_cos(r)
implement
{}(*tmp*)
tan_real(r) = JSmath_tan(r)

(* ****** ****** *)

(* end of [real_double.sats] *)
