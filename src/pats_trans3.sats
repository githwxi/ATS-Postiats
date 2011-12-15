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

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

//
// HX-2011-05:
// the list of possible errors that may occur
// during the level-2 translation
//
datatype trans3err =
  | T3E_intsp of (d2exp)
  | T3E_floatsp of (d2exp)
  | T3E_p2at_trdn_ann of (p2at, s2hnf)
  | T3E_d2exp_trup_laminit_fc of (d2exp, funclo)
  | T3E_d2exp_trup_con_npf of (d2exp, int(*npf*))
  | T3E_d3exp_trdn of (d3exp, s2hnf)
  | T3E_d23explst_trdn_arity of (location, int(*-1/1*))
  | T3E_d23exp_trup_app23_npf of (location(*fun*), int(*npf*))
  | T3E_fundeclst_tr_metsrts of (d2ecl, s2rtlstopt)
// end of [trans3err]

fun the_trans3errlst_add (x: trans3err): void
fun the_trans3errlst_finalize (): void // cleanup all the errors

(* ****** ****** *)

fun p2at_syn_type (p2t: p2at): s2hnf
fun p2atlst_syn_type (p2ts: p2atlst): s2hnflst

(* ****** ****** *)
//
fun p2at_trup_arg (p2t: p2at): p3at
fun p2atlst_trup_arg
  (npf: int, p2ts: p2atlst): p3atlst
fun p2at_trdn_arg (p2t: p2at, s2f: s2hnf): p3at
//
fun p2at_trdn (p2t: p2at, s2f: s2hnf): p3at
//
(* ****** ****** *)

fun d2exp_funclo_of_d2exp
  (d2e0: d2exp, fc0: &funclo): d2exp
// end of [d2exp_funclo_of_d2exp]

fun d2exp_s2eff_of_d2exp
  (d2e0: d2exp, s2fe0: &s2eff) : d2exp
// end of [d2exp_s2eff_of_d2exp]

(* ****** ****** *)

fun d2exp_is_varlamcst (d2e: d2exp): bool

dataviewtype d23exp =
  | D23Ed2exp of d2exp | D23Ed3exp of d3exp
viewtypedef d23explst = List_vt (d23exp)

fun d23exp_free (x: d23exp): void
fun d23explst_free (xs: d23explst): void

fun d3exp_trdn (d3e: d3exp, s2f: s2hnf): d3exp

(* ****** ****** *)

fun d2exp_trup_i0nt (
  d2e0: d2exp, base: int, rep: string, sfx: uint
) : d3exp // end of [d2exp_trup_int]
fun d2exp_trup_bool (d2e0: d2exp, b: bool): d3exp
fun d2exp_trup_char (d2e0: d2exp, c: char): d3exp
fun d2exp_trup_string (d2e0: d2exp, str: string): d3exp
fun d2exp_trup_f0loat
  (d2e0: d2exp, rep: string, sfx: uint): d3exp
// end of [d2exp_trup_float]

(* ****** ****** *)

fun d2exp_trup (d2e: d2exp): d3exp
fun d2explst_trup (d2es: d2explst): d3explst
fun d2explstlst_trup (d2ess: d2explstlst): d3explstlst

fun d2exp_trdn (d2e: d2exp, s2f: s2hnf): d3exp
fun d2exp_trdn_rest (d2e: d2exp, s2f: s2hnf): d3exp

(* ****** ****** *)

fun d2ecl_tr (d2c: d2ecl): d3ecl
fun d2eclist_tr (d2cs: d2eclist): d3eclist

(* ****** ****** *)

fun d2eclist_tr_errck (d2cs: d2eclist): d3eclist

(* ****** ****** *)

(* end of [pats_trans3.sats] *)
