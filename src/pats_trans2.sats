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
//
staload
SYN = "./pats_syntax.sats"
//
typedef s0rtq = $SYN.s0rtq
typedef sqi0de = $SYN.sqi0de
//
(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_dynexp1.sats"
staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)
//
// HX-2011-05:
// the list of possible errors that may occur
// during the level-2 translation
//
datatype trans2err =
//
  | T2E_s1rt_tr of (s1rt)
  | T2E_s2var_check_tmplev of (s2var)
  | T2E_effvar_tr of (effvar)
  | T2E_s1exp_trup of (s1exp)
  | T2E_s1exp_trup_app of (s1exp)
  | T2E_s1exp_trdn of (s1exp, s2rt)
  | T2E_s1exp_trdn_impred of (s1exp)
  | T2E_s2exp_trdn of (location, s2exp, s2rt)
//
  | T2E_S1Ed2ctype_tr of S1Ed2ctype
//
  | T2E_s1arg_trdn of (s1arg, s2rt)
  | T2E_s1marg_trdn of (s1marg, s2rtlst)
//
  | T2E_sp1at_trdn of (sp1at, s2rt)
  | T2E_sc2laulst_coverck_sort of (location, s2rt)
  | T2E_sc2laulst_coverck_sort of (location, s2rt)
  | T2E_sc2laulst_coverck_repeat of (location, sc2lau)
  | T2E_sc2laulst_coverck_missing of (location, s2cst)
//
  | T2E_q1marg_tr_dec of (q1marg)
//
  | T2E_s1rtext_tr of (s1rtext)
  | T2E_s1expdef_tr of (s1expdef)
//
  | T2E_s1aspdec_tr of (s1aspdec)
  | T2E_s1aspdec_tr_arg of (s1aspdec, s1marg)
  | T2E_s1aspdec_tr_res of (s1aspdec, s2rt, s2rt)
//
  | T2E_re1assume_tr of (sqi0de(*s2cst*))
//
  | T2E_d1atcon_tr of (d1atcon)
  | T2E_d1atdec_tr of (d1atdec)
//
  | T2E_macdef_check of (location, d2mac)
  | T2E_macvar_check of (location, d2var)
//
  | T2E_p1at_tr of (p1at)
  | T2E_d1exp_tr of (d1exp)
  | T2E_d1exp_tr_ann of (d1exp, s2exp)
  | T2E_i1nvarg_tr of (i1nvarg)
  | T2E_c1lau_tr of (c1lau)
//
  | T2E_f1undec_tr of (f1undec)
//
  | T2E_d1cstdec_tr of (d1cstdec)
//
  | T2E_prv1ardec_tr of (v1ardec)
//
  | T2E_d1ecl_tr_impdec of (d1ecl)
  | T2E_d1ecl_tr_impdec_nontop of (d1ecl)
  | T2E_d1ecl_tr_impdec_tmparg of (d1ecl)
//
  | T2E_d1ecl_tr_overload of (d1ecl)
  | T2E_d1ecl_tr_overload_def of (location)
  | T2E_d1ecl_tr_staloadnm of (d1ecl)
//
// end of [trans2err]

fun the_trans2errlst_add (x: trans2err): void
fun the_trans2errlst_finalize (): void // cleanup all the errors

(* ****** ****** *)

fun s1rt_tr (s1t: s1rt): s2rt
fun s1rtlst_tr (s1ts: s1rtlst): s2rtlst
fun s1rtopt_tr (s1topt: s1rtopt): s2rtopt

(* ****** ****** *)

fun a1srt_tr_srt (x: a1srt): s2rt
fun a1msrt_tr_srt (x: a1msrt): s2rtlst

fun a1srt_tr_symsrt (x: a1srt): syms2rt
fun a1msrt_tr_symsrt (x: a1msrt): syms2rtlst

(* ****** ****** *)

fun effcst_tr (efc: effcst): s2eff

(* ****** ****** *)

fun s1arg_trup (s1a: s1arg): s2var
fun s1arglst_trup (s1as: s1arglst): s2varlst

fun s1arg_trdn (s1a: s1arg, s2t: s2rt): s2var
fun s1arglst_trdn_err
  (s1as: s1arglst, s2ts: s2rtlst, err: &int): s2varlst
// end of [s1arglst_trdn_err]

fun s1marg_trdn (s1ma: s1marg, s2ts: s2rtlst): s2varlst

(* ****** ****** *)

fun s1vararg_tr (s1a: s1vararg): s2vararg

(* ****** ****** *)

fun sp1at_trdn (sp1t: sp1at, s2t: s2rt): sp2at

fun sc2laulst_coverck
  (loc0: location, xs: sc2laulst, s2t: s2rt): void
// end of [sc2laulst_coverck]

(* ****** ****** *)

fun s1exp_trup (s1e: s1exp): s2exp
fun s1exp_trup_hnfize (s1e: s1exp): s2exp

fun s1explst_trup (s1es: s1explst): s2explst
fun s1explst_trup_hnfize (s1es: s1explst): s2explst

fun s1expopt_trup (s1es: s1expopt): s2expopt

fun s2exp_trdn (
  loc: location, s2e: s2exp, s2t: s2rt
) : s2exp // end of [s2exp_trdn]
fun s1exp_trdn (s1e: s1exp, s2t: s2rt): s2exp

