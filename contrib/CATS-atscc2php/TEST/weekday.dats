(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to PHP
//
(* ****** ****** *)
//
#define
LIBATSCC2PHP_targetloc
"$PATSHOME\
/contrib/libatscc2php/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2PHP}/staloadall.hats"
//
(* ****** ****** *)

datatype
weekday =
  | Monday of ()
  | Tuesday of ()
  | Wednesday of ()
  | Thursday of () | Friday of ()
  | Saturday of () | Sunday of ()
// end of [weekday]

(* ****** ****** *)

fun
isweekend
  (x: weekday): bool =
(
  case+ x of
  | Saturday () => true | Sunday () => true | _ => false 
) (* end of [isweekend] *)

(* ****** ****** *)
//
extern
fun
weekday_test(): void = "mac#weekday_test"
//
(* ****** ****** *)

implement
weekday_test() =
{
  val () = println! ("isweekend(Monday) = ", isweekend(Monday))
  val () = println! ("isweekend(Saturday) = ", isweekend(Saturday))
}

(* ****** ****** *)

(* end of [weekday.dats] *)
