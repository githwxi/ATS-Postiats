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
//
fun {
a:t@ype
} msort{n:int}
(
xs: list(a, n), n: int(n), f: list(a, n) -> void
) : void =
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
val r = ref<int>(0)
val ys1 = ref<list(a, n/2)>(_)
val ys2 = ref<list(a, n-n/2)>(_)
//
val () =
msort(
  xs1, n2
, lam(ys1_) =>
  (!ys1 := ys1_; !r := !r + 1; if !r < 2 then () else f(list_merge<a>(!ys1, !ys2)))
)
val () =
msort(
  xs2, n-n2
, lam(ys2_) =>
  (!ys2 := ys2_; !r := !r + 1; if !r < 2 then () else f(list_merge<a>(!ys1, !ys2)))
)
//
in
  // nothing
end // end of [then]
else f(xs) // end of [else]
) (* end of [msort] *)
//
(* ****** ****** *)

(* end of [msort_par_cps.dats] *)
