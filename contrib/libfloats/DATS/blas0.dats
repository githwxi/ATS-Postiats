(* ****** ****** *)
//
// Basic Linear Algebra Subprograms in ATS
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

staload "./../SATS/blas.sats"

(* ****** ****** *)

implement
blas$gnorm<float><float> (x) = abs(x)
implement
blas$gnorm<double><double> (x) = abs(x)

(* ****** ****** *)

implement
blas$gnorm2<float><float> (x) = x*x
implement
blas$gnorm2<double><double> (x) = x*x

(* ****** ****** *)

implement{a}
blas$_alpha_0 (alpha, x) =
  gmul_val<a> (alpha, x)
implement{a}
blas$_alpha_1 (alpha, x, y) =
  gadd_val<a> (gmul_val<a> (alpha, x), y)
implement{a}
blas$_alpha_beta
  (alpha, x, beta, y) =
  gadd_val<a> (gmul_val<a> (alpha, x), gmul_val<a> (beta, y))
// end of [blas_alphabeta]

(* ****** ****** *)

implement{a}
blas_inner$fmul (x, y) = gmul_val<a> (x, y)

(* ****** ****** *)

(* end of [blas0.dats] *)
