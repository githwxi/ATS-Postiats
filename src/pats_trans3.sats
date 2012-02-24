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
// Start Time: October, 2011
//
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
//
  | T3E_intsp of (location, string(*rep*))
  | T3E_floatsp of (location, string(*rep*))
//
  | T3E_s2varlst_instantiate_napp of (location(*arg*), int(*-1/1*))
  | T3E_s2varlst_instantiate_arity of (location(*arg*), int(*-1/1*))
  | T3E_s2varlst_instantiate_srtck of (location(*arg*), s2rt(*s2v*), s2rt(*s2e*))
//
  | T3E_s2exp_uni_instantiate_sexparglst of (location, s2exp, s2exparglst)
//
  | T3E_p2at_trdn of (p2at, s2exp)
  | T3E_p2at_trup_con of p2at // pfarity // ill-typed
  | T3E_p2at_trdn_con_arity of (p2at, int(*serr*))
//
  | T3E_d2exp_trup_item of (location, d2itm)
//
  | T3E_d2exp_trup_con_npf of (d2exp, int(*npf*))
  | T3E_d2exp_trup_laminit_funclo of (d2exp, funclo)
//
  | T3E_d3exp_trdn of (d3exp, s2exp)
  | T3E_d23explst_trdn_arity of (location, int(*serr*))
  | T3E_d23exp_trup_app23_npf of (location(*fun*), int(*npf*))
//
  | T3E_d2exp_trup_applst_sym_nil of (d2exp, d2sym) // found none
  | T3E_d2exp_trup_applst_sym_cons2 of (d2exp, d2sym) // found too many
//
  | T3E_d2exp_trdn_lam_dyn of (d2exp, s2exp)
//
  | T3E_guard_trdn of
      (location, bool(*gval*), s2exp(*gtyp*))
  | T3E_c2lau_trdn_arity of (c2lau, s2explst)
  | T3E_c2laulst0_trdn_noclause of (location)
  | T3E_c2laulst2_trdn_redundant of (location, c2lau)
//
  | T3E_f2undeclst_tr_termetsrtck of (f2undec, s2rtlstopt)
  | T3E_v2aldecreclst_tr_linearity of (v2aldec, s2exp(*linear*))
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
fun p2at_trdn_arg (p2t: p2at, s2e: s2exp): p3at
fun p2atlst_trdn_arg {n:nat} (
  loc: location, npf: int
, p2ts: p2atlst, s2es: list (s2exp, n), serr: &int
) : list (p3at, n) // end of [p2atlst_trdn_arg]
//
fun p2at_trdn (p2t: p2at, s2e: s2exp): p3at
fun p2at_trdn_con (p2t: p2at, s2f: s2hnf): p3at
fun p2atlst_trdn {n:nat} (
  loc: location
, p2ts: p2atlst, s2es: list (s2exp, n), serr: &int
) : list (p3at, n) // end of [p2atlst_trdn]
//
fun guard_trdn
  (loc: location, gval: bool, gtyp: s2exp): void
// end of [guard_trdn]
//
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

dataviewtype d23exp =
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
fun intrep_syn_type
  (loc0: location, rep: string): s2exp // g0int
fun intrep_syn_type_ind
  (loc0: location, rep: string): s2exp // g1int
fun d2exp_trup_intrep (d2e0: d2exp, rep: string): d3exp
//
fun d2exp_trup_bool (d2e0: d2exp, b: bool): d3exp
fun d2exp_trup_char (d2e0: d2exp, c: char): d3exp
fun d2exp_trup_string (d2e0: d2exp, str: string): d3exp
//
fun float_syn_type
  (loc0: location, rep: string): s2exp
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

fun d2exp_trup_var (loc: location, d2v: d2var): d3exp
fun d2exp_trup_cst (loc: location, d2c: d2cst): d3exp

(* ****** ****** *)

fun d2exp_trup_applst
  (d2e0: d2exp, _fun: d2exp, _arg: d2exparglst): d3exp
// end of [d2exp_trup_applst]
fun d2exp_trup_applst_sym
  (d2e0: d2exp, _fun: d2sym, _arg: d2exparglst): d3exp
// end of [d2exp_trup_applst_sym]

fun d23exp_trup_applst
  (d2e0: d2exp, _fun: d3exp, _arg: d2exparglst): d3exp
// end of [d23exp_trup_applst]

(* ****** ****** *)

fun d2exp_trup_loopexn (d2e0: d2exp, knd: int): d3exp

(* ****** ****** *)

fun d2exp_trup (d2e: d2exp): d3exp
fun d2explst_trup (d2es: d2explst): d3explst
fun d2explstlst_trup (d2ess: d2explstlst): d3explstlst

fun d2exp_trdn (d2e: d2exp, s2e: s2exp): d3exp
fun d2explst_trdn_elt (d2es: d2explst, s2e: s2exp): d3explst

(* ****** ****** *)

fun d2exp_trdn_rest (d2e: d2exp, s2f: s2hnf): d3exp
fun d2exp_trdn_ifhead (d2e: d2exp, s2f: s2hnf): d3exp
fun d2exp_trdn_casehead (d2e: d2exp, s2f: s2hnf): d3exp
fun d2exp_trdn_lam_dyn (d2e: d2exp, s2f: s2hnf): d3exp

(* ****** ****** *)

fun d2ecl_tr (d2c: d2ecl): d3ecl
fun d2eclist_tr (d2cs: d2eclist): d3eclist

(* ****** ****** *)

fun d2eclist_tr_errck (d2cs: d2eclist): d3eclist

(* ****** ****** *)

(* end of [pats_trans3.sats] *)
