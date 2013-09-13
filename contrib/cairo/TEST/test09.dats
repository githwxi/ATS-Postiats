(*
**
** A simple CAIRO example: filling rules
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: March, 2010
**
*)

(* ****** ****** *)

(*
** Ported to ATS2 by Hongwei Xi, September, 2013
*)

(* ****** ****** *)

(*
** How to compile:
   atscc -o test09 `pkg-config --cflags --libs cairo` test09.dats
** How to test: ./test09
** 'gthumb' can be used to view the generated image file 'test09.png'
*)

(* ****** ****** *)

macdef PI = 3.14159265359

(* ****** ****** *)

staload INT = "prelude/DATS/integer.dats"
staload FLOAT = "prelude/DATS/float.dats"

(* ****** ****** *)

staload "./../SATS/cairo.sats"

(* ****** ****** *)

implement
main0 () = () where {
  val surface =
    cairo_image_surface_create (CAIRO_FORMAT_ARGB32, 256, 256)
  val cr = cairo_create (surface)
//
  val () = cairo_set_line_width (cr, 6.0)
  val () = cairo_rectangle (cr, 12.0, 12.0, 232.0, 70.0)
  val () = cairo_move_to (cr, 104.0, 64.0)
  val () = cairo_arc (cr, 64.0, 64.0, 40.0, 0.0, 2*PI)
  val () = cairo_move_to (cr, 232.0, 64.0)
  val () = cairo_arc_negative (cr, 192.0, 64.0, 40.0, 0.0, ~2*PI)
//
  val () = cairo_set_fill_rule (cr, CAIRO_FILL_RULE_EVEN_ODD)
  val () = cairo_set_source_rgb (cr, 0.0, 0.7, 0.0)
  val () = cairo_fill_preserve (cr)
  val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
  val () = cairo_stroke (cr)
//
  val () = cairo_translate (cr, 0.0, 128.0)
  val () = cairo_rectangle (cr, 12.0, 12.0, 232.0, 70.0)
  val () = cairo_move_to (cr, 104.0, 64.0)
  val () = cairo_arc (cr, 64.0, 64.0, 40.0, 0.0, 2*PI)
  val () = cairo_move_to (cr, 232.0, 64.0)
  val () = cairo_arc_negative (cr, 192.0, 64.0, 40.0, 0.0, ~2*PI)
//
  val () = cairo_set_fill_rule (cr, CAIRO_FILL_RULE_WINDING)
  val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.9)
  val () = cairo_fill_preserve (cr)
  val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
  val () = cairo_stroke (cr)
//
  val status = cairo_surface_write_to_png (surface, "test09.png")
  val () = cairo_surface_destroy (surface)
  val () = cairo_destroy (cr)
//
  val () = if status = CAIRO_STATUS_SUCCESS then begin
    print "The image is written to the file [test09.png].\n"
  end else begin
    print "exit(ATS): [cairo_surface_write_to_png] failed"; print_newline ()
  end // end of [if]
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test09.dats] *)
