(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
extern fun fact(int): int
//
(* ****** ****** *)
//
implement
fact =
fix f(x: int): int => if x > 0 then x * f(x-1) else 1
//
(* ****** ****** *)

val _fact10_ = fact(10)

(* ****** ****** *)

(* end of [fact.dats] *)