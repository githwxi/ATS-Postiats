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

staload "libfloats/SATS/blas.sats"

(* ****** ****** *)

staload "libfloats/SATS/lavector.sats"
staload "libfloats/SATS/lamatrix.sats"

(* ****** ****** *)

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
    val () = prerr (msg) in assertexn (false)
  end // end of [TRANSP_T]
| TPC () => let
    val () = prerr (msg) in assertexn (false)
  end // end of [TRANSP_C]
//
end // end of [LAgmat_TPN_assert]

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
  {tp:transp}
  LAGMAT (a, mo, m, n) of
  (
    uint(*rfc*), sourcerfc
  , MORD(mo), ptr, int(m), int(n), int(ld), TRANSP(tp)
  )
// end of [LAgmat]

assume
LAgmat_vtype
  (a:t0p, mo: int, l:addr, m: int, n:int) = LAgmat (a, mo, m, n)
// end of [assume]

in (* in of [local] *)

(* ****** ****** *)

implement
LAgmat_nrow
  (M) = m where
{
val+LAGMAT (_, _, _, _, m, _, _, _) = M
} (* end of [LAgmat_nrow] *)

implement
LAgmat_ncol
  (M) = n where
{
val+LAGMAT (_, _, _, _, _, n, _, _) = M
} (* end of [LAgmat_ncol] *)

(* ****** ****** *)

implement{}
LAgmat_make_arrayptr
  (mo, A, m, n) = let
//
val pA = $UN.castvwtp0{ptr}(A)
val src = refcnt_make<ptr> (pA)
//
in
  LAGMAT (1u(*rfc*), src, mo, pA, m, n, n, TPN)
end // end of [LAgmat_make_arrayptr]

implement{}
LAgmat_make_matrixptr
  (M, m, n) = let
//
val pM = $UN.castvwtp0{ptr}(M)
val src = refcnt_make<ptr> (pM)
//
in
  LAGMAT (1u(*rfc*), src, MORDrow, pM, m, n, n, TPN)
end // end of [LAgmat_make_matrixptr]

(* ****** ****** *)

end // end of [local]

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
val mo = LAgmat_mord (A)
val nrow = LAgmat_nrow (A)
val ncol = LAgmat_ncol (A)
//
var ma: int and mb: int
var na: int and nb: int
var lda: int and ldb: int
var tra: ptr and trb: ptr
//
val
(
  pfa, fpfa, pftra | pA
) = LAgmat_vtakeout_matrix (A, ma, na, lda, tra)
val
(
  pfb, fpfb, pftrb | pB
) = LAgmat_vtakeout_matrix (B, mb, nb, ldb, trb)
//
val () = LAgmat_TPN_assert (tra, "LAgmat_axby:transposed:A")
val () = LAgmat_TPN_assert (trb, "LAgmat_axby:transposed:B")
//
val-TPN () = tra
val-TPN () = trb
//
prval TPDIM_N () = pftra
prval TPDIM_N () = pftrb
//
val () =
(
case+ mo of
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

(* end of [lamatrix.dats] *)
