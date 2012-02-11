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
// Start Time: January, 2012
//
(* ****** ****** *)

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

implement
fprint_c3str (out, c3t) = let
  macdef prstr (x) = fprint_string (out, ,(x))
in
//
case+ c3t.c3str_node of
| C3STRprop s2p => {
    val () = prstr "C3STRprop("
    val () = fprint_c3strkind (out, c3t.c3str_kind)
    val () = prstr "; "
    val () = fpprint_s2exp (out, s2p)
    val () = prstr ")"
  } // end of [C3STRprop]
| C3STRitmlst s3is => {
    val () = prstr "C3STRitmlst("
    val () = fprint_c3strkind (out, c3t.c3str_kind)
    val () = prstr "; "
    val () = fprint_s3itmlst (out, s3is)
    val () = prstr ")"
  } // end of [C3STRitmlst]
//
end // end of [fprint_c3str]

(* ****** ****** *)

implement
fprint_c3strkind (out, knd) = let
  macdef prstr (x) = fprint_string (out, ,(x))
in
//
case+ knd of
| C3STRKINDmain () => prstr "main"
(*
| C3STRKINDmetric_nat () => prstr "metric_nat"
| C3STRKINDmetric_dec () => prstr "metric_dec"
*)
| C3STRKINDcase_exhaustiveness _ => prstr "case_exhaustiveness"
(*
| C3STRKINDvarfin _ => prstr "varfin"
| C3STRKINDloop (knd) => begin
    prstr "loop("; fprint1_int (out, knd); prstr ")"
  end (* end of [C3STRKINDloop] *)
*)
//
end // end of [fprint_c3strkind]

(* ****** ****** *)

implement
fprint_h3ypo (out, h3p) = let
  macdef prstr (x) = fprint_string (out, ,(x))
in
//
case+ h3p.h3ypo_node of
| H3YPOprop s2p => {
    val () = prstr "H2YPOprop("
    val () = fpprint_s2exp (out, s2p)
    val () = prstr ")"
  } // end of [H3YPOprop]
| H3YPObind (s2v, s2p) => {
    val () = prstr "H2YPObind("
    val () = fprint_s2var (out, s2v)
    val () = prstr " -> "
    val () = fpprint_s2exp (out, s2p)
    val () = prstr ")"
  } // end of [H3YPObind]
| H3YPOeqeq (s2e1, s2e2) => {
    val () = prstr "H2YPOeqeq("
    val () = fpprint_s2exp (out, s2e1)
    val () = prstr " == "
    val () = fpprint_s2exp (out, s2e2)
    val () = prstr ")"
  } // end of [H3YPOeqeq]
//
end // end of [fprint_h3ypo]

(* ****** ****** *)

implement
fprint_s3itm (out, s3i) = let
  macdef prstr (x) = fprint_string (out, ,(x))
in
//
case+ s3i of
| S3ITMcstr (c3t) => {
    val () =  prstr "S3ITMcstr("
    val () = fprint_c3str (out, c3t)
    val () = prstr ")"
  } // end of [S3ITMcstr]
| S3ITMdisj (s3iss) => {
    val () =  prstr "S3ITMdisj("
    val () = fprint_s3itmlstlst (out, s3iss)
    val () = prstr ")"
  }
| S3ITMhypo (h3p) => {
    val () = prstr "S3ITMhypo("
    val () = fprint_h3ypo (out, h3p)
    val () = prstr ")"
  } // end of [S3ITMhypo]
| S3ITMsvar (s2v) => {
    val () = prstr "S3ITMsvar("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")"
  } // end of [S3ITMsvar]
| S3ITMsVar (s2V) => {
    val () = prstr "S3ITMsVar("
    val () = fprint_s2Var (out, s2V)
    val opt = s2Var_get_link (s2V)
    val () = (
      case+ opt of
      | Some s2e => (
          prstr "->"; fpprint_s2exp (out, s2e)
        ) // end of [Some]
      | None () => () // end of [None]
    ) : void // end of [val]
    val () = prstr ")"
  } // end of [S3ITMsVar]
//
end // end of [fprint_s3itm]

(* ****** ****** *)

implement
fprint_s3itmlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_s3itm)
// end of [fprint_s3itmlst]

implement
fprint_s3itmlstlst
  (out, xss) = $UT.fprintlst (out, xss, "; ", fprint_s3itmlst)
// end of [fprint_s3itmlstlst]

(* ****** ****** *)

(* end of [pats_trans3_env_print.dats] *)
