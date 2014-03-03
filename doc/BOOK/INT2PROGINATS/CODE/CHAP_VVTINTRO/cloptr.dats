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
** Time: Marck, 2014
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun{
a:t@ype}{b:vt@ype
} list_map_cloptr{n:int}
(
  xs: list (a, n), f: !(a) -<cloptr1> b
) : list_vt (b, n) =
(
  case+ xs of
  | list_nil () => list_vt_nil ()
  | list_cons (x, xs) => list_vt_cons (f (x), list_map_cloptr<a><b> (xs, f))
)

(* ****** ****** *)

implement
main0 () =
{
//
val xs =
$list_vt{int}(0, 1, 2, 3, 4)
//
val len = list_vt_length (xs)
//
val f = lam (x: int): int =<cloptr1> x * len
val ys =
list_map_cloptr<int><int> ($UNSAFE.list_vt2t(xs), f)
val () = cloptr_free($UNSAFE.castvwtp0{cloptr(void)}(f))
//
val () = println! ("xs = ", xs) // xs = 0, 1, 2, 3, 4
val () = println! ("ys = ", ys) // ys = 0, 5, 10, 15, 20
//
val ((*freed*)) = list_vt_free (xs)
val ((*freed*)) = list_vt_free (ys)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [cloptr.dats] *)
