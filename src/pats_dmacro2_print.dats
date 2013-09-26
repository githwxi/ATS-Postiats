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
// Start Time: June, 2012
//
(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_dmacro2.sats"

(* ****** ****** *)

implement
fprint_m2val
  (out, x) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x of
| M2Vint (i) => {
    val () = prstr "M2Vint("
    val () = fprint_int (out, i)
    val () = prstr ")"
  }
| M2Vbool (b) => {
    val () = prstr "M2Vbool("
    val () = fprint_bool (out, b)
    val () = prstr ")"
  }
| M2Vchar (c) => {
    val () = prstr "M2Vchar("
    val () = fprint_char (out, c)
    val () = prstr ")"
  }
| M2Vfloat (rep) => {
    val () = prstr "M2Vfloat("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  }
| M2Vstring (str) => {
    val () = prstr "M2Vstring("
    val () = fprint_string (out, str)
    val () = prstr ")"
  }
| M2Vunit () => prstr "M2Vunit()"
//
| M2Vscode (s2e) => {
    val () = prstr "M2Vscode("
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  }
| M2Vdcode (d2e) => {
    val () = prstr "M2Vdcode("
    val () = fprint_d2exp (out, d2e)
    val () = prstr ")"
  }
//
| M2Vlist (xs) => {
    val () = prstr "M2Vlist("
    val () = $UT.fprintlst (out, xs, ", ", fprint_m2val)
    val () = prstr ")"
  }
//
| M2Verr () => prstr "M2Verr()"
//
end // end of [fprint_m2val]

implement
print_m2val (x) = fprint_m2val (stdout_ref, x)
implement
prerr_m2val (x) = fprint_m2val (stderr_ref, x)

(* ****** ****** *)

implement
fprint_m2valist
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_m2val)
// end of [fprint_m2valist]

(* ****** ****** *)

(* end of [pats_dmacro2_print.dats] *)
