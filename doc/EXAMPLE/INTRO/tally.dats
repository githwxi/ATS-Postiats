//
// Illustrating tail-recursion
//
// Author: Hongwei Xi (December 31, 2012)
//

(* ****** ****** *)

staload "prelude/lmacrodef.sats"
staload INT = "prelude/DATS/integer.dats"

(* ****** ****** *)

fun tally
  (n: int): int = let
//
fun loop (n: int, res: int): int =
  if n > 0 then loop (n-1, res + n) else res
//
in
  loop (n, 0)
end // end of [tally]

(* ****** ****** *)

fun tally2
  (n: int): ullint = let
//
var n: int = n
var i: int // uninitialized
var res: ullint = 0ull
val () = for (i := 1 ; i <= n ; i :=+ 1) res :=+ (g0i2u)i
//
in
  res
end // end of [tally2]

(* ****** ****** *)

fun tally3
  (n: int): ullint = let
//
var n: int = n
var i: int = 1
var res: ullint = 0ull
//
val () =
  while (true) (
  if i > n then break; res :=+ g0i2u(i); i :=+ 1
) // end of [val] 
//
in
  res
end // end of [tally3]

(* ****** ****** *)
//
// HX: this one makes use of closure
//
fun tally4
  (n: int): ullint = let
//
fun loop
(
  i: int, res: ullint
) : ullint =
  if i <= n then loop (i+1, res + g0i2u(i)) else res
//
in
  loop (0, 0ull)
end // end of [tally4]

(* ****** ****** *)

implement 
main () = let
  #define N 1000
  val () = assertloc (tally (N) = N * (N+1) / 2)
  val () = assertloc (tally2 (N) = N * (N+1) / 2)
  val () = assertloc (tally3 (N) = N * (N+1) / 2)
  val () = assertloc (tally4 (N) = N * (N+1) / 2)
in
  0(*normalexit*)
end // end of [main]

(* ****** ****** *)

(* end of [tally.dats] *)
