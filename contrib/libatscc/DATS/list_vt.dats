(*
** libatscc-common
*)

(* ****** ****** *)

(*
//
staload "./../SATS/list_vt.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
implement
{}(*tmp*)
list_vt_is_nil
  (xs) =
(
case+ xs of
| list_vt_nil() => true
| list_vt_cons _ => false
)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
list_vt_is_cons
  (xs) =
(
case+ xs of
| list_vt_nil() => false
| list_vt_cons _ => true
)
//
(* ****** ****** *)
//
implement
list_vt_length
  {a}(xs) =
  loop(xs, 0) where
{
//
fun
loop
{i,j:nat}
(
xs: !list_vt(a, i), j: int(j)
) : int(i+j) =
(
case+ xs of
| list_vt_nil() => j
| list_vt_cons(_, xs) => loop(xs, j+1)
)
//
prval () = lemma_list_vt_param(xs)
//
} (* list_vt_length *)
//
(* ****** ****** *)
//
implement
list_vt_snoc
  {a}(xs, x0) =
(
list_vt_append{a}(xs, list_vt_sing(x0))
)
implement
list_vt_extend
  {a}(xs, x0) =
(
list_vt_append{a}(xs, list_vt_sing(x0))
)
//
(* ****** ****** *)

implement
list_vt_append
  {a}(xs, ys) = let
//
fun
aux
{i,j:nat} .<i>.
(
xs: list_vt(a, i),
ys: list_vt(a, j)
) : list_vt(a, i+j) =
(
case+ xs of
| ~list_vt_nil() => ys
| ~list_vt_cons(x, xs) => list_vt_cons(x, aux(xs, ys))
)
//
prval () = lemma_list_vt_param(xs)
prval () = lemma_list_vt_param(ys)
//
in
  aux(xs, ys)
end // end of [list_vt_append]

(* ****** ****** *)
//
implement
list_vt_reverse
  {a}(xs) =
  list_vt_reverse_append{a}(xs, nil_vt())
//
(* ****** ****** *)
//
implement
list_vt_reverse_append
  {a}(xs, ys) =
  loop(xs, ys) where
{
//
fun
loop
{i,j:nat} .<i>.
(
xs: list_vt(a, i),
ys: list_vt(a, j)
) : list_vt(a, i+j) =
(
case+ xs of
| ~list_vt_nil() => ys
| ~list_vt_cons(x, xs) => loop(xs, list_vt_cons(x, ys))
)
//
prval () = lemma_list_vt_param(xs)
prval () = lemma_list_vt_param(ys)
//
} (* end of [list_vt_reverse_append] *)
//
(* ****** ****** *)

(* end of [list_vt.dats] *)
