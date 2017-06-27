(* ****** ****** *)
(*
** For Andes
** computational utilities
*)
(* ****** ****** *)
//
staload
"./../SATS/andes_comp.sats"
//
(* ****** ****** *)

implement
//{}(*tmp*)
list_average
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
} (* end of [list_average] *)

(* ****** ****** *)

(* end of [andes_comp_util.dats] *)