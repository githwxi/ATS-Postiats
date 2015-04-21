(*
** Bug causing erroneous
** compilation of tuple pattern matching
*)

(* ****** ****** *)

(*
** Source:
** Reported by kiwamu-2015-04-21
*)

(* ****** ****** *)

fun
match1
(
  a:int, b:int
) :void =
(
case+ (a, b) of
| (0, 0) => println! "00"
| (1, 1) => println! "11"
| (_, _) => println! "**"
)

(* ****** ****** *)

fun
match2
(
  ab: (int,int)
) :void =
(
case+ ab of
| @(0, 0) => println! "00"
| @(1, 1) => println! "11"
| _ (*rest*) => println! "**"
)

(* ****** ****** *)

implement
main0 () =
{
//
  val () =
  print! "match1(1, 1) = "
  val () = match1(1, 1)
//
  val () =
  print! "match2(1, 1) = "
  val () = match2((1, 1))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [bug-2015-04-21.dats] *)
