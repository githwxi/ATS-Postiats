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
stacst
neg_float: float -> float
stadef ~ = neg_float
//
(* ****** ****** *)
//
stacst
add_float_float:
  (float, float) -> float
stacst
sub_float_float:
  (float, float) -> float
stacst
mul_float_float:
  (float, float) -> float
stacst
div_float_float:
  (float, float) -> float
//
stadef + = add_float_float
stadef - = sub_float_float
stadef * = mul_float_float
stadef / = div_float_float
//
(* ****** ****** *)
//
stacst
lt_float_float:
  (float, float) -> bool
stacst
lte_float_float:
  (float, float) -> bool
stacst
gt_float_float:
  (float, float) -> bool
stacst
gte_float_float:
  (float, float) -> bool
stacst
eq_float_float:
  (float, float) -> bool
stacst
neq_float_float:
  (float, float) -> bool
//
stadef < = lt_float_float
stadef <= = lte_float_float
stadef > = gt_float_float
stadef >= = gte_float_float
stadef == = eq_float_float
stadef != = neq_float_float
//
(* ****** ****** *)
//
stacst
int2float : int -> float
stadef i2f = int2float
//
(* ****** ****** *)
//
stacst
abs_float: float -> float
stadef abs = abs_float
//
stacst
sqrt_float: float -> float
stadef sqrt = sqrt_float
//
(* ****** ****** *)

(* end of [float.sats] *)
