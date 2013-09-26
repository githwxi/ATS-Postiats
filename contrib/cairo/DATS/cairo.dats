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
** Start Time: September, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

staload "./../SATS/cairo.sats"

(* ****** ****** *)

implement
cairo_get1_source (ctx) = let
  val (
    fpf | xrpat
  ) = cairo_get_source (ctx)
  val xrpat1 = cairo_pattern_reference (xrpat)
  prval () = minus_addback (fpf, xrpat | ctx)
in
  xrpat1
end // end of [cairo_get1_source]

(* ****** ****** *)

implement
cairo_get1_target (ctx) = let
  val (
    fpf | xrsf
  ) = cairo_get_target (ctx)
  val xrsf1 = cairo_surface_reference (xrsf)
  prval () = minus_addback (fpf, xrsf | ctx)
in
  xrsf1
end // end of [cairo_get1_target]

implement
cairo_get1_group_target (ctx) = let
  val (
    fpf | xrsf
  ) = cairo_get0_group_target (ctx)
  val xrsf1 = cairo_surface_reference (xrsf)
  prval () = minus_addback (fpf, xrsf | ctx)
in
  xrsf1
end // end of [cairo_get1_group_target]

(* ****** ****** *)

implement
cairo_set_source_rgb_arr (ctx, A) =
  cairo_set_source_rgb (ctx, A.[0], A.[1], A.[2])
// end of [cairo_set_source_rgb_arr]
implement
cairo_set_source_rgb_vec (ctx, rgb) =
  cairo_set_source_rgb (ctx, rgb.red, rgb.green, rgb.blue)
// end of [cairo_set_source_rgb_vec]

(* ****** ****** *)

implement
cairo_set_source_rgba_arr (ctx, A) =
  cairo_set_source_rgba (ctx, A.[0], A.[1], A.[2], A.[3])
// end of [cairo_set_source_rgba_arr]
implement
cairo_set_source_rgba_vec (ctx, rgba) =
  cairo_set_source_rgba (ctx, rgba.red, rgba.green, rgba.blue, rgba.alpha)
// end of [cairo_set_source_rgba_vec]

(* ****** ****** *)

(* end of [cairo.dats] *)
