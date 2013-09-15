(*
**
** ATS/Cairo Tutorial:
** drawing rectangles and circles
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: 2010-04
**
*)

(*
** Copyright (C) 2009-2010 Hongwei Xi, Boston University
**
** Permission is hereby granted, free of charge, to any person
** obtaining a copy of this software and associated documentation
** files (the "Software"), to deal in the Software without
** restriction, including without limitation the rights to use,
** copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following
** conditions:
**
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)

(*
** Ported to ATS2 by Hongwei Xi, September, 2013
*)

(* ****** ****** *)
//
// How to compile:
//   patscc -o tutprog_sqrcirc tutprog_sqrcirc.dats `pkg-config cairo --cflags --libs`
//
// How to test: ./tutprog_sqrcirc
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload MATH = "libc/SATS/math.sats"
//
macdef PI = $MATH.M_PI
//
(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

fun draw_sqrcirc {l:agz}
  (cr: !cairo_ref l): void = let
  val () = cairo_rectangle (cr, ~0.5, ~0.5, 1.0, 1.0)
  val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0) // black color
  val () = cairo_fill (cr)
  val () = cairo_arc (cr, 0.0, 0.0, 0.5, 0.0, 2*PI)
  val () = cairo_set_source_rgb (cr, 1.0, 1.0, 1.0) // white color
  val () = cairo_fill (cr)
in
  // nothing
end // end of [draw_sqrcirc]

(* ****** ****** *)

implement
main0 () = () where {
//
val W = 250 and H = 250
//
// create a sf for drawing
//
val sf =
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, W, H)
val cr = cairo_create (sf)
//
val WH = min (W, H)
val WH = g0int2float_int_double (WH)
//
val (pf0 | ()) = cairo_save (cr)
val () = cairo_translate (cr, WH/2, WH/2)
val () = cairo_scale (cr, WH, WH)
val () = draw_sqrcirc (cr)
val () = cairo_restore (pf0 | cr)
//
val status =
  cairo_surface_write_to_png (sf, "tutprog_sqrcirc.png")
val () = cairo_surface_destroy (sf) // a type error if omitted
val () = cairo_destroy (cr) // a type error if omitted
//
// in case of a failure ...
//
val () = assertloc (status = CAIRO_STATUS_SUCCESS)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [tutprog_sqrcirc.dats] *)
