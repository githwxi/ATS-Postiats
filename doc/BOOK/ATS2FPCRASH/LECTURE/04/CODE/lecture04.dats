(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#staload "./../../mylib/mylib.dats"

(* ****** ****** *)
//
val
square =
lam(x: int): int => x * x
//
val fact =
fix f(x: int): int =>
  if x > 0 then x * f(x) else 1
//
(* ****** ****** *)
//
fun
fact(n:int): int =
int_foldleft<int>
(n, 1, lam(res, i) => res * (i+1))
//
val () =
int_foreach<(*void*)>
( 10
, lam(i) =>
  println!("fact(", i, ") = ", fact(i))
)
//
(* ****** ****** *)
//
fun
fact(n:int): int =
(n).foldleft
(TYPE{int})(1, lam(res, i) => res * (i+1))
//
val () =
(10).foreach()
(lam(i) => println!("fact(", i, ") = ", fact(i)))
//
(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture04.dats] *)
