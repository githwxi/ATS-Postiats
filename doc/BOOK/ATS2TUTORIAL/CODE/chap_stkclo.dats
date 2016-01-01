(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
(*
#include
"share/atspre_staload.hats"
*)
//
(* ****** ****** *)
//
fun
{res:t@ype}
ifold{n:nat}
(
  n: int(n)
, fopr: (res, natLt(n)) -<cloref1> res, ini: res
) : res = let
//
fun
loop
{i:nat | i <= n} .<n-i>.
  (i: int(i), res: res): res = let
  val () = println! ("loop: i = ", i)
  val () = (print("loop: res = "); fprint_val<res>(stdout_ref, res); println!())
in
  if i < n then loop(i+1, fopr(res, i)) else res
end
//
in
  loop(0, ini)
end // end of [ifold]
////
(* ****** ****** *)
//
(*
fun
dotprod
  {n:nat}
(
  n: int(n)
, A: arrayref(double, n), B: arrayref(double, n)
) : double =
(
  ifold<double>(n, lam(res, i) => res + A[i]*B[i], 0.0)
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
, A: arrayref(double, n), B: arrayref(double, n)
) : double = let
//
(*
var
fopr =
lam@(res: double, i: natLt(n)): double =<clo1> (println!("i=",i); println!("res=",res); res + A[i]*B[i])
*)
var
fopr2 =
lam@(i: natLt(n), res: double): double =<clo1> (println!("fopr2: i=",i); println!("fopr2: res=",res); res + A[i]*B[i])
//
in
  ifold<double>(n, $UNSAFE.cast(addr@fopr2), 1000.0)
end // end of [dotprod]
//
(* ****** ****** *)
(*
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
  if i < n then loop(i+1, fopr, fopr(res, i)) else res
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
, A: arrayref(double, n), B: arrayref(double, n)
) : double = let
//
var
fopr =
lam@(res: double, i: natLt(n)): double => res + A[i]*B[i]
//
in
  ifold_<double>(n, fopr, 0.0)
end // end of [dotprod_]
//
*)
(* ****** ****** *)

implement
main0 () = () where
{
//
val N = 3
var A = @[double](1.0, 2.0, 3.0)
//
val res =
dotprod(N, $UNSAFE.cast(addr@A), $UNSAFE.cast(addr@A))
val ((*void*)) = println! ("1.0*1.0+2.0*2.0+3.0*3.0 = ", res)
//
(*
val res_ =
dotprod_(N, $UNSAFE.cast(addr@A), $UNSAFE.cast(addr@A))
val ((*void*)) = println! ("1.0*1.0+2.0*2.0+3.0*3.0 = ", res_)
*)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [chap_stkclo.dats] *)
