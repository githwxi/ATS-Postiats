(* ****** ****** *)
//
// Linear Algebra matrix operations
//
(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"

(* ****** ****** *)

staload "./../SATS/lavector.sats"

(* ****** ****** *)

#define WR(x) x

(* ****** ****** *)
//
absvtype
LAgmat_vtype
  (a:t@ype, mo: mord, l: addr, m: int, n: int) = ptr(l)
//
stadef LAgmat = LAgmat_vtype
//
vtypedef LAgmat
  (a:t@ype, mo: mord, m: int, n: int) = [l:addr] LAgmat(a, mo, l, m, n)
//
(* ****** ****** *)

praxi
lemma_LAgmat_param
  {a:t0p}{mo:mord}{m,n:int}
  (M: !LAgmat(a, mo, m, n))
: [0 <= mo; mo <= 1; 0 <= m; 0 <= n] void

(* ****** ****** *)
//
// HX: only if you know what you are doing
//
praxi
LAgmat_initize
  {a:t0p}{mo:mord}
  {l:addr}{m,n:int}
  (M: !LAgmat(a?, mo, l, m, n) >> LAgmat(a, mo, l, m, n)): void
// end of [LAgmat_initize]
praxi
LAgmat_uninitize
  {a:t0p}{mo:mord}
  {l:addr}{m,n:int}
  (M: !LAgmat(a, mo, l, m, n) >> LAgmat(a?, mo, l, m, n)): void
// end of [LAgmat_uninitize]

(* ****** ****** *)
//
fun{}
LAgmat_mord
  {a:t0p}{mo:mord}{m,n:int}
  (M: !LAgmat(a, mo, m, n)): MORD(mo)
//
fun{}
LAgmat_nrow
  {a:t0p}{mo:mord}{m,n:int}
  (M: !LAgmat(a, mo, m, n)): int (m)
fun{}
LAgmat_ncol
  {a:t0p}{mo:mord}{m,n:int}
  (M: !LAgmat(a, mo, m, n)): int (n)
//
(* ****** ****** *)

fun{}
LAgmat_vtakeout_row
  {a:t0p}{mo:mord}{m,n:int}
(
  !LAgmat(a, mo, m, n)
, i: natLt(m), d: &int? >> int(d)
) :
#[
  l:addr;d:int
] (
  gvector_v (a, l, n, d)
, gvector_v (a, l, n, d) -<lin,prf> void
| ptr (l)
) // end of [LAgmat_vtakeout_row]

fun{}
LAgmat_vtakeout_col
  {a:t0p}{mo:mord}{m,n:int}
(
  !LAgmat(a, mo, m, n)
, j: natLt(n), d: &int? >> int(d)
) :
#[
  l:addr;d:int
] (
  gvector_v (a, l, m, d)
, gvector_v (a, l, m, d) -<lin,prf> void
| ptr (l)
) // end of [LAgmat_vtakeout_col]

(* ****** ****** *)

fun{}
LAgmat_vtakeout_matrix
  {a:t0p}{mo:mord}{m,n:int}
(
  !LAgmat(a, mo, m, n)
, ld: &int? >> int(ld)
) :
#[
  l:addr;ld:int
] (
  gmatrix_v (a, mo, l, m, n, ld)
, gmatrix_v (a, mo, l, m, n, ld) -<lin,prf> void
| ptr (l)
) // end of [LAgmat_vtakeout_matrix]

(* ****** ****** *)
//
fun{}
LAgmat_incref // refcnt++
  {a:t0p}
  {mo:mord}
  {l:addr}{m,n:int}
  (!LAgmat(a, mo, l, m, n)): LAgmat(a, mo, l, m, n)
//
(* ****** ****** *)

fun{}
LAgmat_decref // refcnt--
  {a:t0p}
  {mo:mord}
  {l:addr}{m,n:int}
  (M: LAgmat(a, mo, l, m, n)): void
