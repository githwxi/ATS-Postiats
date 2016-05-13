//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

(*
fun foo(x: int): int =
  case+ () of
  | () when x >= 0 => 0 | () => ~1
//
implement
main0() =
{
  val () = assert(foo(0) = 0)
  val () = assert(foo(~1) = ~1)
}
*)

(* ****** ****** *)

extern fun
  foo
  {a:nat}
  (a: int a):
  [b: nat | b > a] int b

(** This implementation obviously works **)
(*
implement foo
  {a}(a) = let
  fun loop
  {x, y: nat}
  (x: int x, y: int y):
  [z: nat | z > x] int z =
  if y > x
  then y
  else loop(x, y+1)
in
  loop(a, 0)
end*)


(** And so should this one! **)
implement foo
  {a}(a) = let
  fun loop
  {x, y: nat}
  (x: int x, y: int y):
  [z: nat | z > x] int z =
  case () of
  | () when y > x => y
  | () =>> loop(x, y+1)
in
  loop(a, 0)
end

(* ****** ****** *)

implement main0 () = let
  val x = foo(5)
  val () = println!(x) (* Should output 6, but outputs 0 instead! *)
  val () = assert(x = 6)
in
  (**)
end // end of [main0]

(* ****** ****** *)

(* end of [bug-2016-05-13.dats] *)
