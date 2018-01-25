//
// Course: BU CAS CS 520, Fall, 2011
// Instructor: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
//
(* ****** ****** *)
(*
//
// Midterm Examination: generate an image using cairo
//
*)
(* ****** ****** *)

(* 
** Author: William Blair
** Authoremail: wdblairATbuDOTedu
*)

(* ****** ****** *)

(*
** Ported to ATS2 by HX-2013-10-01
*)

(* ****** ****** *)

(*
//
Please implement a program in ATS that can generate
the following image:
//
http://www.psy.ritsumei.ac.jp/~akitaoka/Bulge02c.jpg
//
*)

(* ****** ****** *)

staload INT = "prelude/DATS/integer.dats"
staload FLOAT = "prelude/DATS/float.dats"

(* ****** ****** *)

staload "./../SATS/cairo.sats"

(* ****** ****** *)

#define CELL 36.0
#define DIM 15 (* Dimmensions 15x15 *)
#define SUBSIZE 0.285714286
#define OFFSET 0.04

(* ****** ****** *)

#define int2dbl(x) g0int2float_int_double(x)

(* ****** ****** *)

extern
fun lies_on_axis (i:int, j:int) : bool
extern fun quadrant (i:int,j:int) : int
extern fun in_range (i:int,j:int) : bool

(* ****** ****** *)

extern
fun draw_row{l:agz} (cr: !cairo_ref l, x :int) : void

extern
fun draw_square{l:agz} (cr: !cairo_ref l, i:int, j:int) : void

extern
fun draw_diagonal{l:agz} (cr: !cairo_ref l, i:int, j:int, color:int) : void

extern
fun draw_horizontal{l:agz} (cr: !cairo_ref l, i:int, j:int, color:int) : void

(* ****** ****** *)

implement
quadrant (i,j) = 
  if (i > 7 && j < 7)      then 1 
  else if (i < 7 && j < 7) then 2
  else if (i < 7 && j > 7) then 3
  else if (i > 7 && j > 7) then 4
  else ~1 (* Say the axis is outside the quadrants. *)
// end of [quadrant]

(* ****** ****** *)

implement
draw_horizontal{l}
  (cr, i,j,color) = let (* Extra blocks lie on the same line. *)
  val new_color = int2dbl((color+1) mod 2)
in
//
if (i != 7 || j != 7) then
{
  val x =
  (
    if (i < 7 && j = 7)
      then int2dbl(i+1)-OFFSET else int2dbl(i)+OFFSET
  ) : double
  val y =
  (
    if (i = 7 && j < 7)
      then int2dbl(j+1)-OFFSET else int2dbl(j)+OFFSET
  ) : double
  val x1 =
  (
    if (i > 7 && j = 7)
      then int2dbl(i)+OFFSET else int2dbl(i+1)-OFFSET 
  ) : double
  val y1 =
  (
    if (i = 7 && j > 7)
      then int2dbl(j)+OFFSET else int2dbl(j+1)-OFFSET
  ) : double
  val height =
  (
    if(i = 7 && j < 7) then ~SUBSIZE else SUBSIZE
  ) : double // end of [val]
  val height1 =
  (
    if(i = 7 && j > 7) then SUBSIZE else ~SUBSIZE
  ) : double // end of [val]
  val width =
    (if(i < 7 && j = 7) then ~SUBSIZE else SUBSIZE): double
  val width1 =
    (if(i > 7 && j = 7) then SUBSIZE else ~SUBSIZE): double
  val () = cairo_rectangle( cr, x, y, width, height)
  val () = cairo_set_source_rgb(cr, new_color, new_color, new_color)
  val () = cairo_fill(cr)
  val () = cairo_rectangle( cr, x1,y1,width1,height1)
  val () = cairo_set_source_rgb(cr, new_color, new_color, new_color)
  val () = cairo_fill(cr)
} (* end of [if] *)
//
end // end of [draw_horizontal]

(* ****** ****** *)

implement
draw_diagonal{l}
  (cr, i, j, color) = let
