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
  (x, y, env) = env := gadd_val<a> (env, blas_inner$mul<a> (x, y))
//
var env: tenv = gnumber_int<a> (0)
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
val _(*n*) = gvector_foreach2<a,a> (V1, V2, n, d1, d2)
//
in
  // nothing
end // end of [blas_copy]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_copy2_row
  {m,n}{ldx,ldy}
(
  X2, Y2, m, n, ldx, ldy
) = let
//
prval (
) = __initize (Y2) where
{
extern praxi
__initize (&GMR(a?, m, n, ldy) >> GMR(a, m, n, ldy)): void
} (* end of [where] *) // end of [prval]
//
implement(env)
gmatrow_foreachrow2$fwork<a,a><env>
  (X, Y, n, env) = blas_copy<a> (X, Y, n, 1, 1)
//
val () = gmatrow_foreachrow2<a,a> (X2, Y2, m, n, ldx, ldy)
//
in
  // nothing
end // end of [blas_copy2_row]

implement
{a}(*tmp*)
blas_copy2_col
  {m,n}{ldx,ldy}
(
  X2, Y2, m, n, ldx, ldy
) = let
//
prval (
) = __initize (Y2) where
{
extern praxi
__initize (&GMC(a?, m, n, ldy) >> GMC(a, m, n, ldy)): void
} (* end of [where] *) // end of [prval]
//
implement(env)
gmatcol_foreachcol2$fwork<a,a><env>
  (X, Y, m, env) = blas_copy (X, Y, m, 1, 1)
//
val () = gmatcol_foreachcol2<a,a> (X2, Y2, m, n, ldx, ldy)
//
in
  // nothing
end // end of [blas_copy2_col]

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
blas_scal2_row
  {m,n}{ld}
(
  alpha, X2, m, n, ld
) = let
//
implement(env)
gmatrow_foreachrow$fwork<a><env>
  (X, n, env) = blas_scal (alpha, X, n, 1)
//
val () = gmatrow_foreachrow<a> (X2, m, n, ld)
//
in
  // nothing
end // end of [blas_scal2_row]

implement
{a}(*tmp*)
blas_scal2_col
  {m,n}{ld}
(
  alpha, X2, m, n, ld
) = let
//
implement(env)
gmatcol_foreachcol$fwork<a><env>
  (X, m, env) = blas_scal (alpha, X, m, 1)
//
val () = gmatcol_foreachcol<a> (X2, m, n, ld)
//
in
  // nothing
end // end of [blas_scal2_col]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_ax1y
  (alpha, X, Y, n, dx, dy) = let
//
val beta = gnumber_int<a> (1)
//
implement
blas$_alpha_beta<a>
  (alpha, x, beta, y) = blas$_alpha_1<a> (alpha, x, y)
//
in
  blas_axby<a> (alpha, X, beta, Y, n, dx, dy)
end // end of [blas_ax1y]

implement
{a}(*tmp*)
blas_ax1y2_row
  (alpha, X2, Y2, m, n, ldx, ldy) = let
//
val beta = gnumber_int<a> (1)
//
implement
blas$_alpha_beta<a>
  (alpha, x, beta, y) = blas$_alpha_1<a> (alpha, x, y)
//
in
  blas_axby2_row<a> (alpha, X2, beta, Y2, m, n, ldx, ldy)
end // end of [blas_ax1y2_row]

implement
{a}(*tmp*)
blas_ax1y2_col
  (alpha, X2, Y2, m, n, ldx, ldy) = let
//
val beta = gnumber_int<a> (1)
//
implement
blas$_alpha_beta<a>
  (alpha, x, beta, y) = blas$_alpha_1<a> (alpha, x, y)
//
in
  blas_axby2_col<a> (alpha, X2, beta, Y2, m, n, ldx, ldy)
end // end of [blas_ax1y2_col]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_axby
  (alpha, X, beta, Y, n, dx, dy) = let
//
implement
{a1,a2}{env}
gvector_foreach2$cont (x, y, env) = true
//
implement(env)
gvector_foreach2$fwork<a,a><env>
  (x, y, env) = y := blas$_alpha_beta<a> (alpha, x, beta, y)
//
val _(*n*) = gvector_foreach2<a,a> (X, Y, n, dx, dy)
//
in
  // nothing
end // end of [blas_axby]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_axby2_row
  {m,n}{ldx,ldy}
(
  alpha, X2, beta, Y2, m, n, ldx, ldy
) = let
//
implement(env)
gmatrow_foreachrow2$fwork<a,a><env>
  (X, Y, n, env) =
  blas_axby<a> (alpha, X, beta, Y, n, 1, 1)
//
val () = gmatrow_foreachrow2<a,a> (X2, Y2, m, n, ldx, ldy)
//
in
  // nothing
end // end of [blas_axby2_row]

implement
{a}(*tmp*)
blas_axby2_col
  {m,n}{ldx,ldy}
(
  alpha, X2, beta, Y2, m, n, ldx, ldy
) = let
//
implement(env)
gmatcol_foreachcol2$fwork<a,a><env>
  (X, Y, n, env) =
  blas_axby<a> (alpha, X, beta, Y, n, 1, 1)
//
val () = gmatcol_foreachcol2<a,a> (X2, Y2, m, n, ldx, ldy)
//
in
  // nothing
end // end of [blas_axby2_col]

(* ****** ****** *)

(* end of [blas1.dats] *)
