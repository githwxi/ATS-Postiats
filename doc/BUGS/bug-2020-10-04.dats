(* ****** ****** *)
//
// Reported by
// HX-2020-10-04
//
(* ****** ****** *)
//
datavtype
lint(i:int) = LINT of int(i)
//
fun
foo(x: !lint(0) >> lint(1)): void =
let
val y = x
val () =
(
case+ y of ~LINT(_) => ()
)
prval () = (x := LINT(1)) in (*nothing*) end
//
(* ****** ****** *)

(* end of [bug-2020-10-04.dats] *)
