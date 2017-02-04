(*
**
** A simple CAIRO example involving PS surface
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
  atscc -o test10 `pkg-config --cflags --libs cairo` cairo-multable.dats
** How to test: ./caior-multable
** The generated postscript file [cairo-multable.ps] can be viewed with 'gv'
*)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload INT = "prelude/DATS/integer.dats"
staload FLOAT = "prelude/DATS/float.dats"

(* ****** ****** *)

staload "./../SATS/cairo.sats"

(* ****** ****** *)

%{^
#include <math.h>
%} // end of [%{]

(* ****** ****** *)

stadef dbl = double
macdef PI = $extval (dbl, "M_PI")

(* ****** ****** *)

fun draw_cross
(
  xr: !xr1
, x: double, y: double, sz: double
) : void = let
  val (pf | ()) = cairo_save (xr)
  val () = cairo_translate (xr, x, y)
  val sz2 = sz / 2
  val () = cairo_set_line_width (xr, sz/5)
  val () = cairo_move_to (xr, ~sz2, ~sz2)
  val () = cairo_line_to (xr,  sz2,  sz2)
  val () = cairo_stroke (xr)
  val () = cairo_move_to (xr,  sz2, ~sz2)
  val () = cairo_line_to (xr, ~sz2,  sz2)
  val () = cairo_stroke (xr)
  val () = cairo_restore (pf | xr)
in
  // nothing
end // end of [draw_cross]

(* ****** ****** *)

extern
fun draw_nrowsep
(
  xr: !xr1, n: intGte(1), xlen: dbl, ylen: dbl
) : void
implement
draw_nrowsep
  (xr, n, xlen, ylen) = let
//
fun loop
(
  xr: !xr1
, xlen: dbl, yd: dbl, i: int, y0: dbl
) : void = let
in
//
if i >= 0 then let
  val () = cairo_move_to (xr, 0.0, y0)
  val () = cairo_line_to (xr, xlen, y0)
  val () = cairo_stroke (xr)
in
  if i > 0 then loop (xr, xlen, yd, i-1, y0 + yd)
end else () // end of [if]
//
end // end of [loop]
//
in
  loop (xr, xlen, ylen / n, n, 0.0)
end // end of [draw_nrowsep]

(* ****** ****** *)

extern
fun draw_ncolsep
(
  xr: !xr1, n: intGte(1), xlen: dbl, ylen: dbl
) : void
implement
draw_ncolsep
  (xr, n, xlen, ylen) = let
//
fun loop
(
  xr: !xr1
, xd: dbl, ylen: dbl, i: int, x0: dbl
) : void = let
in
//
if i >= 0 then let
  val () = cairo_move_to (xr, x0, 0.0)
  val () = cairo_line_to (xr, x0, ylen)
  val () = cairo_stroke (xr)
in
  if i > 0 then loop (xr, xd, ylen, i-1, x0 + xd)
end else () // end of [if]
//
end // end of [loop]
//
in
  loop (xr, xlen / n, ylen, n, 0.0)
end // end of [draw_ncolsep]

(* ****** ****** *)

extern
fun draw_table
(
  xr: !xr1
, n: intGte(1), width: double, fntsz: double
) : void // end of [draw_table]

implement
draw_table
  (xr, n, width, fntsz) = let
//
val xd = width / n
val () =
  draw_cross (xr, 0.50*xd, 1.00*fntsz, fntsz)
//
val () = draw_nrowsep (xr, n, width, 2.00 * n * fntsz)
val () = draw_ncolsep (xr, n, width, 2.00 * n * fntsz)
//
in
end // end of [draw_table]

(* ****** ****** *)
//
// letter: 8.5 x 11 (inches)
//
val x_letter = 8.5 * 72 and y_letter = 11.0 * 72
//
(* ****** ****** *)

implement
main0 () = {
//
val wsf = 512 and hsf = 768
(*
val sf =
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, wsf, hsf)
// end of [val]
*)
val wsf = 1.0*wsf and hsf = 1.0*hsf
//
val sf = cairo_ps_surface_create ("cairo-multable.ps", x_letter, y_letter)
val () = cairo_ps_surface_dsc_comment (sf, "%%Title: Zoe's Multiplication Table")
val () = cairo_ps_surface_dsc_comment (sf, "%%Copyright: Copyright (C) Hongwei Xi")
val () = cairo_ps_surface_dsc_begin_setup (sf)
val () = cairo_ps_surface_dsc_comment (sf, "%%IncludeFeatures: *MediaColor: White")
val () = cairo_ps_surface_dsc_begin_page_setup (sf)
val () = cairo_ps_surface_dsc_comment (sf, "%%IncludeFeatures: *PageSize Letter")
//
val cr = cairo_create (sf)
//
val () = cairo_translate (cr, (x_letter-wsf)/2, 72.0)
//
val image = cairo_image_surface_create_from_png ("DATA/zoe-2006-05-27-1.png")
//
val wimg = cairo_image_surface_get_width (image)
val himg = cairo_image_surface_get_height (image)
//
val (pf | ()) = cairo_save (cr)
val xrat = (1.0*250/512) and yrat = (1.0*224/768)
val () = cairo_translate (cr, ~120.0/512*wsf, ~80.0/768*hsf)
val () = cairo_arc (cr, xrat*wsf, yrat*hsf, 95.0, 0.0, 2*PI);
val () = cairo_clip (cr)
val xcoef = wsf / wimg and ycoef = hsf / himg
val () = cairo_scale (cr, xcoef, ycoef)
val () = cairo_set_source_surface (cr, image, 0.0, 0.0)
val () = cairo_paint (cr)
val () = cairo_restore (pf | cr)
val () = cairo_surface_destroy (image)
//
val () =
  cairo_select_font_face (
  cr, "serif", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD
) // end of [val]
val () = cairo_set_font_size (cr, 24.0)
val () = cairo_set_source_rgb (cr, 0.0, 0.0, 1.0)
//
var texts : cairo_text_extents_t
val title = "Zoe's Multiplication Table"
val () = cairo_text_extents (cr, title, texts)
val x_title = (wsf-texts.width)/2
val () = cairo_move_to (cr, x_title, 272.0/768*hsf)
val () = cairo_show_text (cr, title)
//
val m_table = 72.0 // margin
val (pf | ()) = cairo_save (cr)
val () = cairo_translate (cr, m_table, 300.0)
val w_table = 2*(wsf/2 - m_table)
val () = draw_table (cr, 10, w_table, 14.0(*fntsz*))
val () = cairo_restore (pf | cr)
//
val () = cairo_show_page (cr)
//
val () = cairo_destroy (cr)
val () = cairo_surface_destroy (sf)
//
} // end of [main0]

(* ****** ****** *)

(* end of [cairo-mutable.dats] *)
