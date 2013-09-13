(*
**
** A simple CAIRO example: line cap styles
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: March, 2010
**
*)

(* ****** ****** *)

(*
** Ported to ATS2 by Hongwei Xi, April, 2013
*)

(* ****** ****** *)

(*
** How to compile:
   atscc -o test05-1 `pkg-config --cflags --libs cairo` test05-1.dats
** How to test: ./test05-1
** Note that 'eog' and 'gthumb' can be used to view the generated image file.
**
*)

(* ****** ****** *)

staload INT = "prelude/DATS/integer.dats"
staload FLOAT = "prelude/DATS/float.dats"

(* ****** ****** *)

staload "./../SATS/cairo.sats"

(* ****** ****** *)

implement
main () = (0) where {
//
val surface =
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, 256, 256)
val cr = cairo_create (surface)
//
var x: double = 0.0
val () = cairo_set_line_width (cr, 30.0)
//
val () = x := x + 64
val () = cairo_set_line_cap (cr, CAIRO_LINE_CAP_BUTT) // default
val () = cairo_move_to (cr, x, 50.0)
val () = cairo_line_to (cr, x, 200.0)
val () = cairo_stroke (cr)
//
val () = x := x + 64
val () = cairo_set_line_cap (cr, CAIRO_LINE_CAP_ROUND)
val () = cairo_move_to (cr, x, 50.0)
val () = cairo_line_to (cr, x, 200.0)
val () = cairo_stroke (cr)
//
val () = x := x + 64
val () = cairo_set_line_cap (cr, CAIRO_LINE_CAP_SQUARE)
val () = cairo_move_to (cr, x, 50.0)
val () = cairo_line_to (cr, x, 200.0)
val () = cairo_stroke (cr)
//
// drawing help lines
//
val () = x := 0.0
val () = cairo_set_source_rgb (cr, 1.0, 0.2, 0.2)
val () = cairo_set_line_width (cr, 2.56)
//
val () = x := x + 64
val () = cairo_set_line_cap (cr, CAIRO_LINE_CAP_BUTT) // default
val () = cairo_move_to (cr, x, 50.0)
val () = cairo_line_to (cr, x, 200.0)
val () = cairo_stroke (cr)
//
val () = x := x + 64
val () = cairo_set_line_cap (cr, CAIRO_LINE_CAP_ROUND)
val () = cairo_move_to (cr, x, 50.0)
val () = cairo_line_to (cr, x, 200.0)
val () = cairo_stroke (cr)
//
val () = x := x + 64
val () = cairo_set_line_cap (cr, CAIRO_LINE_CAP_SQUARE)
val () = cairo_move_to (cr, x, 50.0)
val () = cairo_line_to (cr, x, 200.0)
val () = cairo_stroke (cr)
//
val status = cairo_surface_write_to_png (surface, "test05-1.png")
//
val () = cairo_destroy (cr)
val () = cairo_surface_destroy (surface)
//
val () =
(
if status = CAIRO_STATUS_SUCCESS then begin
  println! ("The image is written to the file [test05-1.png].")
end else
  println! ("exit(ATS): [cairo_surface_write_to_png] failed.")
// end of [if]
) : void // end of [val]
//
} // end of [main]

(* ****** ****** *)

(* end of [test05-1.dats] *)
