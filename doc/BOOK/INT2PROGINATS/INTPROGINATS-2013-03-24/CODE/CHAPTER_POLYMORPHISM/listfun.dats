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
list0_append (
  xs: list0 a, ys: list0 a
) : list0 a = case+ xs of
  | list0_cons (x, xs) => list0_cons (x, list0_append (xs, ys))
  | list0_nil () => ys
// end of [list0_append]

fun{a:t@ype}
list0_reverse_append (
  xs: list0 a, ys: list0 a
) : list0 a = case+ xs of
  | list0_cons (x, xs) => list0_reverse_append (xs, list0_cons (x, ys))
  | list0_nil () => ys
// end of [list0_reverse_append]

fun{a:t@ype}
list0_reverse
  (xs: list0 a): list0 a = list0_reverse_append (xs, list0_nil)
// end of [list0_reverse]

(* ****** ****** *)

fun{a:t@ype}{b:t@ype}
list0_map (
  xs: list0 a, f: a -<cloref1> b
) : list0 b = case+ xs of
  | list0_cons (x, xs) => list0_cons (f x, list0_map (xs, f))
  | list0_nil () => list0_nil ()
// end of [list0_map]

(* ****** ****** *)

fun{a,b:t@ype}
list0_zip (
  xs: list0 a, ys: list0 b
) : list0 @(a, b) = case+ (xs, ys) of
  | (list0_cons (x, xs),
     list0_cons (y, ys)) => list0_cons ((x, y), list0_zip (xs, ys))
  | (_, _) => list0_nil ()
// end of [list0_zip]

fun{a,b:t@ype}{c:t@ype}
list0_zipwith (
  xs: list0 a, ys: list0 b, f: (a, b) -<cloref1> c
) : list0 c = case+ (xs, ys) of
  | (list0_cons (x, xs), list0_cons (y, ys)) =>
      list0_cons (f (x, y), list0_zipwith (xs, ys, f))
  | (_, _) => list0_nil ()
// end of [list0_zipwith]

(* ****** ****** *)

extern fun{a:t@ype} eq (x: a, y: a): bool

fun{a:t@ype}
eq_list0_list0 (
  xs: list0 a, ys: list0 a
) : bool =
  case+ (xs, ys) of
  | (list0_cons (x, xs), list0_cons (y, ys)) =>
      if eq (x, y) then eq_list0_list0 (xs, ys) else false
  | (list0_nil (), list0_nil ()) => true
  | (_, _) => false
// end of [eq_list0_list0]
overload = with eq_list0_list0

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
  val xs1 = list0_randgen<T> (N1)
  val xs2 = list0_randgen<T> (N2)
//
  val () = assertloc (
    list0_reverse_append<T> (xs1, xs2)
  = list0_append (list0_reverse<T> (xs1), xs2)
  ) // end of [val]
//
  typedef T2 = (T, T)
  val ys = list0_map<T2><T>
    (list0_zip (xs1, xs2), lam xx => xx.0 + xx.1)
  val zs = list0_zipwith<T,T><T> (xs1, xs2, lam (x1, x2) => x1 + x2)
  val () = assertloc (ys = zs)
//
} // end of [main]

(* ****** ****** *)

(* end of [listfun.dats] *)
