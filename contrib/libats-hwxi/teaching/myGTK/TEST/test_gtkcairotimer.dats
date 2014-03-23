(*
** Testing gtkcairotimer
*)

(* ****** ****** *)

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

%{^
typedef char **charptrptr ;
%} ;
abstype charptrptr = $extype"charptrptr"

(* ****** ****** *)
//
staload "./../SATS/gtkcairotimer.sats"
//
staload "./../DATS/gtkcairotimer/gtkcairotimer_toplevel.dats"
dynload "./../DATS/gtkcairotimer/gtkcairotimer_toplevel.dats"
//
staload CP = "./../DATS/gtkcairotimer/ControlPanel.dats"
staload DP = "./../DATS/gtkcairotimer/DrawingPanel.dats"
//
staload MAIN = "./../DATS/gtkcairotimer/gtkcairotimer_main.dats"
//
staload TIMER = "./../DATS/gtkcairotimer/gtkcairotimer_timer.dats"
//
(* ****** ****** *)
//
typedef dbl = double
//  
(* ****** ****** *)
//
staload "libc/SATS/math.sats"
staload _(*anon*) = "libc/DATS/math.dats"
//
macdef PI = M_PI
macdef PI2 = PI/2
macdef _2PI = 2*PI
//
(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)
  
extern
fun
mytime_get
  ((*void*)): @(dbl, dbl, dbl)
implement
mytime_get () = let
//
val n = the_timer_get_ntick ()
val ss = fmod (n, 60.0)
val mm = n / 60
val mm = fmod (mm, 60.0)
val hh = n / 3600
val hh = fmod (hh, 12.0)
//
in
  (hh*PI/6, mm*PI/30, ss*PI/30)
end // end of [mytime_get]

(* ****** ****** *)

fn draw_clock
  (cr: !cairo_ref1): void = () where {
//
  val (hs, ms, ss) = mytime_get ()
//
  val () = cairo_set_source_rgba (cr, 1.0, 1.0, 1.0, 1.0)
  val () = cairo_paint (cr)
  val () = cairo_set_line_cap (cr, CAIRO_LINE_CAP_ROUND)
  val () = cairo_set_line_width (cr, 0.1)
//
  // draw a black clock outline
  val () = cairo_set_source_rgba (cr, 0.0, 0.0, 0.0, 1.0)
  val () = cairo_translate (cr, 0.5, 0.5)
  val () = cairo_arc (cr, 0.0, 0.0, 0.4, 0.0, _2PI)
  val () = cairo_stroke (cr)
//
  // draw a white dot on the current second
  val () = cairo_set_source_rgba (cr, 1.0, 1.0, 1.0, 0.6)
  val () = cairo_arc (cr, 0.4 * sin(ss), 0.4 * ~cos(ss), 0.05, 0.0, _2PI)
  val () = cairo_fill (cr)
//
  // draw the minutes indicator
  val () = cairo_set_source_rgba (cr, 0.2, 0.2, 1.0, 0.6)
  val () = cairo_move_to (cr, 0.0, 0.0)
  val () = cairo_line_to (cr, 0.4 * sin(ms), 0.4 * ~cos(ms))
  val () = cairo_stroke(cr)
//
  // draw the hours indicator
  val () = cairo_set_source_rgba (cr, 1.0, 0.2, 0.2, 0.6)
  val () = cairo_move_to (cr, 0.0, 0.0)
  val () = cairo_line_to (cr, 0.2 * sin(hs), 0.2 * ~cos(hs))
  val () = cairo_stroke (cr)
//
} // end of [draw_clock]

(* ****** ****** *)

extern
fun mydraw_clock
  (cr: !cairo_ref1, width: int, height: int): void
// end of [mydraw_clock]

(* ****** ****** *)

implement
mydraw_clock
(
  cr, width, height
) = () where {
  val w = g0int2float_int_double(width)
  val h = g0int2float_int_double(height)
  val mn = min (w, h)
  val xc = w / 2 and yc = h / 2
  val (pf0 | ()) = cairo_save (cr)
  val () = cairo_scale (cr, w, h)
  val () = draw_clock (cr)
  val () = cairo_restore (pf0 | cr)
} (* end of [mydraw_clock] *)

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
var argc: int = argc
var argv
  : charptrptr = $UN.castvwtp1{charptrptr}(argv)
//
val () = $extfcall (void, "gtk_init", addr@(argc), addr@(argv))
//
implement
gtkcairotimer_title<> () = stropt_some"gtkcairotimer"
implement
gtkcairotimer_timeout_interval<> () = 50U // millisecs
//
implement
gtkcairotimer_mydraw<> (cr, width, height) = mydraw_clock (cr, width, height)
//
val ((*void*)) = gtkcairotimer_main ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test_gtkcairotimer.dats] *)
