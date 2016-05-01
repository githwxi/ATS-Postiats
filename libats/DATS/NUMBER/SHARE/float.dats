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
extern
fun{}
neg_float:
  {x:float} (float(x)) -<fun> float(~x)
//
(* ****** ****** *)
//
extern
fun{}
add_float_float
  {x,y:float}(float(x), float(y)):<> float(x+y)
//
(* ****** ****** *)
//
extern
fun{}
add_float_float
  {x,y:float}(float(x), float(y)):<> float(x+y)
//
extern
fun{}
sub_float_float
  {x,y:float}(float(x), float(y)):<> float(x-y)
//
extern
fun{}
mul_float_float
  {x,y:float}(float(x), float(y)):<> float(x*y)
//
extern
fun{}
div_float_float
  {x,y:float}(float(x), float(y)):<> float(x/y)
//
(* ****** ****** *)
//
extern
fun{}
abs_float:
  {x:float} (float(x)) -<fun> float(abs(x))
//
(* ****** ****** *)
//
extern
fun{}
sqrt_float:
  {x:float | x >= i2f(0)} (float(x)) -<fun> float(sqrt(x))
//
(* ****** ****** *)

(* end of [float.sats] *)
