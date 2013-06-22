//
// A simple example of datatype
//
(* ****** ****** *)
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
//
// Start time: May 2013
//
(* ****** ****** *)

datatype
weekday =
| Monday of ()
| Tuesday of ()
| Wednesday of ()
| Thursday of ()
| Friday of ()

(* ****** ****** *)

val-Monday () = Monday ()
val-Tuesday () = Tuesday ()
val-Wednesday () = Wednesday ()
val-Thursday () = Thursday ()
val-Friday () = Friday ()

(* ****** ****** *)

fun isFriday
  (x: weekday): bool =
  case+ x of Friday () => true | _ => false
// end of [isFriday]

val () = assertloc (~isFriday(Monday))
val () = assertloc (~isFriday(Tuesday))
val () = assertloc (~isFriday(Wednesday))
val () = assertloc (~isFriday(Thursday))
val () = assertloc ( isFriday(Friday) )

(* ****** ****** *)

fun isFriday2
  (x: weekday): bool =
  case+ 0 of _ when x as Friday _ => true | _ => false
// end of [isFriday2]

val () = assertloc (~isFriday2(Monday))
val () = assertloc (~isFriday2(Tuesday))
val () = assertloc (~isFriday2(Wednesday))
val () = assertloc (~isFriday2(Thursday))
val () = assertloc ( isFriday2(Friday) )

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [weekday.dats] *)

