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
datasort real = //
// abstract sort for real numbers
//
(* ****** ****** *)
//
stacst
neg_real: real -> real
stadef ~ = neg_real
//
(* ****** ****** *)
//
stacst
add_real_real:
  (real, real) -> real
stacst
sub_real_real:
  (real, real) -> real
stacst
mul_real_real:
  (real, real) -> real
stacst
div_real_real:
  (real, real) -> real
//
stadef + = add_real_real
stadef - = sub_real_real
stadef * = mul_real_real
stadef / = div_real_real
//
(* ****** ****** *)
//
stacst
lt_real_real:
  (real, real) -> bool
stacst
lte_real_real:
  (real, real) -> bool
stacst
gt_real_real:
  (real, real) -> bool
stacst
gte_real_real:
  (real, real) -> bool
stacst
eq_real_real:
  (real, real) -> bool
stacst
neq_real_real:
  (real, real) -> bool
//
stadef < = lt_real_real
stadef <= = lte_real_real
stadef > = gt_real_real
stadef >= = gte_real_real
stadef == = eq_real_real
stadef != = neq_real_real
//
(* ****** ****** *)
//
stacst
lt_real_int:
  (real, int) -> bool
stacst
lte_real_int:
  (real, int) -> bool
stacst
gt_real_int:
  (real, int) -> bool
stacst
gte_real_int:
  (real, int) -> bool
stacst
eq_real_int:
  (real, int) -> bool
stacst
neq_real_int:
  (real, int) -> bool
//
stadef < = lt_real_int
stadef <= = lte_real_int
stadef > = gt_real_int
stadef >= = gte_real_int
stadef == = eq_real_int
stadef != = neq_real_int
//
(* ****** ****** *)

stacst
int2real : int -> real
stadef i2r = int2real

stacst
float2real : float -> real
stadef f2r = float2real

(* ****** ****** *)
//
stacst
abs_real: real -> real
stadef abs = abs_real
//
stacst
sqrt_real: real -> real
stadef sqrt = sqrt_real
stacst
cbrt_real: real -> real
stadef cbrt = cbrt_real
//
(* ****** ****** *)
//
stacst
sin_real: real -> real // sine
stacst
cos_real: real -> real // cosine
stacst
tan_real: real -> real // tangent
stacst
cot_real: real -> real // cotangent
//
stadef sin = sin_real and cos = cos_real
stadef tan = tan_real and cot = cot_real
//
(* ****** ****** *)

(* end of [real.sats] *)
