//
// Fibonacci function via memoization
//
// Author: Hongwei Xi (February 21, 2013)
//

(* ****** ****** *)
//
// How to test:
//   ./fibmem
// How to compile:
//   atscc -o fibmem fibmem.dats
//
(* ****** ****** *)
//
#include
"share/atspre_tmpdef_staload.hats"
//
(* ****** ****** *)

extern
fun fib
  {n:nat} (n: int n): int
// end of [fib]
extern
fun fibmem
  {m,n:nat | m > n} (tbl: &(@[int][m]) >> _, n: int n): int
// end of [fibmem]

(* ****** ****** *)

implement
fibmem
  (tbl, n) = let
in
//
if n >= 2 then let
  val res = tbl.[n]
in
  if res >= 0 then res else let
    val res =
      fibmem (tbl, n-1) + fibmem (tbl, n-2)
    val () = tbl.[n] := res
  in
    res
  end // end of [if]
end else n // fib(0)=0; fib(1)=1
//
end // end of [fibmem]

(* ****** ****** *)

implement
fib (n) = let
//
val asz = g1int2uint (n+1)
val arrp = arrayptr_make_elt<int> (asz, ~1)
val (pf | p) = arrayptr_takeout_viewptr (arrp)
//
val res = fibmem (!p, n)
//
prval () = arrayptr_addback (pf | arrp)
//
val () = arrayptr_free (arrp)
//
in
  res
end // end of [fib]

(* ****** ****** *)

implement
main0 () = {
  val N = 10
  val () = println! ("fib(", N, ") = ", fib (N))
} // end of [main0]

(* ****** ****** *)

(* end of [fibmem.dats] *)
