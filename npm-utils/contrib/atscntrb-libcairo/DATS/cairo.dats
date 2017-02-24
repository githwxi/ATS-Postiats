(*
** API in ATS for cairo
*)

(* ****** ****** *)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
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
