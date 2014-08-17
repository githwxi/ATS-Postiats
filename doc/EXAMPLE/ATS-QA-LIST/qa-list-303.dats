(* ****** ****** *)
//
// HX-2014-07-23
//
// Showing use of DIVMOD
//
(* ****** ****** *)

staload _ = "prelude/DATS/integer.dats"

(* ****** ****** *)

fun foo
(
  n: ullint
) : [r:int | r >= 2] ullint(r) =
(
if n mod 3ULL = 1
  then foo((n + 2ULL) / 3ULL) else g1ofg0(n) + 2ULL
)
(* ****** ****** *)

fun
foo2
{
  n:nat
} (
  n: ullint(n)
) : [r:int | r >= 2] ullint(r) = let
  val (pfmod | r) = g1uint_mod2 (n, 3ull)
  prval ((*void*)) = divmod_mul_elim (pfmod)
in
//
if
r = 1
then let
  val (pfdiv | q) =
    g1uint_div2 (n + 2ull, 3ull)
  prval ((*void*)) = divmod_mul_elim (pfdiv)
in
  foo2 (q)
end // end of [then]
else n + 2ull
//
end // end of [foo2]

(* ****** ****** *)

implement
main0 () =
{
//
val () = assertloc (foo(100ull) = 14ull)
val () = assertloc (foo2(100ull) = 14ull)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-303.dats] *)
