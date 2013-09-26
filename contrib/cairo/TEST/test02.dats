(*
**
** A simple CAIRO example: rounded rectangle
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
   atscc -o test02 `pkg-config --cflags --libs cairo` test02.dats
** how to test the generated executable: ./test02
** please use 'gthumb' or 'eog' to view the generated image file 'test02.png'
*)

(* ****** ****** *)

staload
_ = "prelude/DATS/float.dats"

(* ****** ****** *)

staload "./../SATS/cairo.sats"

(* ****** ****** *)

stadef dbl = double

(* ****** ****** *)

fun draw_rounded_rectangle .<>.
(
  xr: !xr1, x: dbl, y: dbl, w: dbl, h:dbl, r: dbl
) : void = let
  val () = cairo_move_to (xr, x+r, y)
  val () = cairo_line_to (xr, x+w-r, y)
  val () = cairo_curve_to (xr, x+w, y, x+w, y, x+w, y+r)
  val () = cairo_line_to (xr, x+w, y+h-r)
  val () = cairo_curve_to (xr, x+w, y+h, x+w, y+h, x+w-r, y+h)
  val () = cairo_line_to (xr, x+r, y+h)
  val () = cairo_curve_to (xr, x, y+h, x, y+h, x, y+h-r)
  val () = cairo_line_to (xr, x, y+r)
  val () = cairo_curve_to (xr, x, y, x, y, x+r, y)
  val () = cairo_stroke (xr)
in
  // nothing
end // end of [draw_rounded_rectangle]
   
(* ****** ****** *)

implement
main () = (0) where {
//
val sf =
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, 200, 200)
val xr = cairo_create (sf)
//
val x = 50.0 and y = 50.0
val w = 100.0 and h = 100.0
val r = 10.0
//  
val () = draw_rounded_rectangle (xr, x, y, w, h, r)
//
val status = cairo_surface_write_to_png (sf, "test02.png")
val () = cairo_surface_destroy (sf)
val () = cairo_destroy (xr)
//
val () =
(
  if status = CAIRO_STATUS_SUCCESS then (
  println! "The image is written to the file [test02.png]."
) else (
  println! "exit(ATS): [cairo_surface_write_to_png] failed";
) // end of [if]
) : void // end of [val]
} // end of [main]

(* ****** ****** *)

(* end of [test02.dats] *)
