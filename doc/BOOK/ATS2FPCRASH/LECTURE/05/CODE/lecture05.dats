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
//
extern
fun
{r:t@ype}
{a:t@ype}
list0_foldleft
(
xs: list0(a), r0: r, fopr: cfun(r, a, r)
) : (r) // end of [list0_foldleft]
//
implement
{r}{a}
list0_foldleft
(xs, r0, fopr) =
  loop(xs, r0) where
{
fun
loop(xs: list0(a), r0: r): r =
case+ xs of
| list0_nil() => r0
| list0_cons(x, xs) => loop(xs, fopr(r0, x))
}
//
(* ****** ****** *)
//
fun
{a:t@ype}
list0_length
  (xs: list0(a)): int =
  list0_foldleft<int><a>(xs, 0, lam(r, _) => r + 1)
//
fun
{a:t@ype}
list0_revappend
(
xs: list0(a),
ys: list0(a)
) : list0(a) =
  list0_foldleft<list0(a)><a>(xs, ys, lam(ys, x) => list0_cons(x, ys))
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{r:t@ype}
list0_foldright
( xs: list0(a)
, fopr: cfun(a, r, r), r0: r): r
//
implement
{a}{r}
list0_foldright
( xs
, fopr, r0) =
auxlst(xs) where
{
fun
auxlst
(xs: list0(a)): r =
(
case+ xs of
| list0_nil() => r0
| list0_cons(x, xs) => fopr(x, auxlst(xs))
) (* end of [auxlst] *)
}
//
(* ****** ****** *)

val () =
println! ("|xs3| = ", list0_length<int>(xs3))

(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture05.dats] *)
