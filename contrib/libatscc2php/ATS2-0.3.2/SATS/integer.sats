(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)
//
// HX: prefix for external names
//
#define ATS_EXTERN_PREFIX "ats2phppre_"
//
(* ****** ****** *)
//
fun
abs_int0 : int -<fun> int = "mac#%"
overload abs with abs_int0 of 100
//
(* ****** ****** *)
//
fun
neg_int0 : int -<fun> int = "mac#%"
//
fun neg_int1
  : {i:int} int(i) -<fun> int(~i) = "mac#%"
//
overload ~ with neg_int0 of 100
overload ~ with neg_int1 of 110
overload neg with neg_int0 of 100
overload neg with neg_int1 of 110
//
(* ****** ****** *)
//
fun succ_int0 : int -<fun> int = "mac#%"
fun pred_int0 : int -<fun> int = "mac#%"
//
fun succ_int1
  : {i:int} int(i) -<fun> int(i+1) = "mac#%"
fun pred_int1
  : {i:int} int(i) -<fun> int(i-1) = "mac#%"
//
overload succ with succ_int0 of 100
overload pred with pred_int0 of 100
//
overload succ with succ_int1 of 110
overload pred with pred_int1 of 110
//
(* ****** ****** *)
//
fun half_int0 : int -<fun> int = "mac#%"
fun half_int1
  : {i:int} int(i) -<fun> int(i/2) = "mac#%"
//
overload half with half_int0 of 100
overload half with half_int1 of 110
//
(* ****** ****** *)
//
fun add_int0_int0: (int, int) -<fun> int = "mac#%"
fun sub_int0_int0 : (int, int) -<fun> int = "mac#%"
fun mul_int0_int0 : (int, int) -<fun> int = "mac#%"
fun div_int0_int0 : (int, int) -<fun> int = "mac#%"
fun mod_int0_int0 : (int, int) -<fun> int = "mac#%"
//
(* ****** ****** *)
//
fun add_int1_int1
  : {i,j:int} (int(i), int(j)) -<fun> int(i+j) = "mac#%"
fun sub_int1_int1
  : {i,j:int} (int(i), int(j)) -<fun> int(i-j) = "mac#%"
fun mul_int1_int1
  : {i,j:int} (int(i), int(j)) -<fun> int(i*j) = "mac#%"
fun div_int1_int1
  : {i,j:int} (int(i), int(j)) -<fun> int(i/j) = "mac#%"
//
(* ****** ****** *)
//
fun
nmod_int1_int1
{ i,j:int
| i >= 0; j > 0
} (i: int(i), j: int(j)):<fun> int(nmod(i, j)) = "mac#%"
//
(* ****** ****** *)
//
overload + with add_int0_int0 of 100
overload - with sub_int0_int0 of 100
overload * with mul_int0_int0 of 100
overload / with div_int0_int0 of 100
overload % with mod_int0_int0 of 100
//
overload mod with mod_int0_int0 of 100
//
overload + with add_int1_int1 of 120
overload - with sub_int1_int1 of 120
overload * with mul_int1_int1 of 120
overload / with div_int1_int1 of 120
//
(* ****** ****** *)
//
fun lt_int0_int0: (int, int) -<fun> bool = "mac#%"
fun lte_int0_int0: (int, int) -<fun> bool = "mac#%"
fun gt_int0_int0: (int, int) -<fun> bool = "mac#%"
fun gte_int0_int0: (int, int) -<fun> bool = "mac#%"
//
fun eq_int0_int0: (int, int) -<fun> bool = "mac#%"
fun neq_int0_int0: (int, int) -<fun> bool = "mac#%"
//
fun compare_int0_int0: (int, int) -<fun> int = "mac#%"
//
(* ****** ****** *)
//
fun lt_int1_int1
  : {i,j:int} (int(i), int(j)) -<fun> bool(i < j) = "mac#%"
fun lte_int1_int1
  : {i,j:int} (int(i), int(j)) -<fun> bool(i <= j) = "mac#%"
fun gt_int1_int1
  : {i,j:int} (int(i), int(j)) -<fun> bool(i > j) = "mac#%"
fun gte_int1_int1
  : {i,j:int} (int(i), int(j)) -<fun> bool(i >= j) = "mac#%"
//
fun eq_int1_int1
  : {i,j:int} (int(i), int(j)) -<fun> bool(i == j) = "mac#%"
fun neq_int1_int1
  : {i,j:int} (int(i), int(j)) -<fun> bool(i != j) = "mac#%"
//
(* ****** ****** *)
//
overload < with lt_int0_int0 of 100
overload <= with lte_int0_int0 of 100
overload > with gt_int0_int0 of 100
overload >= with gte_int0_int0 of 100
overload = with eq_int0_int0 of 100
overload != with neq_int0_int0 of 100
overload <> with neq_int0_int0 of 100
//
overload compare with compare_int0_int0 of 100
//
(* ****** ****** *)
//
overload < with lt_int1_int1 of 120
overload <= with lte_int1_int1 of 120
overload > with gt_int1_int1 of 120
overload >= with gte_int1_int1 of 120
overload = with eq_int1_int1 of 120
overload != with neq_int1_int1 of 120
overload <> with neq_int1_int1 of 120
//
(* ****** ****** *)
//
fun max_int0_int0: (int, int) -<fun> int = "mac#%"
fun min_int0_int0: (int, int) -<fun> int = "mac#%"
//
fun max_int1_int1
  : {i,j:int} (int(i), int(j)) -<fun> int(max(i,j)) = "mac#%"
fun min_int1_int1
  : {i,j:int} (int(i), int(j)) -<fun> int(min(i,j)) = "mac#%"
//
(* ****** ****** *)
//
overload max with max_int0_int0 of 100
overload min with min_int0_int0 of 100
//
overload max with max_int1_int1 of 120
overload min with min_int1_int1 of 120
//
(* ****** ****** *)

(* end of [integer.sats] *)
