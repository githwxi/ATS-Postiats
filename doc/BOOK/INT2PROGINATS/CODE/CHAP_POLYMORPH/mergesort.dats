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
** Example:
** A Functional Implementation of Mergesort
*)

(* ****** ****** *)

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

typedef lte (a:t@ype) = (a, a) -> bool

fun{
a:t@ype
} merge (
  xs: list0 a, ys: list0 a, lte: lte a
) : list0 a =
(
  case+ xs of
  | cons0 (x, xs1) => (
    case+ ys of
    | cons0 (y, ys1) =>
        if x \lte y then
          cons0{a}(x, merge<a> (xs1, ys, lte))
        else
          cons0{a}(y, merge<a> (xs, ys1, lte))
        // end of [if]
    | nil0 () => xs
    ) // end of [cons0]
  | nil0 () => ys
) (* end of [merge] *)

fun{
a:t@ype
} mergesort
(
  xs: list0 a, lte: lte a
) : list0 a = let
//
val n = list0_length<a> (xs)
//
fun msort
(
  xs: list0 a, n: int, lte: lte a
) : list0 a =
  if n >= 2 then split (xs, n, lte, n/2, nil0) else xs
//
and split
(
  xs: list0 a, n: int, lte: lte a, i: int, xsf: list0 a
) : list0 a =
  if i > 0 then let
    val-cons0 (x, xs) = xs
  in
    split (xs, n, lte, i-1, cons0{a}(x, xsf))
  end else let
    val xsf = list0_reverse<a> (xsf) // make sorting stable!
    val xsf = msort (xsf, n/2, lte) and xs = msort (xs, n-n/2, lte)
  in
    merge<a> (xsf, xs, lte)
  end // end of [if]
//
in
  msort (xs, n, lte)
end // end of [mergesort]

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/time.sats"
staload "libc/SATS/stdlib.sats"
staload "{$LIBATSHWXI}/testing/SATS/randgen.sats"
staload _(*anon*) = "{$LIBATSHWXI}/testing/DATS/randgen.dats"

(* ****** ****** *)

typedef T1 = int
macdef INTMAX = 1000L
implement
randgen_val<T1> () = let
  val x = lrand48 () mod INTMAX in $UN.cast2int(x)
end // end of [randgen]

(* ****** ****** *)

typedef T2 = double
implement randgen_val<T2> () = drand48 ()

(* ****** ****** *)

implement
main0 () =
{
//
#define N 10
//
val out = stdout_ref
//
val () =
  srand48 ($UN.cast2lint(time_get()))
//
val xs1 = randgen_list<T1> (N)
val () = fprintln! (out, "input:\t", xs1)
val xs1 = g0ofg1 (xs1)
val ys1 = mergesort<T1> (xs1, lam (x, y) => (x <= y))
val ys1 = g1ofg0 (ys1)
val () = fprintln! (out, "output:\t", ys1)
//
val xs2 = randgen_list<T2> (N)
val () = fprintln! (out, "input:\t", xs2)
val xs2 = g0ofg1 (xs2)
val ys2 = mergesort<T2> (xs2, lam (x, y) => (x <= y))
val ys2 = g1ofg0 (ys2)
val () = fprintln! (out, "output:\t", ys2)
//
} // end of [main]

(* ****** ****** *)

(* end of [mergesort.dats] *)
