(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)

abst0ype
stamp_t0ype = int
typedef stamp = stamp_t0ype

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

abstype symbol_type = ptr
typedef symbol = symbol_type

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

abstype location_type = ptr
typedef loc_t = location_type

(* ****** ****** *)

fun fprint_location
  : (FILEref, loc_t) -> void
overload fprint with fprint_location

(* ****** ****** *)

fun location_make (rep: string): loc_t

(* ****** ****** *)

datatype
funkind = 
datatype
funkind =
//
  | FK_fn // nonrec fun
  | FK_fnx // tailrec fun
  | FK_fun // recursive fun
//
  | FK_ignored // error-handling
// end of [funkind]

(* ****** ****** *)

datatype
valkind =
//
  | VK_val // val
  | VK_val_pos // val+
  | VK_val_neg // val-
//
  | VK_ignored // error-handling
// end of [valkind]

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

abstype d2sym_type = ptr
typedef d2sym = d2sym_type

(* ****** ****** *)

fun fprint_d2sym
  : (FILEref, d2sym) -> void
overload fprint with fprint_d2sym

(* ****** ****** *)

fun d2sym_make (sym: symbol): d2sym

(* ****** ****** *)

fun d2sym_get_name (d2sym):<> symbol

(* ****** ****** *)

datatype
p2at_node =
//
  | P2Tany of ()
  | P2Tvar of (d2var)
//
  | P2Tpat of (p2at)
//
  | P2Tignored of ((*void*))
// end of [p2at_node]

where
p2at = '{
  p2at_loc= loc_t, p2at_node= p2at_node
} (* end of [p2at] *)

and
p2atlst = List0 (p2at)

(* ****** ****** *)
//
fun fprint_p2at: (FILEref, p2at) -> void
fun fprint_p2atlst: (FILEref, p2atlst) -> void
//
overload fprint with fprint_p2at
overload fprint with fprint_p2atlst of 10
//
(* ****** ****** *)
//
fun p2at_make_node
  (loc: loc_t, node: p2at_node): p2at
//
(* ****** ****** *)

fun p2at_var (loc: loc_t, d2v: d2var): p2at

(* ****** ****** *)

fun p2at_ignored (loc_t): p2at // error-handling

(* ****** ****** *)

datatype
d2ecl_node =
//
  | D2Cimpdec of (int(*knd*), i2mpdec)
//
  | D2Cfundecs of (funkind, f2undeclst)
  | D2Cvaldecs of (valkind, v2aldeclst)
//
  | D2Clocal of (d2eclist(*head*), d2eclist(*body*))
//
  | D2Cignored of ((*void*)) // HX: error-handling
// end of [d2ecl_node]

and d2exp_node =
//
  | D2Ecst of (d2cst)
  | D2Evar of (d2var)
  | D2Esym of (d2sym)
//
  | D2Eint of (int)
  | D2Echar of (char)
  | D2Efloat of (double)
  | D2Estring of (string)
//
  | D2Ei0nt of (string)
  | D2Ef0loat of (string)
  | D2Es0tring of (string)
//
  | D2Eempty of ((*void*))
//
  | D2Eexp of (d2exp) // dummy
//
  | D2Elet of (d2eclist, d2exp)
//
  | D2Eapplst of (d2exp, d2exparglst)
//
  | D2Eifopt of (
      d2exp(*test*), d2exp(*then*), d2expopt(*else*)
    ) (* end of [D2Eifopt] *)
//
  | D2Elam of (p2atlst, d2exp)
  | D2Efix of (d2var, p2atlst, d2exp)
//
  | D2Eignored of ((*void*)) // HX: error-handling
//
// end of [d2exp_node]

and d2exparg =
  | D2EXPARGsta of ()
  | D2EXPARGdyn of (int, loc_t, d2explst)
// end of [d2exparg]

where
d2ecl = '{
  d2ecl_loc= loc_t, d2ecl_node= d2ecl_node
} (* end of [d2ecl] *)

and d2eclist = List0 (d2ecl)

and
d2exp = '{
  d2exp_loc= loc_t, d2exp_node= d2exp_node
} (* end of [d2exp] *)

and d2explst = List0 (d2exp)
and d2expopt = Option (d2exp)

and d2exparglst = List0 (d2exparg)

and i2mpdec = '{
  i2mpdec_loc= loc_t
, i2mpdec_locid= loc_t
, i2mpdec_cst= d2cst
, i2mpdec_def= d2exp
} (* end of [i2mpdec] *)

and f2undec = '{
  f2undec_loc= loc_t
