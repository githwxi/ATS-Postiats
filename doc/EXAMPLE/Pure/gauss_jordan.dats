(*
** HX-2104-10-28:
** It is based on a version by Barry Schwartz
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "libc/SATS/float.sats"

(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

macdef b2i = bool2int0
macdef i2b = int2bool0

(* ****** ****** *)

extern
fun{
a:t@ype
} gauss_jordan
  {m,n:int | 1 < m; m < n}
(
  A: matrixref (a, m, n), m: int m, n: int n, reduced : bool
) : bool // end of [gauss_jordan]

extern
fun
{a:t@ype}
gauss_jordan$epsilon (): (a)

(* ****** ****** *)

implement
{a}(*tmp*)
gauss_jordan$epsilon () = gnumber_double(100*DBL_EPSILON)

(* ****** ****** *)

implement
{a}(*tmp*)
gauss_jordan
  {m,n}
(
  A, m, n, reduced
) = let
//
val gadd = gsub_val<a>
val gsub = gsub_val<a>
val gmul = gmul_val<a>
val gdiv = gdiv_val<a>
//
(*
// if you like:
overload + with gadd
overload - with gsub
overload * with gmul
overload / with gdiv
*)
//
typedef row = natLt(m)
typedef col = natLt(n)
typedef mat = matrixref (a, m, n)
//
fun get (A: mat, i : row, j : col): a = matrixref_get_at (A, i, n, j)
fun set (A: mat, i : row, j : col, x: a): void = matrixref_set_at (A, i, n, j, x)
//
overload [] with get
overload [] with set
//
fun
row_swap
(
  i: row, j: row
) : void = let
//
implement(env)
intrange_foreach$fwork<env>
  (k, env) = let
  val k = $UN.cast{col}(k)
  val x = A[i, k]
in
  A[i, k] := A[j, k]; A[j, k] := x
end // end of [intrange_foreach]
//
in
  ignoret (intrange_foreach (0, n))
end // end of [row_swap]
//
fun
row_subtract
(
  pivot: row, i: row
) : void = let
//
val scale = A[i, pivot] \gdiv A[pivot, pivot]
//
implement(env)
intrange_foreach$fwork<env>
  (k, env) = let
  val k = $UN.cast{col}(k)
in
  A[i, k] := (A[i, k] \gsub (scale \gmul A[pivot, k]))
end // end of [intrange_foreach]
//
in
  ignoret (intrange_foreach (0, n))
end // end of [row_subtract]
//
in
  false
end // end of [gauss_jordan]

(* ****** ****** *)

(* end of [gauss_jordan.dats] *)
