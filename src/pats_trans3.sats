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

staload EFF = "./pats_effect.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dmacro2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)
//
// HX-2011-05:
// the list of possible errors that may occur
// during the level-3 translation
//
datatype trans3err =
//
  | T3E_intsp of (loc_t, string(*rep*))
  | T3E_floatsp of (loc_t, string(*rep*))
//
  | T3E_s2varlst_instantiate_nabs of (loc_t(*arg*), int(*-1/1*)) // exi
  | T3E_s2varlst_instantiate_napp of (loc_t(*arg*), int(*-1/1*)) // uni
  | T3E_s2varlst_instantiate_arity of (loc_t(*arg*), int(*-1/1*))
  | T3E_s2varlst_instantiate_srtck of (loc_t(*arg*), s2rt(*s2v*), s2rt(*s2e*))
//
  | T3E_s2exp_uni_instantiate_sexparglst of (loc_t, s2exp, s2exparglst)
//
  | T3E_d2var_typeless of (loc_t, d2var) // accessing a consumed linear d2var
  | T3E_d2var_fin_some_none of (loc_t, d2var) // should be preserved but is consumed
  | T3E_d2var_fin_none_some of (loc_t, d2var) // should be consumed but is preserved
  | T3E_d2var_fin_some_some of (loc_t, d2var) // is preserved but with something incompatible
//
  | T3E_p2at_trdn of (p2at, s2exp)
  | T3E_p2at_trdn_vbox_ref of (p2at) // resulting in disallowed ref-effect
//
  | T3E_p2at_trdn_lst of (int(*lin*), p2at)
//
  | T3E_p2at_trup_con of p2at // pfarity // ill-typed
  | T3E_p2at_trdn_con_arity of (p2at, int(*serr*))
  | T3E_p2at_free_update of (p3at) // linear constructor freeing
//
  | T3E_d2exp_trup_item of (loc_t, d2itm)
//
  | T3E_d2exp_trup_tmpid of (d2exp) // non-template treated as template
//
  | T3E_d2var_trup_llamlocal of (d2var) // non-local linear variable
//
  | T3E_d2exp_trup_con_npf of (d2exp, int(*npf*))
  | T3E_d2exp_trup_laminit_funclo of (d2exp, funclo)
//
  | T3E_d3exp_trdn of (d3exp, s2exp)
  | T3E_d23explst_trdn_arity of (loc_t, int(*serr*))
//
  | T3E_d3exp_trup_applst_eff of (loc_t(*app*), s2eff(*eff*))
//
  | T3E_d23exp_trup_app23_npf of (loc_t(*fun*), int(*npf*))
  | T3E_d23exp_trup_app23_fun of (loc_t(*fun*), s2exp(*fun*))
  | T3E_d23exp_trup_app23_eff of (loc_t(*app*), s2eff(*eff*))
//
  | T3E_d2exp_trup_sym of (d2exp) // non-applied sym
  | T3E_d2exp_trup_applst_sym_nil of (d2exp, d2sym) // found none
  | T3E_d2exp_trup_applst_sym_cons2 of (d2exp, d2sym) // found too many
//
  | T3E_d2exp_trup_exn of (loc_t)
  | T3E_d2exp_trup_wrt of (loc_t)
//
  | T3E_d2exp_trdn_tup of (d2exp, s2exp)
  | T3E_d2exp_trdn_rec of (d2exp, s2exp)
  | T3E_d2exp_trdn_exist of (d2exp, s2exp)
  | T3E_d2exp_trdn_lam_dyn of (d2exp, s2exp)
//
  | T3E_d2exp_trup_arg_body_linpat of (p2at)
//
  | T3E_d3exp_delay of (loc_t, d3exp)
//
  | T3E_d3exp_foldat of (loc_t, d3exp)
  | T3E_d3exp_freeat of (loc_t, d3exp)
//
  | T3E_d3exp_extfcall_arg of (loc_t, d3exp)
  | T3E_d3exp_extmcall_arg of (loc_t, d3exp)
