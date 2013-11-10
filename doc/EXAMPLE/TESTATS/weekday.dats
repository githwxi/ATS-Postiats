//
// A simple example of datatype
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: May, 2013
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

datavtype
weekday_vt =
| Monday_vt of ()
| Tuesday_vt of ()
| Wednesday_vt of ()
| Thursday_vt of ()
| Friday_vt of ()

(* ****** ****** *)

val-~Monday_vt () = Monday_vt ()
val-~Tuesday_vt () = Tuesday_vt ()
val-~Wednesday_vt () = Wednesday_vt ()
val-~Thursday_vt () = Thursday_vt ()
val-~Friday_vt () = Friday_vt ()

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [weekday.dats] *)

