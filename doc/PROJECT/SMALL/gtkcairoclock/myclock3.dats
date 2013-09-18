(*
** CS511 HW8
** William Blair
** wdblair@bu.edu
** 
** This one is mostly Prof. Xi's
** GTK/Cairo-clock from ${ATSHOME}/doc/EXAMPLE/GTK/ 
*)

(* ****** ****** *)

(*
** Ported to ATS2 by Hongwei Xi, September, 2013
*)

(* ****** ****** *)

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

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

fn draw_hand{l:agz}
(
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

fn draw_clock{l:agz}
(
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
val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
val () = cairo_fill (cr)
//
val () = cairo_select_font_face
  (cr, "serif", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
val () = cairo_set_font_size (cr, 8.0)
//
fun drop_number
(
  cr: !cr l, s:string,x:double,y:double,angle:double
) : void = () where
{
  val (pf | ()) = cairo_save (cr)
  val () = cairo_move_to(cr,x,y)
  val () = cairo_rotate(cr,angle)
  val () = cairo_show_text (cr, s)
  val () = cairo_restore (pf | cr)
} (* end of [drop_number] *)
//
val () = cairo_set_source_rgb (cr, 1.0, 1.0, 1.0)
//
val () = drop_number(cr,"7",0.0,25.0,1.3)
val () = drop_number(cr,"3",~10.0,37.0,~1.2)
val () = drop_number(cr,"1",8.0,30.0,2.8)
val () = drop_number(cr,"5",12.0,30.0,PI/2.0)
val () = drop_number(cr,"2",18.0,27.0,PI/3.0)
val () = drop_number(cr,"∞",~5.0,38.0,0.12)
val () = drop_number(cr,"4",~22.0,31.0,0.7)
val () = drop_number(cr,"6",~8.0,32.0,PI/8.0)
//
val h_l = 0.60 * rad
val (pf | ()) = cairo_save (cr)
val () = cairo_set_source_rgb (cr, 0.85, 0.87, 0.87)
val () = cairo_rotate (cr, h_ang)
val () = draw_hand (cr, 3.0, 1.5, h_l)
val () = cairo_restore (pf | cr)
val (pf | ()) = cairo_save (cr)
val () = cairo_set_source_rgb (cr, 0.85, 0.87, 0.87)
val () = cairo_rotate (cr, h_ang+PI)
val () = draw_hand (cr, 3.0, 1.5, h_l/4)
val () = cairo_restore (pf | cr)
//
val m_l = 0.85 * rad
val (pf | ()) = cairo_save (cr)
val () = cairo_set_source_rgb (cr, 0.85, 0.87, 0.87)
val () = cairo_rotate (cr, m_ang)
val () = draw_hand (cr, 2.0, 1.0, m_l)
val () = cairo_restore (pf | cr)
val (pf | ()) = cairo_save (cr)
val () = cairo_set_source_rgb (cr, 0.85, 0.87, 0.87)
val () = cairo_rotate (cr, m_ang+PI)
val () = draw_hand (cr, 2.0, 1.0, h_l/4)
val () = cairo_restore (pf | cr)
//
val s_l = 0.85 * rad
val (pf | ()) = cairo_save (cr)
val () = cairo_set_source_rgb (cr, 1.0, 1.0, 1.0)
val () = cairo_rotate (cr, s_ang)
val () = draw_hand (cr, 1.0, 0.5, m_l)
val () = cairo_restore (pf | cr)
val (pf | ()) = cairo_save (cr)
val () = cairo_set_source_rgb (cr, 1.0, 1.0, 1.0)
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

extern
fun mydraw_clock
  (cr: !cairo_ref1, width: int, height: int): void = "ext#"
// end of [mydraw_clock]

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
val () = draw_clock (cr, hr, min, sec)
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

(* end of [myclock3.dats] *)
