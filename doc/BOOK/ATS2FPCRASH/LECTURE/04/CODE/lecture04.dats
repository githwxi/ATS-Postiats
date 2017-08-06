(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#staload "./../../MYLIB/mylib.dats"

(* ****** ****** *)
//
val
square =
lam(x: int): int => x * x
//
val fact =
fix f(x: int): int =>
  if x > 0 then x * f(x) else 1
//
(* ****** ****** *)
//
fun
fact(n:int): int =
int_foldleft<int>
(n, 1, lam(res, i) => res * (i+1))
//
val () =
int_foreach<(*void*)>
( 10
, lam(i) =>
  println!("fact(", i, ") = ", fact(i))
)
//
(* ****** ****** *)

fun
{a:t@ype}
matrix_mulby
( p:int, q:int, r:int
, A:matrix0(a), B:matrix0(a), C:matrix0(a)
) : void = let
//
val add = gadd_val_val<a>
val mul = gmul_val_val<a>
//
fun
fwork(i: int, j: int): void =
(
  C[i,j] :=
  int_foldleft<a>
  ( q, C[i,j]
  , lam(res, k) => add(res, mul(A[i,k], B[k,j]))
  )
)
//
in
  int_cross_foreach(p, r, lam(i, j) => fwork(i, j))
end // end of [matrix_mulby]

(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture04.dats] *)
