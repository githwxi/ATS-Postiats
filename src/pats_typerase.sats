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
// Start Time: July, 2012
//
(* ****** ****** *)

staload
LOC = "./pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)
//
// HX-2012-09:
// the list of possible errors that may occur
// during the level-4 translation
//
datatype trans4err =
//
  | T4E_p3at_tyer_isprf of (p3at) // [p3at] is partial
//
  | T4E_d3exp_tyer_isprf of (d3exp) // [d3exp] should be erased
//
(*
  | T4E_d3exp_tyer_isnotval of (d3exp) // HX: it is only a warning!
*)
// end of [trans4err]
//
(* ****** ****** *)

fun the_trans4errlst_add (x: trans4err): void
fun the_trans4errlst_finalize (): void // cleanup all the errors

(* ****** ****** *)
//
// HX-2012-09:
// [s2exp_tyer] is essentially for
// measuring the size of a given type
//
fun
s2exp_tyer // flag=0/1:shallow/deep
  (loc: location, flag: int, s2e0: s2exp): hisexp
//
fun
s2exp_tyer_deep(loc: location, s2e0: s2exp): hisexp
fun
s2exp_tyer_shallow(loc: location, s2e0: s2exp): hisexp
//
(* ****** ****** *)

fun s2zexp_tyer (loc: location, s2ze: s2zexp): hisexp

(* ****** ****** *)

fun t2mpmarg_tyer (t2ma: t2mpmarg): hisexplst
fun t2mpmarglst_tyer (t2mas: t2mpmarglst): hisexplstlst

(* ****** ****** *)

fun t2mpmarg_mhnfize (t2ma: t2mpmarg): t2mpmarg
fun t2mpmarglst_mhnfize (t2mas: t2mpmarglst): t2mpmarglst

(* ****** ****** *)

fun d2var_tyer (d2v: d2var): d2var
fun d2cst_tyer (d2c: d2cst): d2cst

(* ****** ****** *)

fun p3at_tyer (p3t: p3at): hipat
fun p3atlst_tyer (p3ts: p3atlst): hipatlst
fun p3atlst_tyer2 (d3es: d3explst, p3ts: p3atlst): hipatlst

(* ****** ****** *)

fun d3exp_tyer (d3e: d3exp): hidexp
fun d3explst_tyer (d3es: d3explst): hidexplst
fun d3expopt_tyer (opt: d3expopt): hidexpopt

(* ****** ****** *)

fun d3lab_tyer (d3l: d3lab): hilab
fun d3lablst_tyer (d3ls: d3lablst): hilablst

(* ****** ****** *)

fun decarg2imparg (s2qs: s2qualst): s2varlst

(* ****** ****** *)

fun d3ecl_tyer (d3c: d3ecl): hidecl
fun d3eclist_tyer (d3cs: d3eclist): hideclist

(* ****** ****** *)

fun d3eclist_tyer_errck (d3cs: d3eclist): hideclist

(* ****** ****** *)

(* end of [pats_typerase.sats] *)
