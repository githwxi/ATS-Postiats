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

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

datatype staerr =
//
  | STAERR_label_equal of (location, label, label)
  | STAERR_stamp_equal of (location, stamp, stamp)
//
  | STAERR_funclo_equal of (location, funclo, funclo)
  | STAERR_clokind_equal of (location, int(*knd*), int(*knd*))
  | STAERR_linearity_equal of (location, int(*lin*), int(*lin*))
  | STAERR_pfarity_equal of (location, int(*npf*), int(*npf*))
//
  | STAERR_s2eff_subeq of (location, s2eff, s2eff)
//
  | STAERR_boxity_equal of (location, int(*knd*), tyreckind)
  | STAERR_tyreckind_equal of (location, tyreckind, tyreckind)
//
  | STAERR_refval_equal of (location, int(*knd*), int(*knd*))
//
  | STAERR_s2zexp_merge of (location, s2zexp, s2zexp)
//
  | STAERR_s2exp_equal of (location, s2exp, s2exp)
  | STAERR_s2exp_tyleq of (location, s2exp, s2exp)
//
  | STAERR_s2Var_s2exp_solve of (location, s2Var, s2exp)
//
  | STAERR_s2explst_length of (location, int(*-1/1*))
  | STAERR_labs2explst_length of (location, int(*-1/1*))
//
  | STAERR_wths2explst_shape of (location, wths2explst, wths2explst)
//
  | STAERR_s2exp_linearity of (location, s2exp)
//
// end of [datatype]

viewtypedef staerrlst_vt = List_vt (staerr)

(* ****** ****** *)
//
fun the_staerrlst_clear (): void
//
fun the_staerrlst_add (x: staerr): void
//
// HX-2011-10-22:
// [n] stores the total number of errors, some of
// which may not be recorded
//
fun the_staerrlst_get (n: &int? >> int): staerrlst_vt
//
(* ****** ****** *)

fun prerr_the_staerrlst (): void

(* ****** ****** *)

(* end of [pats_staexp2_error.sats] *)
