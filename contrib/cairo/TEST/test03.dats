(*
**
** A simple CAIRO example: regular polygon
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: December, 2009
**
*)

(*
HX: how to compile:
atscc -o test3 \
  `pkg-config --cflags --libs cairo` $ATSHOME/contrib/cairo/atscntrb_cairo.o \
  cairo-test3.dats

HX: how to test the generated executable:

./test03

HX: please use 'gthumb' or 'eog' to view the generated image file 'test03.png'
*)

(* ****** ****** *)

staload "cairo/SATS/cairo.sats"

(* ****** ****** *)

extern val M_PI: double
extern fun sin : double -> double
extern fun cos : double -> double

(* ****** ****** *)

stadef dbl = double

fun draw_reg_polygon
  {n:nat | n >= 3}
  (xr: !xr1, n: int n): void = let
  val angl_delta = 2.0 * M_PI / n
  fun loop {i:nat | i <= n} .<n-i>.
    (xr: !xr1, angl0: dbl, i: int i):<cloref1> void =
    if i < n - 1 then let
      val angl1 = angl0 + angl_delta
      val () = cairo_line_to (xr, cos angl1, sin angl1)
    in
      loop (xr, angl1, i + 1)
    end else let
      val () = cairo_line_to (xr, 1.0, 0.0)
    in
      // nothing
    end // end of [if]
  // end of [loop]
  val () = cairo_move_to (xr, 1.0, 0.0)
  val () = loop (xr, 0.0, 0)
in
  // nothing
end // end of [draw_reg_polygon]

(* ****** ****** *)

fn draw_circle (
    xr: !xr1, rad: dbl, x0: dbl, y0: dbl
  ) : void = let
  val n0 = 8
  val angl0 = 2 * M_PI / n0
  val n = loop (rad, n0, angl0) where {
    fun loop {n:int | n >= 8}
      (rad: dbl, n: int n, angl: double): intGte 8 =
      if (rad * angl > 1.0) then
        loop (rad, 2 * n, angl / 2) else n // loop exits
      // end of [if]
    // end of [loop]
  } // end of [val]
  val (pf_save | ()) = cairo_save (xr)
  val () = cairo_scale (xr, rad, rad)
  val () = draw_reg_polygon (xr, n)
  val () = cairo_restore (pf_save | xr)
in
  // nothing
end // end of [draw_circle]

(* ****** ****** *)

#define ALPHA 0.90

implement
main () = (0) where {
//
val sf =
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, 200, 200)
//
val xr = cairo_create (sf)
val x = 100.0 and y = 100.0
val () = cairo_translate (xr, x, y)
val () = cairo_rotate (xr, ~(M_PI) / 2)
val (pf_save | ()) = cairo_save (xr)
val sx = ALPHA * 100.0 and sy = ALPHA * 100.0
val () = cairo_scale (xr, sx, sy)
val () = draw_reg_polygon (xr, 5)
val () = cairo_fill (xr)
val () = cairo_restore (pf_save | xr)
val () = draw_circle (xr, ALPHA * 100.0, x, y)
val () = cairo_stroke (xr)
//
val status = cairo_surface_write_to_png (sf, "test03.png")
val () = cairo_surface_destroy (sf)
val () = cairo_destroy (xr)
//
val () =
  if status = CAIRO_STATUS_SUCCESS then (
  println! "The image is written to the file [test03.png]."
) else (
  println! "exit(ATS): [cairo_surface_write_to_png] failed";
) // end of [if]
} // end of [main]

(* ****** ****** *)

(* end of [test03.dats] *)
