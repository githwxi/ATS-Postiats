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
// a simple drawing package
// based on cairo and canvas-2d
//
(* ****** ****** *)

#staload
"./../SATS/mydraw.sats"

(* ****** ****** *)
//
#staload
M = "libats/libc/SATS/math.sats"
#staload
_(*M*) = "libats/libc/DATS/math.dats"
//
(* ****** ****** *)
//
macdef M_sin = $M.sin
macdef M_cos = $M.cos
macdef M_sqrt = $M.sqrt
//
(* ****** ****** *)

local

assume
point_t0ype = real2

in (* in of [local] *)
//
implement{}
point_make (x, y) = @(x, y)
//
implement{} point_get_x(p) = p.0
implement{} point_get_y(p) = p.1
//
end // end of [local]

(* ****** ****** *)

implement
{}(*tmp*)
point_hshift
  (p, x) = point_make(p.x() + x, p.y())
implement
{}(*tmp*)
point_vshift
  (p, y) = point_make(p.x(), p.y() + y)

(* ****** ****** *)

local

assume
vector_t0ype = real2

in (* in of [local] *)
//
implement{}
vector_make(x, y) = @(x, y)
//
implement{} vector_get_x (p) = p.0
implement{} vector_get_y (p) = p.1
//
end // end of [local]

(* ****** ****** *)
//
implement
{}(*tmp*)
dotprod(v1, v2) =
  v1.x() * v2.x() + v1.y() * v2.y()
//
(* ****** ****** *)

implement{}
sub_point_point
  (p1, p2) =
  vector_make(p1.x() - p2.x(), p1.y() - p2.y())
// end of [sub_point_point]

(* ****** ****** *)

implement{}
add_point_vector
  (p1, v2) =
  point_make(p1.x() + v2.x(), p1.y() + v2.y())
// end of [add_point_vector]
implement{}
sub_point_vector
  (p1, v2) =
  point_make(p1.x() - v2.x(), p1.y() - v2.y())
// end of [sub_point_vector]

(* ****** ****** *)

implement{}
add_vector_vector
  (v1, v2) =
  vector_make(v1.x() + v2.x(), v1.y() + v2.y())
// end of [add_vector_vector]
implement{}
sub_vector_vector
  (v1, v2) =
  vector_make(v1.x() - v2.x(), v1.y() - v2.y())
// end of [sub_vector_vector]

(* ****** ****** *)
//
implement{}
mul_scalar_vector
  (k, v) =
  vector_make(k * v.x(), k * v.y())
//
implement{}
div_vector_scalar
  (v, k) = let
  val _1k = 1.0 / k
in
  vector_make(_1k * v.x(), _1k * v.y())
end // end of [div_vector_scalar]
//
(* ****** ****** *)

implement{}
vector_length (v) = let
  val x = v.x() and y = v.y() in M_sqrt (x*x + y*y)
end // end of [vector_length]

(* ****** ****** *)

implement{}
vector_rotate
  (v, delta) = let
  val dx = v.x() and dy = v.y()
  val c0 = M_cos (delta) and s0 = M_sin (delta)
in
  vector_make(c0 * dx - s0 * dy, s0 * dx + c0 * dy)
end // end of [vector_rotate]

(* ****** ****** *)

local

assume
color_t0ype = real3

in (* in of [local] *)
//
implement
{}(*tmp*)
color_make(r, g, b) = @(r, g, b)
//
implement{} color_get_r(clr) = clr.0
implement{} color_get_g(clr) = clr.1
implement{} color_get_b(clr) = clr.2
//
end // end of [local]

(* ****** ****** *)

implement{}
color_complement(clr) =
  color_make(1.0 - clr.r(), 1.0 - clr.g(), 1.0 - clr.b())
// end of [color_complement]

(* ****** ****** *)

implement
{}(*tmp*)
mydraw_triangle
  (p1, p2, p3) = let
  val () = mydraw_move_to(p1)
  val () = mydraw_line_to(p2)
  val () = mydraw_line_to(p3)
  val () = mydraw_close_path()
in
  // nothing
end // end of [mydraw_triangle]

(* ****** ****** *)

implement
{}(*tmp*)
mydraw_quadrilateral
  (p1, p2, p3, p4) = let
  val () = mydraw_move_to(p1)
  val () = mydraw_line_to(p2)
  val () = mydraw_line_to(p3)
  val () = mydraw_line_to(p4)
  val () = mydraw_close_path()
in
  // nothing
end // end of [mydraw_quadrilateral]

(* ****** ****** *)

(* end of [mydraw.dats] *)
