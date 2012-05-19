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
// Start Time: May, 2012
//
(* ****** ****** *)

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload SYM = "pats_symbol.sats"
macdef fprint_symbol = $SYM.fprint_symbol
staload SYN = "pats_syntax.sats"
macdef fprint_cstsp = $SYN.fprint_cstsp
macdef fprint_l0ab = $SYN.fprint_l0ab
macdef fprint_i0de = $SYN.fprint_i0de
macdef fprint_d0ynq = $SYN.fprint_d0ynq

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

implement
fprint_p3at
  (out, p3t0) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ p3t0.p3at_node of
//
| P3Tany (d2v) => {
    val () = prstr "P3Tany("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
| P3Tvar (d2v) => {
    val () = prstr "P3Tvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
//
| P3Tcon (
    pck, d2c, npf, p3ts
  ) => {
    val () = prstr "P3Tcon("
    val () = fprint_pckind (out, pck)
    val () = prstr "; "
    val () = fprint_d2con (out, d2c)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_p3atlst (out, p3ts)
    val () = prstr ")"
  } // end of [P3Tcon]
//
| P3Tint (i) =>
    fprintf (out, "P3Tint(%i)", @(i))
| P3Tintrep (s) =>
    fprintf (out, "P3Tintrep(%s)", @(s))
| P3Tbool (b) => let
    val name = if b then "true" else "false"
  in
    fprintf (out, "P3Tbool(%s)", @(name))
  end // end of [P3Tbool]
| P3Tchar (c) =>
    fprintf (out, "P3Tchar(%c)", @(c))
| P3Tstring (str) =>
    fprintf (out, "P3Tstring(%s)", @(str))
//
| P3Ti0nt (i) => prstr "P3Ti0nt(...)"
| P3Tf0loat (f) => prstr "P3Tf0loat(...)"
//
| P3Tempty () => prstr "P3Tempty()"
//
| P3Trec _ => prstr "P3Trec(...)"
| P3Tlst (lin, p3ts) => {
    val () = prstr "P3Tlst("
    val () = fprint_int (out, lin)
    val () = prstr "; "
    val () = fprint_p3atlst (out, p3ts)
    val () = prstr ")"
  }
//
| P3Trefas (d2v, p3t) => {
    val () = prstr "P3Trefas("
    val () = fprint_d2var (out, d2v)
    val () = prstr " -> "
    val () = fprint_p3at (out, p3t)
    val () = prstr ")"
  } // end of [P3Trefas]
| P3Texist (s2vs, p3t) => {
    val () = prstr "P3Texist("
    val () = fprint_s2varlst (out, s2vs)
    val () = prstr "; "
    val () = fprint_p3at (out, p3t)
    val () = prstr ")"
  } // end of [P3Texist]
| P3Tann (p3t, s2e) => {
    val () = prstr "P3Tann("
    val () = fprint_p3at (out, p3t)
    val () = prstr " : "
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [P3Tann]
//
| P3Terr () => prstr "P3Terr()"
// end of [p3at_node]
end // end of [fprint_p3at]

implement
fprint_p3atlst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_p3at)
// end of [fprint_p3atlst]

(* ****** ****** *)

implement
fprint_d3exp
  (out, d3e0) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ d3e0.d3exp_node of
| D3Evar (d2v) => {
    val () = prstr "D3Evar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
| D3Eptrof_var (d2v) => {
    val () = prstr "D3Eptr_var("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
| D3Esel_var (d2v, d3ls) => {
    val () = prstr "D3Esel_var("
    val () = fprint_d2var (out, d2v)
    val () = prstr "; "
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D3Esel_ptr (d3e, d3ls) => {
    val () = prstr "D3Esel_ptr("
    val () = fprint_d3exp (out, d3e)
    val () = prstr "; "
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D3Esel_ref (d3e, d3ls) => {
    val () = prstr "D3Esel_ref("
    val () = fprint_d3exp (out, d3e)
    val () = prstr "; "
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| _ => {
    val () = prstr "D3E...(...)"
  }
//
end // end of [fprint_d3exp]

(* ****** ****** *)

implement
print_d3exp (x) = fprint_d3exp (stdout_ref, x)
implement
prerr_d3exp (x) = fprint_d3exp (stderr_ref, x)

(* ****** ****** *)

(* end of [pats_dynexp3_print.dats] *)
