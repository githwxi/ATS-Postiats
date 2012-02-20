
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: February, 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload
TRENV3 = "pats_trans3_env.sats"
typedef h3ypo = $TRENV3.h3ypo
typedef c3nstr = $TRENV3.c3nstr

(* ****** ****** *)

datatype
s3exp =
  | S3Evar of s2var
  | S3Ecst of s2cst // abstract constant
  | S3Eapp of (s3exp, s3explst)
  | S3Eexp of s2exp
//
  | S3Enull of () (* the null address *)
  | S3Epadd of (s3exp, s3exp) // ptr arith
//
  | S3Ebool of bool (* boolean constant *)
  | S3Ebneg of s3exp
  | S3Ebadd of (s3exp, s3exp)
  | S3Ebmul of (s3exp, s3exp)
  | S3Ebeq of (s3exp, s3exp)
  | S3Ebneq of (s3exp, s3exp)
  | S3Ebineq of (int(*knd*), s3exp)
//
  | S3Eint of intinf
  | S3Eiatm of s2varmset (* mononomial term *)
  | S3Eicff of (intinf, s3exp) // HX: coefficient
  | S3Eiadd of (s3exp, s3exp)
  | S3Eisub of (s3exp, s3exp)
  | S3Eimul of (s3exp, s3exp)
  | S3Epdiff of (s3exp, s3exp)
//
  | S3Eerr of ()
// end of [s3exp]

where s3explst = List (s3exp)
//
viewtypedef s3explst_vt = List_vt (s3exp)
//
(* ****** ****** *)
//
fun fprint_s3exp
  : fprint_type (s3exp)
fun print_s3exp (s3ae: s3exp): void
fun prerr_s3exp (s3ae: s3exp): void
//
fun fprint_s3explst
  : fprint_type (s3explst)
fun print_s3explst (s3es: s3explst): void
fun prerr_s3explst (s3es: s3explst): void
//
(* ****** ****** *)

fun s3exp_var (s2v: s2var): s3exp
fun s3exp_cst (s2c: s2cst): s3exp

fun s3exp_err ((* void *)): s3exp

(* ****** ****** *)

val s3exp_null : s3exp
fun s3exp_psucc (s3e: s3exp): s3exp
fun s3exp_ppred (s3e: s3exp): s3exp
fun s3exp_padd (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_psub (s3e1: s3exp, s3e2: s3exp): s3exp

(* ****** ****** *)

val s3exp_true: s3exp and s3exp_false: s3exp

fun s3exp_bneg (s3e: s3exp): s3exp
fun s3exp_beq (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_bneq (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_badd (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_bmul (s3e1: s3exp, s3e2: s3exp): s3exp

fun s3exp_ilt (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_ilte (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_igt (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_igte (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_ieq (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_ineq (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_bineq (knd: int, s3e: s3exp): s3exp

fun s3exp_plt (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_plte (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_pgt (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_pgte (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_peq (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_pneq (s3e1: s3exp, s3e2: s3exp): s3exp

(* ****** ****** *)

val intinf_0 : intinf
val intinf_1 : intinf
val intinf_neg_1 : intinf

val s3exp_0 : s3exp
val s3exp_1 : s3exp
val s3exp_neg_1 : s3exp

fun s3exp_int (i: int): s3exp
fun s3exp_intinf (i: intinf): s3exp
fun s3exp_var (s2v: s2var): s3exp
fun s3exp_cst (s2c: s2cst): s3exp

fun s3exp_icff (c: intinf, s3e: s3exp): s3exp

fun s3exp_ineg (s3e: s3exp): s3exp
fun s3exp_isucc (s3e: s3exp): s3exp
fun s3exp_ipred (s3e: s3exp): s3exp

fun s3exp_iadd (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_isub (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_imul (s3e1: s3exp, s3e2: s3exp): s3exp

fun s3exp_pdiff (s3e1: s3exp, s3e2: s3exp): s3exp

(* ****** ****** *)

fun s3exp_syneq (x1: s3exp, x2: s3exp): bool
fun s3explst_syneq (xs1: s3explst, xs2: s3explst): bool

(* ****** ****** *)

absviewtype s2vbcfenv_viewtype
viewtypedef s2vbcfenv = s2vbcfenv_viewtype

fun s2vbcfenv_nil (): s2vbcfenv
fun s2vbcfenv_free (env: s2vbcfenv): void

absview s2vbcfenv_push_v
fun s2vbcfenv_pop
  (pf: s2vbcfenv_push_v | env: &s2vbcfenv): void
fun s2vbcfenv_push (env: &s2vbcfenv): (s2vbcfenv_push_v | void)

fun s2vbcfenv_find (
  env: &s2vbcfenv, s2c: s2cst, arg: s3explst
) : Option_vt (s2var) // end of [s2vbcfenv_find]

fun s2vbcfenv_extract
  (env: !s2vbcfenv): (s2varlst_vt, s3explst_vt, s2cstset_vt)
// end of [s2vbcfenv_extract]

(*
// HX: for handling a special static function
*)
fun
s2vbcfenv_add (
  env: &s2vbcfenv
, s2c: s2cst, arg: s2explst, res: s2var
) : void // end of [s2vbcfenv_add]
fun
s2vbcfenv_replace (
  env: &s2vbcfenv
, s2t: s2rt, s2c: s2cst, arg: s2explst
) : s2var // end of [s2vbcfenv_replace]

(*
// HX: for handling a generic static function
*)
fun
s2vbcfenv_add_none (
  env: &s2vbcfenv
, s2c: s2cst, arg: s2explst, res: s2var
): void // end of [s2vbcfenv_add_none]
fun
s2vbcfenv_replace_none (
  env: &s2vbcfenv
, s2t: s2rt, s2c: s2cst, arg: s2explst
) : s2var // end of [s2vbcfenv_replace]

fun s2vbcfenv_add_svar
  (env: &s2vbcfenv, s2v: s2var): void
// end of [s2vbcfenv_add_svar]

fun s2vbcfenv_add_sexp
  (env: &s2vbcfenv, s3p: s3exp): void
// end of [s2vbcfenv_add_sbexp]

fun s2vbcfenv_add_scst
  (env: &s2vbcfenv, s2c: s2cst): void
// end of [s2vbcfenv_add_scst]

(* ****** ****** *)
//
fun s3exp_make (env: &s2vbcfenv, s2e: s2exp): s3exp
fun s3explst_make (env: &s2vbcfenv, s2es: s2explst): s3explst
//
fun s3exp_make_h3ypo (env: &s2vbcfenv, h3p: h3ypo): s3exp
//
// HX: these are auxiliary functions
//
fun s3exp_make_s2cst_s2explst (
  env: &s2vbcfenv, s2c: s2cst, s2es: s2explst
) : s3exp // end of [fun s3exp_make_s2cst_s2explst]
//
(* ****** ****** *)
//
#define TAUTOLOGY (1)
#define UNDECIDED (0)
#define CONTRADICTION (~1)
//
fun s3explst_solve_s2exp (
  loc0: location, env: &s2vbcfenv, s2p: s2exp, err: &int >> int
) : int(*status*)
// end of [s3explst_solve_s2exp]

(* ****** ****** *)

fun c3nstr_solve (c3t: c3nstr): void

(* ****** ****** *)
//
abstype s2cfunmap
//
fun constraint3_initialize (): void
fun constraint3_initialize_map (map: &s2cfunmap): void
//
(* ****** ****** *)

(* end of [pats_constraint3.sats] *)
