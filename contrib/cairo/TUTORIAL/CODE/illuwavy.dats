(*
**
** A simple CAIRO example: a wavy illusion
** Please see Kitaoka's page: http://www.ritsumei.ac.jp/~akitaoka/
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: April, 2010
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

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

typedef
color = @{
  r= double, g= double, b= double
} (* end of [color] *)

(* ****** ****** *)

macdef
rbgset (cr, c) = let
  val c = ,(c) in cairo_set_source_rgb (,(cr), c.r, c.g, c.b)
end // end of [rbgset]

(* ****** ****** *)

staload
MATH = "libc/SATS/math.sats"
macdef PI = $MATH.M_PI

(* ****** ****** *)

(*

// decoration pattern:

0110
1011
0101
0010

*)

(* ****** ****** *)

#define NEG1 ~1
sortdef two = {n:nat | n < 2}

(* ****** ****** *)

fun flag_eval {i,j:nat}
  (i: int i, j: int j): int = let
  val d = (i mod 4 - j mod 4)
  val flag = (if (~1 <= d && d <= 2) then 1 else 0): int
in
  if (i/4) mod 2 + (j/4) mod 2 = 1 then 1-flag else flag
end // end of [val]

extern
fun draw_decorate {l:agz} {n:pos}
  (cr: !cairo_ref l, c0: &color, c1: &color, X: double, N: int n): void
implement draw_decorate
  {l} (cr, c0, c1, X, N) = () where {
//
  val x0 = X/N
  val rad = 1.0 / 7
//
  fn do1
    (cr: !cairo_ref l):<cloref1> void = let
    val (pf0 | ()) = cairo_save (cr)
    val () = cairo_move_to (cr,  0.0, ~0.5)
    val () = cairo_line_to (cr,  0.0,  0.5)
    val () = cairo_stroke (cr)
    val xc =  0.25 and yc = 0.0
    val () = cairo_arc (cr, xc, yc, rad, 0.0, 2*PI)
    val () = cairo_fill (cr)
    val xc = ~0.25 and yc = 0.0
    val () = cairo_arc (cr, xc, yc, rad, 0.0, 2*PI)
    val () = cairo_fill (cr)
    val () = cairo_restore (pf0 | cr)
  in
    // nothing
  end // end of [do1]
//
  fn do2 (cr: !cairo_ref l):<cloref1> void = let
    val (pf0 | ()) = cairo_save (cr)
    val () = cairo_scale (cr, x0/1.8, x0/1.8)
    val () = do1 (cr)
    val () = cairo_rotate (cr, PI/2)
    val () = do1 (cr)
    val () = cairo_restore (pf0 | cr)
  in
    // nothing
  end // end of [do2]
//
  val N1 = N - 1
  var x: double = 0.0
  var y: double = 0.0
  var i: Nat = 0 and j: Nat = 0
  val () = for (i := 0; i < N1; i := i + 1) let
    val () = x := x + x0; val () = y := 0.0 // init
    val () = for (j := 0; j < N1; j := j + 1) let
      val () = y := y + x0
      val flag = flag_eval (i, j)
      val (
      ) = (
        if flag = 0 then rbgset (cr, c0) else rbgset (cr, c1)
      ) : void // end of [val]
      val () = cairo_set_line_width (cr, 0.1)
      val (pf | ()) = cairo_save (cr)
      val () = cairo_translate (cr, x, y)
      val () = do2 (cr)
      val () = cairo_restore (pf | cr)
    in
      // nothing
    end // end of [for]
  in
    // nothing
  end // end of [for]
//
} // end of [draw_decorater]

(* ****** ****** *)

extern fun draw_board {l:agz} {n:nat}
  (cr: !cairo_ref l, c0: &color, c1: &color, X: double, n: int n): void
// end of [draw_board]

implement
draw_board {l} {n}
  (cr, c0, c1, X, N) = let
  val x = X / N
  viewdef cr = cairo_ref (l)
//
  fun loop1 {i:nat | i <= n} {bw:two}
    (cr: !cr, c0: &color, c1: &color, i: int i, bw: int bw)
    :<cloref1> void =
    if i < N then let
      val () = loop2 (cr, c0, c1, i, 0, bw)
    in
      loop1 (cr, c0, c1, i+1, 1-bw)
    end // end of [if]
  and loop2 {i,j:nat | i < n; j <= n} {bw:two}
    (cr: !cr, c0: &color, c1: &color, i: int i, j: int j, bw: int bw)
    :<cloref1> void =
    if j < N then let
      val (
      ) = (
        if (bw = 0) then rbgset (cr, c0) else rbgset (cr, c1)
      ) : void // end of [val]
      val () = cairo_rectangle (cr, i * x, j * x, x, x)
      val () = cairo_fill (cr)
    in
      loop2 (cr, c0, c1, i, j+1, 1-bw)
    end // end of [if]
//
  val (pf0 | ()) = cairo_save (cr)
  val () = cairo_move_to (cr, 0.0, 0.0)
  val () = loop1 (cr, c0, c1, 0, 0)
  val () = cairo_restore (pf0 | cr)
in
  // nothing
end // end of [draw_board]

(* ****** ****** *)

#define NSIDE 17

(* ****** ****** *)

extern
fun draw_all {l:agz}
(
  cr: !cairo_ref l, width: int, height: int
) : void = "ext#" // endfun

(* ****** ****** *)

implement
draw_all
  (cr, wd, ht) = () where {
  val wd = g0int2float_int_double(wd)
  val ht = g0int2float_int_double(ht)
  val mn = min (wd, ht)
  val xmargin = (wd - mn) / 2
  val ymargin = (ht - mn) / 2
  val (pf0 | ()) = cairo_save (cr)
  val () = cairo_translate (cr, xmargin, ymargin)
//
  var c0: color
  val () = (c0.r := 1.0; c0.g := 1.0; c0.b := 1.0) // white
  var c1: color
  val () = (c1.r := 0.10; c1.g := 0.50; c1.b := 0.5) // deep2 green
  var c2: color
  val () = (c2.r := 0.40; c2.g := 0.90; c2.b := 0.0) // shallow green
  var c3: color
  val () = (c3.r := 0.25; c3.g := 0.75; c3.b := 0.25) // deep green
  val () = cairo_move_to (cr, 0.0, 0.0)
  val () = draw_board (cr, c2, c3, mn, NSIDE)
  val () = draw_decorate (cr, c0, c1, mn, NSIDE)
//
  val () = cairo_restore (pf0 | cr)
} // end of [draw_all]

(* ****** ****** *)

implement
main0 () = () where {
  val W = 300 and H = 300
//
val sf =
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, W, H)
val cr = cairo_create (sf)
//
val () = draw_all (cr, W, H)
//
val status = cairo_surface_write_to_png (sf, "illuwavy.png")
val () = cairo_surface_destroy (sf); val () = cairo_destroy (cr)
//
val () =
if status = CAIRO_STATUS_SUCCESS then begin
  print "The image is written to the file [illuwavy.png].\n"
end else begin
  print "exit(ATS): [cairo_surface_write_to_png] failed"; print_newline ()
end // end of [if]
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [illuwavy.dats] *)
