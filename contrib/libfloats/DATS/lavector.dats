(* ****** ****** *)
//
// Linear Algebra vector operations
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gvector.sats"

(* ****** ****** *)

staload "libfloats/SATS/blas.sats"

(* ****** ****** *)

staload "libfloats/SATS/lavector.sats"

(* ****** ****** *)

implement{a}
add11_LAgmat_LAgmat
  (A, B) = res where
{
//
val res = copy_LAgmat (B)
val ((*void*)) = LAgvec_1x1y (A, res)
//
} // end of [add11_LAgvec_LAgvec]

(* ****** ****** *)

(* end of [lavector.dats] *)
