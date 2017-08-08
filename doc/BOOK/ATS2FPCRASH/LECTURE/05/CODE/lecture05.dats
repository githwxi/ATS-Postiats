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

fun
{a:t@ype}
list0_append
(xs: list0(a),
 ys: list0(a)): list0(a) =
(
case+ xs of
| list0_nil() => ys
| list0_cons(x, xs) =>
  list0_cons(x, list0_append<a>(xs, ys))
) (* end of [list0_append] *)

(* ****** ****** *)

fun
{a:t@ype}
list0_reverse
(xs: list0(a)): list0(a) =
list0_revappend<a>(xs, list0_nil())

and
list0_revappend
(xs: list0(a),
 ys: list0(a)): list0(a) =
(
case+ xs of
| list0_nil() => ys
| list0_cons(x, xs) =>
  list0_revappend<a>(xs, list0_cons(x, ys))
) (* end of [list0_revappend] *)

(* ****** ****** *)

val () =
println! ("|xs3| = ", list0_length<int>(xs3))

(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture04.dats] *)
