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

extern
fun
{a:t@ype}
{b:t@ype}
list0_map
(xs: list0(INV(a)), fopr: cfun(a, b)): list0(b)

(* ****** ****** *)

extern
fun
{a:t@ype}
list0_filter
(xs: list0(INV(a)), pred: cfun(a, bool)): list0(a)

(* ****** ****** *)

implement
{a}{b}
list0_map
(
  xs, fopr
) = auxlst(xs) where
{
//
fun
auxlst
(xs: list0(a)): list0(b) =
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x, xs) =>
  list0_cons(fopr(x), auxlst(xs))
)
//
} (* end of [list0_map] *)

(* ****** ****** *)

val xs =
g0ofg1($list{int}(1, 2, 3, 4, 5))
val () =
println! ("map(xs, square) = ", list0_map<int><int>(xs, lam(x) => x * x))

(* ****** ****** *)

implement
{a}(*tmp*)
list0_filter
(
  xs, test
) = auxlst(xs) where
{
//
fun
auxlst
(xs: list0(a)): list0(a) =
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x, xs) =>
  if test(x) then list0_cons(x, auxlst(xs)) else auxlst(xs)
)
//
} (* end of [list0_filter] *)

(* ****** ****** *)

val xs =
g0ofg1($list{int}(1, 2, 3, 4, 5))
val () =
println! ("filter(xs, isevn) = ", list0_filter<int>(xs, lam(x) => x % 2 = 0))

(* ****** ****** *)

extern
fun
{a:t@ype}
list0_choose_rest
(
  xs: list0(INV(a)), n: int
) : list0($tup(list0(a), list0(a)))

(* ****** ****** *)

fun
{a:t@ype}
list0_permute
(xs: list0(a)): list0(list0(a)) =
(
case+ xs of
| list0_nil() => list0_sing(nil0)
| list0_cons _ => let
    typedef out = list0(list0(a))
    typedef inp = $tup(list0(a), list0(a))
  in
    list0_concat
    (
     list0_map<inp><out>
     ( list0_choose_rest(xs, 1)
     , lam($tup(ys, zs)) => list0_mapcons(ys[0], list0_permute(zs))
     )
    )
  end (* end of [list0_cons] *)
)


(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture06.dats] *)
