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
//
val x = 10
val () = assertloc (abs(x) = max(x, 0) - min(x, 0))
val x = ~10
val () = assertloc (abs(x) = max(x, 0) - min(x, 0))
//
val () = assertloc (10 mod 2 = 0)
val () = assertloc (10 mod 3 = 1)
val () = assertloc ((10 \nmod 5) = 0)
val () = assertloc ((10 \nmod 7) = 3)
//
macdef ngcd = g1int_ngcd
val () = assertloc ((0 \ngcd 0) = 0)
val () = assertloc ((15 \ngcd 27) = 3)
val () = assertloc ((24 \ngcd 60) = 12)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val () = assertloc (pred(succ(0u)) = 0)
val () = assertloc (succ(pred(1u)) = 1)
val () = assertloc (1u + 2u = 2u + 1u)
val () = assertloc ((1u + 2u) + 3u = 1 + (2 + 3))
val () = assertloc (1u * 2u = 2u * 1u)
val () = assertloc ((1u * 2u) * 3u = 1 * (2 * 3))
//
val () = assertloc (10u mod 2u = 0)
val () = assertloc (10u mod 3u = 1)
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
val () = assertloc ((1 << 0) = 1)
val () = assertloc ((1 >> 0) = 1)
val () = assertloc ((1 << 10) = 1024)
val () = assertloc ((1024 >> 10) = 1)
//
val () = assertloc ((1U << 0) = 1U)
val () = assertloc ((1U >> 0) = 1U)
val () = assertloc ((1U << 10) = 1024U)
val () = assertloc ((1024U >> 10) = 1U)
//
val () = assertloc ((1L << 10) = 1024L)
val () = assertloc ((1024L >> 10) = 1L)
//
val x = 0x1234U
val () = assertloc ((x lor x) = x)
val () = assertloc ((x lor ~x) = g0i2u(~1))
val () = assertloc ((x land x) = x)
val () = assertloc ((x land ~x) = 0U)
val () = assertloc ((x lxor x) = 0U)
val () = assertloc ((0x0000U lor x) = x)
val () = assertloc ((0xFFFFU land x) = x)
//
val x = 0x123456UL
val () = assertloc ((x lor x) = x)
val () = assertloc ((x lor ~x) = g0i2u(~1L))
val () = assertloc ((x land x) = x)
val () = assertloc ((x land ~x) = 0UL)
val () = assertloc ((x lxor x) = 0UL)
val () = assertloc ((0x000000UL lor x) = x)
val () = assertloc ((0xFFFFFFUL land x) = x)
//
val x = 0x12345678ULL
val () = assertloc ((x lor x) = x)
val () = assertloc ((x lor ~x) = g0i2u(~1LL))
val () = assertloc ((x land x) = x)
val () = assertloc ((x land ~x) = 0ULL)
val () = assertloc ((x lxor x) = 0ULL)
val () = assertloc ((0x00000000ULL lor x) = x)
val () = assertloc ((0xFFFFFFFFULL land x) = x)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_integer.dats] *)
