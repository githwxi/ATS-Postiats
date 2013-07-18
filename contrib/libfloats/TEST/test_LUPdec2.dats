//
// A naive implementation of LUP decomposition
//
(* ****** ****** *)

staload "libats/SATS/gmatrix.sats"
staload "libfloats/SATS/lamatrix.sats"

(* ****** ****** *)

extern
fun
{a:t0p}
lapack_LUPdec
  {mo:mord}
  {m,n:int | m <= n}
  (M: !LAgmat(a, mo, m, n) >> _): void
// end of [lapack_LUPdec]

(* ****** ****** *)

implement{a}
lapack_LUPdec
  {mo}{m,n} (M) = let
//
fun loop
  {m,n:nat | m <= n}
(
  M: LAgmat(a, mo, m, n), m: int m
) : void = let
in
if m >= 1 then let
//
(*
val imax = auxpivot (M)
*)
//
val
(
  M00, M01, M10, M11
) = LAgmat_split_2x2 (M, 1, 1)
val a00 = M00[0,0]
val () = LAgmat_decref (M00)
val alpha = grecip_val<a> (a00)
val () = LAgmat_scal (alpha, M10)
val alpha2 = gnumber_int<a>(~1) and beta2 = gnumber_int<a>(1)
val () = LAgmat_gemm (alpha2, M10, M01, beta2, M11)
val () = LAgmat_decref2 (M01, M10)
val () = loop (M11, m-1)
//
in
  // nothing
end else
(
  LAgmat_decref (M)
) // end of [if]
//
end // end of [loop]
//
prval () = lemma_LAgmat_param (M)
//
val m = LAgmat_nrow (M)
val () = loop (LAgmat_incref (M), m) 
//
in
  // nothing
end // end of [lapack_LUPdec2]

(* ****** ****** *)

(* end of [test_LUPdec2.dats] *)
