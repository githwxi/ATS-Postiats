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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: June, 2012
//
(* ****** ****** *)
//
// HX: for handling macro expansion during typechecking
//
(* ****** ****** *)

staload
LOC = "pats_location.sats"
typedef location = $LOC.location

staload
SEXP2 = "pats_staexp2.sats"
typedef s2exp = $SEXP2.s2exp
staload
DEXP2 = "pats_dynexp2.sats"
typedef d2exp = $DEXP2.d2exp
typedef d2mac = $DEXP2.d2mac
typedef d2exparglst = $DEXP2.d2exparglst

(* ****** ****** *)

datatype m2val =
//
  | M2Vint of int
  | M2Vbool of bool
  | M2Vchar of char
  | M2Vfloat of string
  | M2Vstring of string
  | M2Vunit of ()
//
  | M2Vscode of s2exp // static code
  | M2Vdcode of d2exp // dynamic code
//
  | M2Vlist of m2valist
//
  | M2Verr of ()
// end of [m2val]

where m2valist = List (m2val)

(* ****** ****** *)

fun fprint_m2val (out: FILEref, x: m2val): void

(* ****** ****** *)

fun dmacro_eval_cross (d2e: d2exp): d2exp
fun dmacro_eval_decode (d2e: d2exp): d2exp

(* ****** ****** *)
//
// HX: for expanding macros in short form
//
fun dmacro_eval_app_short (
  loc0: location, d2m: d2mac, d2as: d2exparglst
) : d2exp // end of [dmacro_eval_app_short]

(* ****** ****** *)

(* end of [pats_dmacro2.sats] *)
