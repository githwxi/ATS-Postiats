(*
**
** A simple CAIRO example: regular polygon
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
   atscc -o test03 `pkg-config --cflags --libs cairo` test03.dats
** how to test the generated executable: ./test03
** please use 'gthumb' or 'eog' to view the generated image file 'test03.png'
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

extern val M_PI: double = "mac#M_PI"
extern fun sin : double -> double = "mac#sin"
extern fun cos : double -> double = "mac#cos"

(* ****** ****** *)

typedef dbl = double

(* ****** ****** *)

fun draw_reg_polygon
  {n:nat | n >= 3}
  (xr: !xr1, n: int n): void = let
//
fun loop
  {i:nat | i <= n} .<n-i>.
(
  xr: !xr1
, n: int n, da: dbl, angl0: dbl, i: int i
) : void = let
in
//
if i < n then let
  val angl1 = angl0 + da
  val () = cairo_line_to (xr, cos angl1, sin angl1)
in
  loop (xr, n, da, angl1, i + 1)
end else let
  val () = cairo_close_path (xr)
in
  // nothing
end // end of [if]
//
end // end of [loop]
//
val da = 2.0 * M_PI / n
val () = cairo_move_to (xr, 1.0, 0.0)
val () = loop (xr, n, da, 0.0, 1)
//
in
  // nothing
end // end of [draw_reg_polygon]

(* ****** ****** *)

macdef ALPHA = 7/8.0

(* ****** ****** *)

implement
main0 () = {
//
val NSIDE = 5
//
val W = 250 and H = 250
//
val sf =
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, W, H)
val xr = cairo_create (sf)
//
val W = 1.0*W and H = 1.0*H
//
val W2 = W/2 and H2 = H/2
val () = cairo_translate (xr, W2, H2)
val () = cairo_rotate (xr, ~(M_PI) / 2)
//
val ax = ALPHA*H2 and ay = ALPHA*W2 // switching due to rotation
//
val (pf | ()) = cairo_save (xr)
val () = cairo_scale (xr, ax, ay)
val () = draw_reg_polygon (xr, NSIDE)
val () = cairo_restore (pf | xr)
val () = cairo_fill (xr)
//
val (pf | ()) = cairo_save (xr)
val () = cairo_scale (xr, ax, ay)
val () = draw_reg_polygon (xr, 64*NSIDE)
val () = cairo_restore (pf | xr)
val () = cairo_stroke (xr)
//
val status = cairo_surface_write_to_png (sf, "test03.png")
//
val () = cairo_destroy (xr)
val () = cairo_surface_destroy (sf)
//
val () =
(
  if status = CAIRO_STATUS_SUCCESS then (
  println! "The image is written to the file [test03.png]."
) else (
  println! "exit(ATS): [cairo_surface_write_to_png] failed";
) // end of [if]
) : void // end of [val]
//
} // end of [main0]

(* ****** ****** *)

(* end of [test03.dats] *)
