(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
stacst fact: int -> int
//
(* ****** ****** *)
//
extern
praxi
fact_bas(): [fact(0)==1] unit_p
extern
praxi
fact_ind{n:pos}(): [fact(n)==n*fact(n-1)] unit_p
//
(* ****** ****** *)

(*
//
// HX:
// it works with Z3-4.3.?
// it does not work with Z3-4.4.0
//
fun
fact
{n:nat}
(
  n: int(n)
) : int(fact(n)) = let
//
prval() = $solver_assert(fact_bas)
prval() = $solver_assert(fact_ind)
//
fun
loop
{n:nat}
{r:int} .<n>.
(
  n: int(n), r: int(r)
) : int(fact(n)*r) = (
//
if n = 0 then (r) else loop(n-1, n*r)
//
) (* end of [loop] *)
//
in
  loop(n, 1)
end // end of [fact]
*)

(* ****** ****** *)

fun
fact
{n:nat}
(
  n: int(n)
) : int(fact(n)) = let
//
prval() = $solver_assert(fact_bas)
prval() = $solver_assert(fact_ind)
//
fun
loop
{ i:nat
| i <= n
} .<n-i>.
(
  i: int(i), r: int(fact(i))
) : int(fact(n)) = (
//
if i < n then loop(i+1, (i+1)*r) else r
//
) (* end of [loop] *)
//
in
  loop(0, 1)
end // end of [fact]

(* ****** ****** *)

implement
main0(argc, argv) =
{
//
val n =
(
if (argc >= 2)
  then g0string2int(argv[1]) else 10
// end of [if]
) : int // end of [val]
//
val n = g1ofg0(n)
val n = (if n >= 0 then n else 0): intGte(0)
//
val () = println! ("fact(", n, ") = ", fact(n))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [fact2.dats] *)
