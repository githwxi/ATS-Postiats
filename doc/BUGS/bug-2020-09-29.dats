(* ****** ****** *)
//
// Reported by
// HX-2017-09-29
//
(* ****** ****** *)
//
// HX-2020-09-29:
// [bar]
// needs to be generative
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

fun
foo
{n:nat}
(x: int(n)): int(n) =
let
exception bar of int(n)
in
if
(x = 0)
then
$raise bar(0)
else try 1+foo(x-1) with ~bar(y) => y
end // end of [foo]

(* ****** ****** *)
//
implement
main0() = () where
{
val () = println!("foo(1) = ", foo(1))
}
//
(* ****** ****** *)

(* end of [bug-2017-09-29] *)
