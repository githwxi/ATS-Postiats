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
M = "libc/SATS/math.sats"
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
"libats/SATS/NUMBER/float.sats"
//
(* ****** ****** *)
//
abst@ype
float_float_t0ype(float) = double
//
typedef float(f:float) = float_float_t0ype(f)

(* ****** ****** *)

typedef float0 = [f:float] float_float_t0ype(f)

(* ****** ****** *)
//
#include "./SHARE/float.dats"
//
(* ****** ****** *)

assume
float_float_t0ype(r:float) = double

(* ****** ****** *)

implement
{}(*tmp*)
neg_float(r) = g0float_neg_double(r)

(* ****** ****** *)
//
implement
{}(*tmp*)
add_float_float(x, y) = g0float_add(x, y)
implement
{}(*tmp*)
sub_float_float(x, y) = g0float_sub(x, y)
implement
{}(*tmp*)
mul_float_float(x, y) = g0float_mul(x, y)
implement
{}(*tmp*)
div_float_float(x, y) = g0float_div(x, y)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
lt_float_float(x, y) = $UN.cast(g0float_lt(x, y))
implement
{}(*tmp*)
lte_float_float(x, y) = $UN.cast(g0float_lte(x, y))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
gt_float_float(x, y) = $UN.cast(g0float_gt(x, y))
implement
{}(*tmp*)
gte_float_float(x, y) = $UN.cast(g0float_gte(x, y))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
eq_float_float(x, y) = $UN.cast(g0float_eq(x, y))
implement
{}(*tmp*)
neq_float_float(x, y) = $UN.cast(g0float_neq(x, y))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
int2float(i) =
  g0int2float_int_double(i)
//
(* ****** ****** *)

implement
{}(*tmp*)
abs_float(x) = g0float_abs(x)

(* ****** ****** *)

implement
{}(*tmp*)
sqrt_float(x) = $M.sqrt_double(x)

(* ****** ****** *)

implement
{}(*tmp*)
print_float0(x) = fprint_float0(stdout_ref, x)
implement
{}(*tmp*)
prerr_float0(x) = fprint_float0(stderr_ref, x)

(* ****** ****** *)

implement
{}(*tmp*)
fprint_float0(out, x) = fprint_double(out, x)

(* ****** ****** *)

(* end of [float_double.sats] *)
