(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: May, 2011
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_staexp2.sats"

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

fun s2cst_select_locs2explstlst
  (s2cs: s2cstlst, arg: List (locs2explst)): s2cstlst
// end of [s2cst_select_locs2explstlst]

(* ****** ****** *)

absviewtype
stasub_viewtype // for static substitution
viewtypedef stasub = stasub_viewtype

fun stasub_make_nil () : stasub
fun stasub_copy (sub: !stasub): stasub
fun stasub_free (sub: stasub): void

fun stasub_add
  (sub: &stasub, s2v: s2var, s2f: s2hnf): void
fun stasub_addlst
  (sub: &stasub, s2vs: s2varlst, s2fs: s2hnflst): int(*err*)
// end of [stasub_addlst]

fun stasub_find
  (sub: !stasub, s2v: s2var): Option_vt (s2exp)
// end of [stasub_find]

fun stasub_get_domain (sub: !stasub): List_vt (s2var)

(* ****** ****** *)

fun stasub_extend_svarlst
  (sub: &stasub, s2vs: s2varlst): s2varlst_vt
// end of [stasub_extend_svarlst]

(* ****** ****** *)

fun s2exp_subst (sub: !stasub, s2e: s2exp): s2exp

fun s2explst_subst (sub: !stasub, s2es: s2explst): s2explst
fun s2expopt_subst (sub: !stasub, os2e: s2expopt): s2expopt

fun s2explstlst_subst
  (sub: !stasub, s2ess: s2explstlst): s2explstlst
// end of [s2explstlst_subst]

(* ****** ****** *)

fun s2exp_alpha 
  (s2v: s2var, s2v_new: s2var, s2e: s2exp): s2exp
// end of [s2exp_alpha]

fun s2explst_alpha
  (s2v: s2var, s2v_new: s2var, s2es: s2explst): s2explst
// end of [s2explst_alpha]

(* ****** ****** *)

fun s2exp_freevars (s2e: s2exp): s2varset_vt

(* ****** ****** *)

fun s2exp_linkrem (s2e: s2exp): s2exp

(* ****** ****** *)

fun s2exp_hnfize (s2e: s2exp): s2hnf

fun s2explst_hnfize (s2es: s2explst): s2hnflst
fun s2expopt_hnfize (os2e: s2expopt): s2hnfopt

fun s2explstlst_hnfize (s2ess: s2explstlst): s2hnflstlst

(* ****** ****** *)

fun s2exp_syneq (s2e1: s2exp, s2e2: s2exp): bool
fun s2hnf_syneq (s2f1: s2hnf, s2f2: s2hnf): bool

(* ****** ****** *)

(* end of [pats_staexp2_util.sats] *)
