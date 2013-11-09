(*
** Some code used in the book INTPROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

dataprop FACT (int, int) =
  | FACTbas (0, 1)
  | {n:nat} {r1,r:int} FACTind (n, r) of (FACT (n-1, r1), MUL (n, r1, r))
// end of [FACT]

(* ****** ****** *)

%{^
#define imul2(x, y) ((x)*(y))
%}
extern
fun
imul2{i,j:int}
(
  i: int i, j: int j
) :<> [ij:int] (MUL (i, j, ij) | int ij) = "mac#imul2"

(* ****** ****** *)
//
// HX:
// this is a verified implementation of
// factorial that is also tail-recursive.
//
fun ifact2
  {n:nat} .<>.
  (n: int (n)):<> [r:int] (FACT (n, r) | int r) = let
  fun loop
    {i:nat | i <= n} {r:int} .<n-i>.
  (
    pf: FACT (i, r) | n: int n, i: int i, r: int r
  ) :<> [r:int] (FACT (n, r) | int r) =
    if n - i > 0 then let
      val (pfmul | r1) = imul2 (i+1, r) in loop (FACTind (pf, pfmul) | n, i+1, r1)
    end else (pf | r) // end of [if]
in
  loop (FACTbas () | n, 0, 1)
end // end of [ifact2]

(* ****** ****** *)
//
// HX:
// this is another verified implementation of
// factorial that is also to be tail-recursive.
//
fun ifact3 {n:nat} .<>.
  (n: int n): [r:int] (FACT (n, r) | int r) = let
//
extern
prfun
lemma{p,q:int}{r:int} (): [qr:int | (p*q)*r==p*(qr)] MUL (q, r, qr)
//
fun loop
  {n:nat}
  {r0:int} .<n>.
(
  n: int n, r0: int r0
) : [r:int] (FACT (n, r) | int (r0*r)) =
  if n > 0 then let
    val [r1:int]
      (pf1 | res) = loop (n-1, r0*n) // pf1: FACT(n-1, r1); res = (r0*n)*r1
    prval pfmul = lemma {r0,n}{r1} () // pfmul: MUL (n, r1, r); res = r0*r for some r
  in (
    FACTind (pf1, pfmul) | res
  ) end else (
    FACTbas () | r0
  ) // end of [if]
in
  loop (n, 1)
end // end of [ifact3]

(* ****** ****** *)

implement
main0 () =
{
  val (pf | res) = ifact2 (10)
  val () = assertloc (res = 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1 * 1)
  val (pf | res) = ifact3 (10)
  val () = assertloc (res = 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1 * 1)
} // end of [main0]

(* ****** ****** *)

(* end of [ifact23.dats] *)
