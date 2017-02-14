(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: October, 2013
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
#define
LIBCAIRO_targetloc
"$PATSHOME/npm-utils\
/contrib/atscntrb-libcairo"
//
(* ****** ****** *)
//
#staload
"{$LIBCAIRO}/SATS/cairo.sats"
//
(* ****** ****** *)
//
#define MYDRAW_CAIRO
//
#include "./../mylibies.hats"
//
#staload $MYDRAW
#staload $MYDRAW_cairo
//
#include "./../DATS/mydraw.dats"
#include "./../DATS/mydraw_cairo.dats"
//
(* ****** ****** *)

#include "./test04.dats"

(* ****** ****** *)

extern
fun
cairo_draw_dragon
  {l:agz}
(
  cr: !cairo_ref (l)
, p1: point, p2: point, clr: color
, level: int
) : void // end of [cairo_draw_dragon]

implement
cairo_draw_dragon
  (cr, p1, p2, clr, n) = let
//
val p_cr = ptrcast (cr)
//
implement
mydraw_get0_cairo<> () = let
//
extern
castfn __cast {l:addr} (ptr(l)): vttakeout (void, cairo_ref(l))
//
in
  __cast (p_cr)
end // end of [mydraw_get0_cairo]
//
val () = draw_dragon (1(*sgn*), p1, p2, clr, n)
//
in
  // nothing
end // end of [cairo_draw3_dragon]

(* ****** ****** *)

implement
main0 () = () where {
//
val W = 400 and H = 400
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
val WH4 = WH / 4
//
val () =
cairo_translate (cr, WH2, WH2)
val (pf0 | ()) = cairo_save (cr)
//
val p1 = point_make (~WH4, 0.0)
val p2 = point_make ( WH4, 0.0)
//
val clr = color_make (0.0, 0.0, 1.0)
//
val () = cairo_draw_dragon (cr, p1, p2, clr, 12)
//
val () = cairo_restore (pf0 | cr)
//
val status =
  cairo_surface_write_to_png (sf, "test04.png")
val () = cairo_surface_destroy (sf) // a type error if omitted
val () = cairo_destroy (cr) // a type error if omitted
//
// in case of a failure ...
//
val () = assertloc (status = CAIRO_STATUS_SUCCESS)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test04-cairo.dats] *)
