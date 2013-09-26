(* ****** ****** *)
//
// Linear Algebra matrix operations
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"
staload "libats/SATS/gmatrix_row.sats"
staload "libats/SATS/refcount.sats"

(* ****** ****** *)

staload "./../SATS/blas.sats"
staload "./../SATS/lavector.sats"
staload "./../SATS/lamatrix.sats"

(* ****** ****** *)

(*
fun{}
LAgmat_TPN_assert
  {tp:transp}
(
  tp: TRANSP (tp), msg: string
) : void = let
in
//
case+ tp of
| TPN () => ()
| TPT () => let
    val () = prerrln! (msg) in assertexn (false)
  end // end of [TRANSP_T]
| TPC () => let
    val () = prerrln! (msg) in assertexn (false)
  end // end of [TRANSP_C]
//
end // end of [LAgmat_TPN_assert]
*)

(* ****** ****** *)

local

vtypedef
sourcerfc = refcnt (ptr)

datavtype
LAgmat
(
  a:t@ype
, mord, int, int
) =
  {mo:mord}
  {m,n:int}
  {ld:int}
  LAGMAT (a, mo, m, n) of
  (
    uint(*rfc*), sourcerfc
  , ptr, MORD(mo), int(m), int(n), int(ld)
  )
// end of [LAgmat]

assume
LAgmat_vtype
  (a:t0p, mo: int, l:addr, m: int, n:int) = LAgmat (a, mo, m, n)
// end of [assume]

in (* in of [local] *)

(* ****** ****** *)

implement{}
LAgmat_mord
  (M) = mo where
{
val+LAGMAT
  (_, _, _, mo, _, _, _) = M
} (* end of [LAgmat_nrow] *)

(* ****** ****** *)

implement{}
LAgmat_nrow
  (M) = m where
{
val+LAGMAT (_, _, _, _, m, _, _) = M
} (* end of [LAgmat_nrow] *)

implement{}
LAgmat_ncol
  (M) = n where
{
val+LAGMAT (_, _, _, _, _, n, _) = M
} (* end of [LAgmat_ncol] *)

(* ****** ****** *)

implement{}
LAgmat_vtakeout_row
  {a}{mo}{m,n}
  (M, i, d0) = let
//
val+LAGMAT
  (_, _, gmp, mo, m, n, ld) = M
//
val d =
(
case+ mo of
| MORDrow () => 1 | MORDcol () => ld
) : Int
val d2 = ld+1-d
//
val () = d0 := d
//
prval [d:int]
  EQINT () = eqint_make_gint (d)
//
in
  $UN.ptr_vtake{gvector(a,n,d)}(ptr_add<a> (gmp,i*d2))
end // end of [LAgmat_vtakeout_row]

implement{}
LAgmat_vtakeout_col
  {a}{mo}{m,n}
  (M, j, d0) = let
//
val+LAGMAT
  (_, _, gmp, mo, m, n, ld) = M
//
val d =
(
case+ mo of
| MORDrow () => ld | MORDcol () => 1
) : Int
val d2 = ld+1-d
//
val () = d0 := d
//
prval [d:int]
  EQINT () = eqint_make_gint (d)
//
in
  $UN.ptr_vtake{gvector(a,m,d)}(ptr_add<a> (gmp,j*d2))
end // end of [LAgmat_vtakeout_col]

(* ****** ****** *)

implement{}
LAgmat_vtakeout_matrix
  {a}{mo}{m,n}
  (M, ld0) = let
//
val+LAGMAT
  (_, _, gmp, mo, m, n, ld) = M
//
val () = ld0 := ld
//
prval [ld:int]
  EQINT () = eqint_make_gint (ld)
//
in
  $UN.ptr_vtake{gmatrix(a,mo,m,n,ld)}(gmp)
end // end of [LAgmat_vtakeout_matrix]

(* ****** ****** *)

implement{}
LAgmat_incref
  {a}{mo}{l}{m,n} (M) = let
//
val+@LAGMAT
  (rfc, _, _, _, _, _, _) = M
