(*
**
** A simple CAIRO example: clipping
**
** Author: Hongwei Xi
** Authoremail: hwxiATcsDOTbuDOTedu
** Time: December, 2009
**
*)

(* ****** ****** *)

(*
** Ported to ATS2 by Hongwei Xi, September, 2013
*)

(* ****** ****** *)

(*
** How to compile:
   atscc -o test06 `pkg-config --cflags --libs cairo` test06.dats
** How to test: ./test06
** Note that 'gthumb' can be used to view the generated image file.
*)

(* ****** ****** *)

staload "libc/SATS/math.sats"

(* ****** ****** *)

staload "./../SATS/cairo.sats"

(* ****** ****** *)

stadef dbl = double
stadef cr = cairo_ref

(* ****** ****** *)

implement
main0 () = () where {
//
  val wd = 256 and ht = 256
  val surface =
    cairo_image_surface_create (CAIRO_FORMAT_ARGB32, wd, ht)
  val wd = g0int2float_int_double(wd) and ht = g0int2float_int_double(ht)
  val cr = cairo_create (surface)
//
  val xc = wd / 2 and yc = ht / 2
  val rad = 100.0
  val () = cairo_arc (cr, 128.0, 128.0, rad, 0.0, 2 * M_PI);
  val () = cairo_clip (cr)
  val () = cairo_new_path (cr)
  val () = cairo_rectangle (cr, 0.0, 0.0, wd, ht)
  val () = cairo_fill (cr)
  val () = cairo_set_source_rgb (cr, 0.0, 1.0, 0.0)
  val () = cairo_move_to (cr, 0.0, 0.0)
  val () = cairo_line_to (cr, wd, ht)
  val () = cairo_move_to (cr, wd, 0.0)
  val () = cairo_line_to (cr, 0.0, ht)
  val () = cairo_set_line_width (cr, 10.0)
  val () = cairo_stroke (cr)
//
  val status = cairo_surface_write_to_png (surface, "test06.png")
  val () = cairo_surface_destroy (surface)
  val () = cairo_destroy (cr)
//
  val () = if status = CAIRO_STATUS_SUCCESS then begin
    print "The image is written to the file [test06.png].\n"
  end else begin
    print "exit(ATS): [cairo_surface_write_to_png] failed"; print_newline ()
  end // end of [if]
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test06.dats] *)
