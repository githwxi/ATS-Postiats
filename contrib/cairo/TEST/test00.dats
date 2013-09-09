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
  `pkg-config --cflags --libs cairo` $ATSHOME/contrib/cairo/atscntrb_cairo.o \
  test01.dats

HX: how ot test the generated executable:

./test1

HX: please use 'gthumb' or 'eog' to view the generated image file 'test01.png'
*)

(* ****** ****** *)

staload "./../SATS/cairo.sats"

(* ****** ****** *)

implement
main0 () = () where
{
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
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test00.dats] *)
