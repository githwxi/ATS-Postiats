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

fun
draw_triangle{l:agz}
(
  cr: !cairo_ref l
, x0: double, y0: double
, x1: double, y1: double
, x2: double, y2: double
) : void = () where {
  val () = cairo_move_to (cr, x0, y0)
  val () = cairo_line_to (cr, x1, y1)
  val () = cairo_line_to (cr, x2, y2)
  val () = cairo_close_path (cr)
} (* end of [draw_triangle] *)

(* ****** ****** *)

implement
main0 () = () where {
//
val W = 300 and H = 300
val sf = cairo_image_surface_create (CAIRO_FORMAT_ARGB32, W, H)
val cr = cairo_create (sf)
//
macdef c0set () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
//
val () = cairo_set_line_width (cr, 15.0)
//
val () = c0set ()
val () = draw_triangle (cr, 50.0, 50.0, 20.0, 250.0, 80.0, 250.0)
val () = cairo_set_line_join (cr, CAIRO_LINE_JOIN_MITER)
val () = cairo_stroke (cr)
//
val () = c0set ()
val () = draw_triangle (cr, 150.0, 50.0, 120.0, 250.0, 180.0, 250.0)
val () = cairo_set_line_join (cr, CAIRO_LINE_JOIN_ROUND)
val () = cairo_stroke (cr)
//
val () = c0set ()
val () = draw_triangle (cr, 250.0, 50.0, 220.0, 250.0, 280.0, 250.0)
val () = cairo_set_line_join (cr, CAIRO_LINE_JOIN_BEVEL)
val () = cairo_stroke (cr)
//
val status =
  cairo_surface_write_to_png (sf, "tutprog_linejoin.png")
val () = cairo_surface_destroy (sf); val () = cairo_destroy (cr)
//
val () =
if status = CAIRO_STATUS_SUCCESS then begin
  print "The image is written to the file [tutprog_linejoin.png].\n"
end else begin
  print "exit(ATS): [cairo_surface_write_to_png] failed"; print_newline ()
end // end of [if]
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [tutprog_linejoin.dats] *)
