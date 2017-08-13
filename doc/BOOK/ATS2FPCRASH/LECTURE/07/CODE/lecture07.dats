(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#define :: list0_cons

(* ****** ****** *)

macdef
list0_sing(x) =
list0_cons(,(x), list0_nil())

(* ****** ****** *)

#staload "./../../MYLIB/mylib.dats"

(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_choose
(xs: list0(a), n: int): list0(list0(a))
//
implement
{a}(*tmp*)
list0_choose
  (xs, n) =
  auxlst(xs, n) where
{
//
typedef xs = list0(a)
//
fun
auxlst
(
xs: xs, n: int
) : list0(xs) =
(
if
(n <= 0)
then
list0_sing(list0_nil())
else
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x0, xs) =>
  list0_append<xs>(list0_mapcons(x0, auxlst(xs, n-1)), auxlst(xs, n))
) (* end of [else] *)
)
//
} (* end of [list0_choose] *)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_choose_rest
(xs: list0(a), n: int): list0($tup(list0(a), list0(a)))
//
implement
{a}(*tmp*)
list0_choose_rest
  (xs, n) =
  auxlst(xs, n) where
{
//
typedef xs = list0(a)
typedef xsxs = $tup(xs, xs)
//
fun
auxlst
(
xs: xs, n: int
) : list0(xsxs) =
(
if
(n <= 0)
then
list0_sing
($tup(list0_nil(), xs))
else
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x0, xs) => let
    val res1 =
    list0_map<xsxs><xsxs>
    ( auxlst(xs, n-1)
    , lam($tup(xs1, xs2)) => $tup(list0_cons(x0, xs1), xs2)
    )
    val res2 =
    list0_map<xsxs><xsxs>
    ( auxlst(xs, n-0)
    , lam($tup(xs1, xs2)) => $tup(xs1, list0_cons(x0, xs2))
    )
  in
    list0_append<xsxs>(res1, res2)
  end // end of [list0_cons]
) (* end of [else] *)
)
//
} (* end of [list0_choose_rest] *)

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
//
(* ****** ****** *)

val () =
println!
("permute(1, 2, 3, 4):")
val () =
fprint_listlist0_sep
(stdout_ref, list0_permute(g0ofg1($list{int}(1,2,3,4))), "\n", ",")
val () = println!((*void*))

(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture06.dats] *)
