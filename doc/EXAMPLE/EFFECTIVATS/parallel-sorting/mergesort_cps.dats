(* ****** ****** *)
//
// For use in Effective-ATS
//
(* ****** ****** *)

extern
fun
{a:t@ype}
mergesort
{n:int}
(xs: list(a, n)): list(a, n)

(* ****** ****** *)

extern
fun
{a:t@ype}
list_split
{n:int}{k:nat | k <= n}
(
xs: list(a, n), k: int(k)
) : (list(a, k), list(a, n-k))

extern
fun
{a:t@ype}
list_merge
{n1,n2:int}
(
xs: list(a, n1), ys: list(a, n2)
) : list(a, n1+n2)

(* ****** ****** *)

implement
{a}(*tmp*)
mergesort{n}(xs) =
msort(xs, length(xs), lam ys => ys) where
{
//
typedef res = list(a, n)
//
fun
msort{n:int}
(
xs: list(a, n), n: int(n), f: list(a, n) -> res
) : res =
(
if
(n >= 2)
then let
//
val n2 = n / 2
val
(xs1, xs2) =
list_split<a>(xs, n2)
//
in
//
msort
( xs1, n2
, lam(ys1) =>
  msort(xs2, n-n2, lam(ys2) => f(list_merge<a>(ys1, ys2)))
)
//
end // end of [then]
else f(xs) // end of [else]
) (* end of [msort] *)
//
} (* end of [mergesort] *)

(* ****** ****** *)

(* end of [mergesort_cps.dats] *)