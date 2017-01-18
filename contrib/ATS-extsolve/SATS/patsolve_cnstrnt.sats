(*
** ATS-extsolve:
** For solving ATS-constraints
** with external SMT-solvers
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: May, 2015
*)

(* ****** ****** *)
//
#define
ATS_PACKNAME "PATSOLVE_CNSTRNT"
//
(* ****** ****** *)
//
abst0ype
stamp_t0ype = int
//
typedef
stamp = stamp_t0ype
//
(* ****** ****** *)
//
fun print_stamp: stamp -> void
and prerr_stamp: stamp -> void
fun fprint_stamp: fprint_type(stamp)
//
overload print with print_stamp
overload prerr with prerr_stamp
overload fprint with fprint_stamp
//
(* ****** ****** *)

fun stamp_make(int): stamp

(* ****** ****** *)

fun stamp_get_int(stamp): int

(* ****** ****** *)

fun hash_stamp(stamp):<> ulint

(* ****** ****** *)
//
fun
eq_stamp_stamp : (stamp, stamp) -<fun0> bool
fun
neq_stamp_stamp : (stamp, stamp) -<fun0> bool
fun
compare_stamp_stamp : (stamp, stamp) -<fun0> int
//
overload = with eq_stamp_stamp
overload != with neq_stamp_stamp
overload compare with compare_stamp_stamp
//
(* ****** ****** *)
//
fun the_stamp_getinc(): stamp
//
fun the_stamp_update(n: stamp): void
//
(* ****** ****** *)

abstype symbol_type = ptr
typedef symbol = symbol_type

(* ****** ****** *)
//
fun print_symbol: symbol -> void
and prerr_symbol: symbol -> void
fun fprint_symbol: fprint_type(symbol)
//
overload print with print_symbol
overload prerr with prerr_symbol
overload fprint with fprint_symbol
//
(* ****** ****** *)

fun
symbol_make_name(string): symbol

(* ****** ****** *)
//
fun
symbol_get_name (x: symbol): string
//
overload .name with symbol_get_name
//
(* ****** ****** *)
//
fun
eq_symbol_symbol : (symbol, symbol) -<fun0> bool
fun
neq_symbol_symbol : (symbol, symbol) -<fun0> bool
fun
compare_symbol_symbol : (symbol, symbol) -<fun0> int
//
overload = with eq_symbol_symbol
overload != with neq_symbol_symbol
overload compare with compare_symbol_symbol
//
(* ****** ****** *)
//
abstype
location_type = ptr
//
typedef loc_t = location_type
//
(* ****** ****** *)
//
fun
fprint_location: fprint_type(loc_t)
//
overload fprint with fprint_location
//
(* ****** ****** *)
//
fun location_make (rep: string): loc_t
//
(* ****** ****** *)
//
datatype label =
  LABint of int | LABsym of symbol
//  
(* ****** ****** *)
//
fun print_label : label -> void
and prerr_label : label -> void
fun fprint_label : fprint_type(label)
//
overload print with print_label
overload prerr with prerr_label
overload fprint with fprint_label
//
(* ****** ****** *)

datatype s2rt =
//
  | S2RTint of ()
  | S2RTaddr of ()
  | S2RTbool of ()
//
  | S2RTreal of ()
//
  | S2RTfloat of ()
  | S2RTstring of ()
//
  | S2RTcls of ()
  | S2RTeff of ()
//
  | S2RTtup of ((*void*))
//
  | S2RTtype of ((*void*))
  | S2RTvtype of ((*void*))
//
  | S2RTt0ype of ((*void*))
  | S2RTvt0ype of ((*void*))
//
  | S2RTprop of ((*void*))
  | S2RTview of ((*void*))
//
  | S2RTtkind of ((*void*))
//
  | S2RTfun of (s2rtlst(*args*), s2rt (*res*))
//
  | S2RTnamed of (symbol)
//
  | S2RTerror of ((*void*))
//
// end of [datatype]

where s2rtlst = List0(s2rt)

