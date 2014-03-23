(*
**
** A simple digital GTK/CAIRO-timer
**
*)

(* ****** ****** *)
//
// Author: HX-2014-03
//
(* ****** ****** *)

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

%{^
typedef char *charptr ;
typedef char **charptrptr ;
%} ;
abstype charptr = $extype"charptr"
abstype charptrptr = $extype"charptrptr"

(* ****** ****** *)
//
staload "{$LIBATSHWXI}/teaching/myGTK/SATS/gtkcairotimer.sats"
staload "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairotimer/gtkcairotimer_toplevel.dats"
//
staload _ = "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairotimer/ControlPanel.dats"
staload _ = "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairotimer/DrawingPanel.dats"
staload _ = "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairotimer/gtkcairotimer_main.dats"
staload _ = "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairotimer/gtkcairotimer_timer.dats"
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
val hh = fmod (hh, 24.0)
//
in
  (hh, mm, ss)
end // end of [mytime_get]

(* ****** ****** *)

fn draw_hand{l:agz}
(
  cr: !cairo_ref(l)
, bot: dbl, top: dbl, len: dbl
) : void = let
  val () = cairo_move_to (cr, 0.0, bot/2)
  val () = cairo_line_to (cr, len, top/2)
  val () = cairo_line_to (cr, len, ~top/2)
  val () = cairo_line_to (cr, 0.0, ~bot/2)
  val () = cairo_close_path (cr)
in
  cairo_fill (cr)
end // end of [draw_hand]

(* ****** ****** *)

fn draw_clock
  {l:agz}{w,h:nat}
(
  cr: !cairo_ref l
, wd: int w, ht: int h
, h: natLt 24, m: natLt 60, s: natLt 60 // hour and minute
) : void = let
//
  val wd = g0int2float_int_double(wd)
  and ht = g0int2float_int_double(ht)
  val dim = min (wd, ht)
  val rad = 0.375 * dim
//
  val xc = wd / 2 and yc = ht / 2
  val () = cairo_translate (cr, xc, yc)
//
  val h = (if h >= 12 then h - 12 else h): natLt 12
  val s_ang = s * (PI / 30) - PI2
  val m_ang = m * (PI / 30) - PI2
  val h_ang = h * (PI / 6) + m * (PI / 360) - PI2
//
  val () = cairo_arc (cr, 0.0, 0.0, rad, 0.0, 2*PI)
  val () = cairo_set_source_rgb (cr, 1.0, 1.0, 1.0)
  val () = cairo_fill (cr)
//
  val () = cairo_arc (cr, 0.0, 0.0, rad, 0.0, 2*PI)
  val () = cairo_set_source_rgb (cr, 0.0, 1.0, 0.0)
  val () = cairo_set_line_width (cr, 10.0)
  val () = cairo_stroke (cr)
//
  val rad1 = 0.90 * rad
  val () = cairo_arc (cr, ~rad1, ~rad1, rad1,  0.0, PI2)
  val () = cairo_arc (cr, ~rad1,  rad1, rad1, ~PI2,  0.)
  val () = cairo_arc (cr,  rad1,  rad1, rad1, ~PI, ~PI2)
  val () = cairo_arc (cr,  rad1, ~rad1, rad1,  PI2,  PI)
  val () = cairo_fill (cr)
//
  val h_l = 0.60 * rad
  val (pf | ()) = cairo_save (cr)
  val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
  val () = cairo_rotate (cr, h_ang)
  val () = draw_hand (cr, 7.0, 5.0, h_l)
  val () = cairo_restore (pf | cr)
  val (pf | ()) = cairo_save (cr)
  val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
  val () = cairo_rotate (cr, h_ang+PI)
  val () = draw_hand (cr, 3.0, 1.5, h_l/4)
  val () = cairo_restore (pf | cr)
//
  val m_l = 0.85 * rad
  val (pf | ()) = cairo_save (cr)
  val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
  val () = cairo_rotate (cr, m_ang)
  val () = draw_hand (cr, 5.0, 3.0, m_l)
  val () = cairo_restore (pf | cr)
  val (pf | ()) = cairo_save (cr)
  val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
  val () = cairo_rotate (cr, m_ang+PI)
  val () = draw_hand (cr, 2.0, 1.0, h_l/4)
  val () = cairo_restore (pf | cr)
//
  val s_l = 0.85 * rad
  val (pf | ()) = cairo_save (cr)
  val () = cairo_set_source_rgb (cr, 1.0, 0.0, 0.0)
  val () = cairo_rotate (cr, s_ang)
  val () = draw_hand (cr, 4.0, 2.0, m_l)
  val () = cairo_restore (pf | cr)
  val (pf | ()) = cairo_save (cr)
  val () = cairo_set_source_rgb (cr, 1.0, 0.0, 0.0)
  val () = cairo_rotate (cr, s_ang+PI)
  val () = draw_hand (cr, 1.0, 0.5, h_l/4)
  val () = cairo_restore (pf | cr)
//
  val (pf | ()) = cairo_save (cr)
  val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
  val () = cairo_new_sub_path (cr)
  val () = cairo_arc (cr, 0.0, 0.0, 2.5, 0.0, 2 * PI)  
  val () = cairo_fill (cr)
  val () = cairo_restore (pf | cr)
in
  // nothing
end // end of [draw_clock]

(* ****** ****** *)

extern
fun mydraw_clock
  (cr: !cairo_ref1, width: int, height: int): void
// end of [mydraw_clock]

implement
mydraw_clock
  (cr, wd, ht) = let
//
val wd = ckastloc_gintGte (wd, 0)
val ht = ckastloc_gintGte (ht, 0)
//
val (hh, mm, ss) = mytime_get ()
val hh = g0float2int_double_int(hh)
val mm = g0float2int_double_int(mm)
val ss = g0float2int_double_int(ss)
//
val hh = ckastloc_gintBtw (hh, 0, 24)
val mm = ckastloc_gintBtw (mm, 0, 60)
val ss = ckastloc_gintBtw (ss, 0, 60)
//
in
  draw_clock (cr, wd, ht, hh, mm, ss)
end // end of [mydraw_clock]

(* ****** ****** *)

dynload "./gtkcairotimer_toplevel.dats"

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

(* end of [mytimer0.dats] *)
