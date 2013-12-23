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
** Linear Lists
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*)

(* ****** ****** *)

(*
dataviewtype
list_vt (a:t@ype+, int) =
  | {n:nat}
    list_vt_cons (a, n+1) of (a, list_vt (a, n))
  | list_vt_nil(a, 0) of ()
// end of [list_vt]
*)

(* ****** ****** *)

(*
#define nil list_vt_nil
#define cons list_vt_cons
*)

(* ****** ****** *)

fn{a:t@ype}
length {n:nat}
  (xs: !list_vt (a, n)): int n = let
  fun loop
    {i,j:nat | i+j==n} .<i>.
    (xs: !list_vt (a, i), j: int j): int (n) =
    case+ xs of
    | list_vt_cons (_, !p_xs1) => let
        val n = loop (!p_xs1, j+1); val () = fold@ (xs) in n
      end // end of [list_vt_cons]
    | list_vt_nil () => (fold@ (xs); j)
  // end of [loop]
in
  loop (xs, 0)
end // end of [length]

(* ****** ****** *)

fun{a:t@ype}
list_vt_free
  {n:nat} .<n>. (xs: list_vt (a, n)): void =
  case+ xs of
  | ~list_vt_cons (x, xs1) => list_vt_free (xs1) // [x] can be replaced with [_]
  | ~list_vt_nil () => ()
// end of [list_vt_free]

fun{a:t@ype}
list_vt_free
  {n:nat} .<n>. (xs: list_vt (a, n)): void =
  case+ xs of
  | list_vt_cons (x, xs1) => (free@ {a} {0} (xs); list_vt_free (xs1))
  | list_vt_nil () => free@ {a} (xs)
// end of [list_vt_free]

(* ****** ****** *)

fn{a:t@ype}
reverse {n:nat}
  (xs: list_vt (a, n)): list_vt (a, n) = let
  fun revapp
    {i,j:nat | i+j==n} .<i>.
    (xs: list_vt (a, i), ys: list_vt (a, j)): list_vt (a, n) =
    case+ xs of
    | list_vt_cons (_, !p_xs1) => let
        val xs1 = !p_xs1; val () = !p_xs1 := ys; val () = fold@ (xs)
      in
        revapp (xs1, xs)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => ys
  // end of [revapp]
in
  revapp (xs, list_vt_nil)
end // end of [reverse]

(* ****** ****** *)

fn{a:t@ype}
append {m,n:nat} (
  xs: list_vt (a, m), ys: list_vt (a, n)
) : list_vt (a, m+n) = let
  fun loop {m,n:nat} .<m>.
    (xs: &list_vt (a, m) >> list_vt (a, m+n), ys: list_vt (a, n)): void =
    case+ xs of
    | list_vt_cons (_, !p_xs1) => let
        val () = loop (!p_xs1, ys) in fold@ (xs)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => xs := ys
  // end of [loop]
  var xs: List_vt (a) = xs // creating a left-value for [xs]
  val () = loop (xs, ys)
in
  xs
end // end of [append]

(* ****** ****** *)

fun{a:t@ype}
append1 {m,n:nat}
  (xs: list (a, m), ys: list (a, n)): list (a, m+n) =
  case+ xs of
  | list_cons (x, xs) => list_cons (x, append1 (xs, ys))
  | list_nil () => ys
// end of [append1]

fun{a:t@ype}
append2 {m,n:nat} (
  xs: list (a, m)
, ys: list (a, n)
) : list (a, m+n) = let
  fun loop
    {m,n:nat} .<m>. (
    xs: list (a, m)
  , ys: list (a, n)
  , res: &(List a)? >> list (a, m+n)
  ) :<> void = begin case+ xs of
    | list_cons (x, xs) => let
        val () = (res := list_cons {a} {0} (x, ?))
        val+ list_cons (_, !p) = res
        val () = loop (xs, ys, !p)
      in
        fold@ res
      end // end of [list_cons]
    | list_nil () => (res := ys)
  end // end of [loop]
  var res: List a // uninitialized variable
  val () = loop (xs, ys, res)
in
  res
end // end of [append2]

(* ****** ****** *)

(* end of [list_vt.dats] *)
