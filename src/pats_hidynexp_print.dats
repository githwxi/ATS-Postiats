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
// Start Time: September, 2012
//
(* ****** ****** *)

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload LAB = "pats_label.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

implement
fprint_hipat
  (out, x) = let
   macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x.hipat_node of
//
| HIPany () => {
    val () = prstr "HIPany()"
  }
| HIPvar (d2v) => {
    val () = prstr "HIPvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
| HIPbool (b) => {
    val () = prstr "HIPbool("
    val () = fprint_bool (out, b)
    val () = prstr ")"
  }
| HIPchar (c) => {
    val () = prstr "HIPchar("
    val () = fprint_char (out, c)
    val () = prstr ")"
  }
| HIPstring (str) => {
    val () = prstr "HIPstring("
    val () = fprint_string (out, str)
    val () = prstr ")"
  }
//
| _ => {
    val () = fprint_string (out, "HIP...(...)")
  } // end of [_]
//
end // end of [fprint_hipat]

(* ****** ****** *)

implement
fprint_hidexp
  (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+
  x.hidexp_node of
//
| HDEbool (b) => {
    val () = prstr "HDEbool("
    val () = fprint_bool (out, b)
    val () = prstr ")"
  }
| HDEchar (c) => {
    val () = prstr "HDEchar("
    val () = fprint_char (out, c)
    val () = prstr ")"
  }
| HDEstring (str) => {
    val () = prstr "HDEstring("
    val () = fprint_string (out, str)
    val () = prstr ")"
  }
//
| _ => {
    val () = fprint_string (out, "HDE...(...)")
  } // end of [_]
//
end // end of [fprint_hidexp]

(* ****** ****** *)

(* end of [pats_hidynexp_print.dats] *)
