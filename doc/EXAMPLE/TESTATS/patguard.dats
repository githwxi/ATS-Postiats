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
| _ (* n >= 1 *) => n * fact (n-1)
) (* end of [fact] *)

(* ****** ****** *)

fun
{a:t@ype}
last(xs: List0(a)): a =
(
  case- xs of
  | list_cons(x, xs)
      when xs as list_nil() => x
    // list_cons ... when ...
  | list_cons(_, xs) => last(xs)
)

(* ****** ****** *)

implement
main0 () =
{
val () = println! ("fact(10) = ", fact(10))
val () = assertloc (last<int>($list{int}(1,2,3)) = 3)
}

(* ****** ****** *)

(* end of [patguard.dats] *)
