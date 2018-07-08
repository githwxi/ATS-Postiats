(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
//
(* ****** ****** *)

#staload "./../../basics_js.sats"

(* ****** ****** *)

val JSmath_E : double = "mac#%"
val JSmath_PI : double = "mac#%"
val JSmath_SQRT2 : double = "mac#%"
val JSmath_SQRT1_2 : double = "mac#%"
val JSmath_LN2 : double = "mac#%"
val JSmath_LN10 : double = "mac#%"
val JSmath_LOG2E : double = "mac#%"
val JSmath_LOG10E : double = "mac#%"

(* ****** ****** *)

fun JSmath_abs : double -<> double = "mac#%"

(* ****** ****** *)
//
fun JSmath_max
  : (double, double) -<> double = "mac#%"
fun JSmath_min
  : (double, double) -<> double = "mac#%"
//
(* ****** ****** *)

fun JSmath_sqrt : double -<> double = "mac#%"

(* ****** ****** *)

fun JSmath_exp : double -<> double = "mac#%"
fun JSmath_pow : (double, double) -<> double = "mac#%"
fun JSmath_log : double -<> double = "mac#%"

(* ****** ****** *)
  
fun JSmath_ceil : double -<> double = "mac#%"
fun JSmath_floor : double -<> double = "mac#%"
fun JSmath_round : double -<> double = "mac#%"
  
(* ****** ****** *)
//
fun JSmath_sin : double -<> double = "mac#%"
fun JSmath_cos : double -<> double = "mac#%"
fun JSmath_tan : double -<> double = "mac#%"
//
(* ****** ****** *)
//
fun JSmath_asin : double -<> double = "mac#%"
fun JSmath_acos : double -<> double = "mac#%"
fun JSmath_atan : double -<> double = "mac#%"
fun JSmath_atan2 (y: double, x: double): double = "mac#%"
//
(* ****** ****** *)
//
fun
JSmath_random
  ((*void*)):<!ref> double = "mac#%"
//
(* ****** ****** *)
//
// HX-2016-12-25
//
fun{}
JSmath_randint
  {n:int|n >= 1}(int(n)): natLt(n) = "mac#%"
//
(* ****** ****** *)

(* end of [JSmath.sats] *)
