(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: September, 2013
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
staload "./../SATS/mydraw.sats"
staload _(*anon*) = "./../DATS/mydraw.dats"
//
staload "{$CAIRO}/SATS/cairo.sats"
staload _(*anon*) = "./../DATS/mydraw_cairo.dats"
//
(* ****** ****** *)
//
extern
fun{}
draw3_solid (point, point, point, color): void
extern
fun{}
draw3_sierpinski
  (point, point, point, color, color, int(*level*)): void
//
(* ****** ****** *)

implement{
} draw3_solid
(
  p1, p2, p3, clr
) = let
//
val () = mydraw_triangle (p1, p2, p3)
val () = mydraw_set_source_color (clr)
val () = mydraw_fill ()
//
in
  // nothing
end // end of [draw3_solid]

(* ****** ****** *)

implement{
} draw3_sierpinski
(
  p1, p2, p3, clr1, clr2, n
) = let
in
//
if n > 0 then let
  val p12 = p1 + 0.5 * (p2 - p1)
  val p23 = p2 + 0.5 * (p3 - p2)
  val p31 = p3 + 0.5 * (p1 - p3)
  val () = draw3_solid (p12, p23, p31, clr2)
  val () = draw3_sierpinski (p1, p12, p31, clr1, clr2, n-1)
  val () = draw3_sierpinski (p12, p2, p23, clr1, clr2, n-1)
  val () = draw3_sierpinski (p31, p23, p3, clr1, clr2, n-1)
in
  // nothing
end else draw3_solid (p1, p2, p3, clr1) // end of [if]
//
end // end of [draw3_sierpinski]

(* ****** ****** *)

extern
fun
cairo_draw3_sierpinski
  {l:agz}
(
  cr: !cairo_ref (l)
, p1: point, p2: point, p3: point, c1: color, c2: color
, level: int
) : void // end of [cairo_draw3_sierpinski]

implement
cairo_draw3_sierpinski
  (cr, p1, p2, p3, c1, c2, n) = let
//
val p_cr = ptrcast (cr)
//
implement
mydraw_get0_cairo<> () = let
//
extern
castfn __cast {l:addr} (ptr (l)): vttakeout (void, cairo_ref(l))
//
in
  __cast (p_cr)
end // end of [mydraw_get0_cairo]
//
in
  draw3_sierpinski (p1, p2, p3, c1, c2, n)
end // end of [cairo_draw3_sierpinski]

(* ****** ****** *)

implement
main0 () = () where {
//
val W = 250 and H = 250
//
// create a sf for drawing
//
val sf =
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, W, H)
val cr = cairo_create (sf)
//
val WH = min (W, H)
val WH = g0int2float_int_double (WH)
val WH2 = WH / 2
//
val () =
cairo_translate (cr, WH2, WH2)
val (pf0 | ()) = cairo_save (cr)
//
val p1 = point_make (~WH2,  WH2)
val p2 = point_make ( 0.0, ~WH2)
val p3 = point_make ( WH2,  WH2)
val clr1 = color_make (1.0, 1.0, 0.0)
val clr2 = color_complement (clr1)
val () = cairo_draw3_sierpinski (cr, p1, p2, p3, clr1, clr2, 4)
//
val () = cairo_restore (pf0 | cr)
//
val status =
  cairo_surface_write_to_png (sf, "test01.png")
val () = cairo_surface_destroy (sf) // a type error if omitted
val () = cairo_destroy (cr) // a type error if omitted
//
// in case of a failure ...
//
val () = assertloc (status = CAIRO_STATUS_SUCCESS)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
