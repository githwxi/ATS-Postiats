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

fun{a:t@ype}
list_append
  {m,n:nat} .<m>. (
  xs: list (a, m), ys: list (a, n)
) : list (a, m+n) = case+ xs of
  | list_cons (x, xs) => list_cons (x, list_append (xs, ys))
  | list_nil () => ys
// end of [list_append]

fun{a:t@ype}
list_reverse_append
  {m,n:nat} .<m>. (
  xs: list (a, m), ys: list (a, n)
) : list (a, m+n) = case+ xs of
  | list_cons (x, xs) =>
      list_reverse_append (xs, list_cons (x, ys))
  | list_nil () => ys
// end of [list_reverse_append]

fun{a:t@ype}
list_reverse {n:nat}
  (xs: list (a, n)): list (a, n) = list_reverse_append (xs, list_nil)
// end of [list_reverse]

fun{a:t@ype}{b:t@ype}
list_map {n:nat} .<n>. (
  xs: list (a, n), f: a -<cloref1> b
) : list (b, n) = case+ xs of
  | list_cons (x, xs) => list_cons (f x, list_map (xs, f))
  | list_nil () => list_nil ()
// end of [list_map]

fun{a,b:t@ype}
list_zip {n:nat} .<n>. (
  xs: list (a, n), ys: list (b, n)
) : list ((a, b), n) = case+ (xs, ys) of
  | (list_cons (x, xs),
     list_cons (y, ys)) => list_cons ((x, y), list_zip (xs, ys))
  | (list_nil (), list_nil ()) => list_nil ()
// end of [list_zip]

fun{a,b:t@ype}{c:t@ype}
list_zipwith
  {n:nat} .<n>. (
  xs: list (a, n)
, ys: list (b, n)
, f: (a, b) -<cloref1> c
) : list (c, n) = case+ (xs, ys) of
  | (list_cons (x, xs), list_cons (y, ys)) =>
      list_cons (f (x, y), list_zipwith (xs, ys, f))
  | (list_nil (), list_nil ()) => list_nil ()
// end of [list_zipwith]

(* ****** ****** *)

extern fun{a:t@ype} eq (x: a, y: a): bool

fun{a:t@ype}
eq_list_list {n:nat} (
  xs: list (a, n), ys: list (a, n)
) : bool =
  case+ (xs, ys) of
  | (list_cons (x, xs), list_cons (y, ys)) =>
      if eq (x, y) then eq_list_list (xs, ys) else false
  | (list_nil (), list_nil ()) => true
// end of [eq_list_list]
overload = with eq_list_list

(* ****** ****** *)

staload "libc/SATS/random.sats"

staload "contrib/testing/SATS/randgen.sats"
staload _(*anon*) = "contrib/testing/DATS/randgen.dats"
staload "contrib/testing/SATS/fprint.sats"
staload _(*anon*) = "contrib/testing/DATS/fprint.dats"

(* ****** ****** *)

typedef T = double
implement eq<T> (x, y) = x = y
implement randgen<T> () = drand48 ()
implement fprint_elt<T> (out, x) = fprint_double (out, x)

(* ****** ****** *)

implement
main () = () where {
  #define N1 10
  #define N2 10
  val xs1 = list_randgen<T> (N1)
  val xs2 = list_randgen<T> (N2)
//
  val () = assertloc (
    list_reverse_append<T> (xs1, xs2)
  = list_append (list_reverse<T> (xs1), xs2)
  ) // end of [val]
//
  typedef T2 = (T, T)
  val ys = list_map<T2><T>
    (list_zip (xs1, xs2), lam xx => xx.0 + xx.1)
  val zs = list_zipwith<T,T><T> (xs1, xs2, lam (x1, x2) => x1 + x2)
  val () = assertloc (ys = zs)
//
} // end of [main]

(* ****** ****** *)

(* end of [listfun.dats] *)
