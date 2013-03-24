(*
** for testing [prelude/float]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

#define EPSILON 1E-8

(* ****** ****** *)

val () = {
//
val () = assertloc (~(~(1)) = 1)
val () = assertloc (neg(neg(~1)) = ~1)
val () = assertloc (abs(~10) = 10)
val () = assertloc (pred(succ(0)) = 0)
val () = assertloc (succ(pred(1)) = 1)
val () = assertloc (1 + 2 = 2 + 1)
val () = assertloc ((1 + 2) + 3 = 1 + (2 + 3))
val () = assertloc (1 * 2 = 2 * 1)
val () = assertloc ((1 * 2) * 3 = 1 * (2 * 3))
val x = 10
val () = assertloc (abs(x) = max(x, 0) - min(x, 0))
val x = ~10
val () = assertloc (abs(x) = max(x, 0) - min(x, 0))
val () = assertloc (10 mod 2 = 0)
val () = assertloc (10 mod 3 = 1)
val () = assertloc (10 mod 5 = 0)
val () = assertloc (10 mod 7 = 3)
//
} // end of [val]

(* ****** ****** *)

val () = {
//
val () = assertloc (1 < 2)
val () = assertloc (1 <= 2)
val () = assertloc (9 > 8)
val () = assertloc (9 >= 8)
val () = assertloc (5 = 5)
val () = assertloc (not(5 != 5))
val () = assertloc (compare (1, 9) = g1int_sgn(1-9))
val () = assertloc (compare (5, 5) = g1int_sgn(5-5))
val () = assertloc (compare (9, 1) = g1int_sgn(9-1))
//
} // end of [val]

(* ****** ****** *)

val () = {
//
val () = assertloc ((1 << 10) = 1024)
val () = assertloc ((1024 >> 10) = 1)
//
val () = assertloc ((1U << 10) = 1024U)
val () = assertloc ((1024U >> 10) = 1U)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_integer.dats] *)