val ((*void*)) = (rfc := succ(rfc))
prval () = fold@(M)
//
in
  $UN.castvwtp1{LAgmat(a,mo,l,m,n)}(M)
end // end of [LAgmat_incref]

(* ****** ****** *)

implement{}
LAgmat_decref
  {a}{mo}{l}{m,n} (M) = let
//
val+@LAGMAT
  (rfc, src, _, _, _, _, _) = M
val rfc1 = pred (rfc)
//
in (* in of [LAgmat_decref] *)
//
if
isgtz(rfc1)
then let
  val () = rfc := rfc1
  prval () = fold@(M)
  prval () = $UN.cast2void (M)
in
  // nothing
end else let
  val opt =
    refcnt_decref_opt (src)
  val () = free@{a}{mo}{m,n}{1}(M)
  extern
  fun __free (ptr): void = "mac#atspre_mfree_gc"
in
  case+ opt of
  | ~Some_vt (gmp) => __free(gmp) | ~None_vt () => ()
end // end of [if]
//
end // end of [LAgmat_decref]

(* ****** ****** *)

implement{}
LAgmat_make_arrayptr
  (mo, A, m, n) = let
//
val pA = $UN.castvwtp0{ptr}(A)
val src = refcnt_make<ptr> (pA)
//
val ld =
(
  case+ mo of MORDrow () => n | MORDcol () => m
) : Int // end of [val]
//
in
  LAGMAT (1u(*rfc*), src, pA, mo, m, n, ld)
end // end of [LAgmat_make_arrayptr]

implement{}
LAgmat_make_matrixptr
  (M, m, n) = let
//
val pM = $UN.castvwtp0{ptr}(M)
val src = refcnt_make<ptr> (pM)
//
in
  LAGMAT (1u(*rfc*), src, pM, MORDrow, m, n, n)
end // end of [LAgmat_make_matrixptr]

(* ****** ****** *)

implement{a}
LAgmat_make_uninitized
  {mo}{m,n} (mo, m, n) = let
//
val mn = m * n
prval () = mul_gte_gte_gte{m,n}()
//
val A = arrayptr_make_uninitized<a> (i2sz(mn))
//
in
  LAgmat_make_arrayptr (mo, A, m, n)
end // end of [LAgmat_make_uninitized]

(* ****** ****** *)

implement{a}
LAgmat_split_1x2
  (M, j) = let
//
val+LAGMAT
  (_, src, p, mo, m, n, ld) = M
//
val src1 = refcnt_incref (src)
val src2 = refcnt_incref (src)
val ((*void*)) = LAgmat_decref (M)
//
val p1 = p
val p2 = (
case+ mo of
| MORDrow () => ptr_add<a> (p, j   )
| MORDcol () => ptr_add<a> (p, j*ld)
) : ptr // endval
//
val j1 = j and j2 = n-j
//
val M1 = LAGMAT (1u(*rfc*), src1, p1, mo, m, j1, ld)
val M2 = LAGMAT (1u(*rfc*), src2, p2, mo, m, j2, ld)
//
in
  (M1, M2)
end // end of [LAgmat_split_1x2]

implement{a}
LAgmat_split_2x1
  (M, i) = let
//
val+LAGMAT
  (_, src, p, mo, m, n, ld) = M
//
val src1 = refcnt_incref (src)
val src2 = refcnt_incref (src)
val ((*void*)) = LAgmat_decref (M)
//
val p1 = p
val p2 = (
case+ mo of
| MORDrow () => ptr_add<a> (p, i*ld)
| MORDcol () => ptr_add<a> (p, i   )
) : ptr // endval
//
val i1 = i and i2 = m-i
//
val M1 = LAGMAT (1u(*rfc*), src1, p1, mo, i1, n, ld)
val M2 = LAGMAT (1u(*rfc*), src2, p2, mo, i2, n, ld)
//
in
  (M1, M2)
end // end of [LAgmat_split_2x1]

(* ****** ****** *)

implement{a}
LAgmat_split_2x2
  (M, i, j) = let
//
val+LAGMAT
  (_, src, p, mo, m, n, ld) = M
