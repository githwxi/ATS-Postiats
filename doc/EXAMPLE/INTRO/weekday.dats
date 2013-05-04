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

implement main0 () = ()

(* ****** ****** *)

(* end of [weekday.dats] *)

