//
#include
"share/atspre_staload.hats"
//
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
//
(* ****** ****** *)

(* end of [bug-2016-05-13.dats] *)