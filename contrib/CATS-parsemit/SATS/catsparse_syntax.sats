(* ****** ****** *)
//
// CATS-parsemit
//
(* ****** ****** *)
//
// HX-2014-07-02: start
//
(* ****** ****** *)
//
#define
ATS_PACKNAME"CATS-PARSEMIT"
//
(* ****** ****** *)

#staload "./catsparse.sats" // opened

(* ****** ****** *)
//
castfn
synent_encode {a:type} (x: a): synent
castfn
synent_decode {a:type} (x: synent): (a)
//
(* ****** ****** *)
//
fun
synent_decode2{a:type} (x: &synent >> _?): a
//
(* ****** ****** *)
//
fun synent_null {a:type} (): a // = null
//
fun synent_is_null {a:type} (x: a):<> bool
fun synent_isnot_null {a:type} (x: a):<> bool
//
(* ****** ****** *)
//
fun
i0dex_make_sym (loc: loc_t, sym: symbol): i0de
fun
i0dex_make_string (loc: loc_t, name: string): i0de
//
(* ****** ****** *)

fun s0exp_ide (loc: loc_t, id: i0de): s0exp
fun s0exp_list (loc: loc_t, s0es: s0explst): s0exp
fun s0exp_appid (id: i0de, s0e: s0exp): s0exp

(* ****** ****** *)
//
// HX: for constructing primvals
//
(* ****** ****** *)
//
fun d0exp_ide (id: i0de): d0exp
//
fun d0exp_list (loc: loc_t, d0es: d0explst): d0exp
//
fun d0exp_appid (id: i0de, d0e_arg: d0exp): d0exp
fun d0exp_appexp (d0e_fun: d0exp, d0e_arg: d0exp): d0exp
//
(* ****** ****** *)
//
fun
ATSPMVint_make
(
  tok_kwd: token, tok: i0nt, tok_end: token
) : d0exp // end-of-fun
fun
ATSPMVintrep_make
(
  tok_kwd: token, tok: i0nt, tok_end: token
) : d0exp // end-of-fun
//
(* ****** ****** *)
//
fun
ATSPMVbool_make
(
  tok_kwd: token, tfv: bool, tok_end: token
) : d0exp // end-of-fun
//
(* ****** ****** *)
//
fun
ATSPMVfloat_make
(
  tok_kwd: token, tok: f0loat, tok_end: token
) : d0exp // end-of-fun
//
(* ****** ****** *)
//
fun
ATSPMVstring_make
(
  tok_kwd: token, tok: s0tring, tok_end: token
) : d0exp // end-of-fun
//
(* ****** ****** *)
//
fun
ATSPMVi0nt_make
(
  tok_kwd: token, tok: i0nt, tok_end: token
) : d0exp // end-of-fun
//
fun
ATSPMVf0loat_make
(
  tok_kwd: token, tok: f0loat, tok_end: token
) : d0exp // end-of-fun
//
(* ****** ****** *)
//
fun
ATSPMVempty_make
  (tok_kwd: token, tok_end: token): d0exp
//
fun
ATSPMVextval_make
  (tok_kwd: token, toks: tokenlst, tok_end: token): d0exp
//
(* ****** ****** *)
//
fun
ATSPMVrefarg0_make
(
  tok_kwd: token, d0e: d0exp, tok_end: token
) : d0exp // end-of-fun
//
fun
ATSPMVrefarg1_make
(
  tok_kwd: token, d0e: d0exp, tok_end: token
) : d0exp // end-of-fun
//
(* ****** ****** *)

fun
ATSPMVfunlab_make
(
  tok_kwd: token, flab: label, tok_end: token
) : d0exp // end-of-fun

(* ****** ****** *)

fun
ATSPMVcfunlab_make
(
  tok_kwd: token
, knd: signed, flab: label, arg: d0exp, tok_end: token
) : d0exp // end-of-fun

(* ****** ****** *)
//
fun
ATSPMVcastfn_make
(
  tok_kwd: token
, fid: i0de, s0e_res: s0exp, arg: d0exp, tok_end: token
) : d0exp // end-of-fun
//
(* ****** ****** *)
//
fun
ATSCSTSPmyloc_make
(
  tok_kwd: token, tok: s0tring, tok_end: token
) : d0exp // end-of-fun
//
(* ****** ****** *)
//
fun
ATSCKiseqz_make
  (tok_kwd: token, d0e: d0exp, tok_end: token): d0exp
