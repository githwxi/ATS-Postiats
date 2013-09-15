(*
**
** ATS/Cairo Tutorial: Drawing Text
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: 2010-04-30
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
//
// How to compile:
//   patscc -o tutprog_showtext tutprog_showtext.dats `pkg-config cairo --cflags --libs`
//
// How to test: ./tutprog_showtext
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
staload
MATH = "libc/SATS/math.sats"
//
macdef PI = $MATH.M_PI
//
(* ****** ****** *)
//
staload "{$CAIRO}/SATS/cairo.sats"
//
(* ****** ****** *)

fun showtext{l:agz}
(
  cr: !cairo_ref l, utf8: string
) : void = () where {
  var te : cairo_text_extents_t
  val () = cairo_text_extents (cr, utf8, te)
//
  val width = te.width
  and height = te.height
  val x_base = te.width / 2 + te.x_bearing
  and y_base = ~te.y_bearing / 2
//
  val (pf0 | ()) = cairo_save (cr)
//
  val () = cairo_rectangle (cr, ~width / 2, ~height/ 2, width, height)
  val () = cairo_set_source_rgb (cr, 0.5, 0.5, 1.0)
  val () = cairo_fill (cr)
//
  #define RAD 2.0
  val () = cairo_arc (cr, ~x_base, y_base, RAD, 0.0, 2*PI)
  val () = cairo_set_source_rgb (cr, 1.0, 0.0, 0.0) // red
  val () = cairo_fill (cr)
//
  val () = cairo_arc (cr, ~x_base+te.x_advance, y_base+te.y_advance, RAD, 0.0, 2*PI)
  val () = cairo_set_source_rgb (cr, 1.0, 0.0, 0.0) // red
  val () = cairo_fill (cr)
//
  val () = cairo_move_to (cr, ~x_base, y_base)
  val () = cairo_text_path (cr, utf8)
  val () = cairo_set_source_rgb (cr, 0.25, 0.25, 0.25) // dark gray
  val () = cairo_fill (cr)
//
  val () = cairo_restore (pf0 | cr)
//
} // end of [showtext]

(* ****** ****** *)

implement
main0 () = () where
{
val W = 300 and H = 60
val sf = cairo_image_surface_create (CAIRO_FORMAT_ARGB32, W, H)
val cr = cairo_create (sf)
//
#define FONTSIZE 20
val () = cairo_select_font_face
  (cr, "Georgia", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
val () = cairo_set_font_size (cr, g0int2float_int_double(FONTSIZE))
//
val () = cairo_translate (cr, 1.0*W/2, 1.0*H/2)
val () = cairo_scale (cr, 2.5, 2.5)
val () = showtext (cr, "Top Secret")
//
val status = cairo_surface_write_to_png (sf, "tutprog_showtext.png")
val () = cairo_surface_destroy (sf) // a type error if omitted
val () = cairo_destroy (cr) // a type error if omitted
//
val () =
if status = CAIRO_STATUS_SUCCESS then begin
  print "The image is written to the file [tutprog_showtext.png].\n"
end else begin
  print "exit(ATS): [cairo_surface_write_to_png] failed"; print_newline ()
end // end of [if]
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [tutprog_showtext.dats] *)
