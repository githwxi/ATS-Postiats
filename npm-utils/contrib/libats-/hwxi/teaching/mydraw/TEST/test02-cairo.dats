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

#include "./test02.dats"

(* ****** ****** *)

implement
main0 () = () where
{
//
val M = 8 and N = 8
val W = 400 and H = 400
//
// create a sf for drawing
//
val sf =
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, W, H)
val cr = cairo_create (sf)
val p_cr = cairo_ref2ptr (cr)
//
val WH = min (W, H)
val WH = g0int2float_int_double (WH)
//
val p0 = point_make (0.0, 0.0)
//
val (pf0 | ()) = cairo_save (cr)
//
val () = cairo_scale (cr, 1.0*W/N, 1.0*H/M)
//
implement
mydraw_get0_cairo<> () = let
extern
castfn __cast {l:addr} (ptr (l)): vttakeout (void, cairo_ref(l))
in
  __cast (p_cr)
end // end of [mydraw_get0_cairo]
//
val clr1 = color_make (1.0, 1.0, 1.0)
val clr2 = color_make (0.0, 0.0, 0.0)
//
val () = draw_mrow (p0, clr1, clr2, M, N)
//
val () = cairo_restore (pf0 | cr)
//
val status =
  cairo_surface_write_to_png (sf, "test02.png")
val () = cairo_surface_destroy (sf) // a type error if omitted
val () = cairo_destroy (cr) // a type error if omitted
//
// in case of a failure ...
//
val () = assertloc (status = CAIRO_STATUS_SUCCESS)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)
