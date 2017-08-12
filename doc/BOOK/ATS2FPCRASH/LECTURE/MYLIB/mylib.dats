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

extern
fun
{a:t@ype}
list0_append
(xs: list0(a), ys: list0(a)): list0(a)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_reverse(xs: list0(a)): list0(a)
and
list0_revappend
(xs: list0(a), ys: list0(a)): list0(a)
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
list0_reverse(xs) =
  list0_revappend<a>(xs, list0_nil())
//
implement
{a}(*tmp*)
list0_revappend(xs, ys) =
  list0_foldleft<list0(a)><a>(xs, ys, lam(ys, x) => list0_cons(x, ys))
//
(* ****** ****** *)

(* end of [mylib.dats] *)
