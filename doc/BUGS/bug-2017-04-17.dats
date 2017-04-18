(* ****** ****** *)
//
// Reported by
// HX-2017-04-17
//
(* ****** ****** *)
//
// HX:
// Compiling 'fix' inside a function template
// leads to failure in handling recursive calls
//
(* ****** ****** *)
//
// HX-2017-04-18: fixed!!!
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

fun{}
fact(n: int): int = let
//
val f =
fix f(i: int): int =<cloptr1>
  if i <= n then i*f(i+1) else 1
//
val res = f(1)
//
in
  cloptr_free($UNSAFE.castvwtp0(f)); res
end

(* ****** ****** *)

fun{}
fact2
(
n: int
): int = res where
//
var f =
fix@ f(i: int): int =<clo1>
  if i <= n then i*f(i+1) else 1
//
val res = f(1)
//
end // end of [where]

(* ****** ****** *)

implement
main0() =
{
val () =
println! ("fact(10) = ", fact(10))
val () =
println! ("fact(10) = ", fact2(10))
}
(* ****** ****** *)

(* end of [bug-2017-04-17] *)
