(*
** Some code used in the book INTPROGINATS
*)

(* ****** ****** *)

dataprop FACT (int, int) =
  | FACTbas (0, 1)
  | {n:nat} {r1,r:int} FACTind (n, r) of (FACT (n-1, r1), MUL (n, r1, r))
// end of [FACT]

(* ****** ****** *)

fun fact {n:nat} .<n>.
  (n: int n): [r:int] (FACT (n, r) | int r) =
  if n > 0 then let
    val (pf1 | r1) = fact (n-1) // pf1: FACT (n-1, r1)
    val (pfmul | r) = n imul2 r1 // pfmul: FACT (n, r1, r)
  in (
    FACTind (pf1, pfmul) | r
  ) end else (
    FACTbas () | 1 // the base case
  ) // end of [if]
// end of [fact]

(* ****** ****** *)

implement
main () = () where {
  val (pf | res) = fact (10)
  val () = assertloc (res = 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1 * 1)
} // end of [main]

(* ****** ****** *)

(* end of [fact.dats] *)
