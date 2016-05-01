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
"libats/SATS/NUMBER/real.sats"
//
(* ****** ****** *)
//
abst@ype
real_real_t0ype(real) = double
//
typedef real(r:real) = real_real_t0ype(r)
//
(* ****** ****** *)
//
#include "./SHARE/real.dats"
//
(* ****** ****** *)

assume
real_real_t0ype(r:real) = double

(* ****** ****** *)

implement
{}(*tmp*)
neg_real(r) = ~r

(* ****** ****** *)
//
implement
{}(*tmp*)
add_real_real(x, y) = g0float_add(x, y)
implement
{}(*tmp*)
sub_real_real(x, y) = g0float_sub(x, y)
implement
{}(*tmp*)
mul_real_real(x, y) = g0float_mul(x, y)
implement
{}(*tmp*)
div_real_real(x, y) = g0float_div(x, y)
//
(* ****** ****** *)

implement
{}(*tmp*)
abs_real(r) = g0float_abs(r)

(* ****** ****** *)

implement
{}(*tmp*)
sqrt_real(r) = $M.sqrt_double(r)

(* ****** ****** *)

(* end of [real_double.sats] *)
