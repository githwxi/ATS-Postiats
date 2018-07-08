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
// HX: for floating point numbers
//
(* ****** ****** *)
//
fun
abs_double
  : double -<> double = "mac#%"
fun
neg_double
  : double -<> double = "mac#%"
//
overload abs with abs_double of 100
overload neg with neg_double of 100
//
(* ****** ****** *)
//
fun
succ_double
  : double -<> double = "mac#%"
fun
pred_double
  : double -<> double = "mac#%"
//
overload succ with succ_double of 100
overload pred with pred_double of 100
//
(* ****** ****** *)
//
fun
sqrt_double
  : double -<> double = "mac#%"
//
overload sqrt with sqrt_double of 100
//
(* ****** ****** *)
//
fun
add_int_double
  : (int, double) -<> double = "mac#%"
fun
add_double_int
  : (double, int) -<> double = "mac#%"
//
fun
sub_int_double
  : (int, double) -<> double = "mac#%"
fun
sub_double_int
  : (double, int) -<> double = "mac#%"
//
fun
mul_int_double
  : (int, double) -<> double = "mac#%"
fun
mul_double_int
  : (double, int) -<> double = "mac#%"
//
fun
div_int_double
  : (int, double) -<> double = "mac#%"
fun
div_double_int
  : (double, int) -<> double = "mac#%"
//
(* ****** ****** *)

overload + with add_int_double of 100
overload + with add_double_int of 100
overload - with sub_int_double of 100
overload - with sub_double_int of 100
overload * with mul_int_double of 100
overload * with mul_double_int of 100
overload / with div_int_double of 100
overload / with div_double_int of 100

(* ****** ****** *)

typedef
float_aop_type = (double, double) -<> double

(* ****** ****** *)
//
fun
add_double_double: float_aop_type = "mac#%"
fun
sub_double_double : float_aop_type = "mac#%"
fun
mul_double_double : float_aop_type = "mac#%"
fun
div_double_double : float_aop_type = "mac#%"
//
(* ****** ****** *)
//
overload + with add_double_double of 100
overload - with sub_double_double of 100
overload * with mul_double_double of 100
overload / with div_double_double of 100
//
(* ****** ****** *)
//
fun lt_int_double
  : (int, double) -<> bool = "mac#%"
fun lt_double_int
  : (double, int) -<> bool = "mac#%"
//
fun lte_int_double
  : (int, double) -<> bool = "mac#%"
fun lte_double_int
  : (double, int) -<> bool = "mac#%"
//
fun gt_int_double
  : (int, double) -<> bool = "mac#%"
fun gt_double_int
  : (double, int) -<> bool = "mac#%"
//
fun gte_int_double
  : (int, double) -<> bool = "mac#%"
fun gte_double_int
  : (double, int) -<> bool = "mac#%"
//
(* ****** ****** *)

typedef
float_cmp_type = (double, double) -<> bool

(* ****** ****** *)
//
fun lt_double_double: float_cmp_type = "mac#%"
fun lte_double_double: float_cmp_type = "mac#%"
fun gt_double_double: float_cmp_type = "mac#%"
fun gte_double_double: float_cmp_type = "mac#%"
//
fun eq_double_double: float_cmp_type = "mac#%"
fun neq_double_double: float_cmp_type = "mac#%"
//
(* ****** ****** *)
//
overload < with lt_double_double of 100
overload <= with lte_double_double of 100
overload > with gt_double_double of 100
overload >= with gte_double_double of 100
overload = with eq_double_double of 100
overload != with neq_double_double of 100
overload <> with neq_double_double of 100
//
(* ****** ****** *)
//
fun
compare_double_double
( x1: double
, x2: double):<> Sgn = "mac#%"
//
overload
compare with compare_double_double of 100
//
(* ****** ****** *)
//
fun
max_double_double
( x1: double
, x2: double):<> double = "mac#%"
fun
min_double_double
( x1: double
, x2: double):<> double = "mac#%"
//
overload max with max_double_double of 100
overload min with min_double_double of 100
//
(* ****** ****** *)
//
fun
exp_double
  (arg: double):<> double = "mac#%"
fun
pow_double_double
( arg1: double
, arg2: double):<> double = "mac#%"
//
overload exp with exp_double of 100
overload pow with pow_double_double of 100
//
(* ****** ****** *)
//
fun
log_double
  (arg: double):<> double = "mac#%"
fun
log2_double
  (arg: double):<> double = "mac#%"
fun
log10_double
  (arg: double):<> double = "mac#%"
//
overload log with log_double of 100
overload log2 with log2_double of 100
overload log10 with log10_double of 100
//
(* ****** ****** *)

(* end of [float.sats] *)