(* ****** ****** *)
//
fun s2rt_int((*void*)): s2rt
fun s2rt_addr((*void*)): s2rt
fun s2rt_bool((*void*)): s2rt
//
fun s2rt_real((*void*)): s2rt
fun s2rt_float((*void*)): s2rt
fun s2rt_string((*void*)): s2rt
//
(* ****** ****** *)
//
fun
s2rt_is_impred(s2t: s2rt): bool
//
(* ****** ****** *)
//
fun print_s2rt : s2rt -> void
and prerr_s2rt : s2rt -> void
fun fprint_s2rt: fprint_type(s2rt)
//
overload print with print_s2rt
overload prerr with prerr_s2rt
overload fprint with fprint_s2rt
//
(* ****** ****** *)

abstype
s2rtdat_type = ptr
typedef s2rtdat = s2rtdat_type
typedef s2rtdatlst = List(s2rtdat)

(* ****** ****** *)
//
fun s2rtdat_get_name (s2rtdat): symbol
fun s2rtdat_get_stamp (s2rtdat): stamp
//
(* ****** ****** *)
//
fun print_s2rtdat : s2rtdat -> void
and prerr_s2rtdat : s2rtdat -> void
fun fprint_s2rtdat: fprint_type(s2rtdat)
//
overload print with print_s2rtdat
overload prerr with prerr_s2rtdat
overload fprint with fprint_s2rtdat
//
(* ****** ****** *)
//
abstype
s2cst_type = ptr
//
typedef s2cst = s2cst_type
//
typedef s2cstlst = List0(s2cst)
vtypedef s2cstlst_vt = List0_vt(s2cst)
//
typedef s2cstopt = Option(s2cst)
vtypedef s2cstopt_vt = Option_vt(s2cst)
//
(* ****** ****** *)
//
fun
s2cst_make
(
  symbol, s2rt, stamp, extdef: Option(string)
) : s2cst // end of [s2cst_make]
//
(* ****** ****** *)
//
fun print_s2cst: s2cst -> void
and prerr_s2cst: s2cst -> void
fun fprint_s2cst: fprint_type(s2cst)
//
overload print with print_s2cst
overload prerr with prerr_s2cst
overload fprint with fprint_s2cst
//
(* ****** ****** *)
//
typedef
scstextdef = stringopt
//
fun s2cst_get_srt (s2cst): s2rt
fun s2cst_get_name (s2cst): symbol
fun s2cst_get_stamp (s2cst): stamp
fun s2cst_get_extdef (s2cst): scstextdef
//
overload .srt with s2cst_get_srt
overload .name with s2cst_get_name
overload .stamp with s2cst_get_stamp
overload .extdef with s2cst_get_extdef
//
(* ****** ****** *)
//
fun
s2cst_get_nused(s2cst): int
fun
s2cst_incby1_nused(s2cst): void
//
(* ****** ****** *)

fun
s2cst_get_payload(s2cst): ptr
fun
s2cst_set_payload(s2cst, payload: ptr): void

(* ****** ****** *)
//
fun
s2rtdat_get_sconlst (s2rtdat): s2cstlst
fun
s2rtdat_make(symbol, stamp, s2cstlst): s2rtdat
//
(* ****** ****** *)
//
abstype
s2var_type = ptr
//
typedef s2var = s2var_type
//
typedef s2varlst = List0(s2var)
vtypedef s2varlst_vt = List0_vt(s2var)
//
typedef s2varopt = Option(s2var)
vtypedef s2varopt_vt = Option_vt(s2var)
//
(* ****** ****** *)
//
fun
s2var_make
  (symbol, s2rt, stamp): s2var
//
(* ****** ****** *)
//
fun print_s2var: s2var -> void
and prerr_s2var: s2var -> void
fun fprint_s2var: fprint_type(s2var)
//
overload print with print_s2var
overload prerr with prerr_s2var
overload fprint with fprint_s2var
//
(* ****** ****** *)
//
fun
s2var_get_srt (s2var): s2rt
fun
s2var_get_name (s2var): symbol
fun
s2var_get_stamp (s2var): stamp
//
overload .srt with s2var_get_srt
overload .name with s2var_get_name
overload .stamp with s2var_get_stamp
//
(* ****** ****** *)

fun s2var_is_impred (s2v: s2var): bool