, f2undec_var= d2var
, f2undec_def= d2exp
} (* end of [f2undec] *)

and f2undeclst = List0 (f2undec)

and v2aldec = '{
  v2aldec_loc= loc_t
, v2aldec_pat= p2at
, v2aldec_def= d2exp
} (* end of [v2aldec] *)

and v2aldeclst = List0 (v2aldec)

(* ****** ****** *)
//
fun fprint_d2exp: (FILEref, d2exp) -> void
fun fprint_d2explst: (FILEref, d2explst) -> void
fun fprint_d2expopt: (FILEref, d2expopt) -> void
//
overload fprint with fprint_d2exp
overload fprint with fprint_d2explst of 10
overload fprint with fprint_d2expopt of 10
//
(* ****** ****** *)
//
fun fprint_d2exparg: (FILEref, d2exparg) -> void
fun fprint_d2exparglst: (FILEref, d2exparglst) -> void
//
overload fprint with fprint_d2exparg
overload fprint with fprint_d2exparglst of 10
//
(* ****** ****** *)
//
fun fprint_d2ecl: (FILEref, d2ecl) -> void
fun fprint_d2eclist : (FILEref, d2eclist) -> void
//
overload fprint with fprint_d2ecl
overload fprint with fprint_d2eclist of 10
//
(* ****** ****** *)

fun d2exp_make_node
  (loc: loc_t, node: d2exp_node): d2exp

(* ****** ****** *)

fun d2exp_cst (loc: loc_t, d2c: d2cst): d2exp
fun d2exp_var (loc: loc_t, d2v: d2var): d2exp
fun d2exp_sym (loc: loc_t, d2s: d2sym): d2exp

(* ****** ****** *)

fun d2exp_i0nt (loc: loc_t, rep: string): d2exp
fun d2exp_f0loat (loc: loc_t, rep: string): d2exp
fun d2exp_s0tring (loc: loc_t, rep: string): d2exp

(* ****** ****** *)

fun d2exp_empty (loc: loc_t): d2exp

(* ****** ****** *)

fun d2exp_exp (loc: loc_t, d2e: d2exp): d2exp

(* ****** ****** *)

fun d2exp_let
  (loc: loc_t, d2cs: d2eclist, d2e: d2exp): d2exp
// end of [d2exp_let]

(* ****** ****** *)

fun d2exp_applst
  (loc: loc_t, d2e: d2exp, d2as: d2exparglst): d2exp
// end of [d2exp_applst]

(* ****** ****** *)

fun d2exp_ifopt
(
  loc: loc_t, d2exp(*test*), d2exp(*then*), d2expopt(*else*)
) : d2exp // end of [d2exp_ifopt]

(* ****** ****** *)

fun d2exp_lam
  (loc: loc_t, p2ts: p2atlst, d2e: d2exp): d2exp
// end of [d2exp_lam]

(* ****** ****** *)

fun d2exp_fix
(
  loc: loc_t, d2v: d2var, p2ts: p2atlst, d2e: d2exp
) : d2exp // end of [d2exp_fix]

(* ****** ****** *)

fun d2exp_ignored (loc_t): d2exp // error-handling

(* ****** ****** *)

fun
i2mpdec_make
(
  loc: loc_t, locid: loc_t, d2cst, def: d2exp
) : i2mpdec // end of [i2mpdec_make]

(* ****** ****** *)

fun f2undec_make (loc_t, d2var, def: d2exp): f2undec

(* ****** ****** *)

fun v2aldec_make (loc_t, p2t0: p2at, def: d2exp): v2aldec

(* ****** ****** *)
//
fun d2ecl_make_node
  (loc: loc_t, node: d2ecl_node): d2ecl
//
(* ****** ****** *)

fun d2ecl_fundeclst
  (loc: loc_t, knd: funkind, f2ds: f2undeclst): d2ecl
fun d2ecl_valdeclst
  (loc: loc_t, knd: valkind, v2ds: v2aldeclst): d2ecl

(* ****** ****** *)

fun d2ecl_local
  (loc: loc_t, head: d2eclist, body: d2eclist): d2ecl

(* ****** ****** *)

fun d2ecl_ignored (loc_t): d2ecl // error-handling

(* ****** ****** *)
//
symintr .name
overload .name with d2cst_get_name
overload .name with d2var_get_name
overload .name with d2sym_get_name
//
symintr .stamp
overload .stamp with d2cst_get_stamp
overload .stamp with d2var_get_stamp
//
(* ****** ****** *)

(* end of [utfpl.sats] *)
