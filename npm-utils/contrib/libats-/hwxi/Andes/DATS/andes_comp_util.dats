(* ****** ****** *)
(*
** For Andes
** computational utilities
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#staload
"libats/libc/DATS/math.dats"
//
(* ****** ****** *)
//
staload
"./../SATS/andes_comp.sats"
//
(* ****** ****** *)
//
staload
MATH =
"libats/libc/SATS/math.sats"
//
(* ****** ****** *)

implement
//{}(*tmp*)
list_mean
  (xs) =
  loop(xs, 1, x) where
{
//
val+list_cons(x, xs) = xs
//
fun
loop
(
xs: List(double), n: int, tot: double
) : double =
(
case+ xs of
| list_nil() => (tot / n)
| list_cons(x, xs) => loop(xs, n+1, tot + x)
)
//
} (* end of [list_mean] *)

(* ****** ****** *)

implement
//{}(*tmp*)
list_stdev
  (xs) = let
//
val n0 = list_length(xs)
//
local
implement
list_foldleft$fopr<double><double>
  (res, x) = res+x
in
val tot =
  list_foldleft<double><double>(xs, 0.0)
end // end of [local]
//
val mean = tot / n0
//
fun sq(x: double) = x*x
//
local
implement
list_foldleft$fopr<double><double>
  (res, x) = res+sq(x-mean)
in
val sqsum =
  list_foldleft<double><double>(xs, 0.0)
end // end of [local]
//
in
  $MATH.sqrt(sqsum / (n0-1))
end // end of [list_stdev]

(* ****** ****** *)

implement
list_smooth
  (xs, k) =
  auxlst(xs) where
{
//
fun
aux
(
xs: List(double),
sum: double, i: intGte(1)
) : double =
(
if
(i < k)
then
(
case+ xs of
| list_nil() => sum / i
| list_cons(x, xs) => aux(xs, sum+x, i+1)
)
else (sum / i)
)
//
fun
auxlst
(
xs: List(double)
) : stream_vt(double) = $ldelay
(
case+ xs of
| list_nil() =>
  stream_vt_nil()
| list_cons(x, xs) =>
  stream_vt_cons(aux(xs, x, 1), auxlst(xs))
)
//
} (* end of [list_smooth] *)

(* ****** ****** *)

(* end of [andes_comp_util.dats] *)