fun
ATSCKisneqz_make
  (tok_kwd: token, d0e: d0exp, tok_end: token): d0exp
//
fun
ATSCKptriscons_make
  (tok_kwd: token, d0e: d0exp, tok_end: token): d0exp
fun
ATSCKptrisnull_make
  (tok_kwd: token, d0e: d0exp, tok_end: token): d0exp
//
(* ****** ****** *)
//
fun
ATSCKpat_int_make
(
  tok_kwd: token, d0e: d0exp, int: d0exp, tok_end: token
) : d0exp // end-of-fun
//
fun
ATSCKpat_bool_make
(
  tok_kwd: token, d0e: d0exp, bool: d0exp, tok_end: token
) : d0exp // end-of-fun
//
fun
ATSCKpat_string_make
(
  tok_kwd: token, d0e: d0exp, bool: d0exp, tok_end: token
) : d0exp // end-of-fun
//
fun
ATSCKpat_con0_make
(
  tok_kwd: token, d0e: d0exp, tag: signed, tok_end: token
) : d0exp // end-of-fun
//
fun
ATSCKpat_con1_make
(
  tok_kwd: token, d0e: d0exp, tag: signed, tok_end: token
) : d0exp // end-of-fun
//
(* ****** ****** *)
//
fun
ATSSELcon_make
(
  tok_kwd: token
, d0e: d0exp, s0e: s0exp, lab: label
, tok_end: token
) : d0exp // end of [ATSSELcon_make]
//
fun
ATSSELrecsin_make
(
  tok_kwd: token
, d0e: d0exp, s0e: s0exp, lab: label
, tok_end: token
) : d0exp // end of [ATSSELrecsin_make]
//
fun
ATSSELboxrec_make
(
  tok_kwd: token
, d0e: d0exp, s0e: s0exp, lab: label
, tok_end: token
) : d0exp // end of [ATSSELboxrec_make]
//
fun
ATSSELfltrec_make
(
  tok_kwd: token
, d0e: d0exp, s0e: s0exp, lab: label
, tok_end: token
) : d0exp // end of [ATSSELfltrec_make]
//
(* ****** ****** *)

fun
ATSextfcall_make
(
  tok_kwd: token
, d0e_fun: i0de, d0e_arg: d0exp
, tok_end: token
) : d0exp // end of [ATSextfcall_make]

(* ****** ****** *)

fun
ATSextmcall_make
(
  tok_kwd: token
, d0e_obj: d0exp
, d0e_mtd: d0exp, d0e_arg: d0exp
, tok_end: token
) : d0exp // end of [ATSextmcall_make]

(* ****** ****** *)

fun
ATSfunclo_fun_make
(
  tok_kwd: token
, d0e: d0exp, arg: s0exp, res: s0exp
, tok_end: token
, d0argopt: d0expopt
) : d0exp // end of [ATSfunclo_fun_make]

(* ****** ****** *)

fun
ATSfunclo_clo_make
(
  tok_kwd: token
, d0e: d0exp, arg: s0exp, res: s0exp
, tok_end: token
, d0argopt: d0expopt
) : d0exp // end of [ATSfunclo_clo_make]

(* ****** ****** *)
//
fun tyfld_make (s0e: s0exp, id: i0de): tyfld
//
fun tyrec_make
  (tok_beg: token, xs: tyfldlst, tok_end: token): tyrec
//
(* ****** ****** *)
//
fun
fkind_extern (tok1: token, tok2: token): fkind
fun
fkind_static (tok1: token, tok2: token): fkind
//
(* ****** ****** *)
//
fun f0arg_none (s0e: s0exp): f0arg
fun f0arg_some (s0e: s0exp, id: i0de): f0arg
//
fun
f0marg_make
  (tok_beg: token, f0as: f0arglst, tok_end: token): f0marg
