//
// Author: Hongwei Xi
// Time: April 29, 2010
//
(* ****** ****** *)

(*
** Ported to ATS2 by Hongwei Xi, September, 2013
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "{$CAIRO}/SATS/cairo.sats"
//
(* ****** ****** *)

implement
main0 () = () where
{
val W = 300 and H = 300
val sf = cairo_image_surface_create (CAIRO_FORMAT_ARGB32, W, H)
val cr = cairo_create (sf)
macdef c0set () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
macdef c1set () = cairo_set_source_rgb (cr, 0.25, 0.25, 0.25)
//
val () = cairo_set_line_width (cr, 30.0)
//
val () = c0set ()
val () = cairo_move_to (cr, 75.0, 50.0)
val () = cairo_rel_line_to (cr, 0.0, 200.0)
val () = cairo_set_line_cap (cr, CAIRO_LINE_CAP_BUTT)
val () = cairo_stroke (cr)
//
val () = c1set ()
val () = cairo_move_to (cr, 150.0, 50.0)
val () = cairo_rel_line_to (cr, 0.0, 200.0)
val () = cairo_set_line_cap (cr, CAIRO_LINE_CAP_ROUND)
val () = cairo_stroke (cr)
val () = c0set ()
val () = cairo_move_to (cr, 150.0, 50.0)
val () = cairo_rel_line_to (cr, 0.0, 200.0)
val () = cairo_set_line_cap (cr, CAIRO_LINE_CAP_BUTT)
val () = cairo_stroke (cr)
//
val () = c1set ()
val () = cairo_move_to (cr, 225.0, 50.0)
val () = cairo_rel_line_to (cr, 0.0, 200.0)
val () = cairo_set_line_cap (cr, CAIRO_LINE_CAP_SQUARE)
val () = cairo_stroke (cr)
val () = c0set ()
val () = cairo_move_to (cr, 225.0, 50.0)
val () = cairo_rel_line_to (cr, 0.0, 200.0)
val () = cairo_set_line_cap (cr, CAIRO_LINE_CAP_BUTT)
val () = cairo_stroke (cr)
//
val status =
  cairo_surface_write_to_png (sf, "tutprog_linecap.png")
val () = cairo_surface_destroy (sf); val () = cairo_destroy (cr)
//
val () =
if status = CAIRO_STATUS_SUCCESS then begin
  print "The image is written to the file [tutprog_linecap.png].\n"
end else begin
  print "exit(ATS): [cairo_surface_write_to_png] failed"; print_newline ()
end // end of [if]
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [tutprog_linecap.dats] *)
