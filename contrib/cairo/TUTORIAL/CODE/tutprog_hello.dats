(*
**
** ATS/Cairo Tutorial: Hello, world!
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
//   patscc -o tutprog_hello tutprog_hello.dats `pkg-config cairo --cflags --libs`
//
// How to test: ./tutprog_hello
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

implement
main0 () = () where {
//
// create a surface for drawing
//
val sf = // create a surface for drawing
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, 250, 80)
//
val cr = cairo_create (sf) // create a context for drawing
//
val () = cairo_select_font_face
  (cr, "Sans", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
val () = cairo_set_font_size (cr, 32.0)
//
// the call [cairo_set_source_rgb] sets the color to blue
//
val () =
  cairo_set_source_rgb (cr, 0.0(*r*), 0.0(*g*), 1.0(*b*))
val () = cairo_move_to (cr, 10.0, 50.0)
val () = cairo_show_text (cr, "Hello, world!")
//
val status =
  cairo_surface_write_to_png (sf, "tutprog_hello.png")
val () = cairo_destroy (cr) // a type error if omitted
val () = cairo_surface_destroy (sf) // a type error if omitted
//
// in case of a failure ...
//
val () = assertloc (status = CAIRO_STATUS_SUCCESS)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [tutprog_hello.dats] *)
