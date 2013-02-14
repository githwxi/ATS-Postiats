(*
**
** A simple CAIRO example: Koch fractal curve
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: December, 2009
**
*)

(*
HX: how to compile:
atscc -o test04 \
  `pkg-config --cflags --libs cairo` $ATSHOME/contrib/cairo/atscntrb_cairo.o \
  test04.dats

HX: how to test the generated executable:

./test04

HX: please use 'gthumb' or 'eog' to view the generated image file 'test04.png'
*)

(* ****** ****** *)

staload "cairo/SATS/cairo.sats"

(* ****** ****** *)

extern val M_PI: double
extern fun sin : double -> double
extern fun cos : double -> double

(* ****** ****** *)

stadef dbl = double

(* ****** ****** *)

val PI3 = M_PI / 3
val sin60 = sin (PI3)

fn koch0 {l:agz}
  (xr: !xr l, x: dbl): void = let
  val () = cairo_move_to (xr, 0.0, 0.0)
  val () = cairo_line_to (xr, x / 3, 0.0)
  val () = cairo_line_to (xr, x / 2, ~x / 3 * sin60)
  val () = cairo_line_to (xr, 2 * x / 3, 0.0)
  val () = cairo_line_to (xr, x, 0.0)
in
  // nothing
end // end of [koch0]

fun koch {l:agz} {n:nat} .<n>.
  (xr: !xr l, n: int n, x: dbl): void =
  if n > 0 then let
    val () = koch (xr, n-1, x / 3)
//
    val (pf | ()) = cairo_save (xr)
    val () = cairo_translate (xr, x / 3, 0.0)
    val () = cairo_rotate (xr, ~PI3)
    val () = koch (xr, n-1, x / 3)
    val () = cairo_restore (pf | xr)
//
    val (pf | ()) = cairo_save (xr)
    val () = cairo_translate (xr, x / 2, ~x / 3 * sin60)
    val () = cairo_rotate (xr, PI3)
    val () = koch (xr, n-1, x / 3)
    val () = cairo_restore (pf | xr)
//
    val (pf | ()) = cairo_save (xr)
    val () = cairo_translate (xr, 2 * x / 3, 0.0)
    val () = koch (xr, n-1, x / 3)
    val () = cairo_restore (pf | xr)
  in
    // nothing
  end else //
    koch0 (xr, x)
  // end of [if]
// end of [koch]

(* ****** ****** *)

implement
main () = (0) where {
  val sf =
    cairo_image_surface_create (CAIRO_FORMAT_ARGB32, 300, 300)
  val xr = cairo_create (sf)
  val x0 = 50.0 and y0 = 100.0
//
  val (pf | ()) = cairo_save (xr)
  val () = cairo_translate (xr, x0, y0)
  val () = koch (xr, 3, 200.0)
  val () = cairo_restore (pf | xr)
  val () = cairo_stroke (xr)
//
  val (pf | ()) = cairo_save (xr)
  val () = cairo_translate (xr, x0+200.0, y0)
  val () = cairo_rotate (xr, 2 * PI3)
  val () = koch (xr, 3, 200.0)
  val () = cairo_restore (pf | xr)
  val () = cairo_stroke (xr)
//
  val (pf | ()) = cairo_save (xr)
  val () = cairo_translate (xr, x0+100.0, y0+200*sin60)
  val () = cairo_rotate (xr, ~2 * PI3)
  val () = koch (xr, 3, 200.0)
  val () = cairo_restore (pf | xr)
  val () = cairo_stroke (xr)
//
  val status =
    cairo_surface_write_to_png (sf, "test04.png")
  val () = cairo_surface_destroy (sf)
  val () = cairo_destroy (xr)
//
val () = if status = CAIRO_STATUS_SUCCESS then (
  println! ("The image is written to the file [test04.png].")
) else (
  println! ("exit(ATS): [cairo_surface_write_to_png] failed")
) // end of [if]
} // end of [main]

(* ****** ****** *)

(* end of [test04.dats] *)