//
val src11 = refcnt_incref (src)
val src12 = refcnt_incref (src)
val src21 = refcnt_incref (src)
val src22 = refcnt_incref (src)
val ((*void*)) = LAgmat_decref (M)
//
val d12 = (
case+ mo of MORDrow () => j | MORDcol () => j*ld
) : int // endval
val d21 = (
case+ mo of MORDrow () => i*ld | MORDcol () => i
) : int // endval
val d22 = d12 + d21
//
val p11 = p
val p12 = ptr_add<a> (p, d12)
val p21 = ptr_add<a> (p, d21)
val p22 = ptr_add<a> (p, d22)
//
val i1 = i and i2 = m-i
val j1 = j and j2 = n-j
//
val M11 = LAGMAT (1u(*rfc*), src11, p11, mo, i1, j1, ld)
val M12 = LAGMAT (1u(*rfc*), src12, p12, mo, i1, j2, ld)
val M21 = LAGMAT (1u(*rfc*), src21, p21, mo, i2, j1, ld)
val M22 = LAGMAT (1u(*rfc*), src22, p22, mo, i2, j2, ld)
//
in
  (M11, M12, M21, M22)
end // end of [LAgmat_split_2x2]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement{a}
LAgmat_get_at
  (M, i, j) = x where
{
//
val cp = LAgmat_getref_at (M, i, j)
val (pf, fpf | p) = $UN.cptr_vtake (cp)
val x = !p
prval () = fpf (pf)
//
} // end of [LAgmat_get_at]

implement{a}
LAgmat_set_at
  (M, i, j, x) = () where
{
//
val cp = LAgmat_getref_at (M, i, j)
val (pf, fpf | p) = $UN.cptr_vtake (cp)
val () = (!p := x)
prval () = fpf (pf)
//
} // end of [LAgmat_set_at]

(* ****** ****** *)

implement{a}
LAgmat_getref_at
  (M, i, j) = let
//
val m = LAgmat_nrow (M)
val n = LAgmat_ncol (M)
val ord = LAgmat_mord (M)
//
var ld: int
val (pf, fpf | p) = LAgmat_vtakeout_matrix (M, ld)
//
val p_ij =
(
case+ ord of
| MORDrow () => ptr_add<a>(p, i*ld+j)
| MORDcol () => ptr_add<a>(p, i+j*ld)
) : ptr // endval
//
prval () = fpf (pf)
//
in
  $UN.cast{cPtr1(a)}(p_ij)
end // end of [Lagmat_getref_at]

(* ****** ****** *)

implement{a}
LAgmat_interchange_row
  (M, i1, i2) = let
//
val n = LAgmat_ncol (M)
val mo = LAgmat_mord (M)
//
var ld: int
val (pf, fpf | p) = LAgmat_vtakeout_matrix (M, ld)
//
val () =
(
case+ mo of
| MORDrow () => gmatrow_interchange_row (!p, n, ld, i1, i2)
| MORDcol () => gmatcol_interchange_row (!p, n, ld, i1, i2)
) : void // endval
//
prval () = fpf (pf)
//
in
  // nothing
end // end of [Lagmat_interchange_row]

implement{a}
LAgmat_interchange_col
  (M, j1, j2) = let
//
val m = LAgmat_nrow (M)
val mo = LAgmat_mord (M)
//
var ld: int
val (pf, fpf | p) = LAgmat_vtakeout_matrix (M, ld)
//
val () =
(
case+ mo of
| MORDrow () => gmatrow_interchange_col (!p, m, ld, j1, j2)
| MORDcol () => gmatcol_interchange_col (!p, m, ld, j1, j2)
) : void // endval
//
prval () = fpf (pf)
//
in
  // nothing
end // end of [Lagmat_interchange_col]

(* ****** ****** *)
//
implement{}
fprint_LAgmat$sep1 (out) = fprint (out, ", ")
implement{}
fprint_LAgmat$sep2 (out) = fprint (out, "; ")
//
implement
{a}(*tmp*)
fprint_LAgmat
  (out, M) = let
