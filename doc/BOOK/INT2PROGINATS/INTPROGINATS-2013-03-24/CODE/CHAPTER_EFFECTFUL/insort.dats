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
** Example: Insertion Sort
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/array.dats"
staload _(*anon*) = "prelude/DATS/array0.dats"

(* ****** ****** *)

fun{a:t@ype}
insertion_sort (
  A: array0 (a), cmp: (a, a) -> int
) : void = let
  val asz = array0_size (A)
  val n = int_of_size (asz)
  fun ins (x: a, i: int):<cloref1> void =
    if i >= 0 then
      if cmp (x, A[i]) < 0 then (A[i+1] := A[i]; ins (x, i-1))
      else A[i+1] := x
    else A[0] := x
  // end of [ins]
  fun loop (i: int):<cloref1> void =
    if i < n then (ins (A[i], i-1); loop (i+1)) else ()
  // end of [loop]
in
  loop (1)
end // end of [insertion_sort]

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
  val A1 = array0_randgen<T1> (N)
  val () = begin
    print "input:\t"; array0_fprint_elt (stdout_ref, A1, ", "); print_newline ()
  end // end of [val]
  val () = insertion_sort<T1> (A1, lam (x, y) => compare (x, y))
  val () = begin
    print "output:\t"; array0_fprint_elt (stdout_ref, A1, ", "); print_newline ()
  end // end of [val]
//
  val A2 = array0_randgen<T2> (N)
  val () = begin
    print "input:\t"; array0_fprint_elt (stdout_ref, A2, ", "); print_newline ()
  end // end of [val]
  val () = insertion_sort<T2> (A2, lam (x, y) => compare (x, y))
  val () = begin
    print "output:\t"; array0_fprint_elt (stdout_ref, A2, ", "); print_newline ()
  end // end of [val]
//
} // end of [main]

(* ****** ****** *)

(* end of [insort.dats] *)
