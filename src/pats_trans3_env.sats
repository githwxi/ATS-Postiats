(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: October, 2011
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
LOC = "./pats_location.sats"
typedef loc_t = $LOC.location

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"
viewtypedef
stampset_vt = $STMP.stampset_vt

(* ****** ****** *)

staload
EFF = "./pats_effect.sats"
typedef effset = $EFF.effset
typedef effect = $EFF.effect
typedef effectlst = $EFF.effectlst

(* ****** ****** *)

staload
JSON = "./pats_jsonize.sats"
typedef jsonval = $JSON.jsonval

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_patcst2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)
//
fun
filenv_get_d3eclistopt (fenv: filenv): d3eclistopt
//
(* ****** ****** *)

datatype
c3nstrkind =
//
  | C3TKmain of () // generic
//
  | C3TKcase_exhaustiveness of
      (caskind (*case/case+*), p2atcstlst) // no [case-]
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
  | C3TKsolverify of () // HX-2015-06-12: $solver_verify
// end of [c3nstrkind]

datatype s3itm =
  | S3ITMsvar of s2var
  | S3ITMhypo of h3ypo
  | S3ITMsVar of s2Var
  | S3ITMcnstr of c3nstr
  | S3ITMcnstr_ref of c3nstroptref // HX: for handling state types
  | S3ITMdisj of s3itmlstlst
  | S3ITMsolassert of (s2exp) // $solver_assert
// end of [s3item]

and c3nstr_node =
  | C3NSTRprop of s2exp
  | C3NSTRitmlst of s3itmlst
  | C3NSTRsolverify of (s2exp) // $solve_verify
// end of [c3nstr_node]

and h3ypo_node =
  | H3YPOprop of s2exp
  | H3YPObind of (s2var, s2exp)
  | H3YPOeqeq of (s2exp, s2exp)
// end of [h3ypo_node]

where
s3itmlst = List (s3itm)
and
s3itmlst_vt = List_vt (s3itm)
and
s3itmlstlst = List (s3itmlst)

and c3nstr = '{
  c3nstr_loc= loc_t
, c3nstr_kind= c3nstrkind
, c3nstr_node= c3nstr_node
} // end of [c3nstr]

and c3nstropt = Option (c3nstr)

and
c3nstroptref = '{
  c3nstroptref_loc= loc_t
, c3nstroptref_ref= ref (c3nstropt)
} // end of [c3nstroptref]

and h3ypo = '{
  h3ypo_loc= loc_t
, h3ypo_node= h3ypo_node
} // end of [h3ypo]

(* ****** ****** *)
//
fun
c3nstr_prop
  (loc: loc_t, s2e: s2exp): c3nstr
//
fun
c3nstr_itmlst
(
  loc: loc_t, knd: c3nstrkind, s3is: s3itmlst
) : c3nstr // end of [c3nstr_itmlst]
//
fun
c3nstr_case_exhaustiveness
(
  loc: loc_t, casknd: caskind, p2tcs: !p2atcstlst_vt
) : c3nstr // end of [c3nstr_case_exhaustiveness]

fun
c3nstr_termet_isnat
  (loc: loc_t, s2e: s2exp): c3nstr
// end of [c3nstr_termet_isnat]
fun
c3nstr_termet_isdec
  (loc: loc_t, met: s2explst, mbd: s2explst): c3nstr
// end of [c3nstr_termet_isdec]
//
fun
c3nstr_solverify(loc: loc_t, s2e_prop: s2exp): c3nstr
//
fun c3nstroptref_make_none (loc0: loc_t): c3nstroptref
//
(* ****** ****** *)

fun h3ypo_prop
  (loc: loc_t, s2e: s2exp): h3ypo
fun h3ypo_bind
  (loc: loc_t, s2v: s2var, s2f: s2hnf): h3ypo
fun h3ypo_eqeq
  (loc: loc_t, s2f1: s2hnf, s2f2: s2hnf): h3ypo
// end of [h3ypo_eqeq]

