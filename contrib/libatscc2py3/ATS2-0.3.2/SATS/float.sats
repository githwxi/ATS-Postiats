(*
** For writing ATS code
** that translates into Python
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_"
//
(* ****** ****** *)
//
fun double2int (x: double): int = "mac#%"
fun int_of_double (x: double): int = "mac#%"
//
fun int2double (x: int): double = "mac#%"
fun double_of_int (x: int): double = "mac#%"
//
(* ****** ****** *)

fun abs_double : (double) -> double = "mac#%"
fun neg_double : (double) -> double = "mac#%"

(* ****** ****** *)

overload abs with abs_double of 100
overload neg with neg_double of 100

(* ****** ****** *)

fun succ_double : (double) -> double = "mac#%"
fun pred_double : (double) -> double = "mac#%"

(* ****** ****** *)

overload succ with succ_double of 100
overload pred with pred_double of 100

(* ****** ****** *)
//
fun add_int_double
  : (int, double) -<fun> double = "mac#%"
fun add_double_int
  : (double, int) -<fun> double = "mac#%"
//
fun sub_int_double
  : (int, double) -<fun> double = "mac#%"
fun sub_double_int
  : (double, int) -<fun> double = "mac#%"
//
fun mul_int_double
  : (int, double) -<fun> double = "mac#%"
fun mul_double_int
  : (double, int) -<fun> double = "mac#%"
//
fun div_int_double
  : (int, double) -<fun> double = "mac#%"
fun div_double_int
  : (double, int) -<fun> double = "mac#%"
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
float_aop_type = (double, double) -> double

(* ****** ****** *)
//
fun add_double_double : float_aop_type = "mac#%"
fun sub_double_double : float_aop_type = "mac#%"
fun mul_double_double : float_aop_type = "mac#%"
fun div_double_double : float_aop_type = "mac#%"
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
  : (int, double) -<fun> bool = "mac#%"
fun lte_int_double
  : (int, double) -<fun> bool = "mac#%"
fun gt_int_double
  : (int, double) -<fun> bool = "mac#%"
fun gte_int_double
  : (int, double) -<fun> bool = "mac#%"
//
fun lt_double_int
  : (double, int) -<fun> bool = "mac#%"
fun lte_double_int
  : (double, int) -<fun> bool = "mac#%"
fun gt_double_int
  : (double, int) -<fun> bool = "mac#%"
fun gte_double_int
  : (double, int) -<fun> bool = "mac#%"
//
(* ****** ****** *)

typedef
float_cmp_type = (double, double) -<fun> bool

(* ****** ****** *)
//
fun lt_double_double : float_cmp_type = "mac#%"
fun lte_double_double : float_cmp_type = "mac#%"
//
fun gt_double_double : float_cmp_type = "mac#%"
fun gte_double_double : float_cmp_type = "mac#%"
//
fun eq_double_double : float_cmp_type = "mac#%"
fun neq_double_double : float_cmp_type = "mac#%"
//
(* ****** ****** *)
//
fun
compare_double_double : (double, double) -<fun> int
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
overload compare with compare_double_double of 100
//
(* ****** ****** *)

(* end of [float.sats] *)
