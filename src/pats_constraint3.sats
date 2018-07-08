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
// Start Time: February, 2012
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_jsonize.sats"

(* ****** ****** *)
//
staload "./pats_staexp2.sats"
//
staload
TRENV3 = "./pats_trans3_env.sats"
typedef h3ypo = $TRENV3.h3ypo
typedef c3nstr = $TRENV3.c3nstr
//
(* ****** ****** *)

staload "./pats_lintprgm.sats"

(* ****** ****** *)
//
// eq=1/neq=~1/gte=2/lt=~2
//
typedef int2 = intBtwe (~2, 2)

datatype s3exp =
//
  | S3Evar of s2var
  | S3Ecst of s2cst // abstract constant
//
  | S3Enull of () // = 0
  | S3Eunit of () // = 1
  | S3Ebool of bool (* boolean constant *)
//
  | S3Ebvar of s2var // s2v == 1
  | S3Ebneg of s3exp
  | S3Ebadd of (s3exp, s3exp)
  | S3Ebmul of (s3exp, s3exp)
  | S3Ebeq of (s3exp, s3exp)
  | S3Ebneq of (s3exp, s3exp)
  | S3Ebineq of (int2(*knd*), s3exp)
//
  | S3Ebdom of s2var // 0 <= s2v <= 1
//
  | S3Eiatm of s2varmset (* mononomial term *)
  | S3Eicff of (intinf, s3exp) // HX: coefficient
  | S3Eisum of s3explst (* sum of list of icffs *)
  | S3Eimul of (s3exp, s3exp)
//
  | S3Esizeof of (s2zexp) // HX: size of a type
//
  | S3Eapp of (s3exp, s3explst)
//
  | S3Eerr of (s2rt)
// end of [s3exp]

where s3explst = List (s3exp)
//
viewtypedef s3explst_vt = List_vt (s3exp)
//
(* ****** ****** *)

fun s3exp_get_srt (s3e: s3exp): s2rt

(* ****** ****** *)
//
// HX: compute the freevar set of [s3e]
//
fun s3exp_get_fvs (s3e: s3exp): s2varset_vt

(* ****** ****** *)
//
fun print_s3exp (x: s3exp): void
fun prerr_s3exp (x: s3exp): void
fun fprint_s3exp : fprint_type (s3exp)
//
fun print_s3explst (xs: s3explst): void
fun prerr_s3explst (xs: s3explst): void
fun fprint_s3explst : fprint_type (s3explst)
//
overload print with print_s3exp
overload prerr with prerr_s3exp
overload prerr with fprint_s3exp
overload print with print_s3explst
overload prerr with prerr_s3explst
overload prerr with fprint_s3explst
//
(* ****** ****** *)

fun s3exp_syneq (x1: s3exp, x2: s3exp): bool
fun s3explst_syneq (xs1: s3explst, xs2: s3explst): bool

(* ****** ****** *)

(*
** HX-2012-02-20:
** this one is used to implement S3Eisum
*)
fun s3exp_isgte (x1: s3exp, x2: s3exp): bool

(* ****** ****** *)

fun s3exp_err (s2t: s2rt): s3exp

(* ****** ****** *)

fun s3exp_var (s2v: s2var): s3exp
fun s3exp_bvar (s2v: s2var): s3exp

(* ****** ****** *)

fun s3exp_cst (s2c: s2cst): s3exp

(* ****** ****** *)

fun s3exp_app (_fun: s3exp, _arg: s3explst): s3exp

(* ****** ****** *)
//
val s3exp_null : s3exp
val s3exp_unit : s3exp
val s3exp_true: s3exp and s3exp_false: s3exp
//
val intinf_0 : intinf
and intinf_1 : intinf
and intinf_2 : intinf
and intinf_neg_1 : intinf
//
val s3exp_0 : s3exp
and s3exp_1 : s3exp
and s3exp_2 : s3exp
and s3exp_neg_1 : s3exp
//
(* ****** ****** *)

fun s3exp_bool (b: bool): s3exp
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
fun s3exp_bineq (knd: int2, s3e: s3exp): s3exp

(* ****** ****** *)

fun s3exp_int (i: int): s3exp
fun s3exp_intinf (int: intinf): s3exp

fun s3exp_icff (c: intinf, s3e: s3exp): s3exp
fun s3explst_icff (c: intinf, s3es: s3explst): s3explst_vt

fun s3exp_isum (s3es: s3explst): s3exp

fun s3exp_ineg (s3e: s3exp): s3exp
fun s3exp_isucc (s3e: s3exp): s3exp
fun s3exp_ipred (s3e: s3exp): s3exp

