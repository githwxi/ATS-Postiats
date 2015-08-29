(* ****** ****** *)

#include "./codegen2_out.dats"

(* ****** ****** *)
//
fun{}
print_weekday
  (x: weekday) =
  fprint_weekday(stdout_ref, x)
//
overload print with print_weekday
//
(* ****** ****** *)

implement
fprint_weekday$lpar<>(out) = fprint(out, "[")
implement
fprint_weekday$rpar<>(out) = fprint(out, "]")

(* ****** ****** *)

implement main0() =
{
//
val () = println! (Monday,    "=", datcontag(Monday))
val () = println! (Tuesday,   "=", datcontag(Tuesday))
val () = println! (Wednesday, "=", datcontag(Wednesday))
val () = println! (Thursday,  "=", datcontag(Thursday))
val () = println! (Friday,    "=", datcontag(Friday))
val () = println! (Saturday,  "=", datcontag(Saturday))
val () = println! (Sunday,    "=", datcontag_weekday(Sunday))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [codegen2_test.dats] *)
