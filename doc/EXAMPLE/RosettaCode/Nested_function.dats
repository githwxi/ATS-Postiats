(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: Somewhere in 2016
//
(* ****** ****** *)
(*
**
** RosettaCode:
** Nested_function
**
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun
MakeList
(
  sep: string
) : void = let
//
var count: int = 0
//
val count =
  $UNSAFE.cast{ref(int)}(addr@count)
//
fun
MakeItem
(
  item: string
) : void = let
  val () = !count := !count+1
in
  println! (!count, sep, item)
end // end of [MakeItem]
//
in
  MakeItem"first"; MakeItem"second"; MakeItem"third"
end // end of [MakeList]

(* ****** ****** *)

implement main0() = { val () = MakeList". " }

(* ****** ****** *)

(* end of [Nested_function.dats] *)
