//
// Testing guarded patterns
//

(* ****** ****** *)
//
staload
INT = "prelude/DATS/integer.dats"
//
(* ****** ****** *)

fun
fact (n: int): int =
(
case+ 0 of
| _ when n = 0 => 1
| _ (* n > 1 *) => n * fact (n-1)
) (* end of [fact] *)

(* ****** ****** *)

implement
main0 () =
{
val () = println! ("fact(10) = ", fact(10))
}

(* ****** ****** *)

(* end of [patguard.dats] *)
