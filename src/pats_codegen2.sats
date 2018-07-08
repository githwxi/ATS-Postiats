(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: August, 2015
//
(* ****** ****** *)
//
staload
S1E = "pats_staexp1.sats"
//
typedef e1xp = $S1E.e1xp
typedef e1xplst = $S1E.e1xplst
//
(* ****** ****** *)
//
staload
S2E = "pats_staexp2.sats"
staload
D2E = "pats_dynexp2.sats"
//
typedef s2rt = $S2E.s2rt
typedef s2cst = $S2E.s2cst
typedef s2var = $S2E.s2var
typedef s2exp = $S2E.s2exp
typedef d2cst = $D2E.d2cst
typedef d2ecl = $D2E.d2ecl
typedef d2eclist = $D2E.d2eclist
//
(* ****** ****** *)
//
fun
datcon_test_e1xp(name: e1xp): bool
fun
datcontag_test_e1xp(name: e1xp): bool
//
fun fprint_test_e1xp(name: e1xp): bool
//
fun absrec_test_e1xp(name: e1xp): bool
//
(* ****** ****** *)
//
fun
codegen2_get_s2cst
  (name: e1xp): Option_vt(s2cst)
//
(* ****** ****** *)
//
fun
codegen2_get_tydef
  (name: e1xp): Option_vt(s2cst)
fun
codegen2_get_datype
  (name: e1xp): Option_vt(s2cst)
//
(* ****** ****** *)
//
fun
codegen2_get_d2cst
  (name: e1xp): Option_vt(d2cst)
//
(* ****** ****** *)
//
fun
codegen2_emit_tmpcstapp
  (out: FILEref, d2cf: d2cst): void
fun
codegen2_emit_tmpcstimp
  (out: FILEref, d2cf: d2cst): void
fun
codegen2_emit_tmpcstdec
  (out: FILEref, d2cf: d2cst): void
//
(* ****** ****** *)
//
fun
codegen2_emit_s2rt
  (out: FILEref, s2t0: s2rt): void
fun
codegen2_emit_s2cst
  (out: FILEref, s2c0: s2cst): void
fun
codegen2_emit_s2var
  (out: FILEref, s2v0: s2var): void
fun
codegen2_emit_s2exp
  (out: FILEref, s2e0: s2exp): void
//
(* ****** ****** *)
//
fun
codegen2_process
  (out: FILEref, d2c0: d2ecl): void
//
(* ****** ****** *)
//
(*
#codegen2(datcon, [datatype])
#codegen2(datcontag, [datatype])
*)
//
fun
codegen2_datcon
  (out: FILEref, d2c0: d2ecl, xs: e1xplst): void
fun
codegen2_datcontag
  (out: FILEref, d2c0: d2ecl, xs: e1xplst): void
//
(* ****** ****** *)
//
(*
#codegen2(fprint, [datatype], <fprint_name>)
*)
//
fun
codegen2_fprint
  (out: FILEref, d2c0: d2ecl, xs: e1xplst): void
//
(* ****** ****** *)
//
(*
#codegen2(absrec, [rectype], <rectype_name>)
*)
//
fun
codegen2_absrec
  (out: FILEref, d2c0: d2ecl, xs: e1xplst): void
//
(* ****** ****** *)
//
fun
d2eclist_codegen_out(out: FILEref, d2cs: d2eclist): void
//
(* ****** ****** *)

(* end of [pats_codegen2.sats] *)
