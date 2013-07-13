(* ****** ****** *)
//
// Basic Linear Algebraic Subprograms in ATS
//
(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

(* Author: ... *)
(* Authoremail: ... *)
(* Start time: ... *)

(* ****** ****** *)

staload "libfloats/SATS/blas.sats"

(* ****** ****** *)

implement{a}
blas$alpha (alpha, x, y) =
  gadd_val<a> (gmul_val<a> (alpha, x), y)

implement{a}
blas$alphabeta
  (alpha, x, beta, y) =
  gadd_val<a> (gmul_val<a> (alpha, x), gmul_val<a> (beta, y))
// end of [blas_alphabeta]

(* ****** ****** *)

implement{a}
blas_inner$mul (x, y) = gmul_val<a> (x, y)

(* ****** ****** *)

(* end of [blas0.dats] *)
