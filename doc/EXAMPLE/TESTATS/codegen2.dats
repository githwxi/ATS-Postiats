//
// testing for
// #codegen2(...)
//
(* ****** ****** *)
//
// Author: HX-2015-08-28
//
(* ****** ****** *)
//
datatype abc =
| A of () | B of (int) | C of (abc, abc)

(* ****** ****** *)
//
extern
fun{}
fprint_abc : fprint_type (abc)
//
overload fprint with fprint_abc
//
#codegen2(fprint, abc, fprint_abc)
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
fun{}
datcon_weekday: (weekday) -> string
extern
fun{}
datcontag_weekday: (weekday) -> natLt(7)
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
