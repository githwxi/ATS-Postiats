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

%{^
typedef
struct { char buf[32] ; } bytes32 ;
%} // end of [%{^]
abst@ype bytes32 = $extype"bytes32"

extern
fun mydraw_clock
  (cr: !cairo_ref1, width: int, height: int): void
// end of [mydraw_clock]

implement
mydraw_clock
  (cr, wd, ht) = let
//
// HX: using a fixed-width font
//
val () = cairo_select_font_face
  (cr, "Courier", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
val () = cairo_set_font_size (cr, 32.0)
//
val (hh, mm, ss) = mytime_get ()
val hh = g0float2int_double_int(hh)
val mm = g0float2int_double_int(mm)
val ss = g0float2int_double_int(ss)
//
val () =
{
  var buf: bytes32?
  val bufp = addr@(buf)
  val _ = $extfcall
  (
    int, "snprintf", $UN.cast{charptr}(bufp), 32, "%02i:%02i:%02i", hh, mm, ss
  ) (* end of [extfcall] *)
//
  var extents: cairo_text_extents_t
  val () = cairo_text_extents (cr, $UN.castvwtp1{string}(bufp), extents)
  val xc = (wd - extents.width) / 2 and yc = (ht - extents.height) / 2
  val () = cairo_move_to (cr, xc - extents.x_bearing, yc - extents.y_bearing)
  val () = cairo_set_source_rgb (cr, 0.0, 0.0, 1.0)
  val () = cairo_show_text (cr, $UN.castvwtp1{string}(bufp))
} (* end of [val] *)
//
in
  // nothing
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