//
(* ****** ****** *)
//
fun f0head_get_f0arglst (fhd: f0head): f0arglst
//
fun
f0head_make (res: s0exp, id: i0de, marg: f0marg): f0head
//
(* ****** ****** *)
//
fun tmpvar_is_sta (tmp: symbol): bool
fun tmpvar_is_arg (tmp: symbol): bool
fun tmpvar_is_apy (tmp: symbol): bool
fun tmpvar_is_env (tmp: symbol): bool
fun tmpvar_is_tmp (tmp: symbol): bool
fun tmpvar_is_tmpret (tmp: symbol): bool
//
(* ****** ****** *)
//
fun tmpvar_is_axrg (tmp: symbol): bool
fun tmpvar_is_axpy (tmp: symbol): bool
//
fun tmpvar_is_local (tmp: symbol): bool
//
(* ****** ****** *)
//
fun
tmpdec_make_none
(
  tok_kwd: token, tmp: i0de, tok_end: token
) : tmpdec // end-of-fun
fun
tmpdec_make_some
(
  tok_kwd: token, tmp: i0de, s0e: s0exp, tok_end: token
) : tmpdec // end-of-fun
//
(* ****** ****** *)
//
// HX: for constructing instructions
//
(* ****** ****** *)
//
fun ATSif_make
(
  tok_if: token
, _test: d0exp, _then: instr, _else: instropt
) : instr // end of [ATSif_make]
//
fun ATSthen_make
(
  tok_then: token, inss: instrlst, tok_end: token
) : instr // end of [ATSthen_make]
//
fun ATSelse_make
(
  tok_else: token, inss: instrlst, tok_end: token
) : instr // end of [ATSelse_make]
//
(* ****** ****** *)
//
fun ATSifthen_make
(
  tok_ifthen: token
, _test: d0exp, _then: instrlst, tok_end: token
) : instr // end-of-fun
//
fun ATSifnthen_make
(
  tok_ifnthen: token
, _test: d0exp, _then: instrlst, tok_end: token
) : instr // end-of-fun
//
(* ****** ****** *)

fun
ATSbranchseq_make
(
  tok_kwd: token, inss: instrlst, tok_end: token
) : instr // end-of-function

(* ****** ****** *)

fun
caseofseq_get_tmplablst (x: instr): labelist

(* ****** ****** *)

fun
ATScaseofseq_make
(
  tok_kwd: token, inss: instrlst, tok_end: token
) : instr // end-of-function

(* ****** ****** *)

fun
funbodyseq_get_funlab (ins0: instr): label

(* ****** ****** *)

fun
ATSfunbodyseq_make
(
  tok_kwd: token, inss: instrlst, tok_end: token
) : instr // end-of-function

(* ****** ****** *)
//
fun
ATSreturn_make
  (tok_kwd: token, tmp: i0de, tok_end: token): instr
fun
ATSreturn_void_make
  (tok_kwd: token, tmp: i0de, tok_end: token): instr
//
(* ****** ****** *)
//
fun
instrlst_skip_linepragma (inss: instrlst): instrlst
//
(* ****** ****** *)
//
fun
ATSlinepragma_make
  (tok_kwd: token, line: token, file: token): instr
//
(* ****** ****** *)
//
fun
ATSINSlab_make
  (tok_kwd: token, tmp: i0de, tok_end: token): instr
//
fun
ATSINSgoto_make
  (tok_kwd: token, tmp: i0de, tok_end: token): instr
//
(* ****** ****** *)
//
fun
ATSINSflab_make
  (tok_kwd: token, tmp: i0de, tok_end: token): instr
//
fun
ATSINSfgoto_make
  (tok_kwd: token, tmp: i0de, tok_end: token): instr
//
(* ****** ****** *)
//
fun
ATSINSfreeclo_make
  (tok_kwd: token, d0e: d0exp, tok_end: token): instr
//
fun
ATSINSfreecon_make
  (tok_kwd: token, d0e: d0exp, tok_end: token): instr
