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
// Start Time: October, 2011
//
(* ****** ****** *)

staload
LOC = "./pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

fun
label_equal_solve_err
(
  loc0: location
, lab1: label, lab2: label, err: &int
) : void
// end of [label_equal_solve_err]

fun
stamp_equal_solve_err
(
  loc0: location
, stamp1: stamp, stamp2: stamp, err: &int
) : void // end of [stamp_equal_solve_err]

(* ****** ****** *)
//
fun
funclo_equal_solve
(
  loc0: location, fc1: funclo, fc2: funclo
) : int(*err*)
fun
funclo_equal_solve_err
(
  loc0: location, fc1: funclo, fc2: funclo, err: &int
) : void // end of [funclo_equal_solve_err]
//
(* ****** ****** *)
//
fun
clokind_equal_solve_err
(
  loc0: location, knd1: int, knd2: int, err: &int
) : void // end of [clokind_equal_solve_err]
//
(* ****** ****** *)
//
fun
linearity_equal_solve
(
  loc: location, lin1: int, lin2: int
) : int(*err*)
fun
linearity_equal_solve_err
(
  loc0: location, lin1: int, lin2: int, err: &int
) : void // end of [linearity_equal_solve_err]
//
(* ****** ****** *)
//
fun
pfarity_equal_solve
(
  loc0: location, npf1: int, npf2: int
) : int(*err*)
fun
pfarity_equal_solve_err
(
  loc0: location, npf1: int, npf2: int, err: &int
) : void // end of [pfarity_equal_solve_err]
//
(* ****** ****** *)
//
fun
s2eff_subeq_solve
(
  loc0: location, s2fe1: s2eff, s2fe2: s2eff
) : int(*err*)
fun
s2eff_subeq_solve_err
(
  loc0: location, s2fe1: s2eff, s2fe2: s2eff, err: &int
) : void // end of [s2eff_subeq_solve_err]
//
(* ****** ****** *)
//
fun
boxity_equal_solve_err
(
  loc0: location
, knd1: int, knd2: tyreckind, err: &int
) : void // end of [boxity_equal_solve_err]
//
fun
tyreckind_equal_solve_err
(
  loc0: location
, knd1: tyreckind, knd2: tyreckind, err: &int
) : void // end of [tyreckind_equal_solve_err]
//
(* ****** ****** *)
//
fun
refval_equal_solve_err
(
  loc0: location, knd1: int, knd2: int, err: &int
) : void // end of [refval_equal_solve_err]
//
(* ****** ****** *)
//
fun
s2hnf_equal_solve
(
  loc0: location, s2f1: s2hnf, s2f2: s2hnf
) : int(*err*) // end of [s2hnf_equal_solve]
fun
s2exp_equal_solve
(
  loc0: location, s2e1: s2exp, s2e2: s2exp
) : int(*err*) // end of [s2exp_equal_solve]
//
(* ****** ****** *)
//
fun
s2hnf_equal_solve_err
(
  loc0: location, s2f1: s2hnf, s2f2: s2hnf, err: &int
) : void // end of [s2hnf_equal_solve_err]
//
fun
s2exp_equal_solve_err
(
  loc0: location, s2e1: s2exp, s2e2: s2exp, err: &int
) : void // end of [s2exp_equal_solve_err]
//
(* ****** ****** *)
//
fun
s2explst_equal_solve_err
(
  loc0: location
, s2es1: s2explst, s2es2: s2explst, err: &int
) : void // end of [s2explst_equal_solve_err]
fun
labs2explst_equal_solve_err
(
  loc0: location
, ls2es1: labs2explst, ls2es2: labs2explst, err: &int
) : void // end of [labs2explst_equal_solve_err]
fun
wths2explst_equal_solve_err
(
  loc0: location
, ws2es1: wths2explst, ws2es2: wths2explst, err: &int
) : void // end of [wths2explst_equal_solve_err]
//
(* ****** ****** *)
//
fun
s2hnf_tyleq_solve
  (loc0: location, s2f1: s2hnf, s2f2: s2hnf): int(*err*)
// end of [s2hnf_tyleq_solve]
fun
s2exp_tyleq_solve
  (loc0: location, s2e1: s2exp, s2e2: s2exp): int(*err*)
// end of [s2exp_tyleq_solve]
//
(* ****** ****** *)
//
fun
s2hnf_tyleq_solve_err
(
  loc0: location, s2f1: s2hnf, s2f2: s2hnf, err: &int
): void // end of [s2hnf_tyleq_solve]
//
(* ****** ****** *)
//
fun
s2exp_tyleq_solve_err
(
  loc0: location, s2e1: s2exp, s2e2: s2exp, err: &int
) : void // end of [s2exp_tyleq_solve_err]
fun
s2explst_tyleq_solve_err
(
  loc0: location
, s2es1: s2explst, s2es2: s2explst, err: &int
) : void // end of [s2explst_tyleq_solve_err]
fun
labs2explst_tyleq_solve_err
(
  loc0: location
, ls2es1: labs2explst, ls2es2: labs2explst, err: &int
) : void // end of [labs2explst_tyleq_solve_err]
fun
wths2explst_tyleq_solve_err
(
  loc0: location
, ws2es1: wths2explst, ws2es2: wths2explst, err: &int
) : void // end of [wths2explst_tyleq_solve_err]

(* ****** ****** *)
//
// HX: handling abstract types
//
fun 
s2explst_tyleq_solve_argsrtlst_err
(
  loc: location
// HX: containing info on
, argsrts: syms2rtlst // argument variances
, s2es1: s2explst, s2es2: s2explst, err: &int
) : void // end of [s2explst_tyleq_solve_argvarlst_err]
//
(* ****** ****** *)
//
fun
s2hnf_hypequal_solve
  (loc: location, s2f1: s2hnf, s2f2: s2hnf): void
fun
s2exp_hypequal_solve
  (loc: location, s2e1: s2exp, s2e2: s2exp): void
fun
s2explst_hypequal_solve
  (loc: location, s2es1: s2explst, s2es2: s2explst): void
//
(* ****** ****** *)

(* end of [pats_staexp2_solve.sats] *)
