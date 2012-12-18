(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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

(*
** Start Time: December, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

typedef rgb_type =
  @{red= double, green= double, blue= double}
typedef rgb = rgb_type

typedef rgba_type =
  @{red= double, green= double, blue= double, alpha= double}
typedef rgba = rgba_type

(* ****** ****** *)

fun cairo_set_source_rgb_arr
  {n:int | n >= 3} (ctx: !xr1, rgb: &(@[double][n])): void
fun cairo_set_source_rgb_vec (ctx: !xr1, rgb: &rgb): void

(* ****** ****** *)

fun cairo_set_source_rgba_arr
  {n:int | n >= 4} (ctx: !xr1, rgb: &(@[double][n])): void
fun cairo_set_source_rgba_vec (ctx: !xr1, rgba: &rgba): void

(* ****** ****** *)

(* end of [cairo_extrats.sats] *)
