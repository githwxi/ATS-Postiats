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
** Top-down Mergesort on Lists
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

typedef cmp (a:t@ype) = (&a, &a) -> int

(* ****** ****** *)

extern
fun{a:t@ype}
compare (x: &a, y: &a, cmp: cmp (a)): int

(* ****** ****** *)

extern
fun{a:t@ype}
mergesort {n:nat}(xs: list_vt (a, n), cmp: cmp a): list_vt (a, n)

(* ****** ****** *)

fun{a:t@ype}
merge {m,n:nat} .<m+n>. (
  xs: list_vt (a, m), ys: list_vt (a, n)
, res: &List_vt(a)? >> list_vt (a, m+n)
, cmp: cmp a
) : void =
  case+ xs of
  | list_vt_cons (!p_x, !p_xs1) => (case+ ys of
    | list_vt_cons (!p_y, !p_ys1) => let
        val sgn = compare<a> (!p_x, !p_y, cmp)
      in
        if sgn <= 0 then let // stable sorting
          val () = res := xs
          val xs1 = !p_xs1
          val () = fold@ (ys)
          val () = merge (xs1, ys, !p_xs1, cmp)
        in
          fold@ (res)
        end else let
          val () = res := ys
          val ys1 = !p_ys1
          val () = fold@ (xs)
          val () = merge (xs, ys1, !p_ys1, cmp)
        in
          fold@ (res)
        end // end of [if]
      end (* end of [list_vt_cons] *)
    | ~list_vt_nil () => (fold@ (xs); res := xs)
    ) // end of [list_vt_cons]
  | ~list_vt_nil () => (res := ys)
// end of [merge]

(* ****** ****** *)

fun{a:t@ype}
split {n,k:nat | k <= n} .<n-k>. (
  xs: &list_vt (a, n) >> list_vt (a, n-k), nk: int (n-k)
) : list_vt (a, k) =
  if nk > 0 then let
    val+ list_vt_cons (_, !p_xs1) = xs
    val res = split (!p_xs1, nk-1); val () = fold@ (xs)
  in
    res
  end else let
    val res = xs; val () = xs := list_vt_nil () in res
  end // end of [if]
// end of [split]

(* ****** ****** *)

fun{a:t@ype}
msort {n:nat} .<n>. (
  xs: list_vt (a, n), n: int n, cmp: cmp(a)
) : list_vt (a, n) =
  if n >= 2 then let
    val n2 = n / 2
    val n3 = n - n2
    var xs = xs // a left-value for [xs]
    val ys = split {n,n/2} (xs(*cbr*), n3)
    val xs = msort (xs, n3, cmp)
    val ys = msort (ys, n2, cmp)
    var res: List_vt (a)
    val () = merge (xs, ys, res(*cbr*), cmp)
  in
    res
  end else xs
// end of [msort]

(* ****** ****** *)

macdef length = list_vt_length

implement{a}
mergesort (xs, cmp) = msort (xs, length (xs), cmp)

(* ****** ****** *)

implement
main () =
{
//
stadef T = int
//
val xs =
list_vt_of_arrpsz<T> ($arrpsz(3, 2, 5, 4, 8, 7, 6, 9, 1, 0))
//
val cmp = $extval (cmp(T), "0")
//
implement
compare<T> (x, y, _) = x-y
//
val xs = mergesort (xs, cmp)
//
val () = list_vt_foreach_fun<T> (xs, lam (x) =<1> print (x))
val () = print_newline ()
//
val () = list_vt_free (xs)
} // end of [main]

(* ****** ****** *)

(* end of [mergesort.dats] *)
