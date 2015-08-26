//
// A simple example of
// datatype and datavtype
//
(* ****** ****** *)
//
datatype
weekday =
| Monday of () | Tuesday of ()
| Wednesday of () | Thursday of () | Friday of ()
| Saturday of () | Sunday of ()
//
(* ****** ****** *)
//
extern
fun datcon_weekday: (weekday) -> string
extern
fun datcontag_weekday: (weekday) -> natLt(7)
//
overload datcon with datcon_weekday
overload datcontag with datcontag_weekday
//
#codegen2(datcon, weekday, datcon_weekday)
#codegen2(datcontag, weekday, datcontag_weekday)
//
(* ****** ****** *)
//
extern
fun{}
fprint_weekday: (FILEref, weekday) -> void
//
(*
#codegen2(fprint, weekday, fprint_weekday)
*)
//
(* ****** ****** *)

implement main0() =
{
//
val () = println! (datcon(Monday),    "=", datcontag(Monday))
val () = println! (datcon(Tuesday),   "=", datcontag(Tuesday))
val () = println! (datcon(Wednesday), "=", datcontag(Wednesday))
val () = println! (datcon(Thursday),  "=", datcontag(Thursday))
val () = println! (datcon(Friday),    "=", datcontag(Friday))
val () = println! (datcon(Saturday),  "=", datcontag(Saturday))
val () = println! (datcon(Sunday),    "=", datcontag_weekday(Sunday))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [codegen2.dats] *)
