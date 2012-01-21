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
  (sub: &stasub, s2v: s2var, s2f: s2exp): void
fun stasub_addlst
  (sub: &stasub, s2vs: s2varlst, s2fs: s2explst): int(*err*)
// end of [stasub_addlst]

fun stasub_find
  (sub: !stasub, s2v: s2var): Option_vt (s2exp)
// end of [stasub_find]

(*
fun stasub_get_domain (sub: !stasub): List_vt (s2var)
*)

fun stasub_occurcheck (sub: !stasub, s2V: s2Var): bool

(* ****** ****** *)

fun stasub_extend_svarlst
  (sub: &stasub, s2vs: s2varlst): s2varlst_vt
// end of [stasub_extend_svarlst]

(* ****** ****** *)
//
fun s2exp_subst (sub: !stasub, s2e: s2exp): s2exp
//
fun s2explst_subst (sub: !stasub, s2es: s2explst): s2explst
fun s2explst_subst_vt (sub: !stasub, s2es: s2explst): s2explst_vt
//
fun s2expopt_subst (sub: !stasub, os2e: s2expopt): s2expopt
//
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
//
fun s2exp_hnfize (x: SHARED(s2exp)): s2exp
//
fun s2explst_hnfize (xs: SHARED(s2explst)): s2explst
fun s2expopt_hnfize (opt: SHARED(s2expopt)): s2expopt
fun s2explstlst_hnfize (xss: SHARED(s2explstlst)): s2explstlst
//
(* ****** ****** *)

fun s2exp2hnf (x: SHARED(s2exp)): s2hnf // = s2exp_hnfize
fun s2hnf2exp (x: SHARED(s2hnf)): s2exp // HX: a cast function

(* ****** ****** *)

fun s2hnf_syneq (s2f1: s2hnf, s2f2: s2hnf): bool
fun s2exp_syneq (s2e1: s2exp, s2e2: s2exp): bool
fun s2explst_syneq (xs1: s2explst, xs2: s2explst): bool

(* ****** ****** *)

fun s2kexp_ismat (x1: s2kexp, x2: s2kexp): bool
fun s2kexplst_ismat (xs1: s2kexplst, xs2: s2kexplst): bool

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

(* end of [pats_staexp2_util.sats] *)
