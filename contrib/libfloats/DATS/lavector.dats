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

implement{}
fprint_LAgvec$sep (out) = fprint_array$sep<> (out)

(* ****** ****** *)

implement{a}
add11_LAgvec_LAgvec
  (A, B) = res where
{
//
val res = copy_LAgvec (B)
val ((*void*)) = LAgvec_1x1y (A, res)
//
} // end of [add11_LAgvec_LAgvec]

(* ****** ****** *)

(* end of [lavector.dats] *)
