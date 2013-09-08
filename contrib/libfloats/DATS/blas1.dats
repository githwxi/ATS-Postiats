(* ****** ****** *)
//
// Basic Linear Algebra Subprograms in ATS
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"
staload "libats/SATS/gmatrix_row.sats"

(* ****** ****** *)

staload "./../SATS/blas.sats"

(* ****** ****** *)
//
// BLAS: level 1
// 
(* ****** ****** *)

implement
{a}{a2}
blas_nrm2
  (V, n, d) = let
//
typedef tenv = a2
//
implement{a}{env}
gvector_foreach$cont (x, env) = true
implement
gvector_foreach$fwork<a><tenv>
  (x, env) =
(
  env := gadd_val<a2> (env, blas$gnorm2<a><a2> (x))
)
//
var env: tenv = gnumber_int<a2>(0)
val _(*n*) = gvector_foreach_env<a><tenv> (V, n, d, env)
//
in
  gsqrt_val<a2> (env)
end // end of [blas_nrm2]

(* ****** ****** *)

implement
{a}{a2}
blas_iamax
  {n}{d}(V, n, d) = let
//
var max: a2
val p_max = addr@(max)
var imax: int = 0
val p_imax = addr@(imax)
//
typedef tenv = int
//
implement{a}{env}
gvector_foreach$cont (x, env) = true
implement
gvector_foreach$fwork<a><tenv>
  (x, env) = let
//
val x2 = blas$gnorm<a><a2> (x)
val isgt = ggt_val<a2> (x2, $UN.ptr1_get<a2> (p_max))
val (
) = if isgt then
(
  $UN.ptr1_set<a2> (p_max, x2); $UN.ptr1_set<int> (p_imax, env)
) (* end of [if] *) // end of [val]
//
in
  env := succ (env)
end // end of [gvector_foreach$fwork]
//
val p = addr@V
prval
(pf, pf2) = gvector_v_uncons (view@V)
val () = max := blas$gnorm<a><a2> (!p)
val (pf2 | p2) = viewptr_match (pf2 | ptr_add<a> (p, d))
//
var env: int = 1
val n1 = pred (n)
val _(*n1*) = gvector_foreach_env<a><tenv> (!p2, n1, d, env)
//
prval () = view@V := gvector_v_cons (pf, pf2)
//
in
  $UN.cast{natLt(n)}(imax)
end // end of [blas_iamax]

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
  (x, y, env) =
(
  env := gadd_val<a> (env, blas_inner$fmul<a> (x, y))
)
//
var env: tenv = gnumber_int<a>(0)
val _(*n*) = gvector_foreach2_env<a,a><tenv> (V1, V2, n, d1, d2, env)
//
in
  env
end // end of [blas_inner]

(* ****** ****** *)

implement
{a}(*tmp*)
blas_inner_u
  (V1, V2, n, d1, d2) = let
//
implement
blas_inner$fmul<a> (x, y) = gmul_val<a> (x, y)
//
in
  blas_inner (V1, V2, n, d1, d2)
end // end of [blas_inner_u]

implement
{a}(*tmp*)
blas_inner_c
  (V1, V2, n, d1, d2) = let
//
implement
blas_inner$fmul<a> (x, y) = let
  val x_ = gconjugate_val<a> (x) in gmul_val<a> (x_, y)
end // end of [blas_inner_c]
//
in
  blas_inner (V1, V2, n, d1, d2)
end // end of [blas_inner_c]

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

implement{a}
blas_copy = gvector_copyto<a>

(* ****** ****** *)

implement{a}
blas_copy2_row = gmatrow_copyto<a>
implement{a}
blas_copy2_col = gmatcol_copyto<a>

(* ****** ****** *)

implement
{a}(*tmp*)
blas_swap = gvector_exchange<a>

(* ****** ****** *)

implement
{a}(*tmp*)
blas_ax1y
  (alpha, X, Y, n, dx, dy) = let
//
val beta = gnumber_int<a> (1)
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