//
val m = LAgmat_nrow (M)
val n = LAgmat_ncol (M)
val ord = LAgmat_mord (M)
//
var ld: int
val (pf, fpf | p) = LAgmat_vtakeout_matrix (M, ld)
//
local
implement
fprint_gmatrix$sep1<>
  (out) = fprint_LAgmat$sep1 (out)
implement
fprint_gmatrix$sep2<>
  (out) = fprint_LAgmat$sep2 (out)
in (* in of [local] *)
val () = fprint_gmatrix (out, !p, ord, m, n, ld)
end // end of [local]
//
prval () = fpf (pf)
//
in
  // nothing
end // end of [fprint_LAgmat]

(* ****** ****** *)

implement
{a}(*tmp*)
fprint_LAgmat_sep
  (out, M, sep1, sep2) = let
//
implement
fprint_LAgmat$sep1<> (out) = fprint_string (out, sep1)
implement
fprint_LAgmat$sep2<> (out) = fprint_string (out, sep2)
//
in
  fprint_LAgmat (out, M)
end // end of [fprint_LAgmat_sep]

(* ****** ****** *)

implement{a}
LAgmat_tabulate
  (ord, m, n) = let
//
infixl (/) %
#define % g0uint_mod
//
val m2 = i2sz(m)
val n2 = i2sz(n)
val mn = m2 * n2
//
in
//
case+ ord of
| MORDrow () => let
    implement
    array_tabulate$fopr<a> (isz) = let
      val i = isz / n2 and j = isz % n2
    in
      LAgmat_tabulate$fopr<a> (g0u2i(i), g0u2i(j))
    end
  in
    LAgmat_make_arrayptr (ord, arrayptr_tabulate<a> (mn), m, n)
  end // end of [MORDrow]
| MORDcol () => let
    implement
    array_tabulate$fopr<a> (isz) = let
      val i = isz % m2 and j = isz / m2
    in
      LAgmat_tabulate$fopr<a> (g0u2i(i), g0u2i(j))
    end
  in
    LAgmat_make_arrayptr (ord, arrayptr_tabulate<a> (mn), m, n)
  end // end of [MORDcol]
//
end // end of [LAgmat_tabulate]

(* ****** ****** *)

(*
fun{a:t0p}{env:vt0p}
LAgmat_iforeach$fwork
  (int, int, &a >> _, &env >> _): void
*)

implement
{a}(*tmp*)
LAgmat_iforeach
  (M) = let
  var env: void = ()
in
  LAgmat_iforeach_env<a><void> (M, env)
end // end of [LAgmat_iforeach]

implement
{a}{env}
LAgmat_iforeach_env
  (M, env) = let
//
val m = LAgmat_nrow (M)
val n = LAgmat_ncol (M)
val ord = LAgmat_mord (M)
//
var ld: int
val (pf, fpf | p) = LAgmat_vtakeout_matrix (M, ld)
//
implement
gmatrix_iforeach$fwork<a><env> = LAgmat_iforeach$fwork<a><env>
//
val () = gmatrix_iforeach_env<a><env> (!p, ord, m, n, ld, env)
//
prval () = fpf (pf)
//
in
  // nothing
end // end of [LAgmat_iforeach_env]

(* ****** ****** *)

implement
{a}(*tmp*)
LAgmat_imake_arrayptr
  (M) = let
//
val m = LAgmat_nrow (M)
val n = LAgmat_ncol (M)
val ord = LAgmat_mord (M)
//
var ld: int
val (pf, fpf | p) = LAgmat_vtakeout_matrix (M, ld)
//
implement
gmatrix_imake$fopr<a> = LAgmat_imake$fopr<a>
//
val A = gmatrix_imake_arrayptr<a> (!p, ord, m, n, ld)
//
prval () = fpf (pf)
//
in
  A
end // end of [LAgmat_imake_arrayptr]

implement
{a}(*tmp*)
LAgmat_imake_matrixptr
  (M) = let
