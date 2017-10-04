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

(* end of [R34dframe.sats] *)
