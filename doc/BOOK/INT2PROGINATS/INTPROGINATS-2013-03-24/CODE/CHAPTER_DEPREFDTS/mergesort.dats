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

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

typedef lte (a:t@ype) = (a, a) -> bool

fun{a:t@ype}
merge {m,n:nat} .<m+n>. (
  xs: list (a, m), ys: list (a, n), lte: lte a
) : list (a, m+n) =
  case+ xs of
  | list_cons (x, xs1) => (
    case+ ys of
    | list_cons (y, ys1) =>
        if x \lte y then
          list_cons (x, merge (xs1, ys, lte))
        else
          list_cons (y, merge (xs, ys1, lte))
        // end of [if]
    | list_nil () => xs
    ) // end of [list_cons]
  | list_nil () => ys
// end of [merge]

fun{a:t@ype}
mergesort {n:nat} (
  xs: list (a, n), lte: lte a
) : list (a, n) = let
//
  fun msort {n:nat} .<n,n>. (
    xs: list (a, n), n: int n, lte: lte a
  ) : list (a, n) =
    if n >= 2 then split (xs, n, lte, n/2, list_nil) else xs
  and split
    {n:int | n >= 2} {i:nat | i <= n/2} .<n,i>. (
    xs: list (a, n-n/2+i)
  , n: int n, lte: lte a, i: int i, xsf: list (a, n/2-i)
  ) : list (a, n) =
    if i > 0 then let
      val+ list_cons (x, xs) = xs
    in
      split (xs, n, lte, i-1, list_cons (x, xsf))
    end else let
      val xsf = list_reverse<a> (xsf) // make sorting stable!
      val xsf = list_of_list_vt (xsf)
      val xsf = msort (xsf, n/2, lte) and xs = msort (xs, n-n/2, lte)
    in
      merge (xsf, xs, lte)
    end // end of [if]
//
  val n = list_length<a> (xs)
//
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
  val xs1 = list_randgen<T1> (N)
  val () = begin
    print "input:\t"; list_fprint_elt (stdout_ref, xs1, ", "); print_newline ()
  end // end of [val]
  val ys1 = mergesort<T1> (xs1, lam (x, y) => (x <= y))
  val () = begin
    print "output:\t"; list_fprint_elt (stdout_ref, ys1, ", "); print_newline ()
  end // end of [val]
//
  val xs2 = list_randgen<T2> (N)
  val () = begin
    print "input:\t"; list_fprint_elt (stdout_ref, xs2, ", "); print_newline ()
  end // end of [val]
  val ys2 = mergesort<T2> (xs2, lam (x, y) => (x <= y))
  val () = begin
    print "output:\t"; list_fprint_elt (stdout_ref, ys2, ", "); print_newline ()
  end // end of [val]
//
} // end of [main]

(* ****** ****** *)

(* end of [mergesort.dats] *)
