(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// HX-2013-02:
// A simple drawing package
// based on cairo and HTML5-canvas-2d
//
(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSCNTRB\
.libats-hwxi.teaching.mydraw"
//
(* ****** ****** *)

typedef real = double
typedef real2 = @(real, real)
typedef real3 = @(real, real, real)

(* ****** ****** *)
//
abst@ype point_t0ype = real2
abst@ype vector_t0ype = real2
//
typedef point = point_t0ype
typedef vector = vector_t0ype
//
(* ****** ****** *)

symintr .x .y

(* ****** ****** *)

fun{}
point_make (x: real, y: real): point

(* ****** ****** *)
//
fun{}
point_get_x (p: point): real
fun{}
point_get_y (p: point): real
//
overload .x with point_get_x
overload .y with point_get_y
//
(* ****** ****** *)

fun{}
point_hshift (p: point, x: real): point
fun{}
point_vshift (p: point, y: real): point

(* ****** ****** *)

fun{}
vector_make (x: real, y: real): vector

(* ****** ****** *)
//
fun{}
vector_get_x (v: vector): real
fun{}
vector_get_y (v: vector): real
//
overload .x with vector_get_x
overload .y with vector_get_y
//
(* ****** ****** *)
//
fun{}
vector_length (v: vector): real
//
(* ****** ****** *)

fun{}
dotprod (v1: vector, v2: vector): real

(* ****** ****** *)

castfn point2vector (p: point):<> vector
castfn vector2point (v: vector):<> point

(* ****** ****** *)

fun{}
sub_point_point (p1: point, p2: point): vector
overload - with sub_point_point

(* ****** ****** *)

fun{}
add_point_vector (p1: point, v2: vector): point
fun{}
sub_point_vector (p1: point, v2: vector): point
overload + with add_point_vector
overload - with sub_point_vector

(* ****** ****** *)

fun{}
add_vector_vector (v1: vector, v2: vector): vector
fun{}
sub_vector_vector (v1: vector, v2: vector): vector
overload + with add_vector_vector
overload - with sub_vector_vector

(* ****** ****** *)

fun{}
mul_scalar_vector (k: real, v: vector): vector
fun{}
div_vector_scalar (v: vector, k: real): vector
overload * with mul_scalar_vector
overload / with div_vector_scalar

(* ****** ****** *)
//
// HX: counterclockwise
//
fun{}
vector_rotate
  (v: vector, delta: real(*radian*)): vector
// end of [vector_rotate]

(* ****** ****** *)
//
abst@ype
color_t0ype = real3
//
typedef color = color_t0ype
//
(* ****** ****** *)

fun{}
color_make (r: real, g: real, b: real):<> color

(* ****** ****** *)
//
symintr .r .g .b
//
fun{}
color_get_r (c: color):<> real
fun{}
color_get_g (c: color):<> real
fun{}
color_get_b (c: color):<> real
//
overload .r with color_get_r
overload .g with color_get_g
overload .b with color_get_b
//
(* ****** ****** *)

fun{}
color_complement (c: color):<> color

(* ****** ****** *)

fun{} mydraw_new_path (): void
fun{} mydraw_new_sub_path (): void
fun{} mydraw_close_path (): void

(* ****** ****** *)

fun{} mydraw_move_to (p: point): void
fun{} mydraw_move_to_xy (x: real, y: real): void

(* ****** ****** *)

fun{} mydraw_line_to (p: point): void
fun{} mydraw_line_to_xy (x: real, y: real): void

fun{} mydraw_rel_line_to (v: vector): void
fun{} mydraw_rel_line_to_dxy (dx: real, dy: real): void

(* ****** ****** *)

fun{
} mydraw_triangle
  (p1: point, p2: point, p3: point): void
// end of [mydraw_triangle]

fun{
} mydraw_quadrilateral
  (p1: point, p2: point, p3: point, p4: point): void
// end of [mydraw_quadrilateral]

(* ****** ****** *)

fun{
} mydraw_rectangle (pul: point, w: real, h: real): void

(* ****** ****** *)

fun{
} mydraw_arc
  (pc: point, rad: real, angle_beg: real, angle_end: real): void
fun{
} mydraw_arc_neg
  (pc: point, rad: real, angle_beg: real, angle_end: real): void

fun{}
mydraw_circle (pc: point, rad: real): void

(* ****** ****** *)

fun{} mydraw_fill (): void

fun{} mydraw_fill_set_rgb
  (r: double, g: double, b: double): void
fun{} mydraw_fill_set_rgba
  (r: double, g: double, b: double, alpha: double): void
fun{} mydraw_fill_set_string (style: string): void

(* ****** ****** *)

fun{} mydraw_stroke (): void

fun{} mydraw_stroke_set_rgb
  (r: double, g: double, b: double): void
fun{} mydraw_stroke_set_rgba
  (r: double, g: double, b: double, alpha: double): void
fun{} mydraw_stroke_set_string (style: string): void

(* ****** ****** *)
//
absview mydraw_save_v
//
fun{} mydraw_save (): (mydraw_save_v | void)
fun{} mydraw_restore (pf: mydraw_save_v | (*void*)): void
//
(* ****** ****** *)

(* end of [mydraw.sats] *)
