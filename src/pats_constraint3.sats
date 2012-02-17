
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
s3aexp = // static address expression
  | S3AEvar of s2var
  | S3AEcst of s2cst // abstract constant
  | S3AEexp of s2exp
  | S3AEnull of () (* the null address *)
  | S3AEpadd of (s3aexp, s3iexp) // ptr arith
// end of [s3aexp]

and
s3bexp = // static boolean expression
  | S3BEvar of s2var
  | S3BEcst of s2cst // abstract constant
  | S3BEexp of s2exp
  | S3BEbool of bool (* boolean constant *)
  | S3BEbneg of s3bexp
  | S3BEbadd of (s3bexp, s3bexp)
  | S3BEbmul of (s3bexp, s3bexp)
  // eq/neq: 1/~1; gte/lt : 2/~2
  | S3BEiexp of (int(*knd*), s3iexp)
// end of [s3bexp]

and
s3iexp = // static integer expression
  | S3IEvar of s2var
  | S3IEcst of s2cst (* abstract constant *)
  | S3IEexp of s2exp
  | S3IEint of intinf
  | S3IEatm of s2varmset (* mononomial term *)
  | S3IEcff of (intinf, s3iexp) // HX: coefficient
  | S3IEiadd of (s3iexp, s3iexp)
  | S3IEisub of (s3iexp, s3iexp)
  | S3IEimul of (s3iexp, s3iexp)
  | S3IEpdiff of (s3aexp, s3aexp)
// end of [s3iexp]

(* ****** ****** *)
//
typedef s3bexplst = List (s3bexp)
typedef s3bexpopt = Option (s3bexp)
//
viewtypedef s3aexpopt_vt = Option_vt (s3aexp)
viewtypedef s3bexpopt_vt = Option_vt (s3bexp)
viewtypedef s3iexpopt_vt = Option_vt (s3iexp)
//
(* ****** ****** *)
//
fun fprint_s3aexp : fprint_type (s3aexp)
fun print_s3aexp (s3ae: s3aexp): void
fun prerr_s3aexp (s3ae: s3aexp): void
//
fun fprint_s3bexp : fprint_type (s3bexp)
fun print_s3bexp (s3be: s3bexp): void
fun prerr_s3bexp (s3be: s3bexp): void
fun fprint_s3bexplst : fprint_type (s3bexplst)
fun print_s3bexplst (s3bes: s3bexplst): void
fun prerr_s3bexplst (s3bes: s3bexplst): void
//
fun fprint_s3iexp : fprint_type (s3iexp)
fun print_s3iexp (s3ie: s3iexp): void
fun prerr_s3iexp (s3ie: s3iexp): void
//
(* ****** ****** *)

val s3aexp_null : s3aexp

fun s3aexp_var (s2v: s2var): s3aexp
fun s3aexp_cst (s2c: s2cst): s3aexp

fun s3aexp_psucc (s3ae: s3aexp): s3aexp
fun s3aexp_ppred (s3ae: s3aexp): s3aexp
fun s3aexp_padd (s3ae1: s3aexp, s3ie2: s3iexp): s3aexp
fun s3aexp_psub (s3ae1: s3aexp, s3ie2: s3iexp): s3aexp

(* ****** ****** *)

val s3bexp_true: s3bexp
val s3bexp_false: s3bexp

fun s3bexp_cst (s2c: s2cst): s3bexp
fun s3bexp_var (s2v: s2var): s3bexp

fun s3bexp_bneg (s3be: s3bexp): s3bexp

fun s3bexp_beq (s3be1: s3bexp, s3be2: s3bexp): s3bexp
fun s3bexp_bneq (s3be1: s3bexp, s3be2: s3bexp): s3bexp

fun s3bexp_badd (s3be1: s3bexp, s3be2: s3bexp): s3bexp
fun s3bexp_bmul (s3be1: s3bexp, s3be2: s3bexp): s3bexp

fun s3bexp_iexp (knd: int, s3ie: s3iexp): s3bexp

fun s3bexp_igt (s3ie1: s3iexp, s3ie2: s3iexp): s3bexp
fun s3bexp_igte (s3ie1: s3iexp, s3ie2: s3iexp): s3bexp
fun s3bexp_ilt (s3ie1: s3iexp, s3ie2: s3iexp): s3bexp
fun s3bexp_ilte (s3ie1: s3iexp, s3ie2: s3iexp): s3bexp

fun s3bexp_ieq (s3ie1: s3iexp, s3ie2: s3iexp): s3bexp
fun s3bexp_ineq (s3ie1: s3iexp, s3ie2: s3iexp): s3bexp

fun s3bexp_pgt (s3ae1: s3aexp, s3ae2: s3aexp): s3bexp
fun s3bexp_pgte (s3ae1: s3aexp, s3ae2: s3aexp): s3bexp
fun s3bexp_plt (s3ae1: s3aexp, s3ae2: s3aexp): s3bexp
fun s3bexp_plte (s3ae1: s3aexp, s3ae2: s3aexp): s3bexp