//
macdef
LAgmat_decref2
  (M1, M2) =
{
  val () = LAgmat_decref ,(M1)
  val () = LAgmat_decref ,(M2)
}
macdef
LAgmat_decref3
  (M1, M2, M3) =
{
  val () = LAgmat_decref ,(M1)
  val () = LAgmat_decref ,(M2)
  val () = LAgmat_decref ,(M3)
}
macdef
LAgmat_decref4
  (M1, M2, M3, M4) =
{
  val () = LAgmat_decref ,(M1)
  val () = LAgmat_decref ,(M2)
  val () = LAgmat_decref ,(M3)
  val () = LAgmat_decref ,(M4)
}
(* ****** ****** *)

fun{}
LAgmat_make_arrayptr
  {a:t0p}
  {mo:mord}{m,n:int}
(
  MORD(mo)
, A: arrayptr (INV(a), m*n), int(m), int(n)
) : LAgmat(a, mo, m, n) // endfun

fun{}
LAgmat_make_matrixptr
  {a:t0p}{m,n:int}
(
  M: matrixptr (INV(a), m, n), int(m), int(n)
) : LAgmat(a, mrow, m, n) // endfun

(* ****** ****** *)

fun{a:t0p}
LAgmat_make_uninitized
  {mo:int}{m,n:nat}
  (MORD(mo), m: int(m), n: int(n)): LAgmat(a?, mo, m, n)
// end of [LAgmat_make_uninitized]

(* ****** ****** *)

fun{a:t0p}
LAgmat_get_at
  {mo:mord}{m,n:int}
(
  M: !LAgmat(a, mo, m, n), i: natLt(m), j: natLt(n)
) : (a) // endfun
fun{a:t0p}
LAgmat_set_at
  {mo:mord}{m,n:int}
(
  M: !LAgmat(a, mo, m, n), i: natLt(m), j: natLt(n), x: a
) : void // endfun
//
overload [] with LAgmat_get_at
overload [] with LAgmat_set_at
//
(* ****** ****** *)

fun{a:t0p}
LAgmat_getref_at
  {mo:mord}{m,n:int}
(
  M: !LAgmat(a, mo, m, n), i: natLt(m), j: natLt(n)
) : cPtr1(a) // end of [LAgmat_getref_at]

(* ****** ****** *)

fun{a:t0p}
LAgmat_interchange_row
  {mo:mord}{m,n:int}
(
  M: !LAgmat(a, mo, m, n), i1: natLt(m), i2: natLt(m)
) : void // end of [gmatcol_interchange_row]

fun{a:t0p}
LAgmat_interchange_col
  {mo:mord}{m,n:int}
(
  M: !LAgmat(a, mo, m, n), j1: natLt(n), j2: natLt(n)
) : void // end of [gmatcol_interchange_col]

(* ****** ****** *)
//
fun{}
fprint_LAgmat$sep1 (FILEref): void
fun{}
fprint_LAgmat$sep2 (FILEref): void
fun{a:t0p}
fprint_LAgmat
  {mo:mord}{m,n:int} (FILEref, !LAgmat(a, mo, m, n)): void
overload fprint with fprint_LAgmat
//
fun{a:t0p}
fprint_LAgmat_sep
  {mo:mord}{m,n:int}
  (FILEref, !LAgmat(a, mo, m, n), sep1: string, sep2: string): void
//
(* ****** ****** *)

fun{a:t0p}
LAgmat_split_1x2
  {mo:mord}{m,n:int}
  {j:nat | j <= n}
(
  LAgmat(a, mo, m, n), j: int j
) :
(
  LAgmat(a, mo,   m,   j)
, LAgmat(a, mo,   m, n-j)
) (* end of [LAgmat_split_1x2] *)

fun{a:t0p}
LAgmat_split_2x1
  {mo:mord}{m,n:int}
  {i:nat | i <= m}
(
  LAgmat(a, mo, m, n), i: int i
) :
(
  LAgmat(a, mo,   i,   n)
, LAgmat(a, mo, m-i,   n)
) (* end of [LAgmat_split_2x1] *)

