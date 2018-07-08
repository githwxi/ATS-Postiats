(*
** Bug causing erroneous
** compilation of tuple pattern matching
*)

(* ****** ****** *)

(*
** Source:
** Reported by kiwamu-2015-04-21
** Symptom: match2(0, 1) returns **
** Symptom: match2(1, 1) returns **
*)

(* ****** ****** *)

(*
** Status: It is fixed by HX-2015-04-21
** See: patcomplst_subtest: auxlst2: PTCMPreclparen
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
| (0, 1) => println! "01"
| (1, 1) => println! "11"
| (_, _) => println! "**"
)

(* ****** ****** *)

fun
match2
(
  a: int, b: int
) :void =
(
case+ @(a, b) of
| @(0, 0) => println! "00"
| @(0, 1) => println! "01"
| @(1, 1) => println! "11"
| _ (*rest*) => println! "**"
)

(* ****** ****** *)
//
datatype
P(a:t@ype, b:t@ype) = P of (a, b)
//
fun
match3
(
  a: int, b: int
) :void =
(
case+ P(a,b) of
| P(0, 0) => println! "00"
| P(0, 1) => println! "01"
| P(1, 1) => println! "11"
| _ (*rest*) => println! "**"
)
//
(* ****** ****** *)

implement
main0 () =
{
//
  val () = (print! "match1(0, 0) = "; match1(0, 0))
  val () = (print! "match1(0, 1) = "; match1(0, 1))
  val () = (print! "match1(1, 1) = "; match1(1, 1))
//
  val () = (print! "match2(0, 0) = "; match2(0, 0))
  val () = (print! "match2(0, 1) = "; match2(0, 1))
  val () = (print! "match2(1, 1) = "; match2(1, 1))
//
  val () = (print! "match3(0, 0) = "; match3(0, 0))
  val () = (print! "match3(0, 1) = "; match3(0, 1))
  val () = (print! "match3(1, 1) = "; match3(1, 1))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [bug-2015-04-21.dats] *)
