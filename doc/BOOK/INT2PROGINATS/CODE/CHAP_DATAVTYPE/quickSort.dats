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
** Quick-Sort on Lists
**
** Author: Hongwei Xi (gmhwxiATgmailDOTcom)
** Start Time: February, 2014
*)

(* ****** ****** *)
//
// HX-2014-02-10: Ported to ATS2
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./insertionSort.dats"

(* ****** ****** *)
//
extern
fun{
a:t@ype
} quickSort{n:nat}
  (xs: list_vt (a, n), cmp: cmp a): list_vt (a, n)
//
(* ****** ****** *)

fun{a:t@ype}
takeout_node_at
  {n:int}{k:nat | k < n}
(
  xs: &list_vt (a, n) >> list_vt (a, n-1), k: int(k)
) : list_vt_cons_pstruct (a, ptr?) =
(
//
if k > 0 then let
  val+@list_vt_cons (x, xs1) = xs
  val res = takeout_node_at<a> (xs1, k-1)
  prval () = fold@ (xs)
in
  res
end else let
  val+@list_vt_cons (x, xs1) = xs
  val nx = xs
  val () = xs := xs1
in
  $UNSAFE.castvwtp0 ((view@x, view@xs1 | nx))
end // end of [if]
//
) (* end of [takeout_node_at] *)

(* ****** ****** *)

fun{
a:t@ype
} partition{n,r1,r2:nat}
(
  xs: list_vt (a, n), pvt: &a
, r1: int(r1), res1: list_vt (a, r1), res2: list_vt (a, r2)
, cmp: cmp (a)
) : [n1,n2:nat | n1+n2==n+r1+r2]
  (int(n1), list_vt (a, n1), list_vt (a, n2)) =
(
  case+ xs of
  | @list_vt_cons
      (x, xs_tail) => let
      val xs_tail_ = xs_tail
      val sgn = compare<a> (x, pvt, cmp)
    in
      if sgn <= 0 then let
        val r1 = r1 + 1
        val () = xs_tail := res1
        prval () = fold@ (xs)
      in
        partition<a> (xs_tail_, pvt, r1, xs, res2, cmp)
      end else let
        val () = xs_tail := res2
        prval () = fold@ (xs)
      in
        partition<a> (xs_tail_, pvt, r1, res1, xs, cmp)
      end // end of [if]
    end (* end of [list_vt_cons] *)
  | ~list_vt_nil ((*void*)) => (r1, res1, res2)
) (* end of [partition] *)

(* ****** ****** *)

implement
{a}(*tmp*)
quickSort
  (xs, cmp) = let
//
fun sort{n:nat}
(
  xs: list_vt (a, n), n: int n
) : list_vt (a, n) =
(
  if n > 10 then let
    val n2 = half (n)
    var xs = xs
    val nx = takeout_node_at<a> (xs, n2)
    val+list_vt_cons (pvt, nx_next) = nx
    val (n1, xs1, xs2) =
    partition<a> (xs, pvt, 0, list_vt_nil, list_vt_nil, cmp)
    val xs1 = sort (xs1, n1)
    val xs2 = sort (xs2, n - 1 - n1)
    val () = nx_next := xs2
    prval () = fold@ (nx)
  in
    list_vt_append (xs1, nx)
  end else insertionSort<a> (xs, cmp)
) (* end of [sort] *)
//
in
  sort (xs, list_vt_length (xs))
end // end of [quickSort]

(* ****** ****** *)

implement
main0 () = () where
{
//
stadef T = int
//
implement
compare<T> (x, y, _) = x - y
//
val xs1 = $list_vt{T}(3, 2, 5, 4, 8, 7, 6, 9, 1, 0)
val xs2 = $list_vt{T}(3, 2, 5, 4, 8, 7, 6, 9, 1, 0)
val xs12 = list_vt_append (xs1, xs2)
val xs12 = quickSort<T> (xs12, $UNSAFE.cast{cmp(T)}(0))
//
val () = list_vt_foreach_fun<T> (xs12, lam (x) =<1> print (x))
val () = print_newline ()
//
val () = list_vt_free (xs12)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [quickSort.dats] *)
