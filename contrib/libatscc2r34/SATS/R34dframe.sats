(* ****** ****** *)
(*
** For writing ATS code
** that translates into R(stat)
*)
(* ****** ****** *)
//
// HX-2017-10:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2r34pre_"
//
(* ****** ****** *)
//
#staload "./../basics_r34.sats"
//
(* ****** ****** *)
//
fun
R34dframe_nrow
{a:t0p}
{m,n:int}
(R34dframe(a, m, n)): int(m) = "mac#%"
fun
R34dframe_ncol
{a:t0p}
{m,n:int}
(R34dframe(a, m, n)): int(n) = "mac#%"
//
overload nrow with R34dframe_nrow
overload ncol with R34dframe_ncol
//
(* ****** ****** *)
//
fun
R34dfram_dimgt
{a:t0p}
{m,n:int}
{i,j:nat}
(R34dframe(a, m, n), int(i), int(j)): bool(m > i && n > j)
fun
R34dfram_dimgte
{a:t0p}
{m,n:int}
{i,j:nat}
(R34dframe(a, m, n), int(i), int(j)): bool(m >= i && n >= j)
//
overload dimgt with R34dfram_dimgt
overload dimgte with R34dfram_dimgte
//
(* ****** ****** *)
//
fun
R34dframe_names
{a:t0p}
{m,n:int}
(R34dframe(a, m, n)): R34vector(string, n) = "mac#%"
//
overload names with R34dframe_names
//
(* ****** ****** *)
//
fun
R34dframe_getcol_at
{a:t0p}
{m,n:int}
{j:pos | j <= n}
(R34dframe(a, m, n), j: int(j)): R34vector(a, m) = "mac#%"
//
fun
R34dframe_getcol_by
{a:t0p}
{m,n:int}
(R34dframe(a, m, n), name: string): R34vector(a, m) = "mac#%"
//
overload getcol_at with R34dframe_getcol_at
overload getcol_by with R34dframe_getcol_by
//
(* ****** ****** *)
//
fun
R34dframe_na_omit
{a:t0p}
{m1,n:int}
(
xs: R34dframe(a, m1, n)
) : [m2:nat | m2 <= m1] R34dframe(a, m2, n) = "mac#%"
//
(* ****** ****** *)
//
fun
R34dframe_subcol
{a:t0p}
{m,n:int}
{i,j:int
|1 <= i
;i <= j;j <= n}
( xs: R34dframe(a, m, n)
, i0: int(i), j0: int(j)): R34dframe(a, m, j-i+1) = "mac#%"
fun
R34dframe_subrow
{a:t0p}
{m,n:int}
{i,j:int
|1 <= i
;i <= j;j <= m}
( xs: R34dframe(a, m, n)
, i0: int(i), j0: int(j)): R34dframe(a, j-i+1, n) = "mac#%"
//
overload subcol with R34dframe_subcol
overload subrow with R34dframe_subrow
//
(* ****** ****** *)

(* end of [R34dframe.sats] *)