(* ****** ****** *)
//
fun print_c3nstr (x: c3nstr): void
and prerr_c3nstr (x: c3nstr): void
fun fprint_c3nstr : fprint_type (c3nstr)
//
overload print with print_c3nstr
overload prerr with prerr_c3nstr
overload fprint with fprint_c3nstr
//
(* ****** ****** *)
//
fun
fprint_c3nstrkind : fprint_type (c3nstrkind)
//
(* ****** ****** *)
//
fun print_h3ypo (x: h3ypo): void
and prerr_h3ypo (x: h3ypo): void
fun fprint_h3ypo : fprint_type (h3ypo)
//
(* ****** ****** *)
//
fun fprint_s3itm : fprint_type (s3itm)
fun fprint_s3itmlst : fprint_type (s3itmlst)
fun fprint_s3itmlstlst : fprint_type (s3itmlstlst)
//
overload fprint with fprint_s3itm
overload fprint with fprint_s3itmlst
overload fprint with fprint_s3itmlstlst
//
(* ****** ****** *)

fun s2exp_Var_make_srt (loc: loc_t, s2t: s2rt): s2exp
fun s2exp_Var_make_var (loc: loc_t, s2v: s2var): s2exp

(* ****** ****** *)

fun stasub_make_svarlst
  (loc: loc_t, s2vs: s2varlst): stasub
// end of [stasub_make_svarlst]

(* ****** ****** *)
//
fun
s2exp_exi_instantiate_all
  (s2e: s2exp, locarg: loc_t, err: &int): (s2exp, s2explst_vt)
fun
s2exp_uni_instantiate_all
  (s2e: s2exp, locarg: loc_t, err: &int): (s2exp, s2explst_vt)
//
fun
s2exp_exiuni_instantiate_all // knd=0/1:exi/uni
  (knd: int, s2e: s2exp, locarg: loc_t, err: &int): (s2exp, s2explst_vt)
//
(* ****** ****** *)
//
fun
s2exp_termet_instantiate
  (loc: loc_t, stamp: stamp, met: s2explst): void
fun
s2exp_unimet_instantiate_all
// HX: instantiating universal quantifiers and term. metrics
  (s2e: s2exp, locarg: loc_t, err: &int): (s2exp, s2explst_vt)
//
(* ****** ****** *)
//
fun
s2exp_exi_instantiate_sexparg
  (s2e: s2exp, arg: s2exparg, err: &int): (s2exp, s2explst_vt)
fun
s2exp_uni_instantiate_sexparglst
  (s2e: s2exp, arg: s2exparglst, err: &int): (s2exp, s2explst_vt)
//
(* ****** ****** *)
//
fun
s2exp_tmp_instantiate_rest
(
  s2f: s2exp, locarg: loc_t, s2qs: s2qualst, nerr: &int
) : (s2exp(*res*), t2mpmarglst) = "ext#patsopt_s2exp_tmp_instantiate_rest"
//
fun
s2exp_tmp_instantiate_tmpmarglst
(
  s2f: s2exp
, locarg: loc_t, s2qs: s2qualst, t2mas: t2mpmarglst, nerr: &int
) : (s2exp(*res*), t2mpmarglst) = "ext#patsopt_s2exp_tmp_instantiate_tmpmarglst"
//
(* ****** ****** *)
//
fun
s2var_occurcheck_s2exp (s2v0: s2var, s2e: s2exp): bool
//
(* ****** ****** *)

absview trans3_env_push_v

fun trans3_env_pop
  (pf: trans3_env_push_v | (*none*)): s3itmlst_vt
// end of [trans3_env_pop]

fun trans3_env_pop_and_add
  (pf: trans3_env_push_v | loc: loc_t, knd: c3nstrkind): void
// end of [trans3_env_pop_and_add]

fun trans3_env_pop_and_add_main
  (pf: trans3_env_push_v | loc: loc_t): void
// end of [trans3_env_pop_and_add_main]

fun trans3_env_push (): (trans3_env_push_v | void)

(* ****** ****** *)

fun trans3_env_add_svar (s2v: s2var): void
fun trans3_env_add_svarlst (s2vs: s2varlst): void

fun trans3_env_add_squa (s2q: s2qua): void
fun trans3_env_add_squalst (s2qs: s2qualst): void

fun trans3_env_add_sp2at (sp2t: sp2at): void

fun trans3_env_add_sVar (s2V: s2Var): void
fun trans3_env_add_sVarlst (s2Vs: s2Varlst): void

fun trans3_env_add_cnstr (c3t: c3nstr): void
fun trans3_env_add_cnstr_ref (ctr: c3nstroptref): void

fun trans3_env_add_prop (loc: loc_t, s2p: s2exp): void
fun trans3_env_add_proplst (loc: loc_t, s2ps: s2explst): void
fun trans3_env_add_proplst_vt (loc: loc_t, s2ps: s2explst_vt): void

fun trans3_env_add_eqeq
  (loc: loc_t, s2e1: s2exp, s2e2: s2exp): void
