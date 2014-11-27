(* ****** ****** *)
//
// HX-2014-09
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

(*
This seems to compile:

staload UN = "prelude/SATS/unsafe.sats"

typedef Cint2 = $extype"struct{ int x; int y; }"

implement
main0 () =
{
val y = @(7, 3)
val x: Cint2 = $UN.cast{Cint2}{@(int,int)}(y)
}
*)

(* ****** ****** *)

typedef Cint2 =
$extype_struct"struct{int x;int y;}" of { x= int, y= int }

implement
main0 () =
{
//
var xy: Cint2;
val () = xy.x :=  1
val () = xy.y :=  2
//
val () = println! ("xy.x = ", xy.x)
val () = println! ("xy.y = ", xy.y)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-366.dats] *)
