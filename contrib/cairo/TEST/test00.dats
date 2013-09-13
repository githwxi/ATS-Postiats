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
   atscc -o test00 `pkg-config --cflags --libs cairo` test00.dats
** How to test the generated executable: ./test00
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
