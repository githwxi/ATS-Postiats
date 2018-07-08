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
//
#define
LIBCAIRO_targetloc
"$PATSHOME/npm-utils/contrib/atscntrb-libcairo"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/mydraw.sats"
staload "./../SATS/mydraw_cairo.sats"

(* ****** ****** *)

staload "{$LIBCAIRO}/SATS/cairo.sats"

(* ****** ****** *)

macdef PI = 3.1415926535898

(* ****** ****** *)

implement
{}(*tmp*)
mydraw_get1_cairo () = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val cr2 = cairo_reference (cr)
  prval ((*void*)) = fpf (cr)
in
  cr2
end // end of [mydraw_get1_cairo]

(* ****** ****** *)

implement
{}(*tmp*)
mydraw_new_path () = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_new_path (cr)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_new_path]

(* ****** ****** *)

implement
{}(*tmp*)
mydraw_close_path () = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_close_path (cr)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_close_path]

(* ****** ****** *)

implement
{}(*tmp*)
mydraw_move_to (p) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_move_to (cr, p.x(), p.y())
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_move_to]

implement
{}(*tmp*)
mydraw_move_to_xy (x, y) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_move_to (cr, x, y)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_move_to_xy]

(* ****** ****** *)

implement
{}(*tmp*)
mydraw_line_to (p) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_line_to (cr, p.x(), p.y())
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_line_to]

implement
{}(*tmp*)
mydraw_line_to_xy (x, y) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_line_to (cr, x, y)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_line_to_xy]

(* ****** ****** *)

implement
{}(*tmp*)
mydraw_rel_line_to (v) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_rel_line_to (cr, v.x(), v.y())
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_rel_line_to]

implement
{}(*tmp*)
mydraw_rel_line_to_dxy (dx, dy) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_rel_line_to (cr, dx, dy)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_rel_line_to_dxy]

(* ****** ****** *)

implement
{}(*tmp*)
mydraw_rectangle
  (pul, w, h) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_rectangle (cr, pul.x(), pul.y(), w, h)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_rectangle]

(* ****** ****** *)

implement
{}(*tmp*)
mydraw_arc
  (pc, rad, ang1, ang2) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_arc (cr, pc.x(), pc.y(), rad, ang1, ang2)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_arc]

implement
{}(*tmp*)
mydraw_arc_neg
  (pc, rad, ang1, ang2) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_arc_negative (cr, pc.x(), pc.y(), rad, ang1, ang2)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_arc_neg]

implement
{}(*tmp*)
mydraw_circle
  (pc, rad) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_new_sub_path (cr)
  val () = cairo_arc (cr, pc.x(), pc.y(), rad, 0.0, 2*PI)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_circle]

(* ****** ****** *)

implement
{}(*tmp*)
mydraw_fill () = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val ((*void*)) = cairo_fill (cr)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_fill]

implement
{}(*tmp*)
mydraw_fill_set_rgb
  (r, g, b) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_set_source_rgb (cr, r, g, b)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_fill_set_rgb]

implement
{}(*tmp*)
mydraw_fill_set_rgba
  (r, g, b, a) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_set_source_rgba (cr, r, g, b, a)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_fill_set_rgba]

(* ****** ****** *)

implement
{}(*tmp*)
mydraw_stroke () = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val ((*void*)) = cairo_stroke (cr)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_stroke]

implement
{}(*tmp*)
mydraw_stroke_set_rgb
  (r, g, b) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_set_source_rgb (cr, r, g, b)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_stroke_set_rgb]

implement
{}(*tmp*)
mydraw_stroke_set_rgba
  (r, g, b, a) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_set_source_rgba (cr, r, g, b, a)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_stroke_set_rgba]

(* ****** ****** *)

local

assume mydraw_save_v = unit_v

in (* in of [local] *)

implement
{}(*tmp*)
mydraw_save () = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val (pf | ()) = cairo_save (cr)
  prval pf = $UN.castview0{unit_v}(pf)
  prval ((*void*)) = fpf (cr)
in
  (pf | ())
end // end of [mydraw_save]

implement
{}(*tmp*)
mydraw_restore (pf | (*void*)) = let
  val [l:addr]
    (fpf | cr) = mydraw_get0_cairo<> ()
  prval pf = $UN.castview0{cairo_save_v(l)}(pf)
  val () = cairo_restore (pf | cr)
  prval ((*void*)) = fpf (cr)
in
  // nothing
end // end of [mydraw_restore]

end // end of [local]

(* ****** ****** *)

(* end of [mydraw_cairo.dats] *)