fun s1exp_trdn_int (s1e: s1exp): s2exp
fun s1exp_trdn_addr (s1e: s1exp): s2exp
fun s1exp_trdn_bool (s1e: s1exp): s2exp
fun s1exp_trdn_t0ype (s1e: s1exp): s2exp
fun s1exp_trdn_vt0ype (s1e: s1exp): s2exp
fun s1exp_trdn_impred (s1e: s1exp): s2exp

fun s1explst_trdn_int (s1es: s1explst): s2explst
fun s1explst_trdn_addr (s1es: s1explst): s2explst
fun s1explst_trdn_bool (s1es: s1explst): s2explst
fun s1explst_trdn_vt0ype (s1es: s1explst): s2explst
fun s1explst_trdn_impred (s1es: s1explst): s2explst

fun s1explst_trdn_err
  (s1es: s1explst, s2ts: s2rtlst, err: &int): s2explst
// end of [s1explst_trdn_err]

(* ****** ****** *)

fun s1exp_trup_arg
  (s1e: s1exp, wths1es: &wths1explst): s2exp
fun s1exp_trdn_arg_impred
  (s1e: s1exp, wths1es: &wths1explst): s2exp
fun s1exp_trdn_res_impred
  (s1e: s1exp, wths1es: (wths1explst)): s2exp

(* ****** ****** *)

fun witht1ype_tr (wty: witht1ype): s2expopt

(* ****** ****** *)
//
fun S1Ed2ctype_tr (d2ctp: S1Ed2ctype): s2exp // HX: $d2ctype(...)
//
(* ****** ****** *)
//
// HX: arg/res type translation
//
fun s1exp_tr_arg_up (s1e: s1exp, w1ts: &wths1explst): s2exp
fun s1exp_trdn_arg_impredicative (s1e: s1exp, w1ts: &wths1explst): s2exp
fun s1exp_trdn_res_impredicative (s1e: s1exp, w1ts:  wths1explst): s2exp

(* ****** ****** *)

fun s1rtext_tr (s1te: s1rtext): s2rtext
fun s1qualst_tr (s1qs: s1qualst): s2qua

(* ****** ****** *)

fun q1marg_tr (q1ma: q1marg): s2qua // HX: loc is discarded
(*
** HX: [q1marg_tr_dec] for (template) decarg
*)
fun q1marg_tr_dec (q1ma: q1marg): s2qua // HX: [s2ps] must be nil

(* ****** ****** *)

fun s1exparg_tr (s1a: s1exparg): s2exparg
fun s1exparglst_tr (s1as: s1exparglst): s2exparglst

(* ****** ****** *)

fun stasub_extend_sarglst_svarlst (
  sub: &stasub, s1as: s1arglst, s2vs: s2varlst, serr: &int
) : s2varlst_vt // end of [fun]

(* ****** ****** *)

fun s1vararg_bind_svarlst (
  s1v: s1vararg, s2vs: s2varlst, serr: &int
) : (stasub, s2varlst_vt) // end of [fun]

(*
fun s1marg_bind_svarlst (
  s1ma: s1marg, s2vs: s2varlst, sub: stasub
) : (stasub, s2varlst) // end of [s1marg_bind_svarlst]
fun t1mpmarg_bind_svarlst (
  t1ma: t1mpmarg, s2vs: s2varlst, sub: stasub
) : (stasub, s2explst) // end of [t1mpmarg_bind_svarlst]
*)

(* ****** ****** *)

fun t1mpmarg_tr (t1ma: t1mpmarg): t2mpmarg
fun t1mpmarglst_tr (t1mas: t1mpmarglst): t2mpmarglst

(* ****** ****** *)

fun d1atcon_tr (
   s2c: s2cst
, islin: bool
, isprf: bool
, s2vss0: s2varlstlst
, fil: filename
, d1c: d1atcon
) : d2con // end of [d1atcon_tr]

(* ****** ****** *)

fun p1at_tr (p1t: p1at): p2at
fun p1atlst_tr (p1ts: p1atlst): p2atlst

fun labp1at_tr (lp1t: labp1at): labp2at

fun p1at_tr_arg (p1t: p1at, w1ts: &wths1explst): p2at
fun p1atlst_tr_arg (p1ts: p1atlst, w1ts: &wths1explst): p2atlst

(* ****** ****** *)
//
// HX: used in [pats_trans3_env]
//
fun d2con_instantiate
  (loc: location, d2c: d2con): @(s2qualst, s2exp)
// end of [d2con_instantiate]

(* ****** ****** *)

fun d1exp_tr (d1e: d1exp): d2exp
fun d1explst_tr (d1es: d1explst): d2explst
fun d1expopt_tr (d1es: d1expopt): d2expopt

(* ****** ****** *)

fun labd1exp_tr (ld1e: labd1exp): labd2exp

(* ****** ****** *)

fun d1lab_tr (d1l: d1lab): d2lab
fun d1lablst_tr (d1ls: d1lablst): d2lablst

(* ****** ****** *)

fun i1mpdec_tr (d1c: d1ecl): Option_vt (i2mpdec)

(* ****** ****** *)

fun d1ecl_tr (d1c: d1ecl): d2ecl
fun d1eclist_tr (d1cs: d1eclist): d2eclist

(* ****** ****** *)

fun d1eclist_tr_errck (d1cs: d1eclist): d2eclist

(* ****** ****** *)

(* end of [pats_trans2.sats] *)