fun{a:t0p}
LAgmat_split_2x2
  {mo:mord}{m,n:int}
  {i,j:nat | i <= m; j <= n}
(
  LAgmat(a, mo, m, n), i: int i, j: int j
) :
(
  LAgmat(a, mo,   i,   j)
, LAgmat(a, mo,   i, n-j)
, LAgmat(a, mo, m-i,   j)
, LAgmat(a, mo, m-i, n-j)
) (* end of [LAgmat_split_2x2] *)

(* ****** ****** *)

fun{a:t0p}
LAgmat_tabulate$fopr (i: int, j: int): a
fun{a:t0p}
LAgmat_tabulate
  {mo:mord}{m,n:pos}
  (mo: MORD(mo), m: int m, n: int n): LAgmat(a, mo, m, n)
// end of [LAgmat_tabulate]

(* ****** ****** *)
//
fun
{a:t0p}
{env:vt0p}
LAgmat_iforeach$fwork
  (i: int, j: int, x: &a >> _, env: &env >> _): void
fun{a:t0p}
LAgmat_iforeach
  {mo:mord}{m,n:int} (!LAgmat (a, mo, m, n) >> _): void
fun
{a:t0p}
{env:vt0p}
LAgmat_iforeach_env
  {mo:mord}{m,n:int}
  (M: !LAgmat (a, mo, m, n) >> _, env: &env >> _): void
//
(* ****** ****** *)
//
fun{a:t0p}
LAgmat_imake$fopr (i: int, j: int, x: a): a
fun{a:t0p}
LAgmat_imake_arrayptr
  {mo:mord}{m,n:int}
  (M: !LAgmat (a, mo, m, n)): arrayptr (a, m*n)
fun{a:t0p}
LAgmat_imake_matrixptr
  {mo:mord}{m,n:int}
  (M: !LAgmat (a, mo, m, n)): matrixptr (a, m, n)
//
(* ****** ****** *)
//
// X <- alpha*X
//
fun{a:t0p}
LAgmat_scal
  {mo:mord}{m,n:int}
(
  alpha: a
, X: !LAgmat(a, mo, m, n) >> _
) : void // endfun

fun{a:t0p}
scal_LAgmat
  {mo:mord}{m,n:int}
(
  alpha: a, X: !LAgmat(a, mo, m, n)
) : LAgmat(a, mo, m, n)

(* ****** ****** *)
//
// Y <- X
//
fun{a:t0p}
LAgmat_copy
  {mo:mord}{m,n:int}
(
  X: !LAgmat(a, mo, m, n)
, Y: !LAgmat(a?, mo, m, n) >> LAgmat(a, mo, m, n)
) : void // endfun

fun{a:t0p}
copy_LAgmat
  {mo:mord}{m,n:int}
  (X: !LAgmat(a, mo, m, n)) : LAgmat(a, mo, m, n)
// end of [copy_LAgmat]

(* ****** ****** *)

fun{a:t0p}
LAgmat_transp
  {mo:mord}{m,n:int}
(
  X: !LAgmat(a, mo, m, n)
, Y: !LAgmat(a?, mo, n, m) >> LAgmat(a, mo, n, m)
) : void // endfun

fun{a:t0p}
transp_LAgmat
  {mo:mord}{m,n:int}
  (X: !LAgmat(a, mo, m, n)) : LAgmat(a, mo, n, m)
// end of [transp_LAgmat]

(* ****** ****** *)
//
// Y <- X + Y
//
fun{a:t0p}
LAgmat_1x1y
  {mo:mord}{m,n:int}
(
  X: !LAgmat(a, mo, m, n)
, Y: !LAgmat(a, mo, m, n) >> _
) : void // endfun
//
// Y <- alpha*X + Y
//
fun{a:t0p}
LAgmat_ax1y
  {mo:mord}{m,n:int}
(
  alpha: a
, X: !LAgmat(a, mo, m, n)
, Y: !LAgmat(a, mo, m, n) >> _
) : void // endfun
//
// Y <- alpha*X + beta*Y
//
fun{a:t0p}
LAgmat_axby
  {mo:mord}{m,n:int}
