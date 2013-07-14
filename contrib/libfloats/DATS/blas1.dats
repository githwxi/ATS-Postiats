(* ****** ****** *)
//
// Basic Linear Algebraic Subprograms in ATS
//
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
blas_inner
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
  (x, y, env) = env := gadd_val<a> (env, blas_inner$mul(x, y))
//
var env: tenv = gnumint<a> (0)
val _(*n*) = gvector_foreach2_env<a,a><tenv> (V1, V2, n, d1, d2, env)
//
in
  env
end // end of [blas_inner]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_copy
  {n}{d1,d2}
  (V1, V2, n, d1, d2) = let
//
prval (
) = __initize (V2) where
{
extern praxi
__initize (&GVT(a?, n, d2) >> GVT(a, n, d2)): void
} (* end of [where] *) // end of [prval]
//
implement
{a1,a2}{env}
gvector_foreach2$cont (x, y, env) = true
implement(env)
gvector_foreach2$fwork<a,a><env> (x, y, env) = y := x
//
val _(*n*) = gvector_foreach2 (V1, V2, n, d1, d2)
//
in
  // nothing
end // end of [blas_copy]

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

implement
{a}(*tmp*)
blas_scal
  (alpha, X, n, dx) = let
//
implement
{a}{env}
gvector_foreach$cont (x, env) = true
//
implement(env)
gvector_foreach$fwork<a><env>
  (x, env) = x := gmul_val<a> (alpha, x)
//
val _(*n*) = gvector_foreach<a> (X, n, dx)
//
in
  // nothing
end // end of [blas_scal]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_axpy
  (alpha, X, Y, n, dx, dy) = let
//
implement
{a1,a2}{env}
gvector_foreach2$cont (x, y, env) = true
//
implement(env)
gvector_foreach2$fwork<a,a><env>
  (x, y, env) = y := blas$alpha (alpha, x, y)
//
val _(*n*) = gvector_foreach2<a,a> (X, Y, n, dx, dy)
//
in
  // nothing
end // end of [blas_axpy]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_axpy2_row
  {m,n}{lda,ldb}
(
  alpha, X2, Y2, m, n, lda, ldb
) = let
//
implement(env)
gmatrow_foreachrow2$fwork<a,a><env>
  (X, Y, n, env) = blas_axpy (alpha, X, Y, n, 1, 1)
//
val () = gmatrow_foreachrow2<a,a> (X2, Y2, m, n, lda, ldb)
//
in
  // nothing
end // end of [blas_axpy2_row]

implement
{a}(*tmp*)
blas_axpy2_col
  {m,n}{lda,ldb}
(
  alpha, X2, Y2, m, n, lda, ldb
) = let
//
implement(env)
gmatcol_foreachcol2$fwork<a,a><env>
  (X, Y, n, env) = blas_axpy (alpha, X, Y, n, 1, 1)
//
val () = gmatcol_foreachcol2<a,a> (X2, Y2, m, n, lda, ldb)
//
in
  // nothing
end // end of [blas_axpy2_col]

(* ****** ****** *)

(* end of [blas1.dats] *)
