(*
**
** A simple digital GTK/CAIRO-clock
**
** Author: Hongwei Xi
** Authoremail: hwxiATcsDOTbuDOTedu
** Time: April, 2010
**
*)

(* ****** ****** *)

(*
//
// It is ported to ATS2 by HX-2013-09
//
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no dynloading at run-time

(* ****** ****** *)

#include
"share/atspre_define.hats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload INT = "prelude/DATS/integer.dats"
staload FLOAT = "prelude/DATS/float.dats"

(* ****** ****** *)

staload "libc/SATS/time.sats"

(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

extern
fun mydraw_clock
  (cr: !cairo_ref1, width: int, height: int): void = "ext#"
// end of [mydraw_clock]

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

implement
mydraw_clock
  (cr, wd, ht) = let
// HX: using a fixed-width font
val () = cairo_select_font_face
  (cr, "Courier", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
val () = cairo_set_font_size (cr, 32.0)
//
var time: time_t
val yn = time_getset (time)
val () = assert_errmsg (yn, $mylocation)
prval () = opt_unsome{time_t}(time)
var tm: tm_struct
val ptr_ = localtime_r (time, tm)
val () = assert_errmsg (ptr_ > 0, $mylocation)
prval () = opt_unsome {tm_struct} (tm)
//
val () =
{
  var buf: bytes32?
  val bufp = addr@(buf)
  val _ = $extfcall (size_t, "mystrftime", bufp, 32, "%I:%M:%S %p", addr@(tm))
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

(* end of [myclock0.dats] *)
