(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#staload "./../../MYLIB/mylib.dats"

(* ****** ****** *)

val xs0 = list0_nil{int}() // xs = ()
val xs1 = list0_cons(1, xs0) // xs = (1)
val xs2 = list0_cons(2, xs1) // xs = (2, 1)
val xs3 = list0_cons(3, xs2) // xs = (3, 2, 1)

(* ****** ****** *)

fun
{a:t@ype}
list0_length
  (xs0: list0(a)): int =
(
case+ xs0 of
| list0_nil() => 0
| list0_cons(x0, xs1) =>
  1 + list0_length<a>(xs1)
) (* end of [list0_length] *)

(* ****** ****** *)

val () =
println! ("|xs3| = ", list0_length<int>(xs3))

(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture04.dats] *)
