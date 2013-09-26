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
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

(*
//
// HX-2013-04:
// this is needed before closure compilation
// becomes fully functioning
//
implement{a}
arrayptr_make_elt
  {n} (asz, x0) = let
//
val (pf, pfgc | p0) = array_ptr_alloc<a> (asz)
//
var i: size_t
var p: ptr = p0
val () = $effmask_ntm
(
//
for
(
  i := i2sz(0); i < asz; i := succ(i)
) (
  $UN.ptr0_set<a> (p, x0); p := ptr_succ<a>(p)
) // end of [for]
//
) // end of [val]
//
in
  $UN.castvwtp0{arrayptr(a,n)}((pf, pfgc | p0))
end // end of [arrayptr_make_elt]
*)

(* ****** ****** *)

static
fun fib {n:nat} (n: int n): int = "sta#fib"
extern
fun fibmem
  {m,n:nat | m > n} (tbl: &(@[int][m]) >> _, n: int n): int = "ext#fibmem"
// end of [fibmem]

(* ****** ****** *)

implement
fibmem (tbl, n) = let
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
val asz = g1i2u (n+1)
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
main0 () =
{
  val N = 20
(*
  val () = println! ("fib(", N, ") = ", fib (N))
*)
  val () = assertloc (fib (N) = 6765)
} // end of [main0]

(* ****** ****** *)

(* end of [fibmem.dats] *)
