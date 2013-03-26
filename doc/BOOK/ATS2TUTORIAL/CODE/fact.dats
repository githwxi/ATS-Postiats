(*
** A simple program to compute factorials
*)

(* ****** ****** *)
//
// pats2xhtml < fact.dats > fact_dats.html
//
(* ****** ****** *)

dataprop
FACT (int, int) =
  | FACTbas (0, 1)
  | {n:nat} {r1,r:int}
    FACTind (n, r) of (FACT (n-1, r1), MUL (n, r1, r))
// end of [FACT]

(* ****** ****** *)
//
// HX:
// this is a verified implementation of factorial
// that is also tail-recursive.
//
fun ifact2
  {n:nat} .<>.
(
  n: int n
) : [r:int]
(
  FACT (n, r) | int r
) = let
//
fun loop
  {i:nat | i <= n} {r:int} .<n-i>.
(
  pf: FACT (i, r) | n: int n, i: int i, r: int r
) : [r:int] (FACT (n, r) | int r) =
(
  if n - i > 0 then let
    val (pfmul | r1) = g1int_mul2 (i+1, r) in loop (FACTind (pf, pfmul) | n, i+1, r1)
  end else (pf | r) // end of [if]
) (* end of [loop] *)
//
in
  loop (FACTbas () | n, 0, 1)
end // end of [ifact2]

(* ****** ****** *)

%{^

/*
** There is not external code in this example
*/

%} // end of [%{^]

(* ****** ****** *)

implement
main0 () = {
  val (pf | res) = ifact2 (10)
  val () = assertloc (res = 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1 * 1)
} // end of [main0]

(* ****** ****** *)

(* end of [fact.dats] *)