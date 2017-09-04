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

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)

implement
fprint_val<int> = fprint_int
implement
fprint_val<string> = fprint_string

(* ****** ****** *)

extern
fun {
a,b:t@ype
} list0_zip
  (xs: list0(a), ys: list0(b)): list0($tup(a, b))
//
implement
{a,b}
list0_zip(xs, ys) =
(
case xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x, xs) =>
  (
    case+ ys of
    | list0_nil() =>
      list0_nil()
    | list0_cons(y, ys) =>
      list0_cons($tup(x, y), list0_zip<a,b>(xs, ys))
  )
)

(* ****** ****** *)

extern
fun
{a
,b:t@ype}
{c:t@ype}
list0_map2
(xs: list0(a), ys: list0(b), fopr: cfun(a, b, c)): list0(c)
//
implement
{a,b}{c}
list0_map2
(xs, ys, fopr) =
(
case xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x, xs) =>
  (
    case+ ys of
    | list0_nil() =>
      list0_nil()
    | list0_cons(y, ys) =>
      list0_cons(fopr(x, y), list0_map2<a,b><c>(xs, ys, fopr))
  ) (* end of [list0_cons] *)
)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_merge
( xs: list0(a)
, ys: list0(a), cmp: cfun(a, a, int)): list0(a)
//
implement
{a}(*tmp*)
list0_merge
(xs0, ys0, cmp) = let
//
fun
auxlst
( xs0: list0(a)
, ys0: list0(a)
) : list0(a) = (
//
case+ xs0 of
| list0_nil() => ys0
| list0_cons
    (x1, xs1) => (
    case+ ys0 of
    | list0_nil() => xs0
    | list0_cons
        (y1, ys1) => let
        val sgn = cmp(x1, y1)
      in
        if (sgn <= 0)
          then list0_cons(x1, auxlst(xs1, ys0))
          else list0_cons(y1, auxlst(xs0, ys1))
        // end of [if]
      end // end of [list0_cons]
  ) (* end of [list0_cons] *)
//
) (* end of [auxlst] *)
//
in
  auxlst(xs0, ys0)
end // end of [list0_merge]

(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_mergesort
(xs: list0(a), cmp: cfun(a, a, int)): list0(a)
//
implement
{a}(*tmp*)
list0_mergesort
  (xs, cmp) = let
//
// It is assumed
// that length(xs) = n
//
fun
msort
(xs: list0(a), n: int): list0(a) =
if
(n >= 2)
then let
  val n1 = n / 2
  val xs1 = list0_take_exn(xs, n1)
  val xs2 = list0_drop_exn(xs, n1)
in
  list0_merge<a>(msort(xs1, n1), msort(xs2, n-n1), cmp)
end // end of [then]
else (xs) // end of [else]
//
in
  msort(xs, list0_length<a>(xs))
end // end of [list0_mergesort]

(* ****** ****** *)
//
val xs =
g0ofg1($list{int}(9, 2, 7, 8, 1, 6, 5, 4, 3, 0))
//
val () =
println! ("xs = ", xs)
val () =
println!
("sort(xs) = ", list0_mergesort<int>(xs, lam(x, y) => compare(x, y)))
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_choose2
(xs: list0(a)): list0($tup(a, a))
//
implement
{a}(*tmp*)
list0_choose2
  (xs) = let
//
typedef aa = $tup(a, a)
//
in
//
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x0, xs) =>
  list0_append<aa>
  (list0_map<a><aa>(xs, lam(x) => $tup(x0, x)), list0_choose2(xs))
//
end // end of [list0_choose2]
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_mapcons
  (x0: a, xss: list0(list0(a))): list0(list0(a))
//
implement
{a}(*tmp*)
list0_mapcons
  (x0, xss) =
(
list0_map<list0(a)><list0(a)>(xss, lam(xs) => list0_cons(x0, xs))
) (* list0_mapcons *)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_nchoose
(xs: list0(a), n: int): list0(list0(a))
//
implement
{a}(*tmp*)
list0_nchoose
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
  list0_append<xs>
  (list0_mapcons<a>(x0, auxlst(xs, n-1)), auxlst(xs, n))
) (* end of [else] *)
)
//
} (* end of [list0_nchoose] *)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_nchoose_rest
(xs: list0(a), n: int): list0($tup(list0(a), list0(a)))
//
implement
{a}(*tmp*)
list0_nchoose_rest
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
} (* end of [list0_nchoose_rest] *)

(* ****** ****** *)
//
fun
{a:t@ype}
list0_permute
(xs: list0(a)): list0(list0(a)) =
(
case+ xs of
| list0_nil() =>
  list0_cons(nil0(), nil0())
| list0_cons _ => let
    typedef xs = list0(a)
    typedef out = list0(xs)
    typedef inp = $tup(xs, xs)
  in
    list0_concat<xs>
    (
     list0_map<inp><out>
     ( list0_nchoose_rest<a>(xs, 1)
     , lam($tup(ys, zs)) => list0_mapcons<a>(ys[0], list0_permute<a>(zs))
     )
    ) (* list0_concat *)
  end (* end of [list0_cons] *)
)
//
(* ****** ****** *)
//
val () =
println!
("permute(1, 2, 3, 4):")
//
val () =
fprint_listlist0_sep
( stdout_ref
, list0_permute<int>(g0ofg1($list{int}(1,2,3,4))), "\n", ",")
//
val () = println!((*void*))
//
(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture07.dats] *)
