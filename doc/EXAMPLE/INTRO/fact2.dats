//
// Two verified implementations
// of the well-known factorial function:
//
// the first one is not tail-recursive
// whereas the second one is tail-recursive
//
(* ****** ****** *)
//
// Author: Hongwei Xi (February 2012)
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/basics.dats"
staload _(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)
//
// HX: an encoding of the factorial function:
// FACT (n, r) means that r equals the factorial of n
//
dataprop
FACT (int, int) =
  | FACTbas (0, 1) of ()
  | {n:pos}{r:int} FACTind (n, n*r) of FACT (n-1, r)
// end of [FACT]

(* ****** ****** *)

fun
fact
{n:nat} .<n>.
(
  x: int n // x = n
) : [r:int]
(
  FACT(n, r) | int(r)
) = (
//
if
x > 0
then let
  val [r1:int]
    (pf1 | r1) = fact (x-1)
  prval pf = FACTind {n}{r1} (pf1)
  val r = x * r1
in
  (pf | r)
end // end of [then]
else (FACTbas () | 1)
//
) (* end of [fact] *)
  
(* ****** ****** *)

(*
** HX: this one is tail-recursive
*)
fun
fact2
{n:nat} .<n>.
(
  x: int n // x = n
) : [r:int]
(
  FACT(n, r) | int(r)
) = let
//
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
//
in
  loop (x, 1)
end // end of [fact2]

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val n = (
  if argc >= 2
    then g1string2int (argv[1]) else 10(*default*)
  // end of [if]
) : Int // end of [val]
val () = assertexn (n >= 0)
//
val pfr = fact (n)
and pfr2 = fact2 (n)
//
val () = assertloc (pfr.1 = pfr2.1)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [fact2.dats] *)