(* ****** ****** *)
//
fun s2var_get_payload(s2var): ptr
fun s2var_set_payload(s2var, payload: ptr): void
//
(* ****** ****** *)
//
abstype
s2Var_type = ptr
//
typedef s2Var = s2Var_type
//
typedef s2Varlst = List0(s2Var)
vtypedef s2Varlst_vt = List0_vt(s2Var)
//
typedef s2Varopt = Option(s2Var)
vtypedef s2Varopt_vt = Option_vt(s2Var)
//
(* ****** ****** *)
//
fun s2Var_make(stamp): s2Var
//
(* ****** ****** *)
//
fun print_s2Var: s2Var -> void
and prerr_s2Var: s2Var -> void
fun fprint_s2Var: fprint_type(s2Var)
//
overload print with print_s2Var
overload prerr with prerr_s2Var
overload fprint with fprint_s2Var
//
(* ****** ****** *)
//
fun
s2Var_get_stamp (s2Var): stamp
//
overload .stamp with s2Var_get_stamp
//
(* ****** ****** *)

datatype
tyreckind =
  | TYRECKINDbox (* boxed *)
  | TYRECKINDbox_lin (* boxed *)
  | TYRECKINDflt0 (* flat *)
  | TYRECKINDflt1 of stamp (* flat *)
  | TYRECKINDflt_ext of string  (* flat *)
// end of [tyreckind]

(* ****** ****** *)
//
fun tyreckind_is_box (knd: tyreckind): bool
fun tyreckind_is_box_lin (knd: tyreckind): bool
//
fun tyreckind_is_flt0 (knd: tyreckind): bool
fun tyreckind_is_flt1 (knd: tyreckind): bool
fun tyreckind_is_flt_ext (knd: tyreckind): bool
//
(* ****** ****** *)
//
fun
print_tyreckind : tyreckind -> void
and
prerr_tyreckind : tyreckind -> void
fun
fprint_tyreckind : fprint_type(tyreckind)
//
overload print with print_tyreckind
overload prerr with prerr_tyreckind
overload fprint with fprint_tyreckind
//
(* ****** ****** *)
//
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
| S2Eeqeq of (s2exp, s2exp)
//
| S2Esizeof of (s2exp(*t0ype*))
//
| S2Eapp of (s2exp, s2explst)
| S2Emetdec of
    (s2explst(*met*), s2explst(*bound*)) // strictly decreasing
  // end of [S2Emetdec]
//
| S2Etop of (int(*knd*), s2exp)
//
| S2Einvar of (s2exp)
//
| S2Efun of (int(*npf*), s2explst, s2exp)
//
| S2Euni of
    (s2varlst, s2explst(*s2ps*), s2exp(*scope*))
| S2Eexi of
    (s2varlst, s2explst(*s2ps*), s2exp(*scope*))
//
| S2Etyrec of (tyreckind, int(*npf*), labs2explst)
//
| S2Eextype of (symbol)
| S2Eextkind of (symbol)
//
| S2Eerror of ((*for-error-indication*))
// end of [s2exp_node]
//
and
labs2exp =
  SLABELED of (label, s2exp)
//
where
s2exp = $rec{
  s2exp_srt= s2rt, s2exp_node= s2exp_node
} (* end of [s2exp] *)
//
and s2explst = List0 (s2exp)
and labs2explst = List0 (labs2exp)
//
(* ****** ****** *)
//
typedef s2expopt = Option(s2exp)
vtypedef s2expopt_vt = Option_vt(s2exp)
//
(* ****** ****** *)
//
fun
s2exp_make_node
  (s2t: s2rt, node: s2exp_node): s2exp
//
fun s2exp_var (s2v: s2var): s2exp
fun s2exp_eqeq (s2e1: s2exp, s2e2: s2exp): s2exp
//
(* ****** ****** *)

fun s2exp_is_impred (s2e: s2exp): bool

(* ****** ****** *)
//
fun print_s2exp(s2exp): void
and prerr_s2exp(s2exp): void
//
overload print with print_s2exp
overload prerr with prerr_s2exp
//
fun print_s2explst(s2explst): void
and prerr_s2explst(s2explst): void
//
overload print with print_s2explst
overload prerr with prerr_s2explst
//
fun fprint_s2exp : fprint_type(s2exp)
fun fprint_s2explst : fprint_type(s2explst)
//
overload fprint with fprint_s2exp
overload fprint with fprint_s2explst of 10
//
fun fprint_labs2exp : fprint_type(labs2exp)
fun fprint_labs2explst : fprint_type(labs2explst)
//
overload fprint with fprint_labs2exp
overload fprint with fprint_labs2explst of 10
//
(* ****** ****** *)

