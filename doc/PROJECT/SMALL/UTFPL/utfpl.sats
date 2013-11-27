(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)

abst0ype
stamp_t0ype = int
typedef
stamp = stamp_t0ype

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
  (out: FILEref, p2t: p2at): void
overload fprint with fprint_p2at

(* ****** ****** *)

fun p2at_var (loc: location, d2v: d2var): p2at

(* ****** ****** *)

datatype
d2ecl_node =
  | D2Cfundecs of f2undeclst

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
  (out: FILEref, d2e: d2exp): void
overload fprint with fprint_d2exp

fun fprint_d2explst
  (out: FILEref, d2es: d2explst): void
overload fprint with fprint_d2explst

(* ****** ****** *)

fun fprint_d2ecl
  (out: FILEref, d2c: d2ecl): void
overload fprint with fprint_d2ecl

fun fprint_d2eclist
  (out: FILEref, d2cs: d2eclist): void
overload fprint with fprint_d2eclist

(* ****** ****** *)

fun d2exp_lam
  (loc: location, p2ts: p2atlst, d2e: d2exp): d2exp
// end of [d2exp_lam]

(* ****** ****** *)

fun d2exp_fix
(
  loc: location, d2v: d2var, d2vs: d2varlst, d2e: d2exp
) : d2exp // end of [d2exp_fix]

(* ****** ****** *)

fun d2exp_app
  (loc: location, d2e1: d2exp, d2es2: d2explst): d2exp
// end of [d2exp_app]

(* ****** ****** *)

fun f2undec_make
  (loc: location, d2v: d2var, d2e: d2exp): f2undec

(* ****** ****** *)

fun d2ecl_fundeclst (loc: location, f2ds: f2undeclst): d2ecl

(* ****** ****** *)

(* end of [utfpl.sats] *)
