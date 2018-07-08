(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// HX-2013-02: a simple drawing package
//
(* ****** ****** *)

#include
"share/atspre_define.hats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/mydraw.sats"
staload "./../SATS/mydraw_HTML5_canvas2d.sats"

(* ****** ****** *)

macdef PI = 3.1415926535898

(* ****** ****** *)

implement{
} mydraw_new_path () = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val () = canvas2d_beginPath (ctx)
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_new_path]

(* ****** ****** *)

implement{
} mydraw_close_path () = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val () = canvas2d_closePath (ctx)
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_close_path]

(* ****** ****** *)

implement{
} mydraw_move_to (p) = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val () = canvas2d_moveTo (ctx, p.x(), p.y())
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_move_to]

implement{
} mydraw_move_to_xy (x, y) = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val () = canvas2d_moveTo (ctx, x, y)
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_move_to_xy]

(* ****** ****** *)

implement{
} mydraw_line_to (p) = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val () = canvas2d_lineTo (ctx, p.x(), p.y())
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_line_to]

implement{
} mydraw_line_to_xy (x, y) = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val () = canvas2d_lineTo (ctx, x, y)
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_line_to_xy]

(* ****** ****** *)

implement{
} mydraw_rectangle
  (pul, w, h) = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val () = canvas2d_rect (ctx, pul.x(), pul.y(), w, h)
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_rectangle]

(* ****** ****** *)

implement{
} mydraw_arc
  (pc, rad, ang1, ang2) = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val () = canvas2d_arc (ctx, pc.x(), pc.y(), rad, ang1, ang2, true)
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_arc]

implement{
} mydraw_arc_neg
  (pc, rad, ang1, ang2) = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val () = canvas2d_arc (ctx, pc.x(), pc.y(), rad, ang1, ang2, false)
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_arc_neg]

(* ****** ****** *)

implement{
} mydraw_fill () = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val ((*void*)) = canvas2d_fill (ctx)
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_fill]

implement{
} mydraw_fill_set_rgb (r, g, b) = let
//
val one = 0.999999
//
val r = (
  if (r > 1.0) then one else if (r < 0.0) then 0.0 else r
) : double
val g = (
  if (g > 1.0) then one else if (g < 0.0) then 0.0 else g
) : double
val b = (
  if (b > 1.0) then one else if (b < 0.0) then 0.0 else b
) : double
//
val r = $UN.cast{int}(r * 0xFF)
val g = $UN.cast{int}(g * 0xFF)
val b = $UN.cast{int}(b * 0xFF)
//
#define BSZ 32
var rgb = @[byte][BSZ]()
val p_rgb = addr@(rgb)
//
abstype charptr = $extype"char*"
//
val
len = $extfcall
(
  int, "snprintf", $UN.cast{charptr}(p_rgb), BSZ, "rgb(%i,%i,%i)", r, g, b
) : int // end of [val]
//
val () = mydraw_fill_set_string<> ($UN.cast{string}(p_rgb))
//
in
  // nothing
end // end of [mydraw_fill_set_rgb]

implement{
} mydraw_fill_set_string (style) = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val ((*void*)) = canvas2d_fillStyle_string (ctx, style)
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_fill_set_string]

(* ****** ****** *)

implement{
} mydraw_stroke () = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val ((*void*)) = canvas2d_stroke (ctx)
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_stroke]

implement{
} mydraw_stroke_set_rgb (r, g, b) = let
//
val one = 0.999999
//
val r = (
  if (r > 1.0) then one else if (r < 0.0) then 0.0 else r
) : double
val g = (
  if (g > 1.0) then one else if (g < 0.0) then 0.0 else g
) : double
val b = (
  if (b > 1.0) then one else if (b < 0.0) then 0.0 else b
) : double
//
val r = $UN.cast{int}(r * 0xFF)
val g = $UN.cast{int}(g * 0xFF)
val b = $UN.cast{int}(b * 0xFF)
//
#define BSZ 32
var rgb = @[byte][BSZ]()
val p_rgb = addr@(rgb)
//
abstype charptr = $extype"char*"
//
val
len = $extfcall
(
  int, "snprintf", $UN.cast{charptr}(p_rgb), BSZ, "rgb(%i,%i,%i)", r, g, b
) : int // end of [val]
//
val () = mydraw_stroke_set_string<> ($UN.cast{string}(p_rgb))
//
in
  // nothing
end // end of [mydraw_stroke_set_rgb]

implement{
} mydraw_stroke_set_string (style) = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val ((*void*)) = canvas2d_strokeStyle_string (ctx, style)
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_stroke_set_string]

(* ****** ****** *)

local

assume mydraw_save_v = unit_v

in (* in of [local] *)

implement{
} mydraw_save () = let
  val (
    fpf | ctx
  ) = mydraw_get0_canvas2d<> ()
  val (pf | ()) = canvas2d_save (ctx)
  prval pf = $UN.castview0{unit_v}(pf)
  prval ((*void*)) = fpf (ctx)
in
  (pf | ())
end // end of [mydraw_save]

implement{
} mydraw_restore (pf | (*void*)) = let
  val [l:addr]
    (fpf | ctx) = mydraw_get0_canvas2d<> ()
  prval pf = $UN.castview0{canvas2d_save_v(l)}(pf)
  val () = canvas2d_restore (pf | ctx)
  prval ((*void*)) = fpf (ctx)
in
  // nothing
end // end of [mydraw_restore]

end // end of [local]

(* ****** ****** *)

(* end of [mydraw_html5_canvas2d.dats] *)
