(*
**
** A simple CAIRO example: Koch fractal curve
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
** how to compile:
   atscc -o test04 `pkg-config --cflags --libs cairo` test04.dats
** how to test the generated executable: ./test04
** please use 'gthumb' or 'eog' to view the generated image file 'test04.png'
*)

(* ****** ****** *)

%{^
#include <math.h>
%} // end of [%{]

(* ****** ****** *)

staload INT = "prelude/DATS/integer.dats"
staload FLOAT = "prelude/DATS/float.dats"

(* ****** ****** *)

staload "./../SATS/cairo.sats"

(* ****** ****** *)

extern val M_PI: double = "mac#"
extern fun sin : double -> double = "mac#"
extern fun cos : double -> double = "mac#"

(* ****** ****** *)

stadef dbl = double

(* ****** ****** *)

val PI3 = M_PI / 3
val sin60 = sin (PI3)

fn koch_nr (
  xr: !xr1, x: dbl
) : void = let
  val () = cairo_move_to (xr, 0.0, 0.0)
  val () = cairo_line_to (xr, x / 3, 0.0)
  val () = cairo_line_to (xr, x / 2, ~x / 3 * sin60)
  val () = cairo_line_to (xr, 2 * x / 3, 0.0)
  val () = cairo_line_to (xr, x, 0.0)
in
  // nothing
end // end of [koch_nr]

(* ****** ****** *)

fun koch_rec
  {n:nat} .<n>. (
  xr: !xr1, n: int n, x: dbl
) : void = let
in
//
if n > 0 then let
  val () = koch_rec (xr, n-1, x / 3)
//
  val (pf | ()) = cairo_save (xr)
  val () = cairo_translate (xr, x / 3, 0.0)
  val () = cairo_rotate (xr, ~PI3)
  val () = koch_rec (xr, n-1, x / 3)
  val () = cairo_restore (pf | xr)
//
  val (pf | ()) = cairo_save (xr)
  val () = cairo_translate (xr, x / 2, ~x / 3 * sin60)
  val () = cairo_rotate (xr, PI3)
  val () = koch_rec (xr, n-1, x / 3)
  val () = cairo_restore (pf | xr)
//
  val (pf | ()) = cairo_save (xr)
  val () = cairo_translate (xr, 2 * x / 3, 0.0)
  val () = koch_rec (xr, n-1, x / 3)
  val () = cairo_restore (pf | xr)
in
  // nothing
end else //
  koch_nr (xr, x)
// end of [if]
end // end of [koch_rec]

(* ****** ****** *)

implement
main0 () = {
//
val UT = 100
//
val sf =
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, 3*UT, 3*UT)
val xr = cairo_create (sf)
//
val UT = 1.0*UT
val x0 = UT/2 and y0 = UT
//
val (pf | ()) = cairo_save (xr)
val () = cairo_translate (xr, x0, y0)
val () = koch_rec (xr, 3, 2*UT)
val () = cairo_restore (pf | xr)
val () = cairo_stroke (xr)
//
val (pf | ()) = cairo_save (xr)
val () = cairo_translate (xr, x0+2*UT, y0)
val () = cairo_rotate (xr, 2 * PI3)
val () = koch_rec (xr, 3, 2*UT)
val () = cairo_restore (pf | xr)
val () = cairo_stroke (xr)
//
val (pf | ()) = cairo_save (xr)
val () = cairo_translate (xr, x0+UT, y0+2*UT*sin60)
val () = cairo_rotate (xr, ~2 * PI3)
val () = koch_rec (xr, 3, 2*UT)
val () = cairo_restore (pf | xr)
val () = cairo_stroke (xr)
//
val status =
  cairo_surface_write_to_png (sf, "test04.png")
//
val () = cairo_destroy (xr)
val () = cairo_surface_destroy (sf)
//
val () =
(
if status = CAIRO_STATUS_SUCCESS then (
  println! ("The image is written to the file [test04.png].")
) else (
  println! ("exit(ATS): [cairo_surface_write_to_png] failed")
) // end of [if]
) : void // end of [val]
} // end of [main]

(* ****** ****** *)

(* end of [test04.dats] *)
