(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: November, 2013
//
(* ****** ****** *)
//
// Author: William Blair
// Authoremail: william.douglass.blairATgmailDOTcom
// Contribing Time: August 7, 2014
//
(* ****** ****** *)
//
// HX-2014-12-09: Reorganizing
//
(* ****** ****** *)
//
staload
JSON = "./pats_jsonize.sats"
typedef jsonval = $JSON.jsonval
//
(* ****** ****** *)
//
staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"
//
(* ****** ****** *)
//
// Statics
//
(* ****** ****** *)
//
fun jsonize_s2rt (s2t: s2rt): jsonval
fun jsonize_s2rtlst (s2ts: s2rtlst): jsonval
//
fun jsonize_s2cst (s2c: s2cst): jsonval
fun jsonize_s2cst_long (s2c: s2cst): jsonval
fun jsonize_s2cstlst (s2cs: s2cstlst): jsonval
//
fun jsonize_s2rtdat_long (s2td: s2rtdat): jsonval
//
fun jsonize_s2var (s2v: s2var): jsonval
fun jsonize_s2var_long (s2v: s2var): jsonval
//
fun jsonize_s2Var (s2V: s2Var): jsonval
fun jsonize_s2Var_long (s2V: s2Var): jsonval
//
fun jsonize_s2varlst (s2vs: s2varlst): jsonval
//
fun jsonize_d2con (d2c: d2con): jsonval
fun jsonize_d2con_long (d2c: d2con): jsonval
fun jsonize_d2conlst (d2cs: d2conlst): jsonval
//
fun jsonize_tyreckind : tyreckind -> jsonval
//
fun jsonize_s2exp (flag: int, s2e: s2exp): jsonval
fun jsonize_s2explst (flag: int, s2es: s2explst): jsonval
fun jsonize_s2expopt (flag: int, s2eopt: s2expopt): jsonval
//
fun jsonize_labs2explst (flag: int, ls2es: labs2explst): jsonval  
//
fun jsonize_wths2explst (flag: int, ws2es: wths2explst): jsonval
//
fun jsonize_s2eff (s2fe: s2eff): jsonval
//
fun jsonize_s2zexp (s2e: s2zexp): jsonval
//
(* ****** ****** *)
//
fun jsonize0_s2exp (s2e: s2exp): jsonval // w/o hnfizing
fun jsonize1_s2exp (s2e: s2exp): jsonval // with hnfizing
//
fun jsonize0_s2explst (s2es: s2explst): jsonval // w/o hnfizing
fun jsonize1_s2explst (s2es: s2explst): jsonval // with hnfizing
//
fun jsonize0_s2expopt (opt: s2expopt): jsonval // w/o hnfizing
fun jsonize1_s2expopt (opt: s2expopt): jsonval // with hnfizing
//  
(* ****** ****** *)
//
// Dynamics
//
(* ****** ****** *)

fun jsonize_d2cst (d2c: d2cst): jsonval
fun jsonize_d2cst_long (d2c: d2cst): jsonval
fun jsonize_d2cstlst (d2cs: d2cstlst): jsonval

(* ****** ****** *)

fun jsonize_d2var (d2v: d2var): jsonval
fun jsonize_d2var_long (d2v: d2var): jsonval

(* ****** ****** *)

fun jsonize_d2itm (d2i: d2itm): jsonval

(* ****** ****** *)

fun jsonize_d2ecl (d2c: d2ecl): jsonval
fun jsonize_d2eclist (d2cs: d2eclist): jsonval

(* ****** ****** *)
//
fun
d2eclist_jsonize_out (out: FILEref, d2cs: d2eclist): void
//
(* ****** ****** *)

(* end of [pats_jsonize_synent2.sats] *)