//
  | T3E_s2exp_selab_tyrec of (loc_t, s2exp)
  | T3E_s2exp_selab_labnot of (loc_t, s2exp, label) // label is not found
  | T3E_s2exp_selab_tyarr of (loc_t, s2exp)
  | T3E_d3exp_arrind of (d3exp) // arrind is not a generic integer
  | T3E_d3exp_arrdim of (loc_t, s2explst, d3explst) // array dimen/index mismatch
  | T3E_d3exp_selab_linrest of (loc_t, d3exp, d3lablst)
//
  | T3E_d2var_nonmut of (loc_t, d2var) // no address for d2var
//
(*
  | T3E_d2var_lin_overld of (loc_t, d2var, d3lablst)
  | T3E_d2var_mul_overld of (loc_t, d2var, d3lablst)
  | T3E_d2exp_deref_overld of (loc_t, d2exp, d3lablst)
*)
//
  | T3E_d3lab_overld_app of (loc_t, d3lab) // dot-symbol not applied
//
  | T3E_d2exp_nonlval of (d2exp) // non-lval expression
  | T3E_d2exp_addrless of (d2exp) // addressless lval
  | T3E_d3exp_nonderef of (d3exp) // non-deref expression
  | T3E_pfobj_search_none of (loc_t, s2exp(*addr*)) // pfobj not found
//
  | T3E_s2exp_assgn_tszeq of (loc_t, s2exp(*bef*), s2exp(*aft*))
  | T3E_s2addr_viewat_addreq of (loc_t, s2exp(*bef*), d3lablst, s2exp(*aft*))
//
  | T3E_s2addr_deref_context of (loc_t, s2exp, d3lablst)
  | T3E_s2addr_assgn_deref_linsel of (loc_t, s2exp, d3lablst)
  | T3E_s2addr_assgn_deref_sharing of (loc_t, s2exp, d3lablst)
  | T3E_s2addr_assgn_deref_proof of (loc_t, s2exp, d3lablst)
  | T3E_s2addr_assgn_deref_context of (loc_t, s2exp, d3lablst)
//
  | T3E_s2addr_xchng_check_LHS of (loc_t, s2exp(*LHS*), s2exp(*RHS*))
  | T3E_s2addr_xchng_check_RHS of (loc_t, s2exp(*LHS*), s2exp(*RHS*))
//
  | T3E_d2var_selab_context of (loc_t, d2var, d3lablst) // linsel
  | T3E_d3exp_deref_reflinsel of (d3exp, d3lablst) // ref linear selection
  | T3E_d3exp_assgn_deref_reflinsel of (d3exp, d3lablst) // linear selection
  | T3E_d3exp_assgn_deref_refsharing of (d3exp, d3lablst) // boxed non-linear field-update
  | T3E_d3exp_trdn_xchng_deref of (d3exp, d3lablst, s2exp) // type mismatch
//
  | T3E_s2addr_viewat_deref_context of (loc_t, s2exp, d3lablst)
//
  | T3E_s2exp_set_viewat_atview of (loc_t, s2exp(*root*))
  | T3E_s2exp_set_viewat_without of (loc_t, s2exp(*root*))
(*
  | T3E_s2exp_set_viewat_tszeq of (loc_t, s2exp(*old*), s2exp(*new*))
  | T3E_s2exp_set_viewat_addreq of (loc_t, s2exp(*root*), d3lablst, s2exp(*new*))
*)
//
  | T3E_d3lval_fun of (d3exp) // non-left-val fun for call-by-ref
  | T3E_d3lval_funarg of (d3exp) // non-left-val funarg for call-by-ref
  | T3E_d3lval_refval of (loc_t, d2var) // non-mutable dvar used for call-by-ref
  | T3E_d3lval_linpatcon of (d3exp, s2exp) // non-left-val is matched against linpatcon
//
  | T3E_d3exp_funclo_topized of (d3exp) // repeated application of a linear funclo
//
  | T3E_s2addr_exch_type_linold of (loc_t, s2exp, d3lablst) // linear abandonment
  | T3E_s2addr_exch_type_oldnew of (loc_t, s2exp, d3lablst, s2exp(*new*))
  | T3E_d3lval_exch_type_linold of (loc_t, d3exp, d3lablst) // linear abandonment
