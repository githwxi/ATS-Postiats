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
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

fun{
a:t@ype
} bsearch_arr{n:nat}
(
  A: arrayref (a, n), n: int n, x0: a, cmp: (a, a) -> int
) : int = let
//
fun loop
  {i,j:int |
   0 <= i; i <= j+1; j+1 <= n}
(
  A: arrayref (a, n), l: int i, u: int j
) :<cloref1> int =
(
  if l <= u then let
    val m = l + half (u - l)
    val x = A[m]
    val sgn = cmp (x0, x)
  in
    if sgn >= 0 then loop (A, m+1, u) else loop (A, l, m-1)
  end else u // end of [if]
) (* end of [loop] *)
//
in
  loop (A, 0, n-1)
end // end of [bsearch_arr]

(* ****** ****** *)
//
staload UN = "prelude/SATS/unsafe.sats"
//
staload STDLIB = "libc/SATS/stdlib.sats"
//
(* ****** ****** *)
//
staload
RG = "{$LIBATSHWXI}/testing/SATS/randgen.sats"
staload
_(*RG*) = "{$LIBATSHWXI}/testing/DATS/randgen.dats"
//
(* ****** ****** *)
%{^
//
#include <time.h>
//
extern void srand48 (long int) ; // in [stdlib.h]
extern double drand48 (/*void*/) ; // in [stdlib.h]
//
atsvoid_t0ype
srand48_with_time ()
{
  srand48(time(0)) ; return ;
}
%}
extern
fun srand48_with_time (): void = "ext#"
//
(* ****** ****** *)

implement
main0 () = () where {
//
#define N 10
//
val () = srand48_with_time ()
//
typedef T = double
implement $RG.randgen_val<T> () = $STDLIB.drand48()
//
val asz = i2sz (N)
val A = $RG.randgen_arrayref<T> (asz)
//
val (pf, fpf | p) = $UN.ptr0_vtake {array(T,N)} ($UN.cast2ptr(A))
//
val () = array_quicksort_stdlib<T> (!p, asz, lam (x, y) => compare (x, y))
//
prval () = fpf (pf)
//
val x0 = 0.5
//
val ans = bsearch_arr<T> (A, N, x0, lam (x, y) => compare (x, y))
//
val () = println! ("x0 = ", x0)
//
val () = print "A = "
val () = fprint_arrayref_sep<T> (stdout_ref, A, asz, ", ")
val () = print_newline ()
//
val () = println! ("ans = ", ans)
//
} // end of [main]

(* ****** ****** *)

(* end of [bsearch_arr.dats] *)