//
val quadrant = quadrant(i,j)
val new_color = int2dbl((color+1) mod 2)
val quad_mod = quadrant mod 2
val x = int2dbl(i)+OFFSET
val y =
(
  if (quad_mod = 1) then int2dbl(j)+OFFSET else int2dbl(j+1)-OFFSET
) : double // end of [val]
val x1 = int2dbl(i+1)-OFFSET
val y1 =
(
  if (quad_mod = 1) then int2dbl(j+1)-OFFSET else int2dbl(j)+OFFSET
) : double // end of [val]
val height =
  (if (quad_mod = 1) then SUBSIZE else ~SUBSIZE): double
val width = SUBSIZE
val width1 = ~SUBSIZE
val height1 =
  (if (quad_mod = 1) then ~SUBSIZE else SUBSIZE): double
//  
val () = cairo_rectangle(cr, x, y, width, height)
val () = cairo_set_source_rgb(cr, new_color, new_color, new_color)
val () = cairo_fill(cr)
val () = cairo_rectangle(cr,x1,y1,width1,height1)
val () = cairo_set_source_rgb(cr, new_color, new_color, new_color)
val () = cairo_fill(cr)
//
in
  // nothing
end // end of [draw_diagonal]
  
(* ****** ****** *)

implement
lies_on_axis(i,j) = (i = 7 || j = 7)

implement
in_range (i,j) = let (* Check if we need to add extra boxes. *)
  val x = abs(7 - i) and y = abs(7 - j)
in
//
(x <= 1 && y <= 6) || (x <= 3 && y <= 5) || (x <= 4 && y <= 4) || (x <= 5 && y <= 3) || (x <= 6 && y <= 1)
//
end // end of [in_range]
  
(* ****** ****** *)

implement
draw_square
  (cr, i, j) = let (* First, draw the underlying square.*)
  val bw =
  (
    if(((i mod 2 = 1) && (j mod 2 = 1) ) || ( (i mod 2) = 0 && (j mod 2 = 0))) then 0 else 1
  ) : int
  val () = cairo_rectangle(cr, int2dbl(i), int2dbl(j), 1.0, 1.0)
//
  var r: double = 0.0
  var g: double = 0.0
  var b: double = 0.0
  val () = (
    if bw > 0 then (r := 1.0; g := 1.0; b := 1.0)
  ) (* end of [val] *)
//
  val () = cairo_set_source_rgb(cr, r, g, b)
  val () = cairo_fill(cr)
in
//
if in_range(i,j) then
  if lies_on_axis(i,j)
    then draw_horizontal(cr, i, j, bw) else draw_diagonal(cr, i, j, bw)
  // end of [if]
//
end // end of [draw_square]

(* ****** ****** *)

implement
draw_row{l}
  (cr, x) = let
//
fun loop
(
  cr: !cairo_ref l, x:int, i:int
) : void = let
  val () = if i < DIM then loop(cr, x, i+1)
in
  draw_square(cr,x,i)
end // end of [loop]
//
in
  loop(cr,x,0)
end // end of [draw_row]

(* ****** ****** *)

extern
fun draw_checkerboard
  {l:agz} (cr: !cairo_ref l): void
implement
draw_checkerboard{l} (cr) = let
//
fun loop
(
  cr: !cairo_ref l, height:int, i:int
) : void = let
  val() = draw_row(cr,i)
in 
  if i < height then loop(cr,height, i+1)
end (* end of [loop] *)
//
in
  loop(cr, DIM, 0)
end // end of [draw_checkerboard]

(* ****** ****** *)

implement
main0 () = () where {
//
val W = 540 and H = 540
//
val surface = // create a surface for drawing
cairo_image_surface_create (CAIRO_FORMAT_ARGB32, W, H)
val cr = cairo_create (surface)
//
val (pf0 | ()) = cairo_save (cr)
val () = cairo_scale (cr, CELL, CELL)
val () = draw_checkerboard (cr)
val () = cairo_restore (pf0 | cr)
//
val status =
cairo_surface_write_to_png (surface, "cairo-Bulge02c.png")
val () = cairo_destroy (cr) // a type error is issued if omitted
val () = cairo_surface_destroy (surface) // a type error if omitted
//
// in case of a failure ...
//
val () = assert_errmsg (status = CAIRO_STATUS_SUCCESS, $mylocation)
} (* end of [main0] *)

(* ****** ****** *)

(* end of [cairo-Bulge02c.dats] *)
