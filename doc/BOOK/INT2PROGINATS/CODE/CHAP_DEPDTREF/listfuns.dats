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
** Example: Some Function Templates on Lists.
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun{
a:t@ype
} list_append
  {m,n:nat} .<m>.
(
  xs: list (a, m)
, ys: list (a, n)
) : list (a, m+n) = case+ xs of
  | list_nil () => ys
  | list_cons (x, xs) =>
      list_cons{a}(x, list_append<a> (xs, ys))
// end of [list_append]

(* ****** ****** *)

fun{
a:t@ype
} list_reverse_append
  {m,n:nat} .<m>. (
  xs: list (a, m), ys: list (a, n)
) : list (a, m+n) = case+ xs of
  | list_cons (x, xs) =>
      list_reverse_append<a> (xs, list_cons{a}(x, ys))
  | list_nil () => ys
// end of [list_reverse_append]

(* ****** ****** *)

fun{
a:t@ype
} list_reverse {n:nat}
  (xs: list (a, n)): list (a, n) = list_reverse_append<a> (xs, list_nil)
// end of [list_reverse]

(* ****** ****** *)

fun{
a:t@ype}
{b:t@ype
} list_map {n:nat} .<n>. (
  xs: list (a, n), f: a -<cloref1> b
) : list (b, n) = case+ xs of
  | list_cons (x, xs) => list_cons{b}(f x, list_map (xs, f))
  | list_nil () => list_nil ()
// end of [list_map]

(* ****** ****** *)

fun{
a,b:t@ype
} list_zip {n:nat} .<n>.
(
  xs: list (a, n), ys: list (b, n)
) : list ((a, b), n) =
(
  case+ (xs, ys) of
  | (list_cons (x, xs),
     list_cons (y, ys)) =>
      list_cons{(a, b)}((x, y), list_zip<a,b> (xs, ys))
  | (list_nil (), list_nil ()) => list_nil ()
) (* end of [list_zip] *)

(* ****** ****** *)

fun{
a,
b:t@ype}
{c:t@ype
} list_zipwith
  {n:nat} .<n>.
  (
  xs: list (a, n)
, ys: list (b, n)
, f: (a, b) -<cloref1> c
) : list (c, n) = case+ (xs, ys) of
  | (list_cons (x, xs),
     list_cons (y, ys)) =>
      list_cons{c}(f (x, y), list_zipwith<a,b><c> (xs, ys, f))
  | (list_nil (), list_nil ()) => list_nil ()
// end of [list_zipwith]

(* ****** ****** *)
//
typedef T = int
typedef T2 = (T, T)
//
(* ****** ****** *)

implement
main0 () =
{
//
#define N1 5
#define N2 5
//
val xs1 = list_vt2t((list)$arrpsz{T}(0, 1, 2, 3, 4))
val xs2 = list_vt2t((list)$arrpsz{T}(5, 6, 7, 8, 9))
//
val () =
assertloc (
  list_reverse_append<T> (xs1, xs2)
= list_append<T> (list_reverse<T> (xs1), xs2)
) // end of [val]
//
val ys = list_map<T2><T>
  (list_zip<T,T>(xs1, xs2), lam xx => xx.0 + xx.1)
val zs = list_zipwith<T,T><T> (xs1, xs2, lam (x1, x2) => x1 + x2)
val () = assertloc (ys = zs)
//
} // end of [main0]

(* ****** ****** *)

(* end of [listfun.dats] *)
