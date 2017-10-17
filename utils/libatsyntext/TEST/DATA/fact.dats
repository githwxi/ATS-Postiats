(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
fun
fact(x: int): int =
if x > 0 then x * fact(x-1) else 1
//
(* ****** ****** *)
//
val
fact =
fix f(x: int): int =>
  (if x > 0 then x * f(x-1) else 1)
//
(* ****** ****** *)
//
extern
fun fact(int): int
//
implement
fact =
fix f(x: int): int =>
  (if x > 0 then x * f(x-1) else 1)
//
(* ****** ****** *)

val _fact10_ = fact(10)

(* ****** ****** *)

(* end of [fact.dats] *)