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
tmulto_LAgvec_LAgvec
  {mo:mord}{m,n:int}
  (V1: !LAgvec (a, m), V2: !LAgvec (a, n), M3: LAgmat (a, mo, m, n)): void

(* ****** ****** *)

(* end of [lamatrix.sats] *)