abstype d2var_type = ptr
typedef d2var = d2var_type

(* ****** ****** *)

datatype
caskind =
  | CK_case // case
  | CK_case_pos // case+
  | CK_case_neg // case-
// end of [caskind]

datatype
c3nstrkind =
//
  | C3TKmain of () // generic
//
  | C3TKcase_exhaustiveness of (caskind)
//
  | C3TKtermet_isnat of () // term. metric welfounded
  | C3TKtermet_isdec of () // term. metric decreasing
//
  | C3TKsome_fin of (d2var, s2exp(*fin*), s2exp)
  | C3TKsome_lvar of (d2var, s2exp(*lvar*), s2exp)
  | C3TKsome_vbox of (d2var, s2exp(*vbox*), s2exp)
//
  | C3TKlstate of () // lstate merge
  | C3TKlstate_var of (d2var) // lstate merge for d2var
//
  | C3TKloop of (int) // HX: ~1/0/1: enter/break/continue
//
  | C3TKsolver of (int) // HX: knd=0/1: solassert/solverify
//
  | C3TKignored of () // HX-2015-06-06: ignored c3nstrkind
// end of [c3nstrkind]

datatype s3itm =
  | S3ITMsvar of s2var
  | S3ITMsVar of s2Var
  | S3ITMhypo of h3ypo
  | S3ITMcnstr of c3nstr
  | S3ITMcnstr_ref of (loc_t, c3nstropt)
  | S3ITMdisj of s3itmlstlst
//
  | S3ITMsolassert of (s2exp) // HX: $solver_assert
// end of [s3item]

and h3ypo_node =
  | H3YPOprop of s2exp
  | H3YPObind of (s2var, s2exp)
  | H3YPOeqeq of (s2exp, s2exp)
// end of [h3ypo_node]

and c3nstr_node =
  | C3NSTRprop of s2exp
  | C3NSTRitmlst of s3itmlst
  | C3NSTRsolverify of (s2exp) // HX: $solver_verify
// end of [c3nstr_node]

where
//
s3itmlst = List0(s3itm)
//
and
s3itmlstlst = List0(s3itmlst)
//
and
h3ypo = $rec{
  h3ypo_loc= loc_t
, h3ypo_node= h3ypo_node
} (* end of [h3ypo] *)
//
and
c3nstr = $rec{
  c3nstr_loc= loc_t
, c3nstr_kind= c3nstrkind
, c3nstr_node= c3nstr_node
} (* end of [c3nstr] *)
//
and c3nstropt = Option(c3nstr)

(* ****** ****** *)
//
fun
h3ypo_make_node (loc_t, h3ypo_node): h3ypo
//
(* ****** ****** *)
//
fun
c3nstr_make_node
  (loc: loc_t, knd: c3nstrkind, c3nstr_node): c3nstr
//
(* ****** ****** *)
//
fun
fprint_s3itm: fprint_type(s3itm)
fun
fprint_s3itmlst: fprint_type(s3itmlst)
fun
fprint_s3itmlstlst: fprint_type(s3itmlstlst)
//
overload fprint with fprint_s3itm
overload fprint with fprint_s3itmlst of 10
overload fprint with fprint_s3itmlstlst of 20
//
(* ****** ****** *)
//
fun
fprint_h3ypo: fprint_type(h3ypo)
//
overload fprint with fprint_h3ypo
//
(* ****** ****** *)
//
fun
fprint_c3nstr: fprint_type(c3nstr)
fun
fprint_c3nstropt: fprint_type(c3nstropt)
//
overload fprint with fprint_c3nstr
overload fprint with fprint_c3nstropt of 10
//
(* ****** ****** *)
//
// HX-2015-05-25:
// pretty-printing
//
fun fpprint_c3nstr: fprint_type(c3nstr)
//
(* ****** ****** *)

(* end of [patsolve_cnstrnt.sats] *)
