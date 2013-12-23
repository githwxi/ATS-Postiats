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
** Time: January, 2011
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/list0.dats"

(* ****** ****** *)

#define nil list0_nil
#define cons list0_cons

(* ****** ****** *)

typedef lte (a:t@ype) = (a, a) -> bool

fun{a:t@ype}
merge (
  xs: list0 a, ys: list0 a, lte: lte a
) : list0 a =
  case+ xs of
  | cons (x, xs1) => (
    case+ ys of
    | cons (y, ys1) =>
        if x \lte y then
          cons (x, merge (xs1, ys, lte))
        else
          cons (y, merge (xs, ys1, lte))
        // end of [if]
    | nil () => xs
    ) // end of [cons]
  | nil () => ys
// end of [merge]

fun{a:t@ype}
mergesort
  (xs: list0 a, lte: lte a): list0 a = let
  val n = list0_length<a> (xs)
  fun msort (
    xs: list0 a, n: int, lte: lte a
  ) : list0 a =
    if n >= 2 then split (xs, n, lte, n/2, nil) else xs
  and split (
    xs: list0 a, n: int, lte: lte a, i: int, xsf: list0 a
  ) : list0 a =
    if i > 0 then let
      val- cons (x, xs) = xs
    in
      split (xs, n, lte, i-1, cons (x, xsf))
    end else let
      val xsf = list0_reverse<a> (xsf) // make sorting stable!
      val xsf = msort (xsf, n/2, lte) and xs = msort (xs, n-n/2, lte)
    in
      merge (xsf, xs, lte)
    end // end of [if]
in
  msort (xs, n, lte)
end // end of [mergesort]

(* ****** ****** *)

staload "libc/SATS/random.sats"

staload "contrib/testing/SATS/randgen.sats"
staload _(*anon*) = "contrib/testing/DATS/randgen.dats"
staload "contrib/testing/SATS/fprint.sats"
staload _(*anon*) = "contrib/testing/DATS/fprint.dats"

(* ****** ****** *)

typedef T1 = int

macdef INTMAX = 1000L

implement randgen<T1> () = let
  val x = lrand48 () mod INTMAX in int_of_lint (x)
end // end of [randgen]

implement fprint_elt<T1> (out, x) = fprintf (out, "%3.3i", @(x))

(* ****** ****** *)

typedef T2 = double
implement randgen<T2> () = drand48 ()
implement fprint_elt<T2> (out, x) = fprint_double (out, x)

(* ****** ****** *)

implement
main () = () where {
//
  val () = srand48_with_time ()
//
  #define N 10
//
  val xs1 = list0_randgen<T1> (N)
  val () = begin
    print "input:\t"; list0_fprint_elt (stdout_ref, xs1, ", "); print_newline ()
  end // end of [val]
  val ys1 = mergesort<T1> (xs1, lam (x, y) => (x <= y))
  val () = begin
    print "output:\t"; list0_fprint_elt (stdout_ref, ys1, ", "); print_newline ()
  end // end of [val]
//
  val xs2 = list0_randgen<T2> (N)
  val () = begin
    print "input:\t"; list0_fprint_elt (stdout_ref, xs2, ", "); print_newline ()
  end // end of [val]
  val ys2 = mergesort<T2> (xs2, lam (x, y) => (x <= y))
  val () = begin
    print "output:\t"; list0_fprint_elt (stdout_ref, ys2, ", "); print_newline ()
  end // end of [val]
//
} // end of [main]

(* ****** ****** *)

(* end of [mergesort.dats] *)
