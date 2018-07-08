(* ****** ****** *)
(*
** DivideConquer:
** list-permutation
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
//
abst@ype permute_list_elt
//
typedef elt = permute_list_elt
//
extern
fun
permute_list
  : (list0(elt)) -> list0(list0(elt))
//
(* ****** ****** *)

assume input_t0ype = list0(elt)
assume output_t0ype = list0(list0(elt))

(* ****** ****** *)
//
implement
DivideConquer$base_test<>
  (xs) =
(
if length(xs) >= 2 then false else true
)
//
(* ****** ****** *)
//
implement
DivideConquer$base_solve<>
  (xs) = list0_cons(xs, nil0((*void*)))
//
(* ****** ****** *)
//
implement
DivideConquer$divide<>
  (xs) = let
//
extern
fun{}
mapcons{n:int}
(
x0: elt,
xs: list0(list(elt, n))
) : list0(list(elt, n+1))
//
implement
mapcons<>
(
  x0, xs
) =
$UNSAFE.cast
(
  list0_mapcons(x0, $UNSAFE.cast(xs))
) (* end of [mapcons] *)
//
fun
divide
{n:nat} .<n>.
(
xs: list(elt,n)
) : list0(list(elt,n-1)) =
(
case+ xs of
| list_nil() =>
  list0_nil()
| list_cons(x, xs) =>
  list0_cons(xs, mapcons(x, divide(xs)))
)
//
in
  $UNSAFE.cast(divide(g1ofg0(xs)))
end // end of [DivideConquer$divide]
//
(* ****** ****** *)
//
implement
DivideConquer$conquer$combine<>
  (xs, rs) =
  combine(xs, rs) where
{
//
fun
combine
(
xs: list0(elt),
rs: list0(list0(list0(elt)))
) : list0(list0(elt)) =
(
case+ xs of
| list0_nil() => list0_nil()
| list0_cons(x, xs) => let
    val-list0_cons(r, rs) = rs
  in
    list0_mapcons(x, r) + combine(xs, rs)
  end // end of [list0_cons]
)
//
} (* end of [DivideConquer$conquer$combine] *)
//
(* ****** ****** *)
//
implement
permute_list(xs) = DivideConquer$solve<>(xs)
//
(* ****** ****** *)

implement
main0() =
{
//
val () =
println!
(
  "Hello from [test05]!"
) (* println! *)
//
assume
permute_list_elt = int
//
val xs = $list{int}(0, 1, 2)
val xss = permute_list(g0ofg1(xs))
//
val ((*void*)) =
fprint_listlist0_sep(stdout_ref, xss, "\n", ", ")
//
val () = fprint_newline(stdout_ref)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test05.dats] *)
