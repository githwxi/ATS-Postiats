(*
**
** A GTK/Cairo-clock
**
** Author: Hongwei Xi
** Authoremail: hwxiATcsDOTbuDOTedu
** Start Time: December, 2009
**
** The clock was drawn after my wall clock at home
*)

(* ****** ****** *)

(*
** Ported to ATS2 by Hongwei Xi, September, 2013
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/math.sats"

macdef PI = M_PI and PI2 = M_PI / 2

(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

stadef dbl = double
stadef cr (l:addr) = cairo_ref l

(* ****** ****** *)

fn draw_hand{l:agz}
(
  cr: !cr l
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
  cr: !cr l
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

staload "libc/SATS/time.sats"

(* ****** ****** *)

extern
fun mydraw_clock
  (cr: !cairo_ref1, width: int, height: int): void
// end of [mydraw_clock]

(* ****** ****** *)

implement
mydraw_clock
  (cr, wd, ht) = let
//
val wd = g1ofg0 (wd)
val ht = g1ofg0 (ht)
val () = assertloc (wd >= 0)
val () = assertloc (ht >= 0)
//
var t: time_t // unintialized
val yn = time_getset (t)
val () = assert_errmsg (yn, $mylocation)
prval () = opt_unsome {time_t} (t)
var tm: tm_struct // unintialized
val _ptr = localtime_r (t, tm)
val () = assert_errmsg (_ptr > 0, $mylocation)
prval () = opt_unsome {tm_struct} (tm)
val hr = tm.tm_hour
and min = tm.tm_min
val sec = tm.tm_sec
val hr = g1ofg0_int (hr)
and min = g1ofg0_int (min)
and sec = g1ofg0_int (sec)
//
val () = assertloc ((0 <= hr) * (hr < 24))
val () = assertloc ((0 <= min) * (min < 60))
val () = assertloc ((0 <= sec) * (sec < 60))
//
in
  draw_clock (cr, wd, ht, hr, min, sec)
end (* end of [mydraw_clock] *)

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

(* end of [myclock1.dats] *)