//
(* ****** ****** *)
//
fun
ATSINSmove_make
(
  tok_kwd: token, tmp: i0de, d0e: d0exp, tok_end: token
) : instr // end of [ATSINSmove_make]
//
fun
ATSINSmove_void_make
(
  tok_kwd: token, tmp: i0de, d0e: d0exp, tok_end: token
) : instr // end of [ATSINSmove_void_make]
//
(* ****** ****** *)
//
fun
ATSINSmove_nil_make
(
  tok_kwd: token, tmp: i0de, tok_end: token
) : instr // end of [ATSINSmove_nil_make]
//
fun
ATSINSmove_con0_make
(
  tok_kwd: token, tmp: i0de, tag: token, tok_end: token
) : instr // end-of-function
//
(* ****** ****** *)
//
fun
ATSINSmove_con1_make
(
  tok_kwd: token, inss: instrlst, tok_end: token
) : instr // end-of-function
//
fun
ATSINSmove_con1_new_make
(
  tok_kwd: token, tmp: i0de, s0e: s0exp, tok_end: token
) : instr // end-of-function
//
fun
ATSINSstore_con1_tag_make
(
  tok_kwd: token, tmp: i0de, tag: token, tok_end: token
) : instr // end-of-function
//
fun
ATSINSstore_con1_ofs_make
(
  tok_kwd: token
, tmp: i0de, s0e: s0exp, lab: label, d0e: d0exp
, tok_end: token
) : instr // end-of-function
//
(* ****** ****** *)
//
fun
ATSINSmove_boxrec_make
(
  tok_kwd: token, inss: instrlst, tok_end: token
) : instr // end-of-function
//
fun
ATSINSmove_boxrec_new_make
(
  tok_kwd: token, tmp: i0de, s0e: s0exp, tok_end: token
) : instr // end-of-function
//
fun
ATSINSstore_boxrec_ofs_make
(
  tok_kwd: token
, tmp: i0de, s0e: s0exp, lab: label, d0e: d0exp
, tok_end: token
) : instr // end-of-function
//
(* ****** ****** *)
//
fun
ATSINSmove_fltrec_make
(
  tok_kwd: token, inss: instrlst, tok_end: token
) : instr // end-of-function
//
fun
ATSINSstore_fltrec_ofs_make
(
  tok_kwd: token
, tmp: i0de, s0e: s0exp, lab: label, d0e: d0exp
, tok_end: token
) : instr // end-of-function
//
(* ****** ****** *)
//
fun
ATSINSmove_delay_make
(
  tok_kwd: token
, tmp: i0de, s0e_res: s0exp, d0e: d0exp (*thunk*)
, tok_end: token
) : instr // end-of-function
//
fun
ATSINSmove_lazyeval_make
(
  tok_kwd: token
, tmp: i0de, s0e_res: s0exp, d0e: d0exp (*lazyval*)
, tok_end: token
) : instr // end-of-function
//
fun
ATSINSmove_ldelay_make
(
  tok_kwd: token
, tmp: i0de, s0e_res: s0exp, d0e: d0exp (*thunk*)
, tok_end: token
) : instr // end-of-function
//
fun
ATSINSmove_llazyeval_make
(
  tok_kwd: token
, tmp: i0de, s0e_res: s0exp, d0e: d0exp (*lazyval*)
, tok_end: token
) : instr // end-of-function
//
(* ****** ****** *)
//
fun
ATStailcalseq_make
(
  tok_kwd: token, inss: instrlst, tok_end: token
) : instr // end-of-function
//
fun
ATSINSmove_tlcal_make
(
  tok_kwd: token, argx: i0de, d0e: d0exp, tok_end: token
) : instr // end-of-function
//
fun
ATSINSargmove_tlcal_make
(
  tok_kwd: token, arg0: i0de, argx: i0de, tok_end: token
) : instr // end-of-function
//
(* ****** ****** *)

fun
ATSINSextvar_assign_make
(
  tok_kwd: token, ext: d0exp, d0e_r: d0exp, tok_end: token
) : instr // end of [ATSINSextvar_assign_make]
fun
ATSINSdyncst_valbind_make
(
  tok_kwd: token, d2cst: i0de, d0e_r: d0exp, tok_end: token
) : instr // end of [ATSINSdyncst_valbind_make]

(* ****** ****** *)
//
fun
ATSINScaseof_fail_make
  (tok_kwd: token, errmsg: token, tok_end: token): instr
