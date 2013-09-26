(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
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
// HX-2013-02: a simple drawing package
//
(* ****** ****** *)

staload "./../SATS/mydraw.sats"

(* ****** ****** *)

implement
dotprod (v1, v2) = v1.x * v2.x + v1.y * v2.y

(* ****** ****** *)

implement
add_point_vector
  (p1, v2) = point_make (p1.x + v2.x, p1.y + v2.y)
implement
sub_point_vector
  (p1, v2) = point_make (p1.x - v2.x, p1.y - v2.y)

(* ****** ****** *)

implement
add_vector_vector
  (v1, v2) = vector_make (v1.x + v2.x, v1.y + v2.y)
implement
sub_vector_vector
  (v1, v2) = vector_make (v1.x - v2.x, v1.y - v2.y)

(* ****** ****** *)

implement
mul_scalar_vector (k, v) = vector_make (k * v.x, k * v.y)
implement
div_scalar_vector (k, v) = vector_make (v.x / k, v.y / k)

(* ****** ****** *)

(* end of [mydraw_basics.dats] *)
