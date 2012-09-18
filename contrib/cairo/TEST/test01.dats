(*
**
** A simple CAIRO example: Hello, world!
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: December, 2009
**
*)

(*
HX: how to compile:

atscc -o test1 \
  `pkg-config --cflags --libs cairo` $ATSHOME/contrib/cairo/atsctrb_cairo.o \
  test01.dats

HX: how ot test the generated executable:

./test1

HX: please use 'gthumb' or 'eof' to view the generated image file 'test01.png'
*)

(* ****** ****** *)

staload "cairo/SATS/cairo.sats"

(* ****** ****** *)

implement
main () = 0 where {
//
val () = println! ("CAIRO_VERSION_MAJOR = ", CAIRO_VERSION_MAJOR)
val () = println! ("CAIRO_VERSION_MINOR = ", CAIRO_VERSION_MINOR)
val () = println! ("CAIRO_VERSION_MICRO = ", CAIRO_VERSION_MICRO)
val CAIRO_VERSION =
  CAIRO_VERSION_ENCODE (CAIRO_VERSION_MAJOR, CAIRO_VERSION_MINOR, CAIRO_VERSION_MICRO)
val () = println! ("CAIRO_VERSION = ", CAIRO_VERSION)
//
val () = println! ("cairo:version:number = ", cairo_version())
val () = println! ("cairo:version:string = ", cairo_version_string())
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
  if status = CAIRO_STATUS_SUCCESS then (
  print "The image is written to the file [test01.png].\n"
) else (
  print "exit(ATS): [cairo_surface_write_to_png] failed"; print_newline ()
) // end of [if]
//
} // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)