//
  | T3E_effenv_check_set of (loc_t, $EFF.effset) // disallowed effects
  | T3E_effenv_check_sexp of (loc_t, s2exp(*S2Eeff*)) // disallowed effects
//
  | T3E_guard_trdn of
      (loc_t, bool(*gval*), s2exp(*gtyp*))
  | T3E_c2lau_trdn_arity of (c2lau, s2explst)
  | T3E_c2laulst0_trdn_noclause of (loc_t)
  | T3E_c2laulst2_trdn_redundant of (loc_t, c2lau)
//
  | T3E_cp2atcstlst_arity of (loc_t, int(*serr*))
//
  | T3E_loopexn of (loc_t, int(*knd*)) // HX: 0/1: break/continue
//
  | T3E_d2var_some of (loc_t, d2var, s2exp) // should be retained but consumed
  | T3E_d2var_none of (loc_t, d2var, s2exp) // should be consumed but retained
  | T3E_d2var_some2 of
      (loc_t, d2var, s2exp(*0*), s2exp) // retained but with a type that fails to merge
    // end of [T3E_d2var_some2]
//
  | T3E_dmacro_eval0_cmp of (loc_t, m2val, m2val)
  | T3E_dmacro_eval0_d2exp of (loc_t, d2exp)
  | T3E_dmacro_eval0_app_mac_arity of (loc_t, d2mac, d2exparglst)
  | T3E_dmacro_evalctx_extend of (loc_t, d2mac)
  | T3E_dmacro_eval1_d2exp of (loc_t, d2exp)
//
  | T3E_reassume_tr_isnotasp of (loc_t, s2cst)
//
  | T3E_f2undeclst_tr_termetsrtck of (f2undec, s2rtlstopt)
  | T3E_v2aldeclst_rec_tr_linearity of (v2aldec, s2exp(*linear*))
// end of [trans3err]

fun the_trans3errlst_add (x: trans3err): void
fun the_trans3errlst_finalize (): void // cleanup all the errors

(* ****** ****** *)

fun p2at_syn_type (p2t: p2at): s2exp
fun p2atlst_syn_type (p2ts: p2atlst): s2explst

(* ****** ****** *)
//
fun p2at_trup_arg (p2t: p2at): p3at
fun p2atlst_trup_arg
  (npf: int, p2ts: p2atlst): p3atlst
//
fun p2at_trdn_arg (p2t: p2at, s2e: s2exp): p3at
fun p2atlst_trdn_arg {n:nat} (
  loc: loc_t, npf: int
, p2ts: p2atlst, s2es: list (s2exp, n), serr: &int
) : list (p3at, n) // end of [p2atlst_trdn_arg]
//
fun p2at_trdn (p2t: p2at, s2e: s2exp): p3at
fun p2at_trdn_con (p2t: p2at, s2f: s2hnf): p3at
fun p2atlst_trdn {n:nat} (
  loc: loc_t
, p2ts: p2atlst, s2es: list (s2exp, n), serr: &int
) : list (p3at, n) // end of [p2atlst_trdn]
//
fun guard_trdn
  (loc: loc_t, gval: bool, gtyp: s2exp): void
// end of [guard_trdn]

(* ****** ****** *)

(*
fun p3at_mutablize (p3t0: p3at): void // HX: var [pat] = ...
*)

(* ****** ****** *)

fun
funarg_patck_exhaust
(
  loc0: location, p2ts_arg: p2atlst, s2es_arg: s2explst
) : void // end of [funarg_patck_exhaust]

(* ****** ****** *)

fun d2exp_funclo_of_d2exp
  (d2e0: d2exp, fc0: &funclo): d2exp
// end of [d2exp_funclo_of_d2exp]

fun d2exp_s2eff_of_d2exp
  (d2e0: d2exp, s2fe0: &s2eff? >> s2eff): d2exp
// end of [d2exp_s2eff_of_d2exp]

(* ****** ****** *)

fun d2exp_syn_type (d2e: d2exp): s2exp
fun d2explst_syn_type (d2es: d2explst): s2explst
fun labd2explst_syn_type (ld2es: labd2explst): labs2explst

(* ****** ****** *)

