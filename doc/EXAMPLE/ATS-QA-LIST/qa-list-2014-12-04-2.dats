(*
**
** An example of merging datatypes
**
*)

(* ****** ****** *)

abstype bottom

(* ****** ****** *)
//
datatype dt1 =
| A1 of () | B1 of (int, dt1) | C1 of bottom
//
datatype dt2 =
| A2 of () | B2 of (int, dt2) | C2 of (dt1, dt2)
//
(* ****** ****** *)

datatype dt12 =
| A12 of () | B12 of (int, dt12) | C12 of (dt12, dt12)

(* ****** ****** *)

extern
castfn dt1_to_dt12 : dt1 -<fun> dt12
extern
castfn dt2_to_dt12 : dt2 -<fun> dt12

(* ****** ****** *)
//
extern
fun{
dt:type
} print_dt : (dt) -> void
//
extern
fun{
dt:type
} print_dt_B : dt -> void
//
(* ****** ****** *)
//
fun{}
print_dt1 (x:dt1): void = print_dt<dt1> (x)
fun{}
print_dt2 (x:dt2): void = print_dt<dt2> (x)
fun{}
print_dt12 (x:dt12): void = print_dt<dt12> (x)
//
overload print with print_dt1
overload print with print_dt2
overload print with print_dt12
//
(* ****** ****** *)

implement
print_dt<dt12>
  (x0) =
(
  case+ x0 of
  | A12 () => print! ("A(", ")")
  | B12 (i, x1) => print_dt_B<dt12> (x0)
  | C12 (x1, x2) => print! ("C(", x1, ", ", x2, ")")
) (* end of [print_dt<dt12>] *)

implement
print_dt_B<dt12> (x0) = let
  val-B12(i, x1) = x0 in print! ("B(", i, ", ", x1, ")")
end // end of [print_dt_B<dt12>]

(* ****** ****** *)
//
implement
print_dt<dt1> (x0) = let
//
implement
print_dt_B<dt12>
  (x0) = let
  val-B12 (i, x1) = x0
in
  print! ("B1(", i, ", ", x1, ")")
end // [print_dt_B<dt12>]
//
val () = print_dt<dt12> (dt1_to_dt12(x0))
//
in
  ignoret(0)
end // end of [print_dt<dt1>]
//
(* ****** ****** *)
//
implement
print_dt<dt2> (x0) = let
//
implement
print_dt_B<dt12>
  (x0) = let
  val-B12 (i, x1) = x0
in
  print! ("B2(", i, ", ", x1, ")")
end // [print_dt_B<dt12>]
//
val () = print_dt<dt12> (dt2_to_dt12(x0))
//
in
  ignoret(0)
end // end of [print_dt<dt2>]
//
(* ****** ****** *)

val x0_dt1 = A1 ()
val x1_dt1 = B1 (1, x0_dt1)
val () = println! ("x1_dt1 = ", x1_dt1)

(* ****** ****** *)

val x0_dt2 = A2 ()
val x1_dt2 = B2 (2, x0_dt2)
val x2_dt2 = C2 (x1_dt1, x1_dt2)
val () = println! ("x2_dt1 = ", x2_dt2)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [qa-list-2014-12-04-2.dats] *)
