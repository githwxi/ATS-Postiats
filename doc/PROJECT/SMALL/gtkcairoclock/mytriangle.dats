(*
**
** Drawing randomly generated triangles
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

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

fun
draw_triangle{l:agz}
(
  cr: !cairo_ref l
, x0: double, y0: double
, x1: double, y1: double
, x2: double, y2: double
) : void = () where
{
  val () = cairo_move_to (cr, x0, y0)
  val () = cairo_line_to (cr, x1, y1)
  val () = cairo_line_to (cr, x2, y2)
  val () = cairo_close_path (cr)
} (* end of [draw_triangle] *)

(* ****** ****** *)

typedef
triangle = @{
  r= double, g= double, b= double
, x0= double, y0= double, x1= double, y1= double, x2= double, y2= double
} // end of [triangle]

(* ****** ****** *)

staload TIME = "libc/SATS/time.sats"
staload STDLIB = "libc/SATS/stdlib.sats"

(* ****** ****** *)

extern
fun mydraw_triangle
  (cr: !cairo_ref1, width: int, height: int): void
// end of [mydraw_triangle]

(* ****** ****** *)

implement
mydraw_triangle
(
  cr, width, height
) = () where
{
//
val W = g0int2float_int_double(width)
val H = g0int2float_int_double(height)
//
val r = $STDLIB.drand48 ()
and g = $STDLIB.drand48 ()
and b = $STDLIB.drand48 ()
//
val x0 = $STDLIB.drand48 ()
and y0 = $STDLIB.drand48 ()
val x1 = $STDLIB.drand48 ()
and y1 = $STDLIB.drand48 ()
val x2 = $STDLIB.drand48 ()
and y2 = $STDLIB.drand48 ()
//
val (
) = draw_triangle
(
  cr, W*x0, H*y0, W*x1, H*y1, W*x2, H*y2
) (* end of [val] *)
//
val () = cairo_set_source_rgb (cr, r, g, b)
val () = cairo_fill_preserve (cr)
val () = cairo_set_line_width (cr, 2.5)
val () = cairo_set_source_rgb (cr, 1-r, 1-g, 1-b)
val () = cairo_stroke (cr)
//
} (* end of [mydraw_triangle] *)

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
val () = $STDLIB.srand48 ($UN.cast2lint($TIME.time_get()))
val () = $extfcall (void, "gtk_init", addr@(argc), addr@(argv))
//
implement
gtkcairoclock_title<> () = stropt_some"gtkcairoclock"
implement
gtkcairoclock_timeout_interval<> () = 1000U // millisecs
implement
gtkcairoclock_mydraw<> (cr, width, height) = mydraw_triangle (cr, width, height)
//
val ((*void*)) = gtkcairoclock_main ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [mytriangle.dats] *)
