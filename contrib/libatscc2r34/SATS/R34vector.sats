(* ****** ****** *)
(*
** For writing ATS code
** that translates into R(stat)
*)
(* ****** ****** *)
//
// HX:
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
{a:t@ype}
R34vector_mean
{n:pos}(xs: R34vector(a, n)): double = "mac#%"
//
(* ****** ****** *)
fun
{a:t@ype}
R34vector_variance
{n:pos}(xs: R34vector(a, n)): double = "mac#%"
//
(* ****** ****** *)

overload mean with R34vector_mean
overload variance with R34vector_variance

(* ****** ****** *)

(* end of [R34vector.sats] *)
