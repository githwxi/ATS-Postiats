(*
**
** A simple CAIRO example: Hello, world!
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: December, 2009
**
*)

(* ****** ****** *)

(*
** Ported to ATS2 by Hongwei Xi, April, 2013
*)

(* ****** ****** *)

(*
** How to compile:
   atscc -o test01 `pkg-config --cflags --libs cairo` test01.dats
** How to test the generated executable: ./test01
** please use 'gthumb' or 'eog' to view the generated image file 'test01.png'
*)

(* ****** ****** *)

staload "./../SATS/cairo.sats"

(* ****** ****** *)

implement
main () = 0 where {
//
val surface =
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, 250, 80)
val cr = cairo_create (surface)
//
(*
val () = cairo_select_font_face
  (cr, "serif", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)
*)
val () = cairo_select_font_face
  (cr, "Sans", CAIRO_FONT_SLANT_ITALIC, CAIRO_FONT_WEIGHT_BOLD)
//
val () = cairo_set_font_size (cr, 32.0)
val () = cairo_set_source_rgb (cr, 0.0, 0.0, 1.0)
val () = cairo_move_to (cr, 10.0, 50.0)
//
val () = cairo_show_text (cr, "Hello, world!")
//
val status = cairo_surface_write_to_png (surface, "test01.png")
val () = cairo_destroy (cr)
val () = cairo_surface_destroy (surface)
//
val () =
(
if status = CAIRO_STATUS_SUCCESS then (
  println! "The image is written to the file [test01.png]."
) else (
  println! "exit(ATS): [cairo_surface_write_to_png] failed"
) // end of [if]
) : void // end of [val]
//
} // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)
