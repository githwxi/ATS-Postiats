(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./codegen2.dats" // written

(* ****** ****** *)

#include "./codegen2_out.dats" // generated

(* ****** ****** *)
//
fun{}
print_abc
  (x: abc) =
  fprint_abc(stdout_ref, x)
//
overload print with print_abc
//
(* ****** ****** *)
//
implement
fprint_abc$carg<abc>
  (out, x) = fprint_abc<>(out, x)
//
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

implement
fprint_weekday$Monday$con<>(out, _) = fprint(out, "Mon")
implement
fprint_weekday$Wednesday$con<>(out, _) = fprint(out, "Wed")

(* ****** ****** *)

implement main0() =
{
//
val () = println! (A())
val () = println! (B(1))
local
implement
fprint_abc$A<>(out, _) = fprint(out, "A")
in // in-of-locl
val () = println! (C(A(), B(1)))
end // end of [local]
//
val () = println! (Monday,    "=", datcontag(Monday))
val () = println! (Tuesday,   "=", datcontag(Tuesday))
val () = println! (Wednesday, "=", datcontag(Wednesday))
val () = println! (Thursday,  "=", datcontag(Thursday))
val () = println! (Friday,    "=", datcontag(Friday))
val () = println! (Saturday,  "=", datcontag(Saturday))
val () = println! (Sunday,    "=", datcontag(Sunday))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [codegen2_test.dats] *)
