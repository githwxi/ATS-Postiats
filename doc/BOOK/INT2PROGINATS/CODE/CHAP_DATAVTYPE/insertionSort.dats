(*
** Copyright (C) 2014 Hongwei Xi, Boston University
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
** Standard Insertion Sort
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: February, 2014
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

typedef cmp (a:t@ype) = (&a, &a) -> int

(* ****** ****** *)

extern
fun{a:t@ype}
compare (x: &a, y: &a, cmp: cmp (a)): int

(* ****** ****** *)
//
extern
fun{
a:t@ype
} insertionSort{n:nat}
  (xs: list_vt (a, n), cmp: cmp a): list_vt (a, n)
//
(* ****** ****** *)

fun{
a:t@ype
} insord{l0,l1,l2:addr}{n:nat}
(
  pf1: a @ l1
, pf2: list_vt (a, 0)? @ l2
| xs0: &list_vt (a, n) >> list_vt (a, n+1)
, nx0: list_vt_cons_unfold (l0, l1, l2), p1: ptr (l1), p2: ptr (l2)
, cmp: cmp (a)
) : void =
(
  case+ xs0 of
  | @list_vt_cons
      (x0, xs1) => let
      val sgn = compare<a> (x0, !p1, cmp)
    in
      if sgn <= 0
        then let
          val () = insord<a> (pf1, pf2 | xs1, nx0, p1, p2, cmp)
          prval () = fold@ (xs0)
        in
          // nothing
        end // end of [then]
        else let
          prval () = fold@ (xs0)
          val () = (!p2 := xs0; xs0 := nx0)
          prval () = fold@ (xs0)
        in
          // nothing
        end // end of [else]
      // end of [if]
    end // end of [list_vt_cons]
  | ~list_vt_nil () =>
    {
      val () = xs0 := nx0
      val () = !p2 := list_vt_nil ()
      prval () = fold@ (xs0)
    }
) (* end of [insord] *)

(* ****** ****** *)

implement{a}
insertionSort
  (xs, cmp) = let
//
fun loop{m,n:nat}
(
  xs: list_vt (a, m)
, ys: &list_vt (a, n) >> list_vt (a, m+n)
, cmp: cmp (a)
) : void =
  case+ xs of
  | @list_vt_cons
      (x, xs1) => let
      val xs1_ = xs1
      val ((*void*)) =
        insord<a> (view@x, view@xs1 | ys, xs, addr@x, addr@xs1, cmp)
      // end of [val]
    in
      loop (xs1_, ys, cmp)
    end // end of [list_vt_cons]
  | ~list_vt_nil ((*void*)) => ()
//
var ys = list_vt_nil{a}()
val () = loop (xs, ys, cmp)
//
in
  ys
end // end of [insertionSort]

(* ****** ****** *)

implement
main0 () = () where
{
//
stadef T = int
//
implement
compare<T> (x, y, _) = x-y
//
val xs = $list_vt{T}(3, 2, 5, 4, 8, 7, 6, 9, 1, 0)
val xs = insertionSort<T> (xs, $UNSAFE.cast{cmp(T)}(0))
//
val () = list_vt_foreach_fun<T> (xs, lam (x) =<1> print (x))
val () = print_newline ()
//
val () = list_vt_free (xs)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [insertionSort.dats] *)
