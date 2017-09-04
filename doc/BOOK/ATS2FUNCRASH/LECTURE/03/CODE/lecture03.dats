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
fact2(n: int): int = let
//
fun
loop(i: int, res: int): int =
if i < n
  then loop(i+1, (i+1)*res) else res
// end of [if]
//
in
  loop(0, n)
end // end of [fact2]

(* ****** ****** *)

val () =
println! ("fact2(10) = ", fact2(10))

(* ****** ****** *)

fun
testfact2
(n: int): void = let
  fun
  loop(i: int): void =
  if i < n then
  (
    println! ("fact(", i, ") = ", fact2(i)); loop(i+1)
  ) (* end of [if] *)
in
  loop(0)
end // end of [testfact2]

(* ****** ****** *)

val () = testfact2(100)

(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture03.dats] *)
