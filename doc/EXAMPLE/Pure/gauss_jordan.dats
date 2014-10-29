(*
** HX-2104-10-28:
** It is based on a version by Barry Schwartz
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

staload "libc/SATS/float.sats"

(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

extern
fun{
a:t@ype
} gauss_jordan
  {m,n:int | 1 <= m; m <= n}
(
  A: matrixref (a, m, n), m: int m, n: int n, reduced : bool
) : void // end of [gauss_jordan]

extern
fun
{a:t@ype}
gauss_jordan$epsilon (): (a)

(* ****** ****** *)

implement
{a}(*tmp*)
gauss_jordan$epsilon
(
// argumentless
) = gnumber_double(100*DBL_EPSILON)

(* ****** ****** *)
//
extern
fun
{a:t@ype} gmag_val (x: a):<> double
//
(* ****** ****** *)

implement
{a}(*tmp*)
gauss_jordan
  {m,n}
(
  A, m, n, reduced
) = let
//
val gneg = gneg_val<a>
val gadd = gadd_val<a>
val gsub = gsub_val<a>
val gmul = gmul_val<a>
val gdiv = gdiv_val<a>
val gmag = gmag_val<a>
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
typedef mat = matrixref(a, m, n)
//
fun get (A: mat, i: row, j: col): a = matrixref_get_at (A, i, n, j)
fun set (A: mat, i: row, j: col, x: a): void = matrixref_set_at (A, i, n, j, x)
//
overload [] with get
overload [] with set
//
fun
row_swap
(
  i0: row, i1: row, j: col
) : void = let
//
implement(env)
intrange_foreach$fwork<env>
  (j, env) = let
  val j =
  $UN.cast{col}(j)
  val x = A[i0, j]
in
  A[i0, j] := A[i1, j]; A[i1, j] := x
end // end of [intrange_foreach]
//
in
  ignoret (intrange_foreach (j, n))
end // end of [row_swap]
//
fun
row_axpy
(
  a: a, i0: row, i1: row, j: col
) : void = let
//
implement(env)
intrange_foreach$fwork<env>
  (j, env) = let
  val j = $UN.cast{col}(j)
in
  A[i1, j] := ((a \gmul A[i0, j]) \gadd A[i1, j])
end // end of [intrange_foreach]
//
in
  ignoret (intrange_foreach (j, n))
end // end of [row_axpy]
//
fun
rowcol_max
(
  j: row
) : row = let
//
fun
loop
(
  i0: row, i1: natLte(m), x0: double
) : row =
(
if
i1 < m
then let
  val x1 = gmag(A[i1, j])
in
  if (x0 >= x1)
    then loop (i0, i1+1, x0) else loop (i1, i1+1, x1)
  // end of [if]
end // end of [then]
else (i0) // end of [else]
)
//
in
  loop (j, j+1, gmag(A[j, j]))
end // end of [rowcol_max]
//
fun
do_one
(
  i: row
) : void = let
//
val j = i
val i_max = rowcol_max (i)
val ((*void*)) = row_swap (i, i_max, j)
val Aii = A[i, j]
//
fun
loop
(
  i1: natLte(m)
) : void =
(
if
(i1 < m)
then let
  val a = gneg(A[i1, j] \gdiv Aii)
in
  row_axpy (a, i, i1, j)
end // end of [then]
else () // end of [else]
)
//
in
  loop (i+1)
end // end of [do_one]
//
fun
do_all
(
  i: natLte(m)
) : void =
  if i < m then (do_one(i); do_all(i+1)) else ()
//
in
  do_all(0)
end // end of [gauss_jordan]

(* ****** ****** *)

(* end of [gauss_jordan.dats] *)
