(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)

abstype
stamp_type = ptr
typedef
stamp = stamp_type

(* ****** ****** *)
//
fun
compare_stamp_stamp
  : (stamp, stamp) -<fun0> int
//
overload compare with compare_stamp_stamp
//
(* ****** ****** *)

abstype
symbol_type = ptr
typedef
symbol = symbol_type

(* ****** ****** *)

abstype
location_type = ptr
typedef
location = location_type

(* ****** ****** *)

fun fprint_location
  (out: FILEref, loc: location): void
overload fprint with fprint_location

(* ****** ****** *)

abstype d2var_type = ptr
typedef d2var = d2var_type
typedef d2varlst = List0 (d2var)

(* ****** ****** *)

fun fprint_d2var
  (out: FILEref, d2v: d2var): void
overload fprint with fprint_d2var

(* ****** ****** *)
//
fun eq_d2var_d2var : (d2var, d2var) -<> bool
fun neq_d2var_d2var : (d2var, d2var) -<> bool
fun compare_d2var_d2var : (d2var, d2var) -<> int
//
overload = with eq_d2var_d2var
overload != with eq_d2var_d2var
overload compare with compare_d2var_d2var
//
(* ****** ****** *)
//
fun d2var_get_stamp (d2var):<> stamp
//
symintr .stamp
overload .stamp with d2var_get_stamp
//
(* ****** ****** *)

abstype d2cst_type = ptr
typedef d2cst = d2cst_type
typedef d2cstlst = List0 (d2cst)

(* ****** ****** *)

fun fprint_d2cst
  (out: FILEref, d2c: d2cst): void
overload fprint with fprint_d2cst

(* ****** ****** *)

datatype
d2exp_node =
//
  | D2Evar of (d2var)
  | D2Ecst of (d2cst)
//
  | D2Eint of (int)
  | D2Echar of (char)
  | D2Efloat of (double)
  | D2Estring of (string)
//
  | D2Elam of (d2varlst, d2exp)
  | D2Efix of (d2var, d2varlst, d2exp)
//
  | D2Eapp of (d2exp, d2explst)
//
// end of [d2exp_node]

where
d2exp = '{
  d2exp_loc= location, d2exp_node= d2exp_node
} (* end of [d2exp] *)

and d2explst = List0 (d2exp)

(* ****** ****** *)

fun d2exp_lam
  (loc: location, d2vs: d2varlst, d2e: d2exp): d2exp
// end of [d2exp_lam]

(* ****** ****** *)

fun d2exp_fix
  (loc: location, d2v: d2var, d2vs: d2varlst, d2e: d2exp): d2exp
// end of [d2exp_fix]

(* ****** ****** *)

fun d2exp_app
  (loc: location, d2e1: d2exp, d2es2: d2explst): d2exp
// end of [d2exp_app]

(* ****** ****** *)

(* end of [utfpl.sats] *)
