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

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload INTINF = "./pats_intinf.sats"
macdef fprint_intinf = $INTINF.fprint_intinf

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

staload "./pats_constraint3.sats"

(* ****** ****** *)

implement
fprint_s3exp (out, x) = let
//
macdef prstr (str) = fprint_string (out, ,(str))
//
in
//
case+ x of
//
| S3Ecst (s2c) => {
    val () = prstr "S3Ecst("
    val () = fprint! (out, s2c, ":", s2cst_get_srt (s2c))
    val () = prstr ")" 
  } // end of [S3Ecst]
//
| S3Evar (s2v) => {
    val () = prstr "S3Evar("
    val () = fprint! (out, s2v, ":", s2var_get_srt (s2v))
    val () = prstr ")" 
  } // end of [S3Evar]
//
| S3Enull () => prstr "0"
| S3Eunit () => prstr "1"
| S3Ebool (b) => {
    val () = fprint_bool (out, b)
  } // end of [S3Ebool]
//
| S3Ebvar (s2v) => {
    val () = prstr "S3Ebvar("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")" 
  } // end of [S3Ebvar]
| S3Ebneg (s3e) => {
    val () = prstr "S3Ebneg("
    val () = fprint_s3exp (out, s3e)
    val () = prstr ")"
  } // end of [S3Ebadd]
| S3Ebadd (s3e1, s3e2) => {
    val () = prstr "S3Ebadd("
    val () = fprint_s3exp (out, s3e1)
    val () = prstr ", "
    val () = fprint_s3exp (out, s3e2)
    val () = prstr ")"
  } // end of [S3Ebadd]
| S3Ebmul (s3e1, s3e2) => {
    val () = prstr "S3Ebmul("
    val () = fprint_s3exp (out, s3e1)
    val () = prstr ", "
    val () = fprint_s3exp (out, s3e2)
    val () = prstr ")"
  } // end of [S3Ebmul]
| S3Ebeq (s3e1, s3e2) => {
    val () = prstr "S3Ebeq("
    val () = fprint_s3exp (out, s3e1)
    val () = prstr ", "
    val () = fprint_s3exp (out, s3e2)
    val () = prstr ")"
  } // end of [S3Ebeq]
| S3Ebneq (s3e1, s3e2) => {
    val () = prstr "S3Ebneq("
    val () = fprint_s3exp (out, s3e1)
    val () = prstr ", "
    val () = fprint_s3exp (out, s3e2)
    val () = prstr ")"
  } // end of [S3Ebneq]
| S3Ebineq (knd, s3e) => { // eq/neq: 1/~1; gte/lt : 2/~2
    val () = prstr "S3Ebineq("
    val () = (
      case+ knd of
      |  1 => prstr "="
      | ~1 => prstr "!="
      |  2 => prstr ">="
      | ~2 => prstr "<"
      |  _ => prstr "?"
    ) : void // end of [val]
    val () = prstr ", "
    val () = fprint_s3exp (out, s3e)
    val () = prstr ")"
  } // end of [S3Ebineq]
//
| S3Ebdom (s2v) => {
    val () = prstr "S3Ebdom("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")"
  } // end of [S3Ebdom]
//
| S3Eiatm (s2vs) => {
    val () = prstr "S3Eiatm("
    val () = fprint_s2varmset (out, s2vs)
    val () = prstr ")"
  } // end of [S3Eiatm]
| S3Eicff (c, s3e) => {
    val () = prstr "S3Eicff("
    val () = fprint_intinf (out, c)
    val () = prstr ", "
    val () = fprint_s3exp (out, s3e)
    val () = prstr ")"
  } // end of [S3Eicff]
| S3Eisum (s3es) => {
    val () = prstr "S3Eisum("
    val () = fprint_s3explst (out, s3es)
    val () = prstr ")"
  } // end of [S3Eiadd]
| S3Eimul (s3e1, s3e2) => {
    val () = prstr "S3Eimul("
    val () = fprint_s3exp (out, s3e1)
    val () = prstr ", "
    val () = fprint_s3exp (out, s3e2)
    val () = prstr ")"
  } // end of [S3Eimul]
//
| S3Esizeof (s2ze) => {
    val () = prstr "S3Esizeof("
    val () = fprint_s2zexp (out, s2ze)
    val () = prstr ")"
  } // end of [S3Esizeof]
//
| S3Eapp (s3e, s3es) => {
    val () = prstr "S3Eapp("
    val () = fprint_s3exp (out, s3e)
    val () = prstr "; "
    val () = fprint_s3explst (out, s3es)
    val () = prstr ")" 
  } // end of [S3Eapp]
//
| S3Eerr (s2t) => {
    val () = prstr "S3Eerr("
    val () = fprint_s2rt (out, s2t)
    val () = prstr ")"
  } // end of [S3Eerr]
//
end // end of [fprint_s3exp]

implement
print_s3exp (x) = fprint_s3exp (stdout_ref, x)
implement
prerr_s3exp (x) = fprint_s3exp (stderr_ref, x)

(* ****** ****** *)

implement
fprint_s3explst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_s3exp)
// end of [fprint_s3explst]

implement
print_s3explst (xs) = fprint_s3explst (stdout_ref, xs)
implement
prerr_s3explst (xs) = fprint_s3explst (stderr_ref, xs)

(* ****** ****** *)

(* end of [pats_constraint3_print.dats] *)
