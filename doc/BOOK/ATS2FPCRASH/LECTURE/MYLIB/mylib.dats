(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
extern
fun{}
int_foreach
( n0: int
, fwork: cfun(int, void)): void
extern
fun{}
int_foreach_method
(n0: int)(fwork: cfun(int, void)): void
//
overload .foreach with int_foreach_method of 100
//
(* ****** ****** *)

implement
{}(*tmp*)
int_foreach
  (n0, fwork) =
  loop(0) where
{
//
fun loop(i: int): void =
  if i < n0 then (fwork(i); loop(i+1))
//
} (* end of [int_foreach] *)

implement
{}(*tmp*)
int_foreach_method(n0) =
lam(fwork) => int_foreach<>(n0, fwork)

(* ****** ****** *)
//
extern
fun
{res:t@ype}
int_foldleft
( n0: int
, res: res
, fopr: cfun(res, int, res)): res
extern
fun
{res:t@ype}
int_foldleft_method
(n0: int, ty: TYPE(res))
(res: res, fopr: cfun(res, int, res)): res
//
overload .foldleft with int_foldleft_method of 100
//
(* ****** ****** *)
//
implement
{res}(*tmp*)
int_foldleft
  (n0, res, fopr) =
  loop(res, 0) where
{
//
fun loop(res: res, i: int): res =
  if i < n0
    then loop(fopr(res, i), i+1) else res
  // end of [if]
//
} (* end of [int_foldleft] *)
//
implement
{res}(*tmp*)
int_foldleft_method(n0, ty) =
lam(res, fopr) => int_foldleft<res>(n0, res, fopr)
//
(* ****** ****** *)
//
extern
fun{}
int_cross_foreach
(m: int, n: int, fwork: cfun(int, int, void)): void
//
implement
{}(*tmp*)
int_cross_foreach
  (m, n, fwork) =
  int_foreach(m, lam(i) => int_foreach(n, lam(j) => fwork(i, j)))
//
(* ****** ****** *)
//
// For list0-values
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_length(xs0: list0(a)): int
//
(*
implement
list0_length
(
case+ xs0 of
| list0_nil() => 0
| list0_cons(x0, xs1) => 1 + list0_length<a>(xs1)
) (* end of [list0_length] *)
*)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_append
(xs: list0(INV(a)), ys: list0(a)): list0(a)
//
extern
fun
{a:t@ype}
list0_concat(xs: list0(list0(INV(a)))): list0(a)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_reverse(xs: list0(INV(a))): list0(a)
and
list0_revappend
(xs: list0(INV(a)), ys: list0(a)): list0(a)
//
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
implement
{a}(*tmp*)
list0_length(xs) =
  list0_foldleft<int><a>(xs, 0, lam(r, _) => r + 1)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_append(xs, ys) =
  list0_foldright<a><list0(a)>
  (xs, lam(x, ys) => list0_cons(x, ys), list0_nil())
//
implement
{a}(*tmp*)
list0_concat(xss) =
  list0_foldright<list0(a)><list0(a)>
  (xss, lam(xs, res) => list0_append(xs, res), list0_nil())
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_reverse(xs) =
  list0_revappend<a>(xs, list0_nil())
//
implement
{a}(*tmp*)
list0_revappend(xs, ys) =
  list0_foldleft<list0(a)><a>(xs, ys, lam(ys, x) => list0_cons(x, ys))
//
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
  if test(x)
    then list0_cons(x, auxlst(xs)) else auxlst(xs)
  // end of [if]
)
//
} (* end of [list0_filter] *)

(* ****** ****** *)

(* end of [mylib.dats] *)
