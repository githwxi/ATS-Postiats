(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
fun
{res:t@ype}
ifold{n:nat}
(
n: int(n),
fopr: (res, natLt(n)) -<cloref1> res, ini: res
) : res = let
//
fun
loop
{i:nat | i <= n} .<n-i>.
  (i: int(i), res: res): res =
  if i < n then loop(i+1, fopr(res, i)) else res
//
in
  loop(0, ini)
end // end of [ifold]
//
(* ****** ****** *)
//
typedef res = double
//
(* ****** ****** *)
//
(*
fun
dotprod
  {n:nat}
(
  n: int(n)
, A: arrayref(res, n), B: arrayref(res, n)
) : res =
(
  ifold<res>(n, lam(res, i) => res + A[i]*B[i], 0.0)
)
*)
//
(* ****** ****** *)
//
fun
dotprod
  {n:nat}
(
  n: int(n)
, A: arrayref(res, n), B: arrayref(res, n)
) : res = let
//
var
fopr =
lam@(res: res, i: natLt(n)) : res =<clo1> res + A[i]*B[i]
//
in
  ifold<res>(n, $UNSAFE.cast(addr@fopr), 0.0)
end // end of [dotprod]
//
(* ****** ****** *)
//
fun
{res:t@ype}
ifold_{n:nat}
(
  n: int(n)
, fopr: &(res, natLt(n)) -<clo1> res, ini: res
) : res = let
//
fun
loop
{i:nat | i <= n} .<n-i>.
(
  i: int(i)
, fopr: &(res, natLt(n)) -<clo1> res, res: res
) : res =
  if i < n
    then loop(i+1, fopr, fopr(res, i)) else res
  // end of [if]
//
in
  loop(0, fopr, ini)
end // end of [ifold_]
//
(* ****** ****** *)
//
fun
dotprod_
  {n:nat}
(
  n: int(n)
, A: arrayref(res, n), B: arrayref(res, n)
) : res = let
//
var
fopr =
lam@(res: res, i: natLt(n)): res => res + A[i]*B[i]
//
in
  ifold_<res>(n, fopr, 0.0)
end // end of [dotprod_]
//
(* ****** ****** *)

implement
main0 () = () where
{
//
val N = 3
var A = @[res](1.0, 2.0, 3.0)
//
val res =
dotprod(N, $UNSAFE.cast(addr@A), $UNSAFE.cast(addr@A))
val ((*void*)) = println! ("1.0*1.0+2.0*2.0+3.0*3.0 = ", res)
//
val res_ =
dotprod_(N, $UNSAFE.cast(addr@A), $UNSAFE.cast(addr@A))
val ((*void*)) = println! ("1.0*1.0+2.0*2.0+3.0*3.0 = ", res_)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [chap_stkclo.dats] *)
