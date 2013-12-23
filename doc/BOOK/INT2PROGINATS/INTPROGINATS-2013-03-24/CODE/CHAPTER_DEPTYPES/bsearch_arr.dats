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
** Example: Binary Search on Arrays
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/array.dats"

(* ****** ****** *)

fun{a:t@ype}
bsearch_arr {n:nat} (
  A: array (a, n), n: int n, x0: a, cmp: (a, a) -> int
) : int = let
  fun loop
    {i,j:int |
     0 <= i; i <= j+1; j+1 <= n} (
    A: array (a, n), l: int i, u: int j
  ) :<cloref1> int =
    if l <= u then let
      val m = l + (u - l) / 2
      val x = A[m]
      val sgn = cmp (x0, x)
    in
      if sgn >= 0 then loop (A, m+1, u) else loop (A, l, m-1)
    end else u // end of [if]
  // end of [loop]
in
  loop (A, 0, n-1)
end // end of [bsearch_arr]

(* ****** ****** *)

staload "libc/SATS/random.sats"

staload "contrib/testing/SATS/randgen.sats"
staload _(*anon*) = "contrib/testing/DATS/randgen.dats"
staload "contrib/testing/SATS/fprint.sats"
staload _(*anon*) = "contrib/testing/DATS/fprint.dats"

(* ****** ****** *)

typedef T = double
implement randgen<T> () = drand48 ()
implement fprint_elt<T> (out, x) = fprintf (out, "%.2f", @(x))

(* ****** ****** *)

staload "libc/SATS/stdlib.sats"

(* ****** ****** *)

implement
main () = () where {
//
  val () = srand48_with_time ()
//
  #define N 10
  val A = array_randgen<T> (N)
  val () = qsort {T}
    (A, N, sizeof<T>, lam (x, y) => compare (x, y)) where {
    extern fun qsort {a:viewt@ype} {n:nat} (
      base: array (a, n)
    , nmemb: size_t n, size: sizeof_t a, compar: (&a, &a) -<fun> int
    ) :<> void = "atslib_qsort"
  } // end of [val]
  val x0 = 0.5
  val ans = bsearch_arr<T> (A, N, x0, lam (x, y) => compare (x, y))
  val () = print "A = "
  val () = array_fprint_elt<T> (stdout_ref, A, N, ", ")
  val () = print_newline ()
  val () = print! ("ans = ", ans)
  val () = print_newline ()
} // end of [main]

(* ****** ****** *)

(* end of [bsearch_arr.dats] *)
