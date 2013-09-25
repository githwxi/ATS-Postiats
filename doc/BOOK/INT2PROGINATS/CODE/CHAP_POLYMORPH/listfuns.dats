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
*)

(*
**
** Author: Hongwei Xi
** Authoremail: hwxiATcsDOTbuDOTedu
** Time: January, 2011
*)

(* ****** ****** *)

(*
** Ported to ATS2 by HX-2013-09
*)

(* ****** ****** *)

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload _(*anon*) = "libats/ML/DATS/list0.dats"

(* ****** ****** *)

fun{a:t@ype}
list0_append
(
  xs: list0 a, ys: list0 a
) : list0 a =
(
  case+ xs of
  | list0_cons (x, xs) =>
      list0_cons{a}(x, list0_append<a> (xs, ys))
  | list0_nil () => ys
) (* end of [list0_append] *)

fun{a:t@ype}
list0_reverse_append
(
  xs: list0 a, ys: list0 a
) : list0 a =
(
  case+ xs of
  | list0_cons
      (x, xs) =>
      list0_reverse_append<a> (xs, list0_cons{a}(x, ys))
  | list0_nil ((*void*)) => ys
) (* end of [list0_reverse_append] *)

fun{a:t@ype}
list0_reverse
  (xs: list0 a): list0 a = list0_reverse_append<a> (xs, list0_nil)
// end of [list0_reverse]

(* ****** ****** *)

fun
{a:t@ype}
{b:t@ype}
list0_map
(
  xs: list0 a, f: a -<cloref1> b
) : list0 b =
(
  case+ xs of
  | list0_cons
      (x, xs) =>
      list0_cons{b}(f x, list0_map<a> (xs, f))
  | list0_nil ((*void*)) => list0_nil ()
) (* end of [list0_map] *)

(* ****** ****** *)

fun{
a,b:t@ype
} list0_zip
(
  xs: list0 a
, ys: list0 b
) : list0 @(a, b) = let
  typedef ab = @(a, b)
in
  case+ (xs, ys) of
  | (list0_cons (x, xs),
     list0_cons (y, ys)) => list0_cons{ab}((x, y), list0_zip<a,b> (xs, ys))
  | (_, _) => list0_nil ()
end (* end of [list0_zip] *)

(* ****** ****** *)

fun
{a,b:t@ype}
{c:t@ype}
list0_zipwith
(
  xs: list0 a
, ys: list0 b
, f: (a, b) -<cloref1> c
) : list0 c =
(
  case+ (xs, ys) of
  | (list0_cons (x, xs),
     list0_cons (y, ys)) =>
      list0_cons{c} (f (x, y), list0_zipwith<a,b><c> (xs, ys, f))
  | (_, _) => list0_nil ()
) // end of [list0_zipwith]

(* ****** ****** *)

staload "libc/SATS/stdlib.sats"
staload "{$LIBATSHWXI}/testing/SATS/randgen.sats"
staload _(*anon*) = "{$LIBATSHWXI}/testing/DATS/randgen.dats"

(* ****** ****** *)

typedef T = double
implement randgen_val<T> () = drand48 ()

(* ****** ****** *)

implement
main0 () =
{
//
#define N1 10
#define N2 10
//
val xs1 = g0ofg1(randgen_list<T> (N1))
val xs2 = g0ofg1(randgen_list<T> (N2))
//
typedef T2 = (T, T)
//
val ys =
list0_map<T2><T>
  (list0_zip<T,T> (xs1, xs2), lam xx => xx.0 + xx.1)
//
val zs =
list0_zipwith<T,T><T> (xs1, xs2, lam (x1, x2) => x1 + x2)
//
val ((*void*)) = assertloc (g1ofg0(ys) = g1ofg0(zs))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [listfun.dats] *)
