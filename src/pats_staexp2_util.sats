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
// Start Time: May, 2011
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
EFF = "./pats_effect.sats"
typedef effect = $EFF.effect
typedef effset = $EFF.effset

(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_staexp2.sats"

(* ****** ****** *)

fun s2rt_linearize (s2t: s2rt): s2rt

(* ****** ****** *)

fun s2rt_prf_lin_fc
  (loc0: location, isprf: bool, islin: bool, fc: funclo): s2rt
// end of [s2rt_prf_lin_fc]

(* ****** ****** *)

fun s2rt_npf_lin_prf_boxed
  (npf: int, lin: int, prgm: int, boxed: int): s2rt
// end of [s2rt_npf_lin_prg_boxed]

fun s2rt_npf_lin_prf_prgm_boxed_labs2explst (
  npf: int, lin: int, prf: int, prgm: int, boxed: int, ls2es: labs2explst
) : s2rt // end of [s2rt_npf_lin_prf_prgm_boxed_labs2explst]

(* ****** ****** *)
//
fun
s2cst_select_locs2explstlst
  (s2cs: s2cstlst, arg: List (locs2explst)): s2cstlst
// end of [s2cst_select_locs2explstlst]
//
(* ****** ****** *)
//
fun s2exp_is_nonvar (s2e: s2exp):<> bool
fun s2exp_is_wthtype (s2e: s2exp):<> bool
fun s2exp_is_without (s2e: s2exp):<> bool
//
// HX-2012-05: this one does more elaborate checking
//
fun s2exp_is_lin2 (x: s2exp): bool // compared to [s2exp_is_lin]
//
(* ****** ****** *)

fun s2hnf_get_head (s2f: s2hnf): s2hnf // the head in HNF
fun s2hnf_is_abscon (s2f: s2hnf): bool // is abstract or datatype

(* ****** ****** *)
//
fun s2eff_add_set (s2fe: s2eff, eff: effset): s2eff
//
fun s2eff_contain_set (s2fe: s2eff, efs: effset): bool
fun s2eff_contain_exp (s2fe: s2eff, s2e: s2exp): bool
fun s2eff_contain_s2eff (s2fe1: s2eff, s2fe2: s2eff): bool
//
(* ****** ****** *)

absvtype
stasub_vtype // for static subst
vtypedef stasub = stasub_vtype

(* ****** ****** *)
//
fun
stasub_make_nil ((*void*)) : stasub
//
fun stasub_free (sub: stasub): void
fun stasub_copy (sub: !stasub): stasub
//
(* ****** ****** *)

fun
fprint_stasub (out: FILEref, sub: !stasub): void

(* ****** ****** *)

fun stasub_add
  (sub: &stasub, s2v: s2var, s2f: s2exp): void
fun stasub_addlst
  (sub: &stasub, s2vs: s2varlst, s2fs: s2explst): int(*err*)
// end of [stasub_addlst]

(* ****** ****** *)

fun stasub_find
  (sub: !stasub, s2v: s2var): Option_vt (s2exp)
// end of [stasub_find]

(* ****** ****** *)
//
(*
fun stasub_get_domain (sub: !stasub): List_vt (s2var)
*)
//
fun
stasub_occurcheck (sub: !stasub, s2V: s2Var): bool
//
(* ****** ****** *)

fun
stasub_extend_svarlst
  (sub: &stasub, s2vs: s2varlst): s2varlst_vt
// end of [stasub_extend_svarlst]

(* ****** ****** *)
//
fun s2exp_subst (sub: !stasub, s2e: s2exp): s2exp
//
fun s2explst_subst (sub: !stasub, s2es: s2explst): s2explst
fun s2explst_subst_vt (sub: !stasub, s2es: s2explst): s2explst_vt
//
fun s2explstlst_subst (sub: !stasub, s2ess: s2explstlst): s2explstlst
//
fun s2expopt_subst (sub: !stasub, os2e: s2expopt): s2expopt
//
(* ****** ****** *)
//
fun
s2exp_subst_flag
  (sub: !stasub, s2e: s2exp, flag: &int): s2exp
// end of [s2exp_subst_flag]
//
fun
s2explst_subst_flag
  (sub: !stasub, s2es: s2explst, flag: &int): s2explst
// end of [s2explst_subst_flag]
//
(* ****** ****** *)

fun
s2zexp_subst_flag
  (sub: !stasub, s2ze: s2zexp, flag: &int): s2zexp
// end of [s2zexp_subst_flag]

(* ****** ****** *)

fun s2exp_alpha 
  (s2v: s2var, s2v_new: s2var, s2e: s2exp): s2exp
// end of [s2exp_alpha]

fun s2explst_alpha
  (s2v: s2var, s2v_new: s2var, s2es: s2explst): s2explst
// end of [s2explst_alpha]

(* ****** ****** *)
//
fun s2ctxt_hrepl
  (ctxt: s2ctxt, repl: s2exp): s2exp
fun s2ctxtopt_hrepl
  (ctxtopt: s2ctxtopt, repl: s2exp): s2expopt
//
fun s2exp_hrepl (s2e: s2exp, repl: s2exp): s2exp
//
(* ****** ****** *)

fun s2exp_linkrem (s2e: s2exp): s2exp

(* ****** ****** *)
//
fun s2exp_topize_0 (s2e: s2exp): s2exp
and s2exp_topize_1 (s2e: s2exp): s2exp
fun s2exp_topize (knd: int, s2e: s2exp): s2exp
//
(* ****** ****** *)
//
fun s2exp_hnfize (x: SHARED(s2exp)): s2exp
fun s2explst_hnfize (xs: SHARED(s2explst)): s2explst
fun s2expopt_hnfize (opt: SHARED(s2expopt)): s2expopt
fun s2explstlst_hnfize (xss: SHARED(s2explstlst)): s2explstlst
//
// HX: this one is implemented in [pats_trans3_env.sats]
//
fun s2exp_hnfize_flag_svar (s2e0: s2exp, s2v: s2var, flag: &int): s2exp
//
(* ****** ****** *)
//
// HX-2013-06: applying [hnfize] recursively
//
fun s2exp_mhnfize (x: SHARED(s2exp)): s2exp
fun s2explst_mhnfize (x: SHARED(s2explst)): s2explst
fun s2explstlst_mhnfize (x: SHARED(s2explstlst)): s2explstlst

(* ****** ****** *)
//
fun s2exp2hnf (x: SHARED(s2exp)): s2hnf // = s2exp_hnfize
fun s2exp2hnf_cast (x: SHARED(s2exp)): s2hnf // HX: a cast function
//
fun s2hnf2exp (x: SHARED(s2hnf)): s2exp // HX: a cast function
//
(* ****** ****** *)

fun s2hnf_syneq (s2f1: s2hnf, s2f2: s2hnf): bool
fun s2exp_syneq (s2e1: s2exp, s2e2: s2exp): bool
fun s2explst_syneq (xs1: s2explst, xs2: s2explst): bool

(* ****** ****** *)
//
// HX-2015-03:
// this version handles bound variables:
//
fun
s2hnf_syneq2 (s2f1: s2hnf, s2f2: s2hnf): bool
fun
s2exp_syneq2 (s2e1: s2exp, s2e2: s2exp): bool
fun
s2explst_syneq2 (xs1: s2explst, xs2: s2explst): bool
//
fun
s2var_syneq_env
(
  env1: !s2varlst_vt
, env2: !s2varlst_vt
, s2v1: s2var, s2v2: s2var
) : bool // end of [s2var_syneq_env]
//
fun
s2hnf_syneq_env
(
  env1: !s2varlst_vt
, env2: !s2varlst_vt
, s2f1: s2hnf, s2f2: s2hnf
) : bool // end of [s2hnf_syneq_env]
//
fun
s2exp_syneq_env
(
  env1: !s2varlst_vt
, env2: !s2varlst_vt
, s2e1: s2exp, s2e2: s2exp
) : bool // end of [s2exp_syneq_env]
//
fun
s2explst_syneq_env
(
  env1: !s2varlst_vt
, env2: !s2varlst_vt
, s2es1: s2explst, s2es2: s2explst
) : bool // end of [s2explst_syneq_env]
//
fun
s2explstlst_syneq_env
(
  env1: !s2varlst_vt
, env2: !s2varlst_vt
, s2ess1: s2explstlst, s2ess2: s2explstlst
) : bool // end of [s2explstlst_syneq_env]
//
(* ****** ****** *)

fun s2hnf_tszeq
  (s2f1: s2hnf, s2f2: s2hnf): bool // type-size-equality-test
fun s2exp_tszeq
  (s2e1: s2exp, s2e2: s2exp): bool // type-size-equality-test
fun s2explst_tszeq
  (s2es1: s2explst, s2es2: s2explst): bool // type-size-equality-test

(* ****** ****** *)

fun s2kexp_ismat (x1: s2kexp, x2: s2kexp): bool
fun s2kexplst_ismat (xs1: s2kexplst, xs2: s2kexplst): bool

(* ****** ****** *)

fun s2zexp_syneq (x1: s2zexp, x2: s2zexp): bool
fun s2zexp_merge (x1: s2zexp, x2: s2zexp): s2zexp

(* ****** ****** *)
//
// HX: implemented in [pats_staexp2_util2.dats]
//
fun s2exp_absuni (s2e: s2exp): @(s2exp, s2varlst_vt, s2explst_vt)
//
fun s2exp_opnexi (s2e: s2exp): @(s2exp, s2varlst_vt, s2explst_vt)
fun s2explst_opnexi (s2es: s2explst): @(s2explst, s2varlst_vt, s2explst_vt)
//
(* ****** ****** *)

fun s2exp_freevars (s2e: s2exp): s2varset_vt

(* ****** ****** *)

fun
s2Var_occurcheck_s2exp
  (s2V0: s2Var, s2e: s2exp) : (int, s2cstlst, s2varlst, s2Varlst)
// end of [s2Var_occurcheck_s2exp]

(* ****** ****** *)

fun s2exp_isbot (s2e: s2exp): bool
fun s2exp_fun_isbot (s2e: s2exp): bool

(* ****** ****** *)

(* end of [pats_staexp2_util.sats] *)