// end of [trans3_env_add_eqeq]

fun
trans3_env_add_patcstlstlst_false
(
  loc: loc_t
, casknd: caskind, cp2tcss: p2atcstlstlst_vt, s2es_pat: s2explst
) : void // end of [trans3_env_add_p2atcstlstlst_false]

(* ****** ****** *)
//
fun trans3_env_hypadd_prop (loc: loc_t, s2p: s2exp): void
fun trans3_env_hypadd_proplst (loc: loc_t, s2ps: s2explst): void
fun trans3_env_hypadd_proplst_vt (loc: loc_t, s2ps: s2explst_vt): void
//
fun trans3_env_hypadd_propopt (loc: loc_t, os2p: s2expopt): void
fun trans3_env_hypadd_propopt_neg (loc: loc_t, os2p: s2expopt): void
//
fun trans3_env_hypadd_bind (loc: loc_t, s2v1: s2var, s2f2: s2hnf): void
fun trans3_env_hypadd_eqeq (loc: loc_t, s2f1: s2hnf, s2f2: s2hnf): void
//
fun trans3_env_hypadd_patcst
  (loc: loc_t, p2tc: p2atcst, s2e: s2exp): void
fun trans3_env_hypadd_patcstlst
  (loc: loc_t, p2tcs: p2atcstlst_vt, s2es: s2explst): void
fun trans3_env_hypadd_labpatcstlst
  (loc: loc_t, lp2tcs: labp2atcstlst_vt, ls2es: labs2explst): void
fun trans3_env_hypadd_patcstlstlst
  (loc: loc_t, p2tcs: p2atcstlstlst_vt, s2es: s2explst): void
//
(* ****** ****** *)
//
fun trans3_env_solver_assert(loc: loc_t, s2e: s2exp): void
fun trans3_env_solver_verify(loc: loc_t, s2e: s2exp): void
//
(* ****** ****** *)
//
absview s2varbindmap_push_v
//
fun the_s2varbindmap_freetop (): void
fun the_s2varbindmap_pop
  (pf: s2varbindmap_push_v | (*nothing*)): void
fun the_s2varbindmap_push (): (s2varbindmap_push_v | void)
//
fun the_s2varbindmap_search (s2v: s2var): Option_vt (s2exp)
fun the_s2varbindmap_insert (s2v: s2var, s2f: s2hnf): void
//
// HX: for the purpose of debugging
//
fun fprint_the_s3itmlst (out: FILEref): void
fun fprint_the_s3itmlstlst (out: FILEref): void
//
fun fprint_the_s2varbindmap (out: FILEref): void
//
(* ****** ****** *)
//
absview s2cstbindlst_push_v
//
fun the_s2cstbindlst_add (s2c: s2cst): void
fun the_s2cstbindlst_addlst (s2cs: s2cstlst_vt): void

fun the_s2cstbindlst_bind_and_add
  (loc: loc_t, s2c: s2cst, s2f: s2hnf): void
// end of [the_s2cstbindlst_bind_and_add]

fun the_s2cstbindlst_pop
  (pf: s2cstbindlst_push_v | (*none*)): s2cstlst_vt
fun the_s2cstbindlst_pop_and_unbind
  (pf: s2cstbindlst_push_v | (*none*)): void

fun the_s2cstbindlst_push (): (s2cstbindlst_push_v | void)

(* ****** ****** *)

absview termetenv_push_v

fun s2explst_check_termet
  (loc0: loc_t, met: s2explst): void
// end of [s2explst_check_termet]

fun termetenv_pop
  (pf: termetenv_push_v | (*none*)): void

fun termetenv_push
  (d2vs: stampset_vt, met: s2explst): (termetenv_push_v | void)
// end of [termetenv_push]

fun termetenv_push_dvarlst
  (d2vs: d2varlst, met: s2explst): (termetenv_push_v | void)
// end of [termetenv_push_dvarlst]

fun termetenv_get_termet (x: stamp): Option_vt (s2explst)

fun s2exp_metfun_load
  (s2e0: s2exp, d2v0: d2var): Option_vt @(s2exp, s2rtlst)
// end of [s2exp_metfun_load]

(* ****** ****** *)

absview effenv_push_v

fun the_effenv_add_eff (eff: effect): void

fun the_effenv_pop
  (pf: effenv_push_v | (*none*)): void
fun the_effenv_pop_if {b:bool}
  (pfopt: option_v (effenv_push_v, b) | test: bool b): void

