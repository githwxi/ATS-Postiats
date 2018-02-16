(* ****** ****** *)
(*
** For writing ATS code
** that translates into R(stat)
*)
(* ****** ****** *)
//
// HX-2018-02:
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
R34factor_levels
{n:int}
(
xs: R34factor(n)
) : R34vector(string, n) = "mac#%"
//
overload levels with R34factor_levels
//
(* ****** ****** *)
//
castfn
R34vector2factor_unsafe
{a:t0p}{n:int}
(xs: R34vector(a, n)): R34factor(n) = "mac#%"
//
(* ****** ****** *)

(* end of [R34factor.sats] *)
