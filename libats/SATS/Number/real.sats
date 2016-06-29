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
(*
// HX:
// it is built-in
datasort real = //
// abstract sort for real numbers
*)
//
(* ****** ****** *)
//
stacst
neg_real
  : real -> real = "ext#"
//
stadef ~ = neg_real
//
(* ****** ****** *)
//
stacst
add_real_real:
  (real, real) -> real = "ext#"
stacst
sub_real_real:
  (real, real) -> real = "ext#"
stacst
mul_real_real:
  (real, real) -> real = "ext#"
stacst
div_real_real:
  (real, real) -> real = "ext#"
//
stadef + = add_real_real
stadef - = sub_real_real
stadef * = mul_real_real
stadef / = div_real_real
//
(* ****** ****** *)
//
stacst
int2real:
  int -> real = "ext#"
stacst
intint2real:
  (int, int) -> real = "ext#"
//
stadef i2r = int2real
stadef ii2r = intint2real
//
(* ****** ****** *)
//
stacst
sgn_real : real -> int = "ext#"
//
(* ****** ****** *)
//
stacst
floor_real : real -> int = "ext#"
//
(* ****** ****** *)
//
(*
stacst
add_int_real: (int, real) -> real
stacst
add_real_int: (real, int) -> real
stacst
sub_int_real: (int, real) -> real
stacst
sub_real_int: (real, int) -> real
stacst
mul_int_real: (int, real) -> real
stacst
div_real_int: (real, int) -> real
*)
//
stadef
add_int_real
  (i: int, x: real) =
  add_real_real(i2r(i), x)
stadef
add_real_int
  (x: real, i: int) =
  add_real_real(x, i2r(i))
//
stadef
sub_int_real
  (i: int, x: real) =
  sub_real_real(i2r(i), x)
stadef
sub_real_int
  (x: real, i: int) =
  sub_real_real(x, i2r(i))
//
stadef
mul_int_real
  (i: int, x: real) =
  mul_real_real(i2r(i), x)
stadef
div_real_int
  (x: real, i: int) =
  div_real_real(x, i2r(i))
//
stadef + = add_int_real
stadef + = add_real_int
stadef - = sub_int_real
stadef - = sub_real_int
stadef * = mul_int_real
stadef / = div_real_int
//
(* ****** ****** *)
//
stacst
lt_real_real:
  (real, real) -> bool = "ext#"
stacst
lte_real_real:
  (real, real) -> bool = "ext#"
stacst
gt_real_real:
  (real, real) -> bool = "ext#"
stacst
gte_real_real:
  (real, real) -> bool = "ext#"
stacst
eq_real_real:
  (real, real) -> bool = "ext#"
stacst
neq_real_real:
  (real, real) -> bool = "ext#"
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
stadef
lt_real_int
  (x: real, i: int) =
  lt_real_real(x, i2r(i))
stadef
lte_real_int
  (x: real, i: int) =
  lte_real_real(x, i2r(i))
stadef
gt_real_int
  (x: real, i: int) =
  gt_real_real(x, i2r(i))
stadef
gte_real_int
  (x: real, i: int) =
  gte_real_real(x, i2r(i))
stadef
eq_real_int
  (x: real, i: int) =
  eq_real_real(x, i2r(i))
stadef
neq_real_int
  (x: real, i: int) =
  neq_real_real(x, i2r(i))
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
float2real:
float -> real = "ext#"
stadef f2r = float2real

(* ****** ****** *)
//
stacst
abs_real:
  real -> real = "ext#"
//
stadef abs = abs_real
//
stacst
sqrt_real:
  real -> real = "ext#"
stacst
cbrt_real:
  real -> real = "ext#"
//
stadef sqrt = sqrt_real
stadef cbrt = cbrt_real
//
(* ****** ****** *)
//
praxi
lemma_sqrt_def
  {x:real|x >= 0}(): [x==sqrt(x)*sqrt(x)] unit_p
//
praxi
lemma_cbrt_def
  {x:real}((*void*)): [x==cbrt(x)*cbrt(x)*cbrt(x)] unit_p
//
(* ****** ****** *)
//
stacst
sin_real: real -> real = "ext#"
stacst
cos_real: real -> real = "ext#"
stacst
tan_real: real -> real = "ext#"
stacst
cot_real: real -> real = "ext#"
//
stadef sin = sin_real and cos = cos_real
stadef tan = tan_real and cot = cot_real
//
(* ****** ****** *)

(* end of [real.sats] *)
