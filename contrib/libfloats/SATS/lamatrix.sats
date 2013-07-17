(* ****** ****** *)
//
// Linear Algebra matrix operations
//
(* ****** ****** *)

staload "libats/SATS/gmatrix.sats"

(* ****** ****** *)

staload "contrib/libfloats/SATS/lavector.sats"

(* ****** ****** *)
//
absvtype
LAgmat_vtype
  (a:t@ype, mo: mord, l: addr, m: int, n: int)
//
stadef LAgmat = LAgmat_vtype
//
vtypedef LAgmat
  (a:t@ype, mo: mord, m: int, n: int) = [l:addr] LAgmat (a, mo, l, m, n)
//
(* ****** ****** *)

fun{a:t0p}
LAgmat_tabulate$fopr (i: intGte(0), j: intGte(0)): a
fun{a:t0p}
LAgmat_tabulate
  {mo:mord}{m,n:pos}
  (mo: MORD(mo), m: int m, n: int n): LAgmat (a, mo, n, n)
// end of [LAgmat_tabulate]

(* ****** ****** *)

fun{}
fprint_LAgmat$sep1 (FILEref): void
fun{}
fprint_LAgmat$sep2 (FILEref): void
fun{a:t0p}
fprint_LAgmat
  {mo:mord}{m,n:int} (FILEref, !LAgmat (a, mo, m, n)): void
overload fprint with fprint_LAgmat

(* ****** ****** *)

fun{a:t0p}
LAgmat_split_1x2
  {mo:mord}{m,n:int}
  {j:nat | j <= n}
(
  !LAgmat (a, mo, m, n), j: int j
) :
(
  LAgmat (a, mo,   m,   j)
, LAgmat (a, mo,   m, n-j)
) (* end of [LAgmat_split_1x2] *)

fun{a:t0p}
LAgmat_split_2x1
  {mo:mord}{m,n:int}
  {i:nat | i <= m}
(
  !LAgmat (a, mo, m, n), i: int i
) :
(
  LAgmat (a, mo,   i,   n)
, LAgmat (a, mo, m-i,   n)
) (* end of [LAgmat_split_2x1] *)

fun{a:t0p}
LAgmat_split_2x2
  {mo:mord}{m,n:int}
  {i,j:nat | i <= m; j <= n}
(
  !LAgmat (a, mo, m, n), i: int i, j: int j
) :
(
  LAgmat (a, mo,   i,   j)
, LAgmat (a, mo,   i, n-j)
, LAgmat (a, mo, m-i,   j)
, LAgmat (a, mo, m-i, n-j)
) (* end of [LAgmat_split_2x2] *)

(* ****** ****** *)
//
// HX-2013-07
// this is deep copy!
//
fun{a:t0p}
LAgmat_copy
  {mo:mord}{m,n:pos} (!LAgmat (a, mo, m, n)): LAgmat (a, mo, m, n)
// end of [LAgmat_copy]

(* ****** ****** *)

fun{a:t0p}
LAgmat_incref // refcnt++
  {mo:mord}{m,n:pos} (!LAgmat (a, mo, m, n)): LAgmat (a, mo, m, n)
// end of [LAgmat_incref]
fun{a:t0p}
LAgmat_decref
  {mo:mord}{m,n:pos} (M: LAgmat (a, mo, m, n)): void (* refcnt-- *)
// end of [LAgmat_decref]

(* ****** ****** *)

fun{a:t0p}
add_LAgmat_LAgmat
  {mo:mord}{m,n:int}
  (!LAgmat (a, mo, m, n), !LAgmat (a, mo, m, n)): LAgmat (a, mo, m, n)
overload + with add_LAgmat_LAgmat

(* ****** ****** *)

fun{a:t0p}
mul_LAgmat_LAgmat
  {mo:mord}{p,q,r:int}
  (!LAgmat (a, mo, p, q), !LAgmat (a, mo, q, r)): LAgmat (a, mo, p, r)
overload * with mul_LAgmat_LAgmat

(* ****** ****** *)

fun{a:t0p}
tmul_LAgvec_LAgvec
  {mo:mord}{m,n:int}
  (V1: !LAgvec (a, m), V2: !LAgvec (a, n), M3: LAgmat (a, mo, m, n)): void

(* ****** ****** *)

(* end of [lamatrix.sats] *)
