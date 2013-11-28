(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)

abst0ype
stamp_t0ype = int
typedef
stamp = stamp_t0ype

(* ****** ****** *)

fun fprint_stamp
  : (FILEref, stamp) -> void
overload fprint with fprint_stamp

(* ****** ****** *)

fun stamp_make (int): stamp

(* ****** ****** *)
//
fun
compare_stamp_stamp
  : (stamp, stamp) -<fun0> int
overload compare with compare_stamp_stamp
//
(* ****** ****** *)

abstype
symbol_type = ptr
typedef
symbol = symbol_type

(* ****** ****** *)

fun fprint_symbol
  : (FILEref, symbol) -> void
overload fprint with fprint_symbol

(* ****** ****** *)

fun symbol_make (string): symbol

(* ****** ****** *)
//
fun
compare_symbol_symbol
  : (symbol, symbol) -<fun0> int
overload compare with compare_symbol_symbol
//
(* ****** ****** *)

abstype
location_type = ptr
typedef
location = location_type

(* ****** ****** *)

fun fprint_location
  : (FILEref, location) -> void
overload fprint with fprint_location

(* ****** ****** *)

fun location_make (rep: string): location

(* ****** ****** *)

abstype d2cst_type = ptr
typedef d2cst = d2cst_type
typedef d2cstlst = List0 (d2cst)
typedef d2cstopt = Option (d2cst)
vtypedef d2cstopt_vt = Option_vt (d2cst)

(* ****** ****** *)

fun fprint_d2cst
  : (FILEref, d2cst) -> void
overload fprint with fprint_d2cst

(* ****** ****** *)

fun d2cst_make (symbol, stamp): d2cst

(* ****** ****** *)
//
fun d2cst_get_name (d2cst):<> symbol
fun d2cst_get_stamp (d2cst):<> stamp
//
(* ****** ****** *)
//
fun eq_d2cst_d2cst : (d2cst, d2cst) -<> bool
fun neq_d2cst_d2cst : (d2cst, d2cst) -<> bool
fun compare_d2cst_d2cst : (d2cst, d2cst) -<> int
//
overload = with eq_d2cst_d2cst
overload != with eq_d2cst_d2cst
overload compare with compare_d2cst_d2cst
//
(* ****** ****** *)

abstype d2var_type = ptr
typedef d2var = d2var_type
typedef d2varlst = List0 (d2var)
typedef d2varopt = Option (d2var)
vtypedef d2varopt_vt = Option_vt (d2var)

(* ****** ****** *)

fun fprint_d2var
  : (FILEref, d2var) -> void
overload fprint with fprint_d2var

(* ****** ****** *)

fun d2var_make (symbol, stamp): d2var

(* ****** ****** *)
//
fun d2var_get_name (d2var):<> symbol
fun d2var_get_stamp (d2var):<> stamp
//
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

datatype
p2at_node =
  | P2Tvar of (d2var)
  | P2Terr of ((*void*))

where
p2at = '{
  p2at_loc= location, p2at_node= p2at_node
} (* end of [p2at] *)

and
p2atlst = List0 (p2at)

(* ****** ****** *)

fun fprint_p2at
  : (FILEref, p2at) -> void
overload fprint with fprint_p2at

(* ****** ****** *)
//
fun p2at_make_node
  (loc: location, node: p2at_node): p2at
//
(* ****** ****** *)

fun p2at_var (loc: location, d2v: d2var): p2at

(* ****** ****** *)

fun p2at_err (loc: location): p2at // HX: error-handling

(* ****** ****** *)

datatype
d2ecl_node =
//
  | D2Cfundecs of f2undeclst
//
  | D2Cerr of ((*void*))

and d2exp_node =
//
  | D2Evar of (d2var)
  | D2Ecst of (d2cst)
//
  | D2Eint of (int)
  | D2Echar of (char)
  | D2Efloat of (double)
  | D2Estring of (string)
//
  | D2Eapp of (d2exp, d2explst)
//
  | D2Eifopt of (d2exp(*test*), d2exp(*then*), d2expopt(*else*))
//
  | D2Elam of (p2atlst, d2exp)
  | D2Efix of (d2var, p2atlst, d2exp)
//
  | D2Eerr of ((*void*))
//
// end of [d2exp_node]

where
d2ecl = '{
  d2ecl_loc= location, d2ecl_node= d2ecl_node
} (* end of [d2ecl] *)

and d2eclist = List0 (d2ecl)

and
d2exp = '{
  d2exp_loc= location, d2exp_node= d2exp_node
} (* end of [d2exp] *)

and d2explst = List0 (d2exp)
and d2expopt = Option (d2exp)

and f2undec = '{
  f2undec_loc= location
, f2undec_var= d2var
, f2undec_def= d2exp
} (* end of [f2undec] *)

and f2undeclst = List0 (f2undec)

(* ****** ****** *)

fun fprint_d2exp
  : (FILEref, d2exp) -> void
overload fprint with fprint_d2exp

fun fprint_d2explst
  : (FILEref, d2explst) -> void
overload fprint with fprint_d2explst

(* ****** ****** *)

fun fprint_d2ecl
  : (FILEref, d2ecl) -> void
overload fprint with fprint_d2ecl

fun fprint_d2eclist
  : (FILEref, d2eclist) -> void
overload fprint with fprint_d2eclist

(* ****** ****** *)

fun d2exp_make_node
  (loc: location, node: d2exp_node): d2exp

(* ****** ****** *)

fun d2exp_cst (loc: location, d2c: d2cst): d2exp
fun d2exp_var (loc: location, d2v: d2var): d2exp

(* ****** ****** *)

fun d2exp_app
  (loc: location, d2e1: d2exp, d2es2: d2explst): d2exp
// end of [d2exp_app]

(* ****** ****** *)

fun d2exp_ifopt
(
  loc: location, d2exp(*test*), d2exp(*then*), d2expopt(*else*)
) : d2exp // end of [d2exp_ifopt]

(* ****** ****** *)

fun d2exp_lam
  (loc: location, p2ts: p2atlst, d2e: d2exp): d2exp
// end of [d2exp_lam]

(* ****** ****** *)

fun d2exp_fix
(
  loc: location, d2v: d2var, p2ts: p2atlst, d2e: d2exp
) : d2exp // end of [d2exp_fix]

(* ****** ****** *)

fun d2exp_err (loc: location): d2exp // HX: error-handling

(* ****** ****** *)

fun f2undec_make
  (loc: location, d2v: d2var, d2e: d2exp): f2undec

(* ****** ****** *)
//
fun d2ecl_make_node
  (loc: location, node: d2ecl_node): d2ecl
//
(* ****** ****** *)

fun d2ecl_fundeclst (loc: location, f2ds: f2undeclst): d2ecl

(* ****** ****** *)

fun d2ecl_err (loc: location): d2ecl // HX: error-handling

(* ****** ****** *)
//
symintr .name
overload .name with d2cst_get_name
overload .name with d2var_get_name
//
symintr .stamp
overload .stamp with d2cst_get_stamp
overload .stamp with d2var_get_stamp
//
(* ****** ****** *)

(* end of [utfpl.sats] *)
