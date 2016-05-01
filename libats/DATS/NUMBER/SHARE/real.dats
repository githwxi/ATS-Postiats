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
neg_real:
  {x:real} (real(x)) -<fun> real(~x)
//
(* ****** ****** *)
//
extern
fun{}
add_real_real
  {x,y:real}(real(x), real(y)):<> real(x+y)
//
(* ****** ****** *)
//
extern
fun{}
add_real_real
  {x,y:real}(real(x), real(y)):<> real(x+y)
//
extern
fun{}
sub_real_real
  {x,y:real}(real(x), real(y)):<> real(x-y)
//
extern
fun{}
mul_real_real
  {x,y:real}(real(x), real(y)):<> real(x*y)
//
extern
fun{}
div_real_real
  {x,y:real}(real(x), real(y)):<> real(x/y)
//
(* ****** ****** *)
//
extern
fun{}
abs_real:
  {x:real} (real(x)) -<fun> real(abs(x))
//
(* ****** ****** *)
//
extern
fun{}
sqrt_real:
  {x:real | x >= i2r(0)} (real(x)) -<fun> real(sqrt(x))
//
(* ****** ****** *)

(* end of [real_double.sats] *)
