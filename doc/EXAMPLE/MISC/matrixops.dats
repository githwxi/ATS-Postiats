(* ****** ****** *)
(*
//
// Some matrix ops
//
*)
(* ****** ****** *)

implement
main((*void*)) = 0

(* ****** ****** *)

extern
fun{a:t0p}
mul_scalar_matrix
  {m,n:int}
(
  c: a
, A: &matrix (INV(a), m, n) >> _
, m: size_t m, n: size_t n
) : void // end of [mul_scalar_matrix]

(* ****** ****** *)

implement{a}
mul_scalar_matrix
  (c, A, m, n) = let
//
implement(env)
matrix_foreach$fwork<a><env>
  (x, env) = (x := gmul_val_val<a> (c, x))
//
in
  matrix_foreach<a> (A, m, n)
end // end of [mul_scalar_matrix]

(* ****** ****** *)

(* end of [matrixops.dats] *)
