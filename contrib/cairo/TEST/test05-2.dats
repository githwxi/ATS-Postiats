(*
**
** A simple CAIRO example: joint styles
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
   atscc -o test05-2 `pkg-config --cflags --libs cairo` test05-2.dats
** How to test:
   ./test05-2
   'gthumb' can be used to view the generated image file 'test05-2.png'
*)

(* ****** ****** *)

staload INT = "prelude/DATS/integer.dats"
staload FLOAT = "prelude/DATS/float.dats"

(* ****** ****** *)

macdef PI = 3.14159265359

(* ****** ****** *)

staload "./../SATS/cairo.sats"

(* ****** ****** *)

implement
main0 () = () where {
  val surface =
    cairo_image_surface_create (CAIRO_FORMAT_ARGB32, 256, 256)
  val cr = cairo_create (surface)
//
  val () = cairo_set_line_width (cr, 40.96)
//
  val () = cairo_move_to (cr, 76.8, 84.48)
  val () = cairo_rel_line_to (cr, 51.2, ~51.2)
  val () = cairo_rel_line_to (cr, 51.2,  51.2)
  val () = cairo_set_line_join (cr, CAIRO_LINE_JOIN_MITER)
  val () = cairo_stroke (cr)
//
  val () = cairo_move_to (cr, 76.8, 161.28)
  val () = cairo_rel_line_to (cr, 51.2, ~51.2)
  val () = cairo_rel_line_to (cr, 51.2,  51.2)
  val () = cairo_set_line_join (cr, CAIRO_LINE_JOIN_BEVEL)
  val () = cairo_stroke (cr)
//
  val () = cairo_move_to (cr, 76.8, 238.08)
  val () = cairo_rel_line_to (cr, 51.2, ~51.2)
  val () = cairo_rel_line_to (cr, 51.2,  51.2)
  val () = cairo_set_line_join (cr, CAIRO_LINE_JOIN_ROUND)
  val () = cairo_stroke (cr)
//
  val status = cairo_surface_write_to_png (surface, "test05-2.png")
  val () = cairo_surface_destroy (surface)
  val () = cairo_destroy (cr)
//
  val () = if status = CAIRO_STATUS_SUCCESS then begin
    print "The image is written to the file [test05-2.png].\n"
  end else begin
    print "exit(ATS): [cairo_surface_write_to_png] failed"; print_newline ()
  end // end of [if]
} // end of [main]

(* ****** ****** *)

(* end of [test05-2.dats] *)
