(*
**
** Drawing instances of
** the famous Pascal's theorem
**
** Author: Hongwei Xi
** Authoremail: hwxiATcsDOTbuDOTedu
** Time: Summer, 2010
**
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "libc/SATS/math.sats"
staload _(*anon*) = "libc/DATS/math.dats"
//
staload "libc/SATS/time.sats"
staload "libc/SATS/stdlib.sats"
//
macdef PI = M_PI and _2PI = 2*PI
//
(* ****** ****** *)

(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

typedef dbl = double

// y = k1 * x + b1
// y = k2 * x + b2

fun line_intersect
(
  k1: dbl, b1: dbl, k2: dbl, b2: dbl
) : @(dbl, dbl) = (x, y) where {
  val x = (b1 - b2) / (k2 - k1); val y = k1 * x + b1
} // end of [line_intersect]

(* ****** ****** *)

fun sort {n:nat}
  (xs: list_vt (double, n)): list_vt (double, n) = let
in
  list_vt_mergesort<double> (xs)
end // end of [sort]

(* ****** ****** *)

fun
draw_colinear
(
  cr: !cairo_ref1
, x1: double, y1: double
, x2: double, y2: double
, x3: double, y3: double
) : void =
(
if x1 <= x2 then
  if x1 <= x3 then let
    val () = cairo_move_to (cr, x1, y1)
  in
    if x2 <= x3 then cairo_line_to (cr, x3, y3) else cairo_line_to (cr, x2, y2)
  end else let
    val () = cairo_move_to (cr, x3, y3)
  in
    cairo_line_to (cr, x2, y2)
  end
else // x2 < x1
  if x2 <= x3 then let
    val () = cairo_move_to (cr, x2, y2)
  in
    if x1 <= x3 then cairo_line_to (cr, x3, y3) else cairo_line_to (cr, x1, y1)
  end else let
    val () = cairo_move_to (cr, x3, y3)
  in
    cairo_line_to (cr, x1, y1)
  end 
// end of [if]
) (* end of [draw_colinear] *)

(* ****** ****** *)

fun genRandDoubles
  {n:nat} (n: int n): list_vt (double, n) =
  if n > 0 then let
    val x = drand48 () in cons_vt{dbl}(x, genRandDoubles (n-1))
  end else list_vt_nil
// end of [genRandDoubles]

(* ****** ****** *)

extern
fun mydraw_pascal
  {l:agz} (cr: !cairo_ref l, W: int, H: int): void
// end of [mydraw_pascal]

implement
mydraw_pascal
  (cr, W, H) = () where {
//
val W = g0int2float_int_double (W)
and H = g0int2float_int_double (H)
//
val ts = list_vt_mergesort (genRandDoubles(6))
val-~cons_vt(t1, ts) = ts
val-~cons_vt(t2, ts) = ts
val-~cons_vt(t3, ts) = ts
val-~cons_vt(t4, ts) = ts
val-~cons_vt(t5, ts) = ts
val-~cons_vt(t6, ts) = ts
val-~list_vt_nil((*void*)) = ts
//
val a1 = _2PI * t1
val x1 = cos a1 and y1 = sin a1
val a2 = _2PI * t2
val x2 = cos a2 and y2 = sin a2
val a3 = _2PI * t3
val x3 = cos a3 and y3 = sin a3
val a4 = _2PI * t4
val x4 = cos a4 and y4 = sin a4
val a5 = _2PI * t5
val x5 = cos a5 and y5 = sin a5
val a6 = _2PI * t6
val x6 = cos a6 and y6 = sin a6
//
val k12 = (y1 - y2) / (x1 - x2)
val b12 = y1 - k12 * x1
val k23 = (y2 - y3) / (x2 - x3)
val b23 = y2 - k23 * x2
val k34 = (y3 - y4) / (x3 - x4)
val b34 = y3 - k34 * x3
val k45 = (y4 - y5) / (x4 - x5)
val b45 = y4 - k45 * x4
val k56 = (y5 - y6) / (x5 - x6)
val b56 = y5 - k56 * x5
val k61 = (y6 - y1) / (x6 - x1)
val b61 = y6 - k61 * x6
//
val (px1, py1) = line_intersect (k12, b12, k45, b45)
val (px2, py2) = line_intersect (k23, b23, k56, b56)
val (px3, py3) = line_intersect (k34, b34, k61, b61)
//
val pxs = let
  macdef :: (x, xs) = cons_vt{dbl}(,(x), ,(xs))
in
  1.0 :: ~1.0 :: px1 :: px2 :: px3 :: nil_vt ()
end // end of [val]
val qxs = sort (pxs)
//
val ~cons_vt (qx1, qxs) = qxs
val ~cons_vt (_qx2, qxs) = qxs
val ~cons_vt (_qx3, qxs) = qxs
val ~cons_vt (_qx4, qxs) = qxs
val ~cons_vt (qx5, qxs) = qxs
val ~list_vt_nil ((*void*)) = qxs
//
val dx = qx5 - qx1
//
val pys = let
  macdef :: (x, xs) = cons_vt{dbl}(,(x), ,(xs))
in
  1.0 :: ~1.0 :: py1 :: py2 :: py3 :: nil_vt ()
end // end of [val]
val qys = sort (pys)
//
val ~cons_vt (qy1, qys) = qys
val ~cons_vt (_qy2, qys) = qys
val ~cons_vt (_qy3, qys) = qys
val ~cons_vt (_qy4, qys) = qys
val ~cons_vt (qy5, qys) = qys
val ~list_vt_nil ((*void*)) = qys
//
val dy = qy5 - qy1
//
val WH = min (W, H)
val dxy = max (dx, dy)
val alpha = WH / dxy
//
val () = cairo_translate (cr, (W-WH)/2, (H-WH)/2)
//
val () = cairo_scale (cr, alpha, alpha)
val () = cairo_rectangle (cr, 0.0, 0.0, dxy, dxy)
val () = cairo_set_source_rgb (cr, 1.0, 1.0, 1.0) // white color
val () = cairo_fill (cr)
//
val () = cairo_translate
(
  cr, (dxy - dx) / 2 - (qx1/dx)*dx, (dxy - dy) / 2 - (qy1/dy)*dy
) // end of [cairo_translate] // end of [val]
//
val xc = 0.0 and yc = 0.0; val rad = 1.0
val () = cairo_arc (cr, xc, yc, rad, 0.0, _2PI)
val () = cairo_set_source_rgb (cr, 0.0, 0.0, 1.0) // blue color
val () = cairo_fill (cr)
//
val () = cairo_move_to (cr, x1, y1)
val () = cairo_line_to (cr, x2, y2)
val () = cairo_line_to (cr, x3, y3)
val () = cairo_line_to (cr, x4, y4)
val () = cairo_line_to (cr, x5, y5)
val () = cairo_line_to (cr, x6, y6)
val () = cairo_close_path (cr)
val () = cairo_set_source_rgb (cr, 1.0, 1.0, 0.0) // yellow color
val () = cairo_fill (cr)
//
val () = cairo_set_line_width (cr, 0.01)
val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0) // black color
//
val () = draw_colinear (cr, x1, y1, x2, y2, px1, py1)
val () = draw_colinear (cr, x4, y4, x5, y5, px1, py1)
//
val () = draw_colinear (cr, x2, y2, x3, y3, px2, py2)
val () = draw_colinear (cr, x5, y5, x6, y6, px2, py2)
//
val () = draw_colinear (cr, x3, y3, x4, y4, px3, py3)
val () = draw_colinear (cr, x6, y6, x1, y1, px3, py3)
//
val () = draw_colinear (cr, px1, py1, px2, py2, px3, py3)
//
val () = cairo_stroke (cr)
//
} // end of [mydraw_pascal]

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
val () = srand48 ($UN.cast2lint(time_get()))
val () = $extfcall (void, "gtk_init", addr@(argc), addr@(argv))
//
implement
gtkcairoclock_title<> () = stropt_some"gtkcairoclock"
implement
gtkcairoclock_timeout_interval<> () = 5000U // millisecs
implement
gtkcairoclock_mydraw<> (cr, width, height) = mydraw_pascal (cr, width, height)
//
val ((*void*)) = gtkcairoclock_main ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [mypascal.dats] *)