(
  alpha: a
, X: !LAgmat(a, mo, m, n)
, beta: a
, Y: !LAgmat(a, mo, m, n) >> _
) : void // endfun

(* ****** ****** *)

fun{a:t0p}
add11_LAgmat_LAgmat
  {mo:mord}{m,n:int}
(
  X: !LAgmat(a, mo, m, n), Y: !LAgmat(a, mo, m, n)
) : LAgmat(a, mo, m, n)
overload + with add11_LAgmat_LAgmat

fun{a:t0p}
sub11_LAgmat_LAgmat
  {mo:mord}{m,n:int}
(
  X: !LAgmat(a, mo, m, n), Y: !LAgmat(a, mo, m, n)
) : LAgmat(a, mo, m, n)
overload - with sub11_LAgmat_LAgmat

(* ****** ****** *)
//
// C <- alpha*(A*B) + beta*C
//
fun{a:t0p}
LAgmat_gemm
  {mo:mord}
  {p,q,r:int}
  {tra,trb:transp}
  {ma,na:int}{mb,nb:int}
(
  pfa: transpdim (tra, ma, na, p, q)
, pfb: transpdim (trb, mb, nb, q, r)   
| alpha: a
, A: !LAgmat(a, mo, ma, na), TRANSP(tra)
, B: !LAgmat(a, mo, mb, nb), TRANSP(trb)
, beta: a
, C: !LAgmat(a, mo, p, r) >> _
) : void // endfun

fun{a:t0p}
LAgmat_gemm_nn
  {mo:mord}
  {p,q,r:int}
(
  alpha: a
, A: !LAgmat(a, mo, p, q)
, B: !LAgmat(a, mo, q, r)
, beta: a
, C: !LAgmat(a, mo, p, r) >> _
) : void // endfun

fun{a:t0p}
LAgmat_gemm_nt
  {mo:mord}
  {p,q,r:int}
(
  alpha: a
, A: !LAgmat(a, mo, p, q)
, B: !LAgmat(a, mo, r, q)
, beta: a
, C: !LAgmat(a, mo, p, r) >> _
) : void // endfun

fun{a:t0p}
LAgmat_gemm_tn
  {mo:mord}
  {p,q,r:int}
(
  alpha: a
, A: !LAgmat(a, mo, q, p)
, B: !LAgmat(a, mo, q, r)
, beta: a
, C: !LAgmat(a, mo, p, r) >> _
) : void // endfun

fun{a:t0p}
LAgmat_gemm_tt
  {mo:mord}
  {p,q,r:int}
(
  alpha: a
, A: !LAgmat(a, mo, q, p)
, B: !LAgmat(a, mo, r, q)
, beta: a
, C: !LAgmat(a, mo, p, r) >> _
) : void // endfun

(* ****** ****** *)

fun{a:t0p}
mul00_LAgmat_LAgmat
  {mo:mord}{p,q,r:int}
(
  X: LAgmat(a, mo, p, q), Y: LAgmat(a, mo, q, r)
) : LAgmat(a, mo, p, r)
fun{a:t0p}
mul01_LAgmat_LAgmat
  {mo:mord}{p,q,r:int}
(
  X: LAgmat(a, mo, p, q), Y: !LAgmat(a, mo, q, r)
) : LAgmat(a, mo, p, r)
fun{a:t0p}
mul10_LAgmat_LAgmat
  {mo:mord}{p,q,r:int}
(
  X: !LAgmat(a, mo, p, q), Y: LAgmat(a, mo, q, r)
) : LAgmat(a, mo, p, r)
fun{a:t0p}
mul11_LAgmat_LAgmat
  {mo:mord}{p,q,r:int}
(
  X: !LAgmat(a, mo, p, q), Y: !LAgmat(a, mo, q, r)
) : LAgmat(a, mo, p, r)
overload * with mul11_LAgmat_LAgmat

(* ****** ****** *)

(* end of [lamatrix.sats] *)
