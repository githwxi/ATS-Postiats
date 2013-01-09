//
// Two verified implementations of the factorial function:
// the first one is not tail-recursive whereas the second is
//
// Author: Hongwei Xi (February 2012)
//

(* ****** ****** *)
//
// HX: an encoding of the factorial function:
// FACT (n, r) means that r equals the factorial of n
//
dataprop FACT (int, int) =
  | FACTbas (0, 1) of ()
  | {n:pos}{r:int} FACTind (n, n*r) of FACT (n-1, r)
// end of [FACT]

(* ****** ****** *)

fun fact
  {n:nat} .<n>. (
  x: int n // the val of x is n
) : [r:int]
  (FACT (n, r) | int r) = let
in
//
if x > 0 then let
  val [r1:int]
    (pf1 | r1) = fact (x-1)
  prval pf = FACTind {n}{r1} (pf1)
  val r = x * r1
in
  (pf | r)
end else
  (FACTbas () | 1)
// end of [if]
//
end // end of [fact]
  
(* ****** ****** *)

(*
** HX: this one is tail-recursive
*)
fun fact2
  {n:nat} .<n>. (
  x: int n // the val of x is n
) : [r:int] (FACT (n, r) | int r) = let
  fun loop
    {n:nat}
    {r0:int} .<n>. (
    x: int n, r0: int r0
  ) : [r:int] (
    FACT (n, r) | int (r*r0)
  ) = (
    if x > 0 then let
      val [r1:int]
        (pf1 | res) = loop (x-1, x*r0)
      prval pf = FACTind {n}{r1} (pf1)
    in
      (pf | res)
    end else
      (FACTbas () | r0)
    // end of [if]
  ) // end of [loop]
in
  loop (x, 1)
end // end of [fact2]

(* ****** ****** *)

implement
main (
  argc, argv
) = let
  val n = (
    if argc >= 2 then g1int_of_string (argv[1]) else 10(*default*)
  ) : Int // end of [val]
  val () = assert (n >= 0)
  val pfr = fact (n)
  and pfr2 = fact2 (n)
  val () = assert (pfr.1 = pfr2.1)
in
  0 (* normal exit *)
end // end of [main]

(* ****** ****** *)

(* end of [fact2.dats] *)
