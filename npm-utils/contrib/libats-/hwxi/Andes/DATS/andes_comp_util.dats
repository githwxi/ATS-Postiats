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
listpre_mean
  (xs, n0) =
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
if
(n < n0)
then
(
case+ xs of
| list_nil() => (tot / n)
| list_cons(x, xs) => loop(xs, n+1, tot + x)
)
else (tot / n0)
)
//
} (* end of [listpre_mean] *)

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
val mu = tot / n0
//
fun sq(x: double) = x*x
//
local
implement
list_foldleft$fopr<double><double>
  (res, x) = res+sq(x-mu)
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
//{}(*tmp*)
listpre_stdev
  (xs, n0) = let
//
fun sq(x: double) = x*x
//
val mu = listpre_mean(xs, n0)
//
fun
auxlst
( xs: List(double)
, i0: int, sqsum: double): double =
(
if
(i0 < n0)
then
(
case+ xs of
| list_nil() =>
  $MATH.sqrt(sqsum / (i0-1))
| list_cons(x, xs) =>
  auxlst(xs, i0+1, sqsum+sq(x-mu))
)
else
(
  $MATH.sqrt(sqsum / (n0-1))
)
) (* end of [auxlst] *)
//
in
  auxlst(xs, 0, 0.0)
end // end of [listpre_stdev]

(* ****** ****** *)

implement
list_ratios(xs) =
  auxlst(x0, xs) where
{
//
fun
auxlst
(
x0: double,
xs: List(double)
) : stream_vt(double) = $ldelay
(
case+ xs of
| list_nil() =>
  stream_vt_nil()
| list_cons(x1, xs) =>
  stream_vt_cons(x1/x0, auxlst(x1, xs))
)
//
val+list_cons(x0, xs) = xs
//
} (* end of [list_ratios] *)

implement
list_change_ratios(xs) =
  auxlst(x0, xs) where
{
//
fun
auxlst
(
x0: double,
xs: List(double)
) : stream_vt(double) = $ldelay
(
case+ xs of
| list_nil() =>
  stream_vt_nil()
| list_cons(x1, xs) =>
  stream_vt_cons(x1/x0 - 1.0, auxlst(x1, xs))
)
//
val+list_cons(x0, xs) = xs
//
} (* end of [list_change_ratios] *)

(* ****** ****** *)

(*
implement
//{}(*tmp*)
list_smooth_bef
  (xs, n0) =
  auxlst(xs, xs, 0) where
{
//
fun
auxlst
{n1,n2:nat}
{i:nat | n1 >= n2+i}
(
xs: list(double, n1), ys: list(double, n2), i0: int(i)
) : stream_vt(double) = $ldelay
(
case+ ys of
| list_nil() =>
  stream_vt_nil()
| list_cons(_, ys) => let
    val i1 = i0 + 1
    val mu = listpre_mean(xs, i1)
  in
    if (i1 < n0)
      then stream_vt_cons(mu, auxlst(xs, ys, i1))
      else stream_vt_cons(mu, auxlst(list_tail(xs), ys, i0))
    // end of [if]
  end // end of [list_cons]
)
//
prval () = lemma_list_param(xs)
//
} (* end of [list_smooth_bef] *)
*)

(* ****** ****** *)

(*
implement
//{}(*tmp*)
list_smooth_aft
  (xs, n0) =
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
(i < n0)
then
(
case+ xs of
| list_nil() => sum / i
| list_cons(x, xs) => aux(xs, sum+x, i+1)
)
else (sum / n0)
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
} (* end of [list_smooth_aft] *)
*)

(* ****** ****** *)

implement
//{}(*tmp*)
list_rolling_mean
{n}{k}(xs, width) = let
//
fun
auxlst
{n1,n2:nat|n1==n2+k}
( xs: list(double, n1)
, ys: list(double, n2)
) : stream_vt(double) = $ldelay
(
let
//
val
mean = listpre_mean(xs, width)
//
in
//
case+ ys of
| list_nil() =>
  stream_vt_sing(mean)
| list_cons(y, ys) =>
  stream_vt_cons(mean, auxlst(list_tail(xs), ys))
//
end
)
//
in
  auxlst(xs, list_drop(xs, width))
end // end of [list_rolling_mean]

(* ****** ****** *)

implement
//{}(*tmp*)
list_rolling_stdev
{n}{k}(xs, width) = let
//
fun
auxlst
{n1,n2:nat|n1==n2+k}
( xs: list(double, n1)
, ys: list(double, n2)
) : stream_vt(double) = $ldelay
(
let
//
val
stdev = listpre_stdev(xs, width)
//
in
//
case+ ys of
| list_nil() =>
  stream_vt_sing(stdev)
| list_cons(y, ys) =>
  stream_vt_cons(stdev, auxlst(list_tail(xs), ys))
//
end
)
//
in
  auxlst(xs, list_drop(xs, width))
end // end of [list_rolling_stdev]

(* ****** ****** *)

implement
{a}(*tmp*)
list_rolling_stream
{n}{k}(xs, width) = let
//
fun
auxlst
{n1,n2:nat|n1==n2+k}
(
xs: list(a, n1), ys: list(a, n2)
) : stream_vt(listGte(a,k)) = $ldelay
(
//
case+ ys of
| list_nil() =>
  stream_vt_sing(xs)
| list_cons(y, ys) =>
  stream_vt_cons(xs, auxlst(list_tail(xs), ys))
//
)
//
in
  auxlst(xs, list_drop(xs, width))
end // end of [list_rolling_stream]

(* ****** ****** *)

(* end of [andes_comp_util.dats] *)