fun the_effenv_push (): (effenv_push_v | void)
fun the_effenv_push_lam (s2fe: s2eff): (effenv_push_v | void)
//
fun the_effenv_push_set (efs: effset): (effenv_push_v | void)
fun the_effenv_push_set_if {b:bool}
  (test: bool b, efs: effset): (option_v (effenv_push_v, b) | void)
// end of [the_effenv_push_set_if]
//
fun the_effenv_push_effmask (s2fe: s2eff): (effenv_push_v | void)

fun the_effenv_check_set
  (loc: loc_t, efs: effset): int (*succ/fail: 0/1*)
//
fun the_effenv_check_eff
  (loc: loc_t, eff: effect): int (*succ/fail: 0/1*)
//
fun the_effenv_check_exn (loc: loc_t): int (*succ/fail: 0/1*)
fun the_effenv_check_ntm (loc: loc_t): int (*succ/fail: 0/1*)
fun the_effenv_check_ref (loc: loc_t): int (*succ/fail: 0/1*)
fun the_effenv_check_wrt (loc: loc_t): int (*succ/fail: 0/1*)
//
fun the_effenv_caskind_check_exn
  (loc: loc_t, knd: caskind): int (*succ/fail: 0/1*)
// end of [the_effenv_caskind_check_exn]

fun the_effenv_check_sexp
  (loc: loc_t, s2e: s2exp): int (*succ/fail: 0/1*)
fun the_effenv_check_s2eff
  (loc: loc_t, s2fe: s2eff): int (*succ/fail: 0/1*)

(* ****** ****** *)

fun s2hnf_absuni_and_add
  (loc: loc_t, s2f: s2hnf): s2exp
// end of [s2hnf_absuni_and_add]

fun s2hnf_opnexi_and_add
  (loc: loc_t, s2f: s2hnf): s2exp
// end of [s2hnf_opnexi_and_add]

fun s2hnf_opn1exi_and_add
  (loc: loc_t, s2f: s2hnf): s2exp
// end of [s2hnf_opn1exi_and_add]

fun s2fun_opninv_and_add
  (loc: loc_t, arg: s2explst, res: s2exp): s2explst
// end of [s2fun_opninv_and_add]

(* ****** ****** *)

fun d2var_opnset_and_add (loc: loc_t, d2v: d2var): void

(* ****** ****** *)

fun
un_s2exp_wthtype
(
  loc: loc_t, s2e: s2exp
) : (
  bool(*iswth*), s2exp, wths2explst
) // end of [un_s2exp_wthtype]

(* ****** ****** *)

fun d3exp_open_and_add (d3e: d3exp): void
fun d3explst_open_and_add (d3es: d3explst): void

(* ****** ****** *)
//
// HX: for turning val into var
//
fun d2var_mutablize
(
  loc0: loc_t
, d2v: d2var, s2e0(*master*): s2exp, opt: d2varopt
) : d2var // end of [d2var_mutablize]
fun d2var_mutablize_none
  (loc0: loc_t, d2v: d2var, s2e0(*master*): s2exp): d2var
// end of [d2var_mutablize_none]

(* ****** ****** *)
//
// HX: for tracking linear dynamic variables
//
absview d2varenv_push_v

fun the_d2varenv_add_dvar (d2v: d2var): void
fun the_d2varenv_add_dvarlst (d2vs: d2varlst): void
fun the_d2varenv_add_dvaropt (opt: d2varopt): void
fun the_d2varenv_add_p3at (p3t: p3at): void
fun the_d2varenv_add_p3atlst (p3ts: p3atlst): void

fun the_d2varenv_get_top (): d2varlst_vt
fun the_d2varenv_get_llamd2vs (): d2varlst_vt

fun the_d2varenv_pop
  (pf: d2varenv_push_v | (*none*)): void
// end of [the_d2varenv_pop]

fun the_d2varenv_push_lam
  (knd(*lin*): int): (d2varenv_push_v | void)
fun the_d2varenv_push_let (): (d2varenv_push_v | void)
fun the_d2varenv_push_try (): (d2varenv_push_v | void)

fun the_d2varenv_d2var_is_llamlocal (d2v: d2var): bool

(*
** HX-2012-03:
** [funarg_d2vfin_check] checks d2var_finknd of funarg
*)
fun funarg_d2vfin_check (loc0: loc_t): void
(*
** HX-2012-03:
** [s2exp_wthtype_instantiate] resets d2var_finknd of funarg
*)
fun s2exp_wthtype_instantiate (loc: loc_t, s2e: s2exp): s2exp