fun s3bexp_peq (s3ae1: s3aexp, s3ae2: s3aexp): s3bexp
fun s3bexp_pneq (s3ae1: s3aexp, s3ae2: s3aexp): s3bexp

(* ****** ****** *)

val intinf_0 : intinf
val intinf_1 : intinf
val intinf_neg_1 : intinf

val s3iexp_0 : s3iexp
val s3iexp_1 : s3iexp
val s3iexp_neg_1 : s3iexp

fun s3iexp_int (i: int): s3iexp
fun s3iexp_intinf (i: intinf): s3iexp
fun s3iexp_var (s2v: s2var): s3iexp
fun s3iexp_cst (s2c: s2cst): s3iexp

fun s3iexp_neg (s3ie: s3iexp): s3iexp
fun s3iexp_cff (i: intinf, s3ie: s3iexp): s3iexp

fun s3iexp_isucc (s3ie: s3iexp): s3iexp
fun s3iexp_ipred (s3ie: s3iexp): s3iexp

fun s3iexp_iadd (s3ie1: s3iexp, s3ie2: s3iexp): s3iexp
fun s3iexp_isub (s3ie1: s3iexp, s3ie2: s3iexp): s3iexp
fun s3iexp_imul (s3ie1: s3iexp, s3ie2: s3iexp): s3iexp

fun s3iexp_pdiff (s3ae1: s3aexp, s3ae2: s3aexp): s3iexp

(* ****** ****** *)

absviewtype s2cfdefmap_viewtype
viewtypedef s2cfdefmap = s2cfdefmap_viewtype

fun s2cfdefmap_free (fds: s2cfdefmap): void

fun s2cfdefmap_pop (fds: &s2cfdefmap): void
fun s2cfdefmap_push (fds: &s2cfdefmap): void

fun s2cfdefmap_find (
  fds: &s2cfdefmap, s2c: s2cst, arg: s2explst
) : s2varopt_vt // end of [s2cfdefmap_find]

(*
// HX: for handling a special static function
*)
fun
s2cfdefmap_add (
  fds: &s2cfdefmap
, s2c: s2cst, arg: s2explst, res: s2var
, s2cs: &s2cstset_vt
) : void // end of [s2cfdefmap_add]
fun
s2cfdefmap_replace (
  fds: &s2cfdefmap
, s2t: s2rt
, s2c: s2cst, s2es: s2explst
, s2cs: &s2cstset_vt
) : s2var // end of [s2cfdefmap_replace]

(*
// HX: for handling a generic static function
*)
fun
s2cfdefmap_add_none (
  fds: &s2cfdefmap
, s2c: s2cst, arg: s2explst, res: s2var
, s2cs: &s2cstset_vt
): void // end of [s2cfdefmap_add_none]
fun
s2cfdefmap_replace_none (
  fds: &s2cfdefmap
, s2t: s2rt
, s2c: s2cst, s2es: s2explst
, s2cs: &s2cstset_vt
) : s2var // end of [s2cfdefmap_replace]

(* ****** ****** *)
//
fun s3aexp_make_s2exp
  (fds: &s2cfdefmap, s2e: s2exp, s2cs: &s2cstset_vt): s3aexpopt_vt
fun s3bexp_make_s2exp
  (fds: &s2cfdefmap, s2e: s2exp, s2cs: &s2cstset_vt): s3bexpopt_vt
fun s3bexp_make_h3ypo
  (fds: &s2cfdefmap, h3p: h3ypo, s2cs: &s2cstset_vt): s3bexpopt_vt
fun s3iexp_make_s2exp
  (fds: &s2cfdefmap, s2e: s2exp, s2cs: &s2cstset_vt): s3iexpopt_vt
//
// HX: these are auxiliary functions
//
fun s3aexp_make_s2cst_s2explst (
  fds: &s2cfdefmap, s2c: s2cst, s2es: s2explst, s2cs: &s2cstset_vt
) : s3aexpopt_vt // end of [fun s3aexp_make_s2cst_s2explst]
fun s3bexp_make_s2cst_s2explst (
  fds: &s2cfdefmap, s2c: s2cst, s2es: s2explst, s2cs: &s2cstset_vt
) : s3bexpopt_vt // end of [fun s3bexp_make_s2cst_s2explst]
fun s3iexp_make_s2cst_s2explst (
  fds: &s2cfdefmap, s2c: s2cst, s2es: s2explst, s2cs: &s2cstset_vt
) : s3iexpopt_vt // end of [fun s3iexp_make_s2cst_s2explst]
//
(* ****** ****** *)

fun c3nstr_solve (c3t: c3nstr): void

(* ****** ****** *)

(* end of [pats_constraint3.sats] *)
