(*
**
** A simple CAIRO example: an illusion of circular motion
** Please see Kitaoka's page: http://www.ritsumei.ac.jp/~akitaoka/
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: 2009-12 // 1st implementation
** Time: 2010-04 // some modifications
**
*)

(*
** Copyright (C) 2009-2010 Hongwei Xi, Boston University
**
** Permission is hereby granted, free of charge, to any person
** obtaining a copy of this software and associated documentation
** files (the "Software"), to deal in the Software without
** restriction, including without limitation the rights to use,
** copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following
** conditions:
**
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// How to compile:
//   patscc -o illucircmot `pkg-config --cflags --libs cairo` illucircmot.dats
//
// How to test: ./illucircmot
//   'gthumb' or 'eog' can be used to view the generated image file 'illucircmot.png'
//
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

staload "libc/SATS/math.sats"
staload _(*anon*) = "libc/DATS/math.dats"

(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

macdef PI = M_PI

(* ****** ****** *)

stadef dbl = double
stadef cr (l:addr) = cairo_ref l

(* ****** ****** *)

// black/white
fn bw_set{l:agz}
  (cr: !cr l, bw: int): void =
(
  if bw > 0 then
    cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
  else
    cairo_set_source_rgb (cr, 1.0, 1.0, 1.0)
  // end of [if]
) // end of [bw_set]

// yellow/blue
fn yb_set {l:agz}
  (cr: !cr l, yb: int): void =
(
  if yb > 0 then
    cairo_set_source_rgb (cr, 1.0, 0.75, 0.0)
  else
    cairo_set_source_rgb (cr, 0.0, 0.00, 1.0)
  // end of [if]
) // end of [yb_set]

(* ****** ****** *)

fn draw_ring
  {l:agz} {n:int | n >= 2} (
    cr: !cr l
  , bw: int, yb: int
  , rad1: dbl, rad2: dbl
  , n: int n
  ) : void = let
  val alpha =  (1.0 - rad2/rad1) / 1.5
  val delta = 2 * PI / n
//
  fun loop {i:nat | i <= n} .<n-i>.
    (cr: !cr l, angle: dbl, i: int i, bw: int, yb: int)
    :<cloref1> void = let
    val _sin = sin angle and _cos = cos angle
    val x1 = rad1 * _cos and y1 = rad1 * _sin
    val x2 = rad2 * _cos and y2 = rad2 * _sin
    val radm = (rad1 + rad2) / 2
    val xm = radm * cos (angle-alpha)
    and ym = radm * sin (angle-alpha)
    val () = cairo_move_to (cr, x1, y1)
    val () = cairo_curve_to (cr, x1, y1, xm, ym, x2, y2)
    val xm = radm * cos (angle+alpha)
    and ym = radm * sin (angle+alpha)
    val () = cairo_curve_to (cr, x2, y2, xm, ym, x1, y1)
    val () = yb_set (cr, yb)
    val () = cairo_fill (cr)
//
    val () = cairo_move_to (cr, x2, y2)
    val () = cairo_curve_to (cr, x2, y2, xm, ym, x1, y1)
    val () = cairo_arc (cr, 0.0, 0.0, rad1, angle, angle+delta)
    val angle = angle + delta
    val _sin = sin angle and _cos = cos angle
    val x3 = rad1 * _cos and y3 = rad1 * _sin
    val x4 = rad2 * _cos and y4 = rad2 * _sin
    val xm = radm * cos (angle-alpha)
    and ym = radm * sin (angle-alpha)
    val () = cairo_curve_to (cr, x3, y3, xm, ym, x4, y4)
    val () = cairo_arc_negative (cr, 0.0, 0.0, rad2, angle, angle-delta)
    val () = bw_set (cr, bw)
    val () = cairo_fill (cr)
  in
    if i < n then loop (cr, angle, i+1, 1-bw, 1-yb)
  end // end of [loop]
in
  loop (cr, 0.0, 1, bw, yb)
end // end of [draw_ring]

(* ****** ****** *)

#define SHRINKAGE 0.78
fun draw_rings
  {l:agz} {n:int | n >= 2} (
    cr: !cr l
  , bw: int, yb: int
  , rad_beg: dbl, rad_end: dbl
  , n: int n
  ) : void =
  if rad_beg <= rad_end then let
    val () = cairo_set_source_rgb (cr, 0.0, 0.0, 0.0)
    val () = cairo_arc (cr, 0.0, 0.0, rad_beg, 0.0, 2*PI)
    val () = cairo_fill (cr)
  in
    // loop exits
  end else let
    val rad_beg_nxt = SHRINKAGE * rad_beg
    val () = draw_ring (cr, bw, yb, rad_beg, rad_beg_nxt, n)
  in
    draw_rings (cr, 1-bw, 1-yb, rad_beg_nxt, rad_end, n)
  end // end of [if]
// end of [draw_rings]

(* ****** ****** *)

implement
main0 () =
{
val margin = 10
val U = 150
#define NROW 2; #define NCOL 2
val wd = NCOL * U and ht = NROW * U
val surface = cairo_image_surface_create
  (CAIRO_FORMAT_ARGB32, wd+margin, ht+margin)
val cr = cairo_create (surface)
//
val U = g0int2float_int_double(U)
val wd = g0int2float_int_double(wd)
and ht = g0int2float_int_double(ht)
val margin = g0int2float_int_double(margin)
//
val xmargin = margin/2 and ymargin = margin/2
//
val () = cairo_translate (cr, xmargin, ymargin)
//
var i : int = 0 and j : int = 0
val () =
(
for (i := 0; i <= NCOL; i := i + 1)
(
  for (
    j := 0; j <= NROW; j := j + 1
  ) let
    val (pf | ()) = cairo_save (cr)
    val () = cairo_translate (cr, i*U, j*U)
    val () = draw_rings (cr, 0, 0, U/2, 4.0, 40)
    val () = cairo_restore (pf | cr)
  in
    // nothing
  end // end of [let] // end of [for]
) // end of [for]
) // end of [val]
//
val () =
(
for (i := 0; i < NCOL; i := i + 1)
(
  for (
    j := 0; j < NROW; j := j + 1
  ) let
    val (pf | ()) = cairo_save (cr)
    val () = cairo_translate (cr, i*U+U/2, j*U+U/2)
    val () = draw_rings (cr, i, 0, U/2, 4.0, 40)
    val () = cairo_restore (pf | cr)
  in
    // nothing
  end // end of [let] // end of [for]
) // end of [for]
) // end of [val]
//
val status = cairo_surface_write_to_png (surface, "illucircmot.png")
val () = cairo_surface_destroy (surface)
val () = cairo_destroy (cr)
//
val () =
if status = CAIRO_STATUS_SUCCESS then begin
  print "The image is written to the file [illucircmot.png].\n"
end else begin
  print "exit(ATS): [cairo_surface_write_to_png] failed"; print_newline ()
end // end of [if]
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [illucircmot.dats] *)