fun fshowtype_d3exp_up (d3e: d3exp): void
fun fshowtype_d3exp_dn (d3e: d3exp): void

(* ****** ****** *)

fun d3lablst_is_overld (d3ls: d3lablst): bool

(* ****** ****** *)

datavtype d23exp =
  | D23Ed2exp of d2exp | D23Ed3exp of d3exp
viewtypedef d23explst = List_vt (d23exp)

fun d23exp_free (x: d23exp): void
fun d23explst_free (xs: d23explst): void

fun d3exp_trdn (d3e: d3exp, s2f: s2exp): d3exp

fun d3explst_trdn_arg
  (d3es: d3explst, s2es: s2explst): d3explst
// end of [d3explst_trdn_arg]

(* ****** ****** *)
//
fun d2exp_trup_int (d2e0: d2exp, i: int): d3exp
//
fun intrep_syn_type // for dyn-patterns
  (loc0: loc_t, rep: string): s2exp // g0int
fun intrep_syn_type_ind // for dyn-expressions
  (loc0: loc_t, rep: string): s2exp // g1int
fun d2exp_trup_intrep (d2e0: d2exp, rep: string): d3exp
//
fun d2exp_trup_bool (d2e0: d2exp, b: bool): d3exp
fun d2exp_trup_char (d2e0: d2exp, c: char): d3exp
fun d2exp_trup_string (d2e0: d2exp, str: string): d3exp
//
fun float_syn_type
  (loc0: loc_t, rep: string): s2exp
fun d2exp_trup_float (d2e0: d2exp, rep: string): d3exp
//
fun i0nt_syn_type (x: i0nt): s2exp // g0int ...
fun i0nt_syn_type_ind (x: i0nt): s2exp // g1int ...
fun d2exp_trup_i0nt (d2e0: d2exp, x: i0nt): d3exp
//
fun f0loat_syn_type (x: f0loat): s2exp
fun d2exp_trup_f0loat (d2e0: d2exp, x: f0loat): d3exp
//
(* ****** ****** *)

fun cstsp_syn_type
  (d2e0: d2exp, x: $SYN.cstsp): s2exp
fun d2exp_trup_cstsp
  (d2e0: d2exp, x: $SYN.cstsp): d3exp
// end of [d2exp_trup_cstsp]

(* ****** ****** *)
//
fun d2exp_trup_tyrep
  (d2e0: d2exp, s2e_rep: s2exp): d3exp
//
(* ****** ****** *)
//
fun d2exp_trup_literal
  (d2e0: d2exp, d2e_lit: d2exp): d3exp
//
(* ****** ****** *)

fun d2var_get_type_some
  (loc: loc_t, d2v: d2var): s2exp
// end of [d2var_get_type_some]

fun d2exp_trup_cst (loc: loc_t, d2c: d2cst): d3exp
fun d2exp_trup_var (loc: loc_t, d2v: d2var): d3exp
fun d2exp_trup_var_mutabl (loc: loc_t, d2v: d2var): d3exp
fun d2exp_trup_var_nonmut (loc: loc_t, d2v: d2var): d3exp

(* ****** ****** *)

fun d2exp_trup_tmpcst
  (loc0: loc_t, d2c: d2cst, t2mas: t2mpmarglst): d3exp
// end of [d2exp_trup_tmpcst]

fun d2exp_trup_tmpvar
  (loc0: loc_t, d2v: d2var, t2mas: t2mpmarglst): d3exp
// end of [d2exp_trup_tmpvar]

(* ****** ****** *)

fun d2exp_trup_applst
  (d2e0: d2exp, _fun: d2exp, _arg: d2exparglst): d3exp
// end of [d2exp_trup_applst]

fun d23exp_trup_applst
  (d2e0: d2exp, _fun: d3exp, _arg: d2exparglst): d3exp
// end of [d23exp_trup_applst]

(* ****** ****** *)
//
fun
d2exp_trup_applst_sym
  (d2e0: d2exp, d2s: d2sym, _arg: d2exparglst): d3exp
