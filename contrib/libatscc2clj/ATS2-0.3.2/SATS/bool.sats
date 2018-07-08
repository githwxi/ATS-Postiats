(*
** For writing ATS code
** that translates into Clojure
*)

(* ****** ****** *)
//
// HX: prefix for external names
//
#define ATS_EXTERN_PREFIX "ats2cljpre_"
//
(* ****** ****** *)
//
fun
bool2int0
  (b: bool):<> natLt(2) = "mac#%"
fun
bool2int1
  {b:bool}
  (b: bool(b)):<> int(bool2int(b)) = "mac#%"
//
symintr bool2int
overload bool2int with bool2int0 of 100
overload bool2int with bool2int1 of 110
//
(* ****** ****** *)
//
fun
int2bool0 (i: int):<> bool = "mac#%"
fun
int2bool1
  {i:int}(i: int(i)):<> bool(i != 0) = "mac#%"
//
symintr int2bool
overload int2bool with int2bool0 of 100
overload int2bool with int2bool1 of 110
//
(* ****** ****** *)
//
fun
neg_bool0
  : bool -> bool = "mac#%"
fun
neg_bool1
  : {b:bool} bool(b) -> bool(~b) = "mac#%"
//
overload ~ with neg_bool0 of 100
overload ~ with neg_bool1 of 110
//
overload not with neg_bool0 of 100
overload not with neg_bool1 of 110
//
(* ****** ****** *)
//
fun
eq_bool0_bool0 : (bool, bool) -> bool = "mac#%"
fun
neq_bool0_bool0 : (bool, bool) -> bool = "mac#%"
//
fun
eq_bool1_bool1 :
 {b1,b2:bool}(bool(b1), bool(b2)) -> bool(b1 == b2) = "mac#%"
fun
neq_bool1_bool1 :
 {b1,b2:bool}(bool(b1), bool(b2)) -> bool(b1 != b2) = "mac#%"
//
overload = with eq_bool0_bool0 of 100
overload = with eq_bool1_bool1 of 120
//
overload != with neq_bool0_bool0 of 100
overload != with neq_bool1_bool1 of 120
//
(* ****** ****** *)

(* end of [bool.sats] *)