//
fun
ATSINSdeadcode_fail_make (tok_kwd: token, tok_end: token): instr
//
(* ****** ****** *)
//
fun
ATSdynload_make (tok_kwd: token, tok_end: token): instr
fun
ATSdynloadset_make (tok_kwd: token, id: i0de, tok_end: token): instr
fun
ATSdynloadfcall_make (tok_kwd: token, id: i0de, tok_end: token): instr
//
fun
ATSdynloadflag_sta_make (tok_kwd: token, id: i0de, tok_end: token): instr
fun
ATSdynloadflag_ext_make (tok_kwd: token, id: i0de, tok_end: token): instr
//
(* ****** ****** *)
//
fun
f0body_classify (f0body): int
//
fun
f0body_get_tmpdeclst (f0body): tmpdeclst
//
fun
f0body_get_bdinstrlst (f0body): instrlst
//
(* ****** ****** *)

fun
f0body_make
(
  tok_beg: token, tmps: tmpdeclst, inss: instrlst, tok_end: token
) : f0body // end-of-fun

(* ****** ****** *)

fun f0decl_none (head: f0head): f0decl
fun f0decl_some (head: f0head, body: f0body): f0decl

(* ****** ****** *)
//
fun d0ecl_include
  (tok_beg: token, fname: s0tring): d0ecl
//
fun d0ecl_typedef
  (tok_beg: token, tyrec: tyrec, id: i0de): d0ecl
//
fun d0ecl_assume
  (tok_beg: token, name: i0de, tok_end: token): d0ecl
//
fun
d0ecl_dyncst_mac
  (tok_beg: token, name: i0de, tok_end: token): d0ecl
//
fun
d0ecl_dyncst_extfun
(
  tok_beg: token
, name: i0de, arg: s0explst, res: s0exp, tok_end: token
) : d0ecl // end of [d0ecl_dyncst_extfun]
//
fun
d0ecl_dyncst_valdec
(
  tok_beg: token, name: i0de, s0e: s0exp, tok_end: token
) : d0ecl // end of [d0ecl_dyncst_valdec]
fun
d0ecl_dyncst_valimp
(
  tok_beg: token, name: i0de, s0e: s0exp, tok_end: token
) : d0ecl // end of [d0ecl_dyncst_valimp]
//
(* ****** ****** *)
//
fun d0ecl_statmp_none
  (tok_kwd: token, tmp: i0de, tok_end: token): d0ecl
fun d0ecl_statmp_some
  (tok_kwd: token, tmp: i0de, opt: s0exp, tok_end: token): d0ecl
//
(* ****** ****** *)
//
fun d0ecl_fundecl (knd: fkind, f0d: f0decl): d0ecl
//
(* ****** ****** *)
//
fun
d0ecl_ifdef
(
  tok_kwd: token, id: i0de, d0cs: d0eclist, tok_end: token
) : d0ecl // end of [d0ecl_ifdef]
//
fun
d0ecl_ifndef
(
  tok_kwd: token, id: i0de, d0cs: d0eclist, tok_end: token
) : d0ecl // end of [d0ecl_ifdef]
//
(* ****** ****** *)
//
fun
d0ecl_extcode
  (tok_kwd: token, extcode: tokenlst, tok_end: token): d0ecl
//
(* ****** ****** *)

fun
d0ecl_closurerize
(
  tok_kwd: token
, fl: label, env: s0exp, arg: s0exp, res: s0exp, tok_end: token
) : d0ecl // end of [d0ecl_closurerize]

(* ****** ****** *)
//
fun
d0ecl_dynloadflag_init
  (tok_kwd: token, flag: i0de, tok_end: token): d0ecl
//
fun
d0ecl_dynloadflag_minit
  (tok_kwd: token, flag: i0de, tok_end: token): d0ecl
//
(* ****** ****** *)
//
fun
d0ecl_dynexn_dec
  (tok_kwd: token, idexn: i0de, tok_end: token): d0ecl
fun
d0ecl_dynexn_extdec
  (tok_kwd: token, idexn: i0de, tok_end: token): d0ecl
fun
d0ecl_dynexn_initize
(
  tok_kwd: token, idexn: i0de, fullname: s0tring, tok_end: token
) : d0ecl // end of [d0ecl_dynexn_initize]
//
(* ****** ****** *)

(* end of [catsparse_syntax.sats] *)