//
fun
d2exp_trup_applst_tmpsym
(
  d2e0: d2exp, d2s: d2sym, t2mas: t2mpmarglst, _arg: d2exparglst
) : d3exp // end of [d2exp_trup_applst_tmpsym]
//
fun
d2exp_trup_applst_seloverld
  (d2e0: d2exp, _fun: d2exp, d2s: d2sym, _arg: d2exparglst): d3exp
//
(* ****** ****** *)

fun d2lab_trup (d2l: d2lab) : d3lab
fun d2lablst_trup (d2ls: d2lablst) : d3lablst

(* ****** ****** *)

fun d3explst_get_ind (d3es: d3explst): s2explst

fun s2exp_get_dlablst_linrest_sharing
(
  loc0: loc_t, s2e: s2exp, d3ls: d3lablst, linrest: &int, sharing: &int
) : (s2exp, s2explst_vt) // end of [fun]

fun d2exp_trup_selab
  (loc0: loc_t, tup: d2exp, labs: d2lablst): d3exp
// end of [d2exp_trup_selab]

(* ****** ****** *)

fun d2exp_trup_foldat (d2e0: d2exp): d3exp
fun d2exp_trup_freeat (d2e0: d2exp): d3exp

(* ****** ****** *)

fun d2exp_trup_ptrof (d2e0: d2exp): d3exp

(* ****** ****** *)

fun
s2exp_get_dlablst_context
(
  loc0: loc_t, s2e: s2exp, d3ls: d3lablst, context: &s2ctxtopt
) : s2exp (*selected*) // endfun

fun
s2exp_get_dlablst_context_check
(
  loc0: loc_t, s2e: s2exp, d3ls: d3lablst, context: &s2ctxtopt
) : (s2exp, s2explst_vt) // endfun

(* ****** ****** *)

fun
d2exp_trup_deref
(
  loc0: loc_t, d2s: d2sym, d2e: d2exp, d2ls: d2lablst
) : d3exp // end of [d2exp_trup_deref]

fun s2addr_deref
(
  loc0: loc_t, s2l: s2exp, d3ls: d3lablst, s2rt: &s2exp? >> s2exp
) : s2exp(*selected elt*) // end of [s2addr_deref]

(* ****** ****** *)

fun d2exp_trup_assgn (d2e0: d2exp): d3exp

fun d2exp_trup_assgn_deref
(
  loc0: loc_t, d2e_l: d2exp, d2ls: d2lablst, d2e_r: d2exp
) : d3exp // end of [d2exp_trup_assgn_deref]

fun
s2addr_assgn_deref
(
  loc0: loc_t
, s2l: s2exp, d3ls: d3lablst, d3e_r: d3exp, s2rt: &s2exp? >> s2exp
) : d3exp(*rval*) // end of [s2addr_assgn_deref]

(* ****** ****** *)

fun d2exp_trup_xchng (d2e0: d2exp): d3exp

(*
** HX: evaluation of [d2e_r] should involving no proofs of views
*)
fun
d2exp_trup_xchng_deref
(
  loc0: loc_t, d2e_l: d2exp, d2ls: d2lablst, d2e_r: d2exp
) : d3exp // end of [d2exp_trup_xchng_deref]

fun
s2addr_xchng_deref
(
  loc0: loc_t
, s2l: s2exp, d3ls: d3lablst, d2e_r: d2exp, s2rt: &s2exp? >> s2exp
) : d3exp(*rval*) // end of [s2addr_xchng_deref]

(* ****** ****** *)

fun d2exp_trup_viewat (d2e0: d2exp): d3exp
fun d2exp_trup_viewat_assgn (d2e0: d2exp): d3exp

(* ****** ****** *)

fun
d2exp_trup_loop
(
  loc: loc_t
, inv: loopi2nv
, init: d2expopt, test: d2exp, post: d2expopt, body: d2exp
) : d3exp // end of [d2exp_trup_loop]

fun d2exp_trup_loopexn (loc: loc_t, knd: int): d3exp

(* ****** ****** *)

fun d2exp_trup (d2e: d2exp): d3exp
fun d2explst_trup (d2es: d2explst): d3explst

(* ****** ****** *)

fun
d2exp_trdn (d2e: d2exp, s2e: s2exp): d3exp
fun
d2explst_trdn_elt (d2es: d2explst, s2e: s2exp): d3explst
fun
d2expopt_trdn_elt (od2e: d2expopt, s2e: s2exp): d3expopt