(* ****** ****** *)

fun the_d2varenv_check (loc0: loc_t): void
fun the_d2varenv_check_llam (loc0: loc_t): void

(* ****** ****** *)
(*
** HX-2012-05
*)

typedef
lstbefitm = '{
  lstbefitm_var= d2var
, lstbefitm_linval= int // HX: a relic no longer in use
, lstbefitm_type= s2expopt
} // end of [lstbefitm]

typedef lstbefitmlst = List (lstbefitm)

fun lstbefitm_make (d2v: d2var, linval: int): lstbefitm

fun fprint_lstbefitm : fprint_type (lstbefitm)
overload fprint with fprint_lstbefitm
fun fprint_lstbefitmlst : fprint_type (lstbefitmlst)
overload fprint with fprint_lstbefitmlst

fun the_d2varenv_save_lstbefitmlst (): lstbefitmlst

fun lstbefitmlst_restore_type (xs: lstbefitmlst): void
fun lstbefitmlst_restore_linval_type (xs: lstbefitmlst): void

(* ****** ****** *)

absviewtype lstaftc3nstr_viewtype
viewtypedef lstaftc3nstr = lstaftc3nstr_viewtype

fun fprint_lstaftc3nstr : fprint_vtype (lstaftc3nstr)

fun lstaftc3nstr_initize (xs: lstbefitmlst): lstaftc3nstr
fun lstaftc3nstr_update (x: !lstaftc3nstr, ctr: c3nstroptref): void
fun lstaftc3nstr_process (x: !lstaftc3nstr, res: i2nvresstate): void
fun lstaftc3nstr_finalize (x: lstaftc3nstr): void

(* ****** ****** *)

fun i2nvarglst_update (loc: loc_t, args: i2nvarglst): void
fun i2nvresstate_update (loc: loc_t, invres: i2nvresstate): void

(* ****** ****** *)
//
absview lamlpenv_push_v
//
// HX: the break/continue statements are skipped during the 1st round
//
datatype lamlp =
  | LAMLPlam of p3atlst (* function arguments *)
  | LAMLPloop0 of () // 1st round typechecking for loops
//
// 2nd round typechekcing for loops
//
  | LAMLPloop1 of (loopi2nv, lstbefitmlst, d2expopt(*post*))
viewtypedef lamlplst_vt = List_vt (lamlp)

fun the_lamlpenv_top ((*void*)): Option_vt (lamlp)
fun the_lamlpenv_get_funarg ((*void*)): Option_vt (p3atlst)

fun the_lamlpenv_pop (pf: lamlpenv_push_v | (*none*)): void

fun the_lamlpenv_push_lam
  (p3ts: p3atlst): (lamlpenv_push_v | void)
fun the_lamlpenv_push_loop0 () : (lamlpenv_push_v | void)
fun the_lamlpenv_push_loop1
  (i2nv: loopi2nv, lbis: lstbefitmlst, post: d2expopt) : (lamlpenv_push_v | void)
// end of [the_lamlpenv_push_loop1]

(* ****** ****** *)

absview pfmanenv_push_v

fun fprint_the_pfmanenv (out: FILEref): void

fun the_pfmanenv_push_let (): (pfmanenv_push_v | void)
fun the_pfmanenv_push_lam (lin: int): (pfmanenv_push_v | void)
fun the_pfmanenv_push_try (): (pfmanenv_push_v | void)

fun the_pfmanenv_pop (pf: pfmanenv_push_v | (*none*)): void

fun the_pfmanenv_add_dvar (d2v: d2var): void
fun the_pfmanenv_add_dvaropt (opt: d2varopt): void
fun the_pfmanenv_add_dvarlst (d2vs: d2varlst): void
fun the_pfmanenv_add_p3at (p3t: p3at): void
fun the_pfmanenv_add_p3atlst (p3ts: p3atlst): void

(* ****** ****** *)
//
datavtype
pfobj = PFOBJ of
  (d2var, s2exp(*ctx*), s2exp(*elt*), s2exp(*addr*))
vtypedef pfobjopt = Option_vt (pfobj)
//
fun pfobj_search_atview (s2l0: s2exp): pfobjopt
//
(* ****** ****** *)

fun the_trans3_env_initialize (): void

(* ****** ****** *)

fun the_trans3_finget_constraint (): c3nstr

(* ****** ****** *)

(* end of [pats_trans3_env.sats] *)