//
val m = LAgmat_nrow (M)
val n = LAgmat_ncol (M)
val ord = LAgmat_mord (M)
//
var ld: int
val (pf, fpf | p) = LAgmat_vtakeout_matrix (M, ld)
//
implement
gmatrix_imake$fopr<a> = LAgmat_imake$fopr<a>
//
val A = gmatrix_imake_matrixptr<a> (!p, ord, m, n, ld)
//
prval () = fpf (pf)
//
in
  A
end // end of [LAgmat_imake_matrixptr]

(* ****** ****** *)
//
// HX: BLAS and BLAS-like functions
//
(* ****** ****** *)

implement
{a}(*tmp*)
LAgmat_scal
  (alpha, M) = let
//
val m = LAgmat_nrow (M)
val n = LAgmat_ncol (M)
val ord = LAgmat_mord (M)
//
var ld: int
val (pf, fpf | p) = LAgmat_vtakeout_matrix (M, ld)
//
in
//
case+ ord of
| MORDrow () => let
    val () =
    blas_scal2_row (alpha, !p, m, n, ld)
    prval () = fpf (pf)
  in
    // nothing
  end // end of [MORDrow]
| MORDcol () => let
    val () =
    blas_scal2_col (alpha, !p, m, n, ld)
    prval () = fpf (pf)
  in
    // nothing
  end // end of [MORDcol]
//
end // end of [LAgmat_scal]

(* ****** ****** *)

implement
{a}(*tmp*)
scal_LAgmat
  (alpha, M) = M2 where
{
//
val m = LAgmat_nrow (M)
val n = LAgmat_ncol (M)
val ord = LAgmat_mord (M)
//
prval () = lemma_LAgmat_param (M)
//
val M2 = LAgmat_make_uninitized<a> (ord, m, n)
//
val _0 = gnumber_int<a>(0)
local
implement
blas$_alpha_beta<a>
  (alpha, x, beta, y) = gmul_val<a> (alpha, x)
prval () = LAgmat_initize (M2)
in (* in of [local] *)
val () = LAgmat_axby (alpha, M, _0, M2)
end // end of [local]
//
} // end of [scal_LAgmat]

(* ****** ****** *)

implement
{a}(*tmp*)
LAgmat_copy
  (M1, M2) = let
//
val m = LAgmat_nrow (M1)
val n = LAgmat_ncol (M1)
val ord = LAgmat_mord (M1)
//
var ld1: int and ld2: int
val (pf1, fpf1 | p1) = LAgmat_vtakeout_matrix (M1, ld1)
val (pf2, fpf2 | p2) = LAgmat_vtakeout_matrix (M2, ld2)
//
in
//
case+ ord of
| MORDrow () => let
    val () =
    gmatrow_copyto (!p1, !p2, m, n, ld1, ld2)
    prval () = gmatrix_uninitize(!p2)
    prval () = fpf1 (pf1) and () = fpf2 (pf2)
    prval () = LAgmat_initize{a}(M2)
  in
    // nothing
  end // end of [MORDrow]
| MORDcol () => let
    val () =
    gmatcol_copyto (!p1, !p2, m, n, ld1, ld2)
    prval () = gmatrix_uninitize(!p2)
    prval () = fpf1 (pf1) and () = fpf2 (pf2)
    prval () = LAgmat_initize{a}(M2)
  in
    // nothing
  end // end of [MORDcol]
//
end // end of [LAgmat_copy]

(* ****** ****** *)

implement
{a}(*tmp*)
copy_LAgmat
  (M) = M2 where
{
//
val m = LAgmat_nrow (M)
and n = LAgmat_ncol (M)
val ord = LAgmat_mord (M)
//
prval () = lemma_LAgmat_param (M)
//
val M2 = LAgmat_make_uninitized<a> (ord, m, n)
val () = LAgmat_copy (M, M2)
//
} // end of [copy_LAgmat]

(* ****** ****** *)

implement
{a}(*tmp*)
LAgmat_transp
  (M1, M2) = let