(* ****** ****** *)
//
fun
d2exp_trdn_rest (d2e: d2exp, s2f: s2hnf): d3exp
//
fun
d2exp_trdn_ifhead (d2e: d2exp, s2f: s2hnf): d3exp
fun
d2exp_trdn_sifhead (d2e: d2exp, s2f: s2hnf): d3exp
//
fun
d2exp_trdn_ifcasehd (d2e: d2exp, s2f: s2hnf): d3exp
//
fun
c2laulst_trdn{n:nat}
(
  loc0: loc_t
, casknd: caskind
, invres: i2nvresstate
, c2ls: c2laulst
, d3es: list (d3exp, n)
, s2es_pat: list (s2exp, n)
, s2e_res: s2exp
) : c3laulst n // end of [c2laulst_trdn]
fun d2exp_trdn_casehead (d2e: d2exp, s2f: s2hnf): d3exp
fun d2exp_trdn_scasehead (d2e: d2exp, s2f: s2hnf): d3exp
//
fun d2exp_trdn_letwhere
(
  d2e0: d2exp, s2f0: s2hnf, d2cs: d2eclist, d2e_scope: d2exp
) : d3exp // end of [d2exp_trdn_letwhere]
//
fun d2exp_trdn_xchng
  (loc0: loc_t, d2e: d2exp, s2f: s2hnf): d3exp
fun d2exp_trdn_xchng_deref
(
  loc0: loc_t, loc: loc_t, d2e: d2exp, d2ls: d2lablst, s2f: s2hnf
) : d3exp // end of [d2exp_trdn_xchng_deref]

fun s2addr_xchng_check
(
  loc0: loc_t, loc: loc_t(*right*)
, s2l: s2exp, d3ls: d3lablst, s2f: s2hnf, s2rt: &s2exp? >> s2exp
) : s2exp // end of [s2addr_xchng_check]

(* ****** ****** *)

fun s2addr_viewat_deref
  (loc0: loc_t, s2l: s2exp, d3ls: d3lablst): s2exp(*atview*)
// end of [s2addr_viewat_deref]

(* ****** ****** *)

fun
s2addr_exch_type
(
  loc0: location
, s2l: s2exp, d3ls: d3lablst, s2e_new: s2exp
) : s2exp(*old*) // end of [s2addr_exch_type]

fun s2addr_set_viewat
(
  loc0: loc_t
, s2l: s2exp, d3ls: d3lablst, s2at_new: s2exp
) : void // end of [s2addr_set_viewat]
fun s2addr_set_viewat_check
(
  loc0: loc_t
, s2l: s2exp, d3ls: d3lablst, s2at_new: s2exp
, s2e_old: s2exp, s2e_new: s2exp, s2l_new: s2exp
) : void // end of [s2addr_set_viewat_check]

(* ****** ****** *)

fun d3lval_set_type_err (
  refval: int, d3e: d3exp, s2e: s2exp, err: &int
) : void // end of [d3lval_set_type_err]

fun d3lval_set_pat_type_left
  (d3e0: d3exp, p3t: p3at): void // end of [fun]
fun d3lvalist_set_pat_type_left
  (d3es: d3explst, p3ts: p3atlst): void // end of [fun]

(* ****** ****** *)

fun d3lval_arg_set_type
  (refval: int, d3e0: d3exp, s2e: s2exp): int (*freeknd*)
// end of [d3lval_arg_set_type]

(* ****** ****** *)

fun d3exp_fun_restore (fc: funclo, d3e_fun: d3exp): d3exp

fun d3explst_arg_restore (
  d3es: d3explst, s2es_arg: s2explst, wths2es: wths2explst
) : d3explst // end of [d3explst_arg_restore]

(* ****** ****** *)

fun d2ecl_tr (d2c: d2ecl): d3ecl
fun d2eclist_tr (d2cs: d2eclist): d3eclist

(* ****** ****** *)

fun d2eclist_tr_errck (d2cs: d2eclist): d3eclist

(* ****** ****** *)

(* end of [pats_trans3.sats] *)
