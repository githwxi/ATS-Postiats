(*
** ATS constaint-solving
*)

(* ****** ****** *)

typedef
fprint_type (a:t@ype) = (FILEref, a) -> void

(* ****** ****** *)

abst0ype
stamp_t0ype = int
typedef stamp = stamp_t0ype

(* ****** ****** *)

fun
fprint_stamp: fprint_type (stamp)
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

datatype s2rt =
| S2RTint of ()
| S2RTaddr of ()
| S2RTbool of ()
| S2RTfun of ((*void*))
| S2RTtup of ((*void*))
| S2RTerr of ((*void*))
| S2RTignored of ((*void*))

(* ****** ****** *)

fun
fprint_s2rt: fprint_type (s2rt)
overload fprint with fprint_s2rt

(* ****** ****** *)

abstype s2cst_type = ptr
typedef s2cst = s2cst_type
typedef s2cstlst = List0 (s2cst)
typedef s2cstopt = Option (s2cst)
vtypedef s2cstopt_vt = Option_vt (s2cst)

(* ****** ****** *)

fun
fprint_s2cst: fprint_type (s2cst)
overload fprint with fprint_s2cst

(* ****** ****** *)

fun
compare_s2cst_s2cst (s2cst, s2cst): int
overload compare with compare_s2cst_s2cst

(* ****** ****** *)

fun s2cst_make (symbol, stamp): s2cst

(* ****** ****** *)
//
fun s2cst_get_name (s2cst):<> symbol
fun s2cst_get_stamp (s2cst):<> stamp
//
(* ****** ****** *)

abstype s2var_type = ptr
typedef s2var = s2var_type
typedef s2varlst = List0 (s2var)
typedef s2varopt = Option (s2var)
vtypedef s2varopt_vt = Option_vt (s2var)

(* ****** ****** *)

fun
fprint_s2var: fprint_type (s2var)
overload fprint with fprint_s2var

(* ****** ****** *)

fun
compare_s2var_s2var (s2var, s2var): int
overload compare with compare_s2var_s2var

(* ****** ****** *)

fun s2var_make (symbol, stamp): s2var

(* ****** ****** *)
//
fun s2var_get_name (s2var):<> symbol
fun s2var_get_stamp (s2var):<> stamp
//
(* ****** ****** *)
  
abstype s2Var_type = ptr
typedef s2Var = s2Var_type
typedef s2Varopt = Option (s2Var)
vtypedef s2Varopt_vt = Option_vt (s2Var)
  
(* ****** ****** *)

fun
fprint_s2Var: fprint_type (s2Var)
overload fprint with fprint_s2Var

(* ****** ****** *)

fun s2Var_make (stamp): s2Var

(* ****** ****** *)

fun s2Var_get_stamp (s2Var):<> stamp

(* ****** ****** *)

datatype
s2exp_node =
//
| S2Eint of (int)
| S2Eintinf of (string)
//
| S2Ecst of (s2cst)
| S2Evar of (s2var)
| S2EVar of (s2Var)
//
| S2Esizeof of (s2exp)
//
| S2Eeqeq of (s2exp, s2exp)
//
| S2Eapp of (s2exp, s2explst)
//
| S2Emetdec of
    (s2explst(*met*), s2explst(*metbound*)) // strictly decreasing
  // end of [S2Emetdec]
//
| S2Eignored of ((*void*))
// end of [s2exp_node]

where
s2exp = '{
  s2exp_srt= s2rt
, s2exp_node= s2exp_node
} (* end of [s2exp] *)

and s2explst = List0 (s2exp)

(* ****** ****** *)
//
fun fprint_s2exp: fprint_type (s2exp)
fun fprint_s2explst: fprint_type (s2explst)
//
overload fprint with fprint_s2exp
overload fprint with fprint_s2explst of 10
//
(* ****** ****** *)

fun s2exp_make_node
  (s2t: s2rt, node: s2exp_node): s2exp

(* ****** ****** *)

fun s2exp_cst (s2t: s2rt, s2c: s2cst): s2exp
fun s2exp_var (s2t: s2rt, s2v: s2var): s2exp

