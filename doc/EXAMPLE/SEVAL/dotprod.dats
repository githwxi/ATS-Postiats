(*
** An example of $seval
*)

(* ****** ****** *)

extern
fun
{a:t0p}
dotprod
{n:nat}
(A1: &(@[a][n]), A2: &(@[a][n])): a

(* ****** ****** *)

implement
{a}(*tmp*)
dotprod{n}
  (A1, A2) = let
//
overload + with gadd_val of 10
overload * with gmul_val of 10
//
fun
loop
{i:nat | i <= n}
(
  A1: &(@[a][n])
, A2: &(@[a][n])
, i: int(i), res: a
) : a = (
//
sif
(i==n)
then res
else let
  val x_i = A1[i]*A2[i]
in
  loop(A1, A2, i+1, res + x_i)
end // end of [else]
//
) (* end of [loop] *)
//
in
  loop(A1, A2, 0, gnumber_int<a>(0))
end // end of [dotprod]

(* ****** ****** *)
//
extern
fun
{a:t0p}
dotprod3
(A1: &(@[a][3]), A2: &(@[a][3])): a
//
(* ****** ****** *)

implement
{a}(*tmp*)
dotprod3(A1, A2) = $seval(dotprod<a>(A1, A2))

(* ****** ****** *)

(* end of [dotprod.dats] *)
