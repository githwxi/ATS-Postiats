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
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail hwxiATcsDOTbuDOTedu
** Time: January, 2011
*)

(* ****** ****** *)

(*
** Ported to ATS2 by HX-2013-09
*)

(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

fun{a:t@ype}
insertion_sort
(
  A: arrszref (a)
, cmp: (a, a) -> int
) : void = let
  val n = g0uint2int_size_int (A.size)
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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/stdlib.sats"

(* ****** ****** *)

staload "{$LIBATSHWXI}/testing/SATS/randgen.sats"
staload _(*anon*) = "{$LIBATSHWXI}/testing/DATS/randgen.dats"

(* ****** ****** *)

typedef T = int

macdef INTMAX = 1000L

implement
randgen_val<T> () = let
  val x = lrand48 () mod INTMAX in $UN.cast2int(x)
end // end of [randgen]

implement
fprint_val<T>
  (out, x) = $extfcall (void, "fprintf", out, "%3.3i", x)
// end of [fprint_val]

(* ****** ****** *)
//
typedef T2 = double
implement randgen_val<T2> () = drand48 ()
implement fprint_val<T2> (out, x) = fprint_double (out, x)
//
(* ****** ****** *)

implement
main0 () =
{
//
#define N 10
//
val A = randgen_arrszref<T> (i2sz(N))
val () = fprintln! (stdout_ref, "input:\t", A)
val () = insertion_sort<T> (A, lam (x, y) => compare (x, y))
val () = fprintln! (stdout_ref, "output:\t", A)
//
val A2 = randgen_arrszref<T2> (i2sz(N))
val () = fprintln! (stdout_ref, "input:\t", A2)
val () = insertion_sort<T2> (A2, lam (x, y) => compare (x, y))
val () = fprintln! (stdout_ref, "output:\t", A2)
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [insort.dats] *)
