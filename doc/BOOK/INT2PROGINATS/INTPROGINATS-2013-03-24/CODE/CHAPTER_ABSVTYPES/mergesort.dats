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
** Top-down Mergesort on Arrays
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: October, 2011
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/array.dats"

(* ****** ****** *)

typedef cmp (a:t@ype) = (&a, &a) -> int

(* ****** ****** *)

extern
fun{a:t@ype}
compare (x: &a, y: &a, cmp: cmp (a)): int

implement{a} compare (x, y, cmp) = cmp (x, y)

(* ****** ****** *)

extern
fun{a:t@ype}
merge {m,n:nat} (
  A: &(@[a][m]), m: size_t m
, B: &(@[a][n]), n: size_t n
, C: &(@[a?][m+n]) >> @[a][m+n]
, cmp: cmp(a)
) : void // end of [merge]

implement{a}
merge (A, m, B, n, C, cmp) = let
//
fun loop {m,n:nat} {lA,lB,lC:addr} .<m+n>. (
  pfA: !array_v (a, m, lA), pfB: !array_v (a, n, lB)
, pfC: !array_v (a?, m+n, lC) >> array_v (a, m+n, lC)
| pA: ptr lA, m: size_t m, pB: ptr lB, n: size_t n, pC: ptr lC, cmp: cmp(a)
) : void =
  if m = 0 then let
    prval pfC1 = pfC: array_v (a?, n, lC)
    val () = array_ptr_copy_tsz {a} {n} (!pB, !pC, n, sizeof<a>)
    prval () = pfC := pfC1
  in
    // nothing
  end else if n = 0 then let
    prval pfC1 = pfC: array_v (a?, m, lC)
    val () = array_ptr_copy_tsz {a} (!pA, !pC, m, sizeof<a>)
    prval () = pfC := pfC1
  in
    // nothing
  end else let
    prval (pfA_at, pfA2) = array_v_uncons {a} (pfA)
    prval (pfB_at, pfB2) = array_v_uncons {a} (pfB)
    prval (pfC_at, pfC2) = array_v_uncons {a?} (pfC)
    val sgn = compare (!pA, !pB, cmp)
  in
    if sgn <= 0 then let
      val () = !pC := !pA
      prval () = pfB := array_v_cons {a} (pfB_at, pfB2)
      val tsz = sizeof<a>
      val () = loop (pfA2, pfB, pfC2 | pA+tsz, m-1, pB, n, pC+tsz, cmp)
      prval () = pfA := array_v_cons {a} (pfA_at, pfA2)
      prval () = pfC := array_v_cons {a} (pfC_at, pfC2)
    in
      // nothing
    end else let // sgn > 0
      val () = !pC := !pB
      prval () = pfA := array_v_cons {a} (pfA_at, pfA2)
      val tsz = sizeof<a>
      val () = loop (pfA, pfB2, pfC2 | pA, m, pB+tsz, n-1, pC+tsz, cmp)
      prval () = pfB := array_v_cons {a} (pfB_at, pfB2)
      prval () = pfC := array_v_cons {a} (pfC_at, pfC2)
    in
      // nothing
    end // end of [if]
  end (* end of [if] *)
in
  loop (view@(A), view@(B), view@(C) | &A, m, &B, n, &C, cmp)
end // end of [merge]

(* ****** ****** *)

fun{a:t@ype}
msort1 {n:nat} .<n>. (
  A: &(@[a][n]), n: size_t n, B: &(@[a?][n]), cmp: cmp(a)
) : void =
  if n >= 2 then let
    val n2 = n / 2
    stadef n2 = n / 2
    val (pfmul | ofs) = mul2_size1_size1 (n2, sizeof<a>)
    prval (pfA1, pfA2) = array_v_split {a}{n}{n/2} (pfmul, view@ (A))
    prval (pfB1, pfB2) = array_v_split {a?}{n}{n/2} (pfmul, view@ (B))
    val () = msort2 (A, n2, B, cmp)
    val pA2 = &A + ofs
    val pB2 = &B + ofs
    val () = msort2 (!pA2, n-n2, !pB2, cmp)
    prval () = view@ (A) := array_v_unsplit {a} (pfmul, pfA1, pfA2)
    val () = merge<a> (B, n2, !pB2, n-n2, A, cmp)
    prval () = view@ (B) := array_v_unsplit {a} (pfmul, pfB1, pfB2)
  in
    // nothing
  end // end of [if]
// end of [msort1]

and msort2 {n:nat} .<n>. (
  A: &(@[a][n]), n: size_t n, B: &(@[a?][n]) >> @[a][n], cmp: cmp(a)
) : void =
  if n >= 2 then let
    val n2 = n / 2
    stadef n2 = n / 2
    val (pfmul | ofs) = mul2_size1_size1 (n2, sizeof<a>)
    prval (pfA1, pfA2) = array_v_split {a}{n}{n/2} (pfmul, view@ (A))
    prval (pfB1, pfB2) = array_v_split {a?}{n}{n/2} (pfmul, view@ (B))
    val () = msort1 (A, n2, B, cmp)
    val pA2 = &A + ofs
    val pB2 = &B + ofs
    val () = msort1 (!pA2, n-n2, !pB2, cmp)
    prval () = view@ (B) := array_v_unsplit {a?} (pfmul, pfB1, pfB2)
    val () = merge<a> (A, n2, !pA2, n-n2, B, cmp)
    prval () = view@ (A) := array_v_unsplit {a} (pfmul, pfA1, pfA2)
  in
    // nothing
  end else
    array_ptr_copy_tsz (A, B, n, sizeof<a>)
  // end of [if]
(* end of [msort2] *)

(* ****** ****** *)

extern
fun{a:t@ype}
mergesort {n:nat}
  (A: &(@[a][n]), n: size_t n, cmp: cmp(a)): void
// end of [mergesort]

implement{a}
mergesort (A, n, cmp) = let
  val (pfgc, pfat | p) = array_ptr_alloc<a> (n)
  val () = msort1 (A, n, !p, cmp)
  val () = array_ptr_free (pfgc, pfat | p)
in
  // nothing
end // end of [mergesort]

(* ****** ****** *)

implement
main () = let
  typedef T = int
//
  val cmp = $extval (cmp(T), "0")
  implement compare<T> (x, y, _) = x - y 
//
  var !parr with pfarr = @[T](3, 2, 5, 4, 8, 7, 6, 9, 1, 0)
  val () = mergesort (!parr, 10, cmp)
  val () = array_ptr_foreach_fun<T> (!parr, lam (x) =<1> print (x), 10)
  val () = print_newline ()
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [mergesort.dats] *)
