(*
** for testing [prelude/float]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define EPSILON 1E-8

(* ****** ****** *)

val () =
{
  val () = assertloc (succ(1.0) = 2.0)
  val () = assertloc (pred(2.0) = 1.0)
  val () = assertloc (1.0 + 2.0 = 3.0)
  val () = assertloc (2.0 - 1.0 = 1.0)
  val () = assertloc (3.0 * 3.0 = 9.0)
  val () = assertloc (abs (3. / 3.0 - 1.0) < EPSILON)
  val () = assertloc (abs (8. / (3 - 8.0 / 3) - 24.0) < EPSILON)
  val () = assertloc (abs (5. - 11. / 7.) * 7. - 24.0 < EPSILON)
  val () = assertloc (5.0 mod 3.0 = 2.0)
  val () = assertloc (10.0 mod 3.0 = 1.0)
  val () = assertloc (21.0 mod 3.0 = 0.0)
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
  val () = assertloc (1.0 < 2)
  val () = assertloc (1.0 <= 2)
  val () = assertloc (~1.0 > ~2)
  val () = assertloc (~1.0 >= ~2)
  val () = assertloc (1.0 = 1)
  val () = assertloc (0.0 != 1)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
  val () = assertloc (1.0 < 2.0)
  val () = assertloc (1.0 <= 2.0)
  val () = assertloc (~1.0 > ~2.0)
  val () = assertloc (~1.0 >= ~2.0)
  val () = assertloc (1.0 = 1.0)
  val () = assertloc (0.0 != 1.0)
  val () = assertloc (1.0 <> 0.0)
//
  val () = assertloc (compare (1.0, 9.0) = ~1)
  val () = assertloc (compare (5.0, 5.0) =  0)
  val () = assertloc (compare (9.0, 1.0) =  1)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val () = assertloc(3.1416 = g0string2float_double("3.1416"))
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_float.dats] *)
