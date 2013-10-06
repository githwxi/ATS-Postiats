(*
**
** A simple GTK/CAIRO-clock:
** a part of the clock is submerged in water
**
*)

(* ****** ****** *)

(*
**
** Assignment 3:
** Class: BU CAS CS520, Fall, 2013
** Due: Thursday, the 26th of September, 2013
** Author: Andrew Barbarello
** Authoremail: abarbsATbuDOTedu
**
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "libc/SATS/math.sats"
//
macdef PI = M_PI and PI2 = PI/2
//
(* ****** ****** *)

staload "libc/SATS/time.sats"

(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

stadef dbl = double
stadef cr (l:addr) = cairo_ref l

(* ****** ****** *)

%{^
typedef
struct { char buf[32] ; } bytes32 ;
%} // end of [%{^]
abst@ype bytes32 = $extype"bytes32"

(* ****** ****** *)

%{^
#define mystrftime(bufp, m, fmt, ptm) strftime((char*)bufp, m, fmt, ptm)
%} // end of [%{^]

(* ****** ****** *)

extern
fun mydraw_clock
  (cr: !cairo_ref1, width: int, height: int): void = "ext#mydraw_clock"
// end of [mydraw_clock]

(* ****** ****** *)

fun
draw_hand
  {l:agz} (
  cr: !cr l, bot: dbl, top: dbl, len: dbl
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

fun
draw_number
  {l:agz} (
  cr: !cr l
, str: string
, rad: double, angle: double
) : void = () where
{
//
  val (pf | ()) = cairo_save (cr)
//
  val num_dist = 0.8 * rad
  val num_x_center =
    num_dist * cos_double(angle) and num_y_center = ~1 * num_dist * sin_double(angle)
//
// Place text origin in center
//
  var extents: cairo_text_extents_t
  val () = cairo_text_extents (cr, str, extents)
  val xc = num_x_center - (extents.width)/ 2 and yc = num_y_center - (extents.height/ 2)
  val () = cairo_move_to (cr, xc - extents.x_bearing, yc - extents.y_bearing)
  val () = cairo_show_text (cr, str)
//
  val () = cairo_restore (pf | cr)
//
} (* end of [draw_number] *)

(* ****** ****** *)

fun
draw_clock
  {l:agz} (
  cr: !cr l
, h: natLt 24, m: natLt 60, s: natLt 60 // hour and minute
) : void = let
//
// please scale it!
//
val dim = 100.0
val rad = 0.4 * dim
//
val h =
(
  if h >= 12 then h - 12 else h
) : natLt 12 // end of [val]
val s_ang = s * (PI / 30) - PI2
val m_ang = m * (PI / 30) - PI2
val h_ang = h * (PI / 6) + m * (PI / 360) - PI2
//
val () = cairo_arc
  (cr, 0.0, 0.0, rad, 0.0, 2 * PI)
val () = cairo_set_source_rgb (cr, 1.0, 1.0, 1.0)
val () = cairo_fill (cr)
//
val () = cairo_select_font_face
  (cr, "serif", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
val () = cairo_set_font_size (cr, 8.0)
//
val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
//
val () = draw_number(cr,  "1", rad,  2*PI/6)
val () = draw_number(cr,  "2", rad,  1*PI/6)
val () = draw_number(cr,  "3", rad,  0*PI/6)
val () = draw_number(cr,  "4", rad, ~1*PI/6)
val () = draw_number(cr,  "5", rad, ~2*PI/6)
val () = draw_number(cr,  "6", rad, ~3*PI/6)
val () = draw_number(cr,  "7", rad, ~4*PI/6)
val () = draw_number(cr,  "8", rad, ~5*PI/6)
val () = draw_number(cr,  "9", rad,  6*PI/6)
val () = draw_number(cr, "10", rad,  5*PI/6)
val () = draw_number(cr, "11", rad,  4*PI/6)
val () = draw_number(cr, "12", rad,  3*PI/6)
//
val h_l = 0.60 * rad
val (pf | ()) = cairo_save (cr)
val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
val () = cairo_rotate (cr, h_ang)
val () = draw_hand (cr, 3.0, 1.5, h_l)
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
val () = draw_hand (cr, 2.0, 1.0, m_l)
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
val () = draw_hand (cr, 1.0, 0.5, m_l)
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
//
in
  // nothing
end // end of [draw_clock]

(* ****** ****** *)

implement
mydraw_clock
  (cr, width, height) =
{
//
val w = g0int2float_int_double(width)
val h = g0int2float_int_double(height)
//
val mn = min (w, h)
val xc = w / 2 and yc = h / 2
//
val (pf0 | ()) = cairo_save (cr)
val () = cairo_translate (cr, xc, yc)
val alpha = mn / 100
val () = cairo_scale (cr, alpha, alpha)
//
var t: time_t
val yn = time_getset (t)
val () = assert_errmsg (yn, $mylocation)
prval () = opt_unsome{time_t}(t)
//
var tm: tm_struct // unintialized
val ptr_ = localtime_r (t, tm)
val () = assert_errmsg (ptr_ > 0, $mylocation)
prval () = opt_unsome{tm_struct}(tm)
//
val hr = tm.tm_hour
and min = tm.tm_min
and sec = tm.tm_sec
//
val hr = g1ofg0(hr)
val () = assertloc ((0 <= hr) * (hr < 24))
val min = g1ofg0(min)
val () = assertloc ((0 <= min) * (min < 60))
val sec = g1ofg0(sec)
val () = assertloc ((0 <= sec) * (sec < 60))
//
val y_offset = 0.1 * h / alpha
//
val (pf1 | ()) = cairo_save(cr)
//
// Clip to the upper portion of the clock
//
val () = cairo_rectangle(cr, ~1 * w/2, ~1 * h/2, w, h/2 + y_offset)
//
// Any region outside of the above rectangle is unaffected by draw_clock
//
val () = cairo_clip (cr)
val () = draw_clock (cr, hr, min, sec)
val () = cairo_restore (pf1 | cr)
//
val (pf1 | ()) = cairo_save(cr)
val x_skew = 0.5
// Clip to the lower portion
val () = cairo_rectangle(cr, ~1 * w/2, y_offset, w, h/2 - y_offset)
val () = cairo_clip (cr)
var cur_mat : cairo_matrix_t
val () = cairo_get_matrix(cr, cur_mat)
var skew_mat = @{
  xx= 1.0, yx= 0.0, xy= x_skew, yy= 1.0, x0= ~y_offset*x_skew, y0= 0.0
} : cairo_matrix_t
val () = cairo_matrix_multiply (skew_mat, skew_mat, cur_mat)
val () = cairo_set_matrix (cr, skew_mat)
val () = cairo_set_source_rgb (cr, 1.0, 0.0, 0.0)
val () = draw_clock (cr, hr, min, sec)
val () = cairo_restore  (pf1 | cr)
//
// Draw some "water"
//
val () = cairo_rectangle(cr, ~1 * w/2, y_offset, w, 1 * h)
val () = cairo_set_source_rgba(cr, 0.0, 0.0, 1.0, 0.5)
val () = cairo_fill(cr)
//
val () = cairo_restore (pf0 | cr)
//
} (* end of [mydraw_clock] *)


(* ****** ****** *)

%{^
typedef char **charptrptr ;
%} ;
abstype charptrptr = $extype"charptrptr"

(* ****** ****** *)

staload "{$LIBATSHWXI}/teaching/myGTK/SATS/gtkcairoclock.sats"
staload _ = "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairoclock.dats"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
var argc: int = argc
var argv: charptrptr = $UN.castvwtp1{charptrptr}(argv)
//
val () = $extfcall (void, "gtk_init", addr@(argc), addr@(argv))
//
implement
gtkcairoclock_title<> () = stropt_some"gtkcairoclock"
implement
gtkcairoclock_timeout_interval<> () = 500U // millisecs
implement
gtkcairoclock_mydraw<> (cr, width, height) = mydraw_clock (cr, width, height)
//
val ((*void*)) = gtkcairoclock_main ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [myclock4.dats] *)