(* ****** ****** *)

fun s2exp_ignored (s2rt): s2exp // error-handling

(* ****** ****** *)

(*
datatype
c3nstrkind = 
//
  | C3NSTRKINDmain of () // generic
//
  | C3NSTRKINDcase_exhaustiveness of
      (caskind (*case/case+*), p2atcstlst) // no [case-]
//
  | C3NSTRKINDtermet_isnat of () // term. metric welfounded
  | C3NSTRKINDtermet_isdec of () // term. metric decreasing
//
  | C3NSTRKINDsome_fin of (d2var, s2exp(*fin*), s2exp)
  | C3NSTRKINDsome_lvar of (d2var, s2exp(*lvar*), s2exp)
  | C3NSTRKINDsome_vbox of (d2var, s2exp(*vbox*), s2exp)
//
  | C3NSTRKINDlstate of () // lstate merge
  | C3NSTRKINDlstate_var of (d2var) // lstate merge for d2var
//
  | C3NSTRKINDloop of (int) // HX: ~1/0/1: enter/break/continue
// end of [c3nstrkind]
*)

(* ****** ****** *)

datatype s3itm =
  | S3ITMsvar of s2var
  | S3ITMhypo of h3ypo
  | S3ITMsVar of s2Var
  | S3ITMcnstr of c3nstr
  | S3ITMcnstr_ref of (loc_t, c3nstropt)
  | S3ITMdisj of s3itmlstlst
// end of [s3item]

and c3nstr_node =
  | C3NSTRprop of s2exp
  | C3NSTRitmlst of s3itmlst
// end of [c3nstr_node]

and h3ypo_node =
  | H3YPOprop of s2exp
  | H3YPObind of (s2var, s2exp)
  | H3YPOeqeq of (s2exp, s2exp)
// end of [h3ypo_node]

where
s3itmlst = List0 (s3itm)
and
s3itmlstlst = List0 (s3itmlst)

and
h3ypo = '{
  h3ypo_loc= loc_t
, h3ypo_node= h3ypo_node
} // end of [h3ypo]

and
c3nstr = '{
  c3nstr_loc= loc_t
(*
, c3nstr_kind= c3nstrkind
*)
, c3nstr_node= c3nstr_node
} // end of [c3nstr]

and
c3nstropt = Option (c3nstr)

(* ****** ****** *)

fun h3ypo_make_node
  (loc: loc_t, node: h3ypo_node): h3ypo

(* ****** ****** *)

fun
fprint_h3ypo: fprint_type (h3ypo)
overload fprint with fprint_h3ypo

(* ****** ****** *)

fun h3ypo_prop (loc_t, s2exp): h3ypo
fun h3ypo_bind (loc_t, s2var, s2exp): h3ypo
fun h3ypo_eqeq (loc_t, s2exp, s2exp): h3ypo

(* ****** ****** *)
//
fun
fprint_s3itm: fprint_type (s3itm)
fun
fprint_s3itmlst: fprint_type (s3itmlst)
//
overload fprint with fprint_s3itm
overload fprint with fprint_s3itmlst of 10
//
(* ****** ****** *)

fun c3nstr_make_node
  (loc: loc_t, node: c3nstr_node): c3nstr

(* ****** ****** *)
//
fun fprint_c3nstr: fprint_type(c3nstr)
fun fprint_c3nstropt: fprint_type(c3nstropt)
//
overload fprint with fprint_c3nstr
overload fprint with fprint_c3nstropt of 10
//
(* ****** ****** *)

fun c3nstr_prop (loc_t, s2exp): c3nstr
fun c3nstr_itmlst (loc_t, s3itmlst): c3nstr

(* ****** ****** *)
//
symintr .name
overload .name with s2cst_get_name
overload .name with s2var_get_name
//
symintr .stamp
overload .stamp with s2cst_get_stamp
overload .stamp with s2var_get_stamp
overload .stamp with s2Var_get_stamp
//
(* ****** ****** *)

(* end of [constraint.sats] *)
