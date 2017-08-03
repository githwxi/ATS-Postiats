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

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [compiling.dats] *)
