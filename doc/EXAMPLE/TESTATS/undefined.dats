(* ****** ****** *)
//
// HX: 2016-08-19:
// Testing 'undefined' macro!
// 
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
fun
fact(n: int): int = undefined()
//
(* ****** ****** *)
//
implement
main0() = let
  val fact10 = fact(10)
in
  println! ("fact(10) = ", fact10)
end // end of [main0]
//
(* ****** ****** *)

(* end of [undefined.dats] *)
