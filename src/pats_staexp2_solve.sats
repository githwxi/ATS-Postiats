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

staload
LOC = "pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

fun label_equal_solve_err
  (loc: location, l1: label, l2: label, err: &int): void
// end of [label_equal_solve_err]

fun stamp_equal_solve_err
  (loc: location, s1: stamp, s2: stamp, err: &int): void
// end of [stamp_equal_solve_err]

(* ****** ****** *)

fun funclo_equal_solve_err
  (loc: location, _: funclo, _: funclo, err: &int): void
// end of [funclo_equal_solve_err]

fun clokind_equal_solve_err
  (loc: location, knd1: int, knd2: int, err: &int): void
// end of [clokind_equal_solve_err]

fun linearity_equal_solve_err
  (loc: location, lin1: int, lin2: int, err: &int): void
// end of [linearity_equal_solve_err]

(* ****** ****** *)

fun pfarity_equal_solve
  (loc: location, npf1: int, npf2: int): int(*err*)
// end of [pfarity_equal_solve]
fun pfarity_equal_solve_err
  (loc: location, npf1: int, npf2: int, err: &int): void
// end of [pfarity_equal_solve_err]

(* ****** ****** *)

fun tyreckind_equal_solve_err
  (loc: location, knd1: int, knd2: int, err: &int): void
// end of [tyreckind_equal_solve_err]

(* ****** ****** *)

fun refval_equal_solve_err
  (loc: location, knd1: int, knd2: int, err: &int): void
// end of [refval_equal_solve_err]

(* ****** ****** *)

fun s2hnf_equal_solve
  (loc: location, s2f1: s2hnf, s2f2: s2hnf): int(*err*)
// end of [s2hnf_equal_solve]
fun s2hnf_equal_solve_err
  (loc: location, s2f1: s2hnf, s2f2: s2hnf, err: &int): void
// end of [s2hnf_equal_solve_err]
fun s2exp_equal_solve_err
  (loc: location, s2e1: s2exp, s2e2: s2exp, err: &int): void
// end of [s2exp_equal_solve_err]

fun s2explst_equal_solve_err (
  loc: location, s2es1: s2explst, s2es2: s2explst, err: &int
) : int(*errlen*) // end of [s2explst_equal_solve_err]

(* ****** ****** *)

fun s2hnf_tyleq_solve
  (loc: location, s2f1: s2hnf, s2f2: s2hnf): int(*err*)
// end of [s2hnf_tyleq_solve]
fun s2hnf_tyleq_solve_err
  (loc: location, s2f1: s2hnf, s2f2: s2hnf, err: &int): void
// end of [s2hnf_tyleq_solve]
fun s2exp_tyleq_solve_err
  (loc: location, s2e1: s2exp, s2e2: s2exp, err: &int): void
// end of [s2exp_tyleq_solve]

(* ****** ****** *)

(* end of [pats_staexp2_solve.sats] *)