//
val m = LAgmat_nrow (M1)
val n = LAgmat_ncol (M1)
val ord = LAgmat_mord (M1)
//
var ld1: int and ld2: int
val (pf1, fpf1 | p1) = LAgmat_vtakeout_matrix (M1, ld1)
val (pf2, fpf2 | p2) = LAgmat_vtakeout_matrix (M2, ld2)
//
in
//
case+ ord of
| MORDrow () => let
    val () =
    gmatrow_transpto (!p1, !p2, m, n, ld1, ld2)
    prval () = gmatrix_uninitize(!p2)
    prval () = fpf1 (pf1) and () = fpf2 (pf2)
    prval () = LAgmat_initize{a}(M2)
  in
    // nothing
  end // end of [MORDrow]
| MORDcol () => let
    val () =
    gmatcol_transpto (!p1, !p2, m, n, ld1, ld2)
    prval () = gmatrix_uninitize(!p2)
    prval () = fpf1 (pf1) and () = fpf2 (pf2)
    prval () = LAgmat_initize{a}(M2)
  in
    // nothing
  end // end of [MORDcol]
//
end // end of [LAgmat_transp]

(* ****** ****** *)

implement
{a}(*tmp*)
transp_LAgmat
  (M) = M2 where
{
//
val m = LAgmat_nrow (M)
and n = LAgmat_ncol (M)
val ord = LAgmat_mord (M)
//
prval () = lemma_LAgmat_param (M)
//
val M2 = LAgmat_make_uninitized<a> (ord, n, m)
val () = LAgmat_transp (M, M2)
//
} // end of [transp_LAgmat]

(* ****** ****** *)

implement
{a}(*tmp*)
LAgmat_1x1y
(
  A, B
) = let
//
val _1 = gnumber_int<a>(1)
//
implement
blas$_alpha_beta<a>
  (alpha, x, beta, y) = gadd_val<a> (x, y)
//
in
  LAgmat_axby (_1, A, _1, B)
end // end of [LAgmat_1x1y]

(* ****** ****** *)

implement
{a}(*tmp*)
LAgmat_ax1y
(
  alpha, A, B
) = let
//
val _1 = gnumber_int<a>(1)
implement
blas$_alpha_beta<a>
  (alpha, x, beta, y) = blas$_alpha_1<a> (alpha, x, y)
//
in
  LAgmat_axby (alpha, A, _1, B)
end // end of [LAgmat_ax1y]

(* ****** ****** *)

implement
{a}(*tmp*)
LAgmat_axby
(
  alpha, A, beta, B
) = let
//
val ord = LAgmat_mord (A)
val nrow = LAgmat_nrow (A)
val ncol = LAgmat_ncol (A)
//
var lda: int and ldb: int
//
val (pfa, fpfa | pA) = LAgmat_vtakeout_matrix (A, lda)
val (pfb, fpfb | pB) = LAgmat_vtakeout_matrix (B, ldb)
//
val () =
(
case+ ord of
| MORDrow () =>
    blas_axby2_row (alpha, !pA, beta, !pB, nrow, ncol, lda, ldb)
| MORDcol () =>
    blas_axby2_col (alpha, !pA, beta, !pB, nrow, ncol, lda, ldb)
) : void // end of [val]
//
prval () = fpfa (pfa)
prval () = fpfb (pfb)
//
in
  // nothing
end // end of [LAgmat_axby]

(* ****** ****** *)

implement{a}
add11_LAgmat_LAgmat
  (A, B) = res where
{
//
val res = copy_LAgmat (B)
val ((*void*)) = LAgmat_1x1y (A, res)
//
} // end of [add11_LAgmat_LAgmat]

(* ****** ****** *)

implement{a}
sub11_LAgmat_LAgmat
  (A, B) = res where
{
//
val _n1 = gnumber_int<a>(~1)
val res = scal_LAgmat (_n1, B)
val ((*void*)) = LAgmat_1x1y (A, res)
//
} // end of [sub11_LAgmat_LAgmat]

(* ****** ****** *)

implement{a}
LAgmat_gemm
  {mo}{p,q,r}
