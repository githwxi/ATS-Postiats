(* ****** ****** *)
(*
** DivideConquer:
** list-mergesort
**
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#staload
"./../DATS/DivideConquer.dats"
//
(* ****** ****** *)

abst@ype elt_t0ype

(* ****** ****** *)
//
typedef elt = elt_t0ype
//
assume
input_t0ype = @(int, list0(elt))
//
assume output_t0ype = list0(elt)
//
(* ****** ****** *)
//
implement
DivideConquer$base_test<>
  (nxs) =
(
if nxs.0 >= 2 then false else true
)
//
(* ****** ****** *)
//
implement
DivideConquer$base_solve<>(nxs) = nxs.1
//
(* ****** ****** *)
//
implement
DivideConquer$divide<>
  (nxs) = let
//
val n =
  g1ofg0(nxs.0)
//
val () = assertloc (n >= 2)
val n2 = half(n)
//
val xs = nxs.1
val xs1 = list0_take_exn(xs, n2)
val xs2 = list0_drop_exn(xs, n2)
//
in
//
g0ofg1($list{input}((n2, xs1), (n-n2, xs2)))
//
end // end of [DivideConquer$divide]
//
(* ****** ****** *)

implement
DivideConquer$conquer$combine<>
  (_, rs) =
  merge(xs1, xs2) where
{
//
val-list0_cons(xs1, rs) = rs
val-list0_cons(xs2, rs) = rs
//
fun
merge
( xs10: output
, xs20: output
) : output =
(
case+ xs10 of
| list0_nil() => xs20
| list0_cons(x1, xs11) =>
  (
  case+ xs20 of
  | list0_nil() => xs10
  | list0_cons(x2, xs21) => let
      val sgn =
      gcompare_val_val<elt>(x1, x2)
    in
      if sgn <= 0
        then list0_cons(x1, merge(xs11, xs20))
        else list0_cons(x2, merge(xs10, xs21))
    end // end of [list0_cons]
  )
)
//
} // end of [DivideConquer$conquer$combine]

(* ****** ****** *)
//
extern
fun
mergesort(list0(elt)): list0(elt)
//
implement
mergesort(xs) = let
  val n = length(xs) in DivideConquer$solve((n, xs))
end // end of [mergesort]
//
(* ****** ****** *)

assume elt_t0ype = int

(* ****** ****** *)

implement
main0((*void*)) =
{
//
val
xs0 =
g0ofg1
(
$list{elt}
(
8, 3, 2, 4, 6, 5, 1, 7, 0, 9
)
) (* end of [val] *)
//
val xs1 = mergesort(xs0)
//
val ((*void*)) = println! ("xs0 = ", xs0)
val ((*void*)) = println! ("xs1 = ", xs1)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [MergeSort_list.dats] *)
