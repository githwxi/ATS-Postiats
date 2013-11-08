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
** Example: Merge Sort
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: February, 2011
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

typedef
lte (a:t@ype) = (a, a) -> bool

(* ****** ****** *)

fun{
a:t@ype
} merge
  {m,n:nat} .<m+n>.
(
  xs: list (a, m)
, ys: list (a, n)
, lte: lte a
) : list (a, m+n) =
  case+ xs of
  | list_nil () => ys
  | list_cons (x, xs1) => (
    case+ ys of
    | list_cons (y, ys1) =>
        if x \lte y then
          list_cons{a}(x, merge<a> (xs1, ys, lte))
        else
          list_cons{a}(y, merge<a> (xs, ys1, lte))
        // end of [if]
    | list_nil () => xs
    ) // end of [list_cons]
// end of [merge]

fun{
a:t@ype
} mergesort{n:nat}
(
  xs: list (a, n), lte: lte a
) : list (a, n) = let
//
fun msort{n:nat} .<n,n>.
(
  xs: list (a, n), n: int n, lte: lte a
) : list (a, n) =
  if n >= 2 then split (xs, n, lte, half(n), list_nil) else xs
and split
  {n:int | n >= 2}
  {i:nat | i <= n/2} .<n,i>. (
  xs: list (a, n-n/2+i)
, n: int n, lte: lte a, i: int i, xsf: list (a, n/2-i)
) : list (a, n) =
  if i > 0 then let
    val+ list_cons (x, xs) = xs
  in
    split (xs, n, lte, i-1, list_cons{a}(x, xsf))
  end else let
    val xsf = list_reverse<a> (xsf) // make sorting stable!
    val xsf = list_of_list_vt (xsf)
    val xsf = msort (xsf, half(n), lte) and xs = msort (xs, n-half(n), lte)
  in
    merge<a> (xsf, xs, lte)
  end // end of [if]
//
val n = list_length<a> (xs)
//
in
  msort (xs, n, lte)
end // end of [mergesort]

(* ****** ****** *)

typedef T1 = int
typedef T2 = double

(* ****** ****** *)

implement
main0 () =
{
//
#define N 10
//
val xs1 = $list{T1}(0, 2, 4, 6, 8, 9, 7, 5, 3, 1)
val () = begin
  print "input:\t"; fprint_list_sep (stdout_ref, xs1, ", "); print_newline ()
end // end of [val]
val ys1 = mergesort<T1> (xs1, lam (x, y) => (x <= y))
val () = begin
  print "output:\t"; fprint_list_sep (stdout_ref, ys1, ", "); print_newline ()
end // end of [val]
//
val xs2 = $list{T2}(0., 2., 4., 6., 8., 9., 7., 5., 3., 1.)
val () = begin
  print "input:\t"; fprint_list_sep (stdout_ref, xs2, ", "); print_newline ()
end // end of [val]
val ys2 = mergesort<T2> (xs2, lam (x, y) => (x <= y))
val () = begin
  print "output:\t"; fprint_list_sep (stdout_ref, ys2, ", "); print_newline ()
end // end of [val]
//
} // end of [main]

(* ****** ****** *)

(* end of [mergesort.dats] *)