fun s3exp_iadd (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_isub (s3e1: s3exp, s3e2: s3exp): s3exp
fun s3exp_imul (s3e1: s3exp, s3e2: s3exp): s3exp

(* ****** ****** *)

absviewtype s2vbcfenv_viewtype
viewtypedef s2vbcfenv = s2vbcfenv_viewtype

fun s2vbcfenv_nil (): s2vbcfenv
fun s2vbcfenv_free (env: s2vbcfenv): void

absview s2vbcfenv_push_v
fun s2vbcfenv_pop
  (pf: s2vbcfenv_push_v | env: &s2vbcfenv): void
fun s2vbcfenv_push (env: &s2vbcfenv): (s2vbcfenv_push_v | void)

fun s2vbcfenv_find_nonlin (
  env: &s2vbcfenv, s3e: s3exp
) : Option_vt (s2var) // end of [s2vbcfenv_find_nonlin]

fun s2vbcfenv_find_cstapp (
  env: &s2vbcfenv, s2c: s2cst, arg: s3explst
) : Option_vt (s2var) // end of [s2vbcfenv_find_cstapp]

fun s2vbcfenv_extract
  (env: !s2vbcfenv): (s2varlst_vt, s3explst_vt)
// end of [s2vbcfenv_extract]

fun s2vbcfenv_add_svar (env: &s2vbcfenv, s2v: s2var): void
fun s2vbcfenv_add_sbexp (env: &s2vbcfenv, s3p: s3exp): void

(*
// HX: for handling special static functions
*)
fun s2vbcfenv_add_cstapp (
  env: &s2vbcfenv, s2c: s2cst, arg: s2explst, res: s2var
) : void // end of [s2vbcfenv_add_cstapp]
fun s2vbcfenv_replace_cstapp (
  env: &s2vbcfenv, s2t: s2rt, s2c: s2cst, arg: s2explst
) : s2var // end of [s2vbcfenv_replace_cstapp]

(*
// HX: for handling generic nonlinear expressions
*)
fun s2vbcfenv_add_nonlin
  (env: &s2vbcfenv, s2v: s2var, s3e: s3exp): void
// end of [s2vbcfenv_add_nonlin]
fun s2vbcfenv_replace_nonlin (env: &s2vbcfenv, s3e: s3exp): s2var

(* ****** ****** *)
//
fun s3exp_make (env: &s2vbcfenv, s2e: s2exp): s3exp
fun s3explst_make (env: &s2vbcfenv, s2es: s2explst): s3explst
//
fun s3exp_make_h3ypo (env: &s2vbcfenv, h3p: h3ypo): s3exp
//
// HX: these are auxiliary functions
//
fun s3exp_make_s2cst_s2explst
(
  env: &s2vbcfenv, s2c: s2cst, s2es: s2explst
) : s3exp // end of [s3exp_make_s2cst_s2explst]
//
(* ****** ****** *)
//
#define TAUTOLOGY (1)
#define UNDECIDED (0)
#define CONTRADICTION (~1)
//
fun s3explst_solve_s2exp
(
  loc0: location, env: &s2vbcfenv, s2p: s2exp, err: &int >> int
) : int(*status*)
// end of [s3explst_solve_s2exp]

(* ****** ****** *)

fun s3exp_lintize (env: &s2vbcfenv, s3e: s3exp): s3exp

(* ****** ****** *)

absviewtype s2varindmap (n:int)

fun s2varindmap_make
  {n:nat} (s2vs: !list_vt (s2var, n)): @(s2varindmap (n), int n)
// end of [s2varindmap_make]

fun s2varindmap_free
  {n:int} (map: s2varindmap (n)): void
// end of [s2varindmap_free]

//
// HX: if 0 is returned, then [s2v] is not found
//
fun s2varindmap_find {n:nat}
  (map: !s2varindmap (n), s2v: s2var): natLte (n)
// end of [s2varindmap_find]

fun{a:t@ype}
s3exp2icnstr{n:nat}
(
  loc: location
, vim: !s2varindmap (n), n: int n, s3e: s3exp
) : icnstr (a, n+1) // end of [s3exp2icnstr]

fun{a:t@ype}
s3exp2myintvec{n:nat}
(
  vim: !s2varindmap (n), n: int n, s3e: s3exp, err: &int
) : myintvec (a, n+1) // end of [s3exp2myintvec]

(* ****** ****** *)

fun c3nstr_ats2_solve (c3t: c3nstr): void

(* ****** ****** *)
//
fun
c3nstr_mapgen_scst_svar
  (c3t: c3nstr):
(
  s2cstset_vt, s2varset_vt
) (* end of [c3nstr_mapgen_scst_svar] *)
//
fun
jsonize_c3nstr (c3t: c3nstr): jsonval
//
fun c3nstr_export (out: FILEref, c3t: c3nstr): void
//
(* ****** ****** *)
//
abstype s2cfunmap
//
fun constraint3_initialize (): void
fun constraint3_initialize_map (map: &s2cfunmap): void
//
(* ****** ****** *)

(* end of [pats_constraint3.sats] *)
