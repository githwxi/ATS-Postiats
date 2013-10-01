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
staload "{$CAIRO}/SATS/cairo.sats"
//
(* ****** ****** *)
//
staload "./../SATS/mydraw.sats"
staload "./../SATS/mydraw_cairo.sats"
staload _(*anon*) = "./../DATS/mydraw.dats"
staload _(*anon*) = "./../DATS/mydraw_cairo.dats"
//
(* ****** ****** *)

extern
fun{} draw_row
(
  pul: point, c1: color, c2: color, n: intGte(0)
) : void // end of [draw_row]

(* ****** ****** *)

implement{
} draw_row
  (pul, c1, c2, n) = let
//
fun loop
(
  pul: point
, c1: color, c2: color
, n: intGte(0)
) : void =
  if n > 0 then let
    val (
    ) = mydraw_rectangle (pul, 1.0, 1.0)
    val () = mydraw_set_source_color (c1)
    val () = mydraw_fill ()
  in
    loop (point_hshift (pul, 1.0), c2, c1, pred(n))
  end else () // end of [if]
//
in
  loop (pul, c1, c2, n)
end // end of [draw_row]

(* ****** ****** *)

extern
fun{} draw_mrow
(
  pul: point, c1: color, c2: color, m: intGte(0), n: intGte(0)
) : void // end of [draw_mrow]

(* ****** ****** *)

implement{
} draw_mrow
  (pul, c1, c2, m, n) = let
in
//
if m > 0 then let
  val () = draw_row (pul, c1, c2, n)
in
  draw_mrow (point_vshift (pul, 1.0), c2, c1, pred(m), n)
end else () // end of [if]
//
end // end of [draw_mrow]

(* ****** ****** *)

implement
main0 () = () where {
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
val WH2 = WH / 2
//
val p0 =
point_make ((W-WH)/2, (W-WH)/2)
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
val c1 = color_make (1.0, 1.0, 1.0)
val c2 = color_make (0.0, 0.0, 0.0)
//
val () = draw_mrow (p0, c1, c2, M, N)
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
