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
fprint_weekday
  (FILEref, wday: weekday): void
//
overload fprint with fprint_weekday
//
#codegen2(fprint, weekday, fprint_weekday)
//
(* ****** ****** *)

(* end of [codegen2.dats] *)