(
  pftra, pftrb
| alpha, A, tra, B, trb, beta, C
) = let
//
val p = LAgmat_nrow (C)
val r = LAgmat_ncol (C)
val ma = LAgmat_nrow (A)
val na = LAgmat_ncol (A)
val q =
(
case+ tra of
| TPN () => let
    prval TPDIM_N () = pftra in na
  end // end of [TPN]
| TPT () => let
    prval TPDIM_T () = pftra in ma
  end // end of [TPT]
| TPC () => let
    prval TPDIM_C () = pftra in ma
  end // end of [TPC]
) : int(q) // endval
val ord = LAgmat_mord (C)
//
var lda: int and ldb: int and ldc: int
val (pfa, fpfa | pA) = LAgmat_vtakeout_matrix (A, lda)
val (pfb, fpfb | pB) = LAgmat_vtakeout_matrix (B, ldb)
val (pfc, fpfc | pC) = LAgmat_vtakeout_matrix (C, ldc)
//
val () = (
case+ ord of
| MORDrow () =>
  blas_gemm_row
  (
    pftra, pftrb | alpha, !pA, tra, !pB, trb, beta, !pC, p, q, r, lda, ldb, ldc
  )
| MORDcol () =>
  blas_gemm_col
  (
    pftra, pftrb | alpha, !pA, tra, !pB, trb, beta, !pC, p, q, r, lda, ldb, ldc
  )
) : void // end of [val]
//
prval () = fpfa (pfa)
prval () = fpfb (pfb)
prval () = fpfc (pfc)
//
in
  // nothing
end // end of [LAgmat_gemm]

(* ****** ****** *)

implement{a}
LAgmat_gemm_nn
  (alpha, A, B, beta, C) =
(
  LAgmat_gemm (TPDIM_N, TPDIM_N | alpha, A, TPN, B, TPN, beta, C)
) (* end of [LAgmat_gemm_nn] *)

implement{a}
LAgmat_gemm_nt
  (alpha, A, B, beta, C) =
(
  LAgmat_gemm (TPDIM_N, TPDIM_T | alpha, A, TPN, B, TPT, beta, C)
) (* end of [LAgmat_gemm_nt] *)

implement{a}
LAgmat_gemm_tn
  (alpha, A, B, beta, C) =
(
  LAgmat_gemm (TPDIM_T, TPDIM_N | alpha, A, TPT, B, TPN, beta, C)
) (* end of [LAgmat_gemm_tn] *)

implement{a}
LAgmat_gemm_tt
  (alpha, A, B, beta, C) =
(
  LAgmat_gemm (TPDIM_T, TPDIM_T | alpha, A, TPT, B, TPT, beta, C)
) (* end of [LAgmat_gemm_tt] *)

(* ****** ****** *)

implement{a}
mul00_LAgmat_LAgmat
  (A, B) = AB where
{
val AB = A * B
val () = LAgmat_decref2 (A, B)
} // end of [mul00_LAgmat_LAgmat]

implement{a}
mul01_LAgmat_LAgmat
  (A, B) = AB where
{
val AB = A * B
val () = LAgmat_decref (A)
} // end of [mul00_LAgmat_LAgmat]

implement{a}
mul10_LAgmat_LAgmat
  (A, B) = AB where
{
val AB = A * B
val () = LAgmat_decref (B)
} // end of [mul00_LAgmat_LAgmat]

(* ****** ****** *)

implement{a}
mul11_LAgmat_LAgmat
  (A, B) = C where
{
//
val p = LAgmat_nrow (A)
val r = LAgmat_ncol (B)
val ord = LAgmat_mord (A)
//
prval () = lemma_LAgmat_param (A)
prval () = lemma_LAgmat_param (B)
//
val C = LAgmat_make_uninitized (ord, p, r)
//
val _1 = gnumber_int<a>(1)
val _0 = gnumber_int<a>(0)
//
local
implement
blas$_alpha_beta<a> (alpha, x, beta, y) = x
prval () = LAgmat_initize (C)
in (* in of [local] *)
val () = LAgmat_gemm (TPDIM_N, TPDIM_N | _1, A, TPN, B, TPN, _0, C)
end // end of [local]
//
} // end of [mul11_LAgmat_LAgmat]

(* ****** ****** *)

(* end of [lamatrix.dats] *)
