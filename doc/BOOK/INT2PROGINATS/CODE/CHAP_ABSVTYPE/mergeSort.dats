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
** Top-down Merge-Sort on Arrays
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: October, 2011
*)

(* ****** ****** *)
//
// HX-2014-02-11: Ported to ATS2
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

typedef cmp (a:t@ype) = (&a, &a) -> int

(* ****** ****** *)

extern
fun{a:t@ype}
compare (x: &a, y: &a, cmp: cmp (a)): int

(* ****** ****** *)

implement{a} compare (x, y, cmp) = cmp (x, y)

(* ****** ****** *)

extern
fun{
a:t@ype
} merge{m,n:nat}
(
  A: &(@[a][m]), m: size_t m
, B: &(@[a][n]), n: size_t n
, C: &(@[a?][m+n]) >> @[a][m+n]
, cmp: cmp(a)
) : void // end of [merge]

implement{a}
merge (A, m, B, n, C, cmp) = let
//
fun loop
  {m,n:nat}
  {lA,lB,lC:addr} .<m+n>.
(
  pfA: !array_v (a, lA, m), pfB: !array_v (a, lB, n)
, pfC: !array_v (a?, lC, m+n) >> array_v (a, lC, m+n)
| pA: ptr lA, m: size_t m, pB: ptr lB, n: size_t n, pC: ptr lC, cmp: cmp(a)
) : void =
  if m = 0 then let
    val () = array_copy<a> (!pC, !pB, n)
  in
    // nothing
  end else if n = 0 then let
    val () = array_copy<a> (!pC, !pA, m)
  in
    // nothing
  end else let
    prval (pfA_at, pfA2) = array_v_uncons{a} (pfA)
    prval (pfB_at, pfB2) = array_v_uncons{a} (pfB)
    prval (pfC_at, pfC2) = array_v_uncons{a?} (pfC)
    val sgn = compare<a> (!pA, !pB, cmp)
  in
    if sgn <= 0 then let
      val () = !pC := !pA
      prval () = pfB := array_v_cons{a} (pfB_at, pfB2)
      val () = loop (pfA2, pfB, pfC2 | ptr_succ<a> (pA), m-1, pB, n, ptr_succ<a> (pC), cmp)
      prval () = pfA := array_v_cons{a} (pfA_at, pfA2)
      prval () = pfC := array_v_cons{a} (pfC_at, pfC2)
    in
      // nothing
    end else let // sgn > 0
      val () = !pC := !pB
      prval () = pfA := array_v_cons{a} (pfA_at, pfA2)
      val () = loop (pfA, pfB2, pfC2 | pA, m, ptr_succ<a> (pB), n-1, ptr_succ<a> (pC), cmp)
      prval () = pfB := array_v_cons{a} (pfB_at, pfB2)
      prval () = pfC := array_v_cons{a} (pfC_at, pfC2)
    in
      // nothing
    end // end of [if]
  end (* end of [if] *)
in
  loop (view@(A), view@(B), view@(C) | addr@A, m, addr@B, n, addr@C, cmp)
end // end of [merge]

(* ****** ****** *)

fun
{a:t@ype}
msort1{n:nat} .<n>.
(
  A: &(@[a][n]), n: size_t n, B: &(@[a?][n]), cmp: cmp(a)
) : void =
  if n >= 2 then let
    val n2 = half(n)
    stadef n2 = n / 2
    prval (pfA1, pfA2) =
      array_v_split{..}{..}{n}{n/2} (view@A)
    prval (pfB1, pfB2) =
      array_v_split{..}{..}{n}{n/2} (view@B)
    val () = msort2<a> (A, n2, B, cmp)
    val pA2 = ptr_add<a> (addr@A, n2)
    val pB2 = ptr_add<a> (addr@B, n2)
    val (pfA2 | pA2) = viewptr_match (pfA2 | pA2)
    val (pfB2 | pB2) = viewptr_match (pfB2 | pB2)
    val () = msort2<a> (!pA2, n-n2, !pB2, cmp)
    prval () = view@ (A) := array_v_unsplit (pfA1, pfA2)
    val () = merge<a> (B, n2, !pB2, n-n2, A, cmp)
    prval () = view@ (B) := array_v_unsplit (pfB1, pfB2)
  in
    // nothing
  end // end of [if]
// end of [msort1]

and
msort2{n:nat} .<n>.
(
  A: &(@[a][n]), n: size_t n, B: &(@[a?][n]) >> @[a][n], cmp: cmp(a)
) : void =
  if n >= 2 then let
    val n2 = half(n)
    stadef n2 = n / 2
    prval (pfA1, pfA2) =
      array_v_split{..}{..}{n}{n/2} (view@A)
    prval (pfB1, pfB2) =
      array_v_split{..}{..}{n}{n/2} (view@B)
    val () = msort1<a> (A, n2, B, cmp)
    val pA2 = ptr_add<a> (addr@A, n2)
    val pB2 = ptr_add<a> (addr@B, n2)
    val (pfA2 | pA2) = viewptr_match (pfA2 | pA2)
    val (pfB2 | pB2) = viewptr_match (pfB2 | pB2)
    val () = msort1<a> (!pA2, n-n2, !pB2, cmp)
    prval () = view@B := array_v_unsplit (pfB1, pfB2)
    val () = merge<a> (A, n2, !pA2, n-n2, B, cmp)
    prval () = view@A := array_v_unsplit (pfA1, pfA2)
  in
    // nothing
  end else
    array_copy<a> (B, A, n)
  // end of [if]
(* end of [msort2] *)

(* ****** ****** *)

extern
fun{a:t@ype}
mergeSort {n:nat}
  (A: &(@[a][n]), n: size_t n, cmp: cmp(a)): void
// end of [mergeSort]

implement{a}
mergeSort (A, n, cmp) = let
  val (pfgc, pfat | p) = array_ptr_alloc<a> (n)
  val ((*void*)) = msort1<a> (A, n, !p, cmp)
  val ((*void*)) = array_ptr_free (pfgc, pfat | p)
in
  // nothing
end // end of [mergeSort]

(* ****** ****** *)

implement
main0 () = let
//
typedef T = int
//
val cmp = $UNSAFE.cast{cmp(T)}(0)
implement compare<T> (x, y, _) = x - y 
//
var A = @[T](3, 2, 5, 4, 8, 7, 6, 9, 1, 0)
val () = mergeSort<T> (A, i2sz(10), cmp)
val () = array_foreach_fun<T>{...}(A, i2sz(10), lam (x) =<1> print (x))
val () = print_newline ((*void*))
//
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [mergeSort.dats] *)
