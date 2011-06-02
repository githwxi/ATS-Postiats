(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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

abstype
stasub_type // for static substitution
typedef stasub = stasub_type

fun stasub_make_nil () : stasub

fun stasub_add
  (sub: stasub, s2v: s2var, s2e: s2exp): stasub
fun stasub_addlst
  (sub: stasub, s2vs: s2varlst, s2es: s2explst): stasub

fun stasub_get_domain (_: stasub): s2varlst

fun stasub_extend_svarlst
  (sub: stasub, s2vs: s2varlst): @(stasub, s2varlst)
fun stasub_extend_sarglst_svarlst
  (sub: stasub, s1as: s1arglst, s2vs: s2varlst): @(stasub, s2varlst)

fun s2exp_subst (sub: stasub, s2e: s2exp): s2exp
fun s2explst_subst (sub: stasub, s2es: s2explst): s2explst
fun s2expopt_subst (sub: stasub, os2e: s2expopt): s2expopt

fun s2explstlst_subst (sub: stasub, s2ess: s2explstlst): s2explstlst

(* ****** ****** *)

fun s2exp_alpha 
  (s2v: s2var, s2v_new: s2var, s2e: s2exp): s2exp
// end of [s2exp_alpha]

fun s2explst_alpha
  (s2v: s2var, s2v_new: s2var, s2es: s2explst): s2explst
// end of [s2explst_alpha]

(* ****** ****** *)

(* end of [pats_staexp2_util.sats] *)
