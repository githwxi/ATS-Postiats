(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
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

staload "./../SATS/mydraw.sats"

(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

macdef PI = 3.1415926535898

(* ****** ****** *)

implement{
} mydraw_get1_cairo () = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val cr2 = cairo_reference (cr)
  prval () = fpf (cr)
in
  cr2
end // end of [mydraw_get1_cairo]

(* ****** ****** *)

implement{
} mydraw_move_to (p) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_move_to (cr, p.x, p.y)
  prval () = fpf (cr)
in
  // nothing
end // end of [mydraw_move_to]

implement{
} mydraw_line_to (p) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_line_to (cr, p.x, p.y)
  prval () = fpf (cr)
in
  // nothing
end // end of [mydraw_line_to]

(* ****** ****** *)

implement{
} mydraw_triangle
  (p1, p2, p3) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_move_to (cr, p1.x, p1.y)
  val () = cairo_line_to (cr, p2.x, p2.y)
  val () = cairo_line_to (cr, p3.x, p3.y)
  val () = cairo_close_path (cr)
  prval () = fpf (cr)
in
  // nothing
end // end of [mydraw_triangle]

(* ****** ****** *)

implement{
} mydraw_rectangle
  (pul, w, h) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_rectangle (cr, pul.x, pul.y, w, h)
  prval () = fpf (cr)
in
  // nothing
end // end of [mydraw_rectangle]

(* ****** ****** *)

implement{
} mydraw_arc
  (pc, rad, ang1, ang2) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_arc (cr, pc.x, pc.y, rad, ang1, ang2)
  prval () = fpf (cr)
in
  // nothing
end // end of [mydraw_arc]

implement{
} mydraw_arc_neg
  (pc, rad, ang1, ang2) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_arc_negative (cr, pc.x, pc.y, rad, ang1, ang2)
  prval () = fpf (cr)
in
  // nothing
end // end of [mydraw_arc_neg]

implement{
} mydraw_circle
  (pc, rad) = let
  val (
    fpf | cr
  ) = mydraw_get0_cairo<> ()
  val () = cairo_new_sub_path (cr)
  val () = cairo_arc (cr, pc.x, pc.y, rad, 0.0, PI)
  prval () = fpf (cr)
in
  // nothing
end // end of [mydraw_circle]

(* ****** ****** *)

(* end of [mydraw_cairo.dats] *)
