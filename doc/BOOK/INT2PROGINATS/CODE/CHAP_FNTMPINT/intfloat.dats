(* ****** ****** *)
//
// For use in INT2PROGINATS
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
datatype
intfloat =
  INT of int | FLOAT of double
//
(* ****** ****** *)
//
fun
print_intfloat
  (x: intfloat): void =
(
case+ x of
| INT(int) => print_int(int)
| FLOAT(float) => print_double(float)
)
//
(* ****** ****** *)
//
fun
fprint_intfloat
(
  x: intfloat
, print_int: int -> void
, print_float: double -> void
) : void =
(
case+ x of
| INT(int) => print_int(int)
| FLOAT(float) => print_double(float)
)
//
(* ****** ****** *)
//
fun
fprint2_intfloat
(
  x: intfloat
, print_int: int -> void
, print_float: double -> void
) : void =
(
case+ x of
| INT(int) =>
  (print "INT("; print_int(int); print ")")
| FLOAT(float) =>
  (print "FLOAT("; print_double(float); print ")")
)
//
(* ****** ****** *)

val i0 = INT(0)
val f1 = FLOAT(1.0)

(* ****** ****** *)

val () =
fprint_intfloat(i0, lam i => print_int(i), lam f => print_double(f))
val () = print_newline ()
val () =
fprint_intfloat(f1, lam i => print_int(i), lam f => print_double(f))
val () = print_newline ()

(* ****** ****** *)

val () =
fprint2_intfloat(i0, lam i => print_int(i), lam f => print_double(f))
val () = print_newline ()
val () =
fprint2_intfloat(f1, lam i => print_int(i), lam f => print_double(f))
val () = print_newline ()

(* ****** ****** *)
//
extern
fun{}
tprint_int(int): void
extern
fun{}
tprint_double(double): void
extern
fun{}
tprint_intfloat(intfloat): void
//
(* ****** ****** *)

implement
tprint_int<> (x) = print_int(x)
implement
tprint_double<> (x) = print_double(x)

(* ****** ****** *)
//
implement
tprint_intfloat<> (x) =
(
case+ x of
| INT(int) => tprint_int<> (int)
| FLOAT(float) => tprint_double<> (float)
)
//
(* ****** ****** *)
//
val () = (
  tprint_intfloat<> (INT(0)); print_newline()
) (* end of [val] *)
//
val () = (
  tprint_intfloat<> (FLOAT(1.0)); print_newline()
) (* end of [val] *)
//
(* ****** ****** *)

local
//
implement
tprint_int<> (x) = print! ("INT(", x, ")")
implement
tprint_double<> (x) = print! ("FLOAT(", x, ")")
//
in (* in-of-local *)
//
val () = (
  tprint_intfloat<> (INT(0)); print_newline()
) (* end of [val] *)
//
val () = (
  tprint_intfloat<> (FLOAT(1.0)); print_newline()
) (* end of [val] *)
//
end // end of [local]

(* ****** ****** *)

implement main0() = ()

(* ****** ****** *)

(* end of [intfloat.dats] *)
