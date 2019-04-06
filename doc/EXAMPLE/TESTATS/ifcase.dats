(* ****** ****** *)
//
// HX: 2016-05-15:
// A simple exercise of syntax design 
// 
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
fun
acker
{m,n:nat}
.<m,n>.
(
  m: int(m)
, n: int(n)
) : intGte(0) =
(
ifcase
| m = 0 => n + 1
| n = 0 => acker(m-1, 1)
| _(*else*) => acker(m-1, acker(m, n-1))
// end of [ifcase]
)
//
(* ****** ****** *)

val () = assertloc(acker(3,3) = 61)

(* ****** ****** *)
//
fun
foo{i:nat}
  (x: int(i), y: int(i+1)): void = ()
//
(* ****** ****** *)

implement
main0 () = () where
{
//
var x: int
var y: int
//
val i = (2: intGte(0))
//
val () = (
//
ifcase: [i:nat]
(
  x: int(i), y: int(i+1)
) =>
  | i = 0 => (x := i; y := x+1)
  | i = 1 => (x := i; y := x+1)
  | _(*i >= 1*) => (x := 10; y := 11)
//
) : void // end of [val]
//
val () = foo(x, y)
//
val () = assertloc(10 = x)
val () = assertloc(11 = y)
val () = println! ("x = ", x, " and y = ", y)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [ifcase.dats] *)
