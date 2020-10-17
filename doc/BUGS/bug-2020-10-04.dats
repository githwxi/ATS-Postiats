(* ****** ****** *)
//
// Reported by
// HX-2020-10-04
//
(* ****** ****** *)
//
// HX-2020-10-17:
// This one cannot be easily
// fixed in ATS2. It will be
// handled in ATS3.
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
