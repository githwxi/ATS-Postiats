(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(*
//
// Not needed here:
//
#include
"share/atspre_staload_libats_ML.hats"
//
*)
(* ****** ****** *)

fun
fact(n: int): int =
if n > 0 then n * fact(n-1) else 1

(* ****** ****** *)

val () =
println! ("fact(10) = ", fact(10))

(* ****** ****** *)

fun
testfact
(n: int): void =
if n > 0 then
(
  testfact(n-1);
  println! ("fact(", n-1, ") = ", n-1)
) (* end of [if] *)

(* ****** ****** *)

val () = testfact(100)

(* ****** ****** *)

fun
testfact2
(n: int): void = let
  fun
  loop(i: int): void =
  if i < n then
  (
    println! ("fact(", i, ") = ", fact(i)); loop(i+1)
  ) (* end of [if] *)
in
  loop(0)
end // end of [testfact2]

(* ****** ****** *)

val () = testfact2(100)

(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [fact.dats] *)
