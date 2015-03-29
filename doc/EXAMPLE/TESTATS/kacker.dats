(*
** Ackermann's function
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
typedef
cont (a: t@ype, res: t@ype) = (a) -<cloref1> res
//
(* ****** ****** *)
//
extern
fun
{res:t@ype}
kacker(
  m: int, n: int, k: cont(int, res)
) : res
implement
{res}
kacker(m, n, k) = let
//
fun
kacker(m: int, n: int, k: cont(int, res)): res =
(
if
m = 0
then k(n+1)
else (
if n = 0
  then kacker(m-1, 1, k)
  else kacker(m, n-1, lam res => kacker(m-1, res, k))
) (* end of [if] *)
) (* end of [kacker] *)
//
in
  kacker(m, n, k)
end // end of [kacker]

(* ****** ****** *)

implement
main0((*void*)) =
{
//
val () =
kacker<void>(3, 3, lam res => println! ("acker(3, 3) = ", res))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [kacker.dats] *)
