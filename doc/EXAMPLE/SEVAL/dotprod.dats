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
) : a =
(
  sif (i < n) then loop(A1, A2, i+1, res+A1[i]*A2[i]) else res
) (* end of [loop] *)
//
in
  loop(A1, A2, 0, gnumber_int<a>(0))
end // end of [dotprod]

(* ****** ****** *)

(*
loop_{0}
loop_{1}
loop_{2}
loop_{3}
*)

(* ****** ****** *)
//
extern
fun
{a:t0p}
dotprod3
  (&(@[a][3]), &(@[a][3])): a
//
(* ****** ****** *)

implement
{a}(*tmp*)
dotprod3(A1, A2) = $seval(dotprod<a>(A1, A2))

(* ****** ****** *)

(* end of [dotprod.dats] *)
