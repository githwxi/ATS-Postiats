
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

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload INTINF = "pats_intinf.sats"
macdef fprint_intinf = $INTINF.fprint_intinf

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

staload "pats_constraint3.sats"

(* ****** ****** *)

implement
fprint_s3aexp (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x of
| S3AEvar (s2v) => {
    val () = prstr "S3AEvar("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")" 
  } // end of [S3AEvar]
| S3AEcst (s2c) => {
    val () = prstr "S3AEcst("
    val () = fprint_s2cst (out, s2c)
    val () = prstr ")" 
  } // end of [S3AEcst]
| S3AEexp (s2e) => {
    val () = prstr "S3AEexp("
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [S3AEexp]
| S3AEnull () => prstr "S3AEnull()"
| S3AEpadd (s3ae, s3ie) => {
    val () = prstr "S3AEpadd("
    val () = fprint_s3aexp (out, s3ae)
    val () = prstr ", "
    val () = fprint_s3iexp (out, s3ie)
    val () = prstr ")"
  } // end of [S3AEpadd]
//
end // end of [s3aexp]

(* ****** ****** *)

implement
fprint_s3bexp (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x of
| S3BEvar (s2v) => {
    val () = prstr "S3BEvar("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")" 
  } // end of [S3BEvar]
| S3BEcst (s2c) => {
    val () = prstr "S3BEcst("
    val () = fprint_s2cst (out, s2c)
    val () = prstr ")" 
  } // end of [S3BEcst]
| S3BEexp (s2e) => {
    val () = prstr "S3BEexp("
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [S3BEexp]
| S3BEbool (b) => {
    val () = prstr "S3BEbool("
    val () = fprint_bool (out, b)
    val () = prstr ")"
  } // end of [S3BEbool]
| S3BEbneg (s2be) => {
    val () = prstr "S3BEbneg("
    val () = fprint_s3bexp (out, s2be)
    val () = prstr ")"
  } // end of [S3BEbadd]
| S3BEbadd (s2be1, s2be2) => {
    val () = prstr "S3BEbadd("
    val () = fprint_s3bexp (out, s2be1)
    val () = prstr ", "
    val () = fprint_s3bexp (out, s2be2)
    val () = prstr ")"
  } // end of [S3BEbadd]
| S3BEbmul (s2be1, s2be2) => {
    val () = prstr "S3BEbmul("
    val () = fprint_s3bexp (out, s2be1)
    val () = prstr ", "
    val () = fprint_s3bexp (out, s2be2)
    val () = prstr ")"
  } // end of [S3BEbmul]
| S3BEiexp (knd, s3ie) => { // eq/neq: 1/~1; gte/lt : 2/~2
    val () = prstr "S3BEiexp("
    val () = fprint_int (out, knd)
    val () = prstr ", "
    val () = fprint_s3iexp (out, s3ie)
    val () = prstr ")"
  } // end of [S3BEiexp]
//
end // end of [fprint_s3bexp]

(* ****** ****** *)

implement
fprint_s3iexp (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x of
| S3IEvar (s2v) => {
    val () = prstr "S3IEvar("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")" 
  } // end of [S3IEvar]
| S3IEcst (s2c) => {
    val () = prstr "S3IEcst("
    val () = fprint_s2cst (out, s2c)
    val () = prstr ")"
  } // end of [S3IEcst]
| S3IEexp (s2e) => {
    val () = prstr "S3IEexp("
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [S3IEexp]
| S3IEint (int) => {
    val () = prstr "S3IEintinf("
    val () = fprint_intinf (out, int)
    val () = prstr ")"
  } // end of [S3IEintinf]
| S3IEatm (s2vs) => {
    val () = prstr "S3IEatm("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  } // end of [S3IEatm]
| S3IEcff (c, s3ie) => {
    val () = prstr "S3IEcff("
    val () = fprint_intinf (out, c)
    val () = fprint_s3iexp (out, s3ie)
    val () = prstr ")"
  } // end of [S3IEineg]
| S3IEiadd (s3ie1, s3ie2) => {
    val () = prstr "S3IEiadd("
    val () = fprint_s3iexp (out, s3ie1)
    val () = prstr ", "
    val () = fprint_s3iexp (out, s3ie2)
    val () = prstr ")"
  } // end of [S3IEiadd]
| S3IEisub (s3ie1, s3ie2) => {
    val () = prstr "S3IEisub("
    val () = fprint_s3iexp (out, s3ie1)
    val () = prstr ", "
    val () = fprint_s3iexp (out, s3ie2)
    val () = prstr ")"
  } // end of [S3IEisub]
| S3IEimul (s3ie1, s3ie2) => {
    val () = prstr "S3IEimul("
    val () = fprint_s3iexp (out, s3ie1)
    val () = prstr ", "
    val () = fprint_s3iexp (out, s3ie2)
    val () = prstr ")"
  } // end of [S3IEimul]
| S3IEpdiff (s3ae1, s3ae2) => {
    val () = prstr "S3IEpdiff("
    val () = fprint_s3aexp (out, s3ae1)
    val () = prstr ", "
    val () = fprint_s3aexp (out, s3ae2)
    val () = prstr ")"
  } // end of [S3IEpdiff]
//
end // end of [fprint_s3iexp]

(* ****** ****** *)

implement
fprint_s3bexplst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_s3bexp)
// end of [fprint_s3bexplst]

(* ****** ****** *)

(* end of [pats_constraint3_print.dats] *)
