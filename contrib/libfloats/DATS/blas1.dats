(* ****** ****** *)
//
// Basic Linear Algebraic System in ATS
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

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"
staload "libats/SATS/gmatrix_row.sats"

(* ****** ****** *)

staload "libfloats/SATS/blas.sats"

(* ****** ****** *)
//
// BLAS: level 1
// 
(* ****** ****** *)

implement
{a}(*tmp*)
blas_dot
  (V1, V2, n, d1, d2) = let
//
typedef tenv = a
//
implement
{a1,a2}{env}
gvector_foreach2$cont (x, y, env) = true
//
implement
gvector_foreach2$fwork<a,a><tenv>
  (x, y, env) = env := gadd_val<a> (env, gmul_val<a> (x, y))
//
var env: tenv = gnumint<a> (0)
val _(*n*) = gvector_foreach2_env<a,a><tenv> (V1, V2, n, d1, d2, env)
//
in
  env
end // end of [blas_dot]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_swap
  (V1, V2, n, d1, d2) = let
//
implement
{a1,a2}{env}
gvector_foreach2$cont (x, y, env) = true
//
implement(env)
gvector_foreach2$fwork<a,a><env>
  (x, y, env) = let val t = x in x := y; y := t end
//
val _(*n*) = gvector_foreach2<a,a> (V1, V2, n, d1, d2)
//
in
  // nothing
end // end of [blas_swap]

(* ****** ****** *)

(* end of [blas1.dats] *)
