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

fun foo
(
  x: int, y: int
) : int = let
//
var bar = lam@ (): int => x * y
//
in
  bar ()
end // end of [foo]

(* ****** ****** *)

fun foo2
(
  x: int, y: int
) : int = let
//
var bar2 = fix@ f (x: int): int => if x > 0 then y + f(x-1) else 0
//
in
  bar2 (x)
end // end of [foo]

(* ****** ****** *)

implement
main0 () =
{
val () = println! ("foo (10, 10) = ", foo (10, 11))
val () = println! ("foo2 (10, 10) = ", foo2 (10, 11))
}

(* ****** ****** *)

(* end of [stkclo.dats] *)
