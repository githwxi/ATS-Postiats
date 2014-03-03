(*
** Copyright (C) 2011 Hongwei Xi, Boston University
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
** Author: Hongwei Xi
** Authoremail: (gmhwxiATgmailDOTcom)
** Time: February, 2014
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun dotprod 
(
  A: &(@[double][3])
, B: &(@[double][3])
) : double =
(
  A[0] * B[0] + A[1] * B[1] + A[2] * B[2]
)

(* ****** ****** *)

implement
main0 () =
{
//
var A = @[double][3](1.0) // initialized with 1.0, 1.0, 1.0
var B = @[double](1.0, 2.0, 3.0) // initialized with 1.0, 2.0, 3.0
//
val () = println! ("A * B = ", dotprod (A, B)) // A * B = 6.0
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [dotprod.dats] *)
