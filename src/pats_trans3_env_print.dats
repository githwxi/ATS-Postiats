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
// Start Time: January, 2012
//
(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

implement
fprint_c3nstr
  (out, c3t) = let
//
macdef prstr (x) = fprint_string (out, ,(x))
//
in
//
case+
c3t.c3nstr_node
of // case+
| C3NSTRprop
    (s2p) => {
    val () =
      prstr "C3NSTRprop("
    val () = fprint_c3nstrkind (out, c3t.c3nstr_kind)
    val () = prstr "; "
    val () = fpprint_s2exp (out, s2p)
    val ((*closing*)) = prstr ")"
  } (* end of [C3NSTRprop] *)
| C3NSTRitmlst
    (s3is) => {
    val () =
      prstr "C3NSTRitmlst("
    val () = fprint_c3nstrkind (out, c3t.c3nstr_kind)
    val () = prstr "; "
    val () = fprint_s3itmlst (out, s3is)
    val ((*closing*)) = prstr ")"
  } (* end of [C3NSTRitmlst] *)
//
| C3NSTRsolverify
    (s2e_prop) => {
    val () =
      prstr "C3NSTRsolverify("
    val () = fprint_s2exp (out, s2e_prop)
    val ((*closing*)) = prstr ")"
  } (* end of [C3NSTRsolverify] *)
//
end // end of [fprint_c3nstr]

implement
print_c3nstr (x) = fprint_c3nstr (stdout_ref, x)
implement
prerr_c3nstr (x) = fprint_c3nstr (stderr_ref, x)

(* ****** ****** *)

implement
fprint_c3nstrkind
  (out, knd) = let
//
macdef prstr (x) = fprint_string (out, ,(x))
//
in
//
case+ knd of
| C3TKmain() =>
    prstr "C3TKmain()"
| C3TKcase_exhaustiveness _ =>
    prstr "C3TKcase_exhaustiveness(...)"
//
| C3TKtermet_isnat() =>
    prstr "C3TKtermet_isnat()"
| C3TKtermet_isdec() =>
    prstr "C3TKtermet_isdec()"
//
| C3TKsome_fin _ =>
    prstr "C3TKsome_fin()"
| C3TKsome_lvar _ =>
    prstr "C3TKsome_lvar()"
| C3TKsome_vbox _ =>
    prstr "C3TKsome_vbox()"
//
| C3TKlstate() =>
    prstr "C3TKlstate()"
| C3TKlstate_var(d2v) =>
  (
    fprint!
      (out, "C3TKlstate(", d2v, ")")
    // fprint!
  ) (* C3TKlstate_var *)
//
| C3TKloop(knd) =>
    fprint! (out, "C3TKloop(", knd, ")")
//
| C3TKsolverify() => prstr "C3TKsolverify()"
//
end // end of [fprint_c3nstrkind]

(* ****** ****** *)

implement
fprint_h3ypo
  (out, h3p) = let
//
macdef
prstr (x) =
  fprint_string (out, ,(x))
//
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

implement
print_h3ypo (x) = fprint_h3ypo (stdout_ref, x)
implement
prerr_h3ypo (x) = fprint_h3ypo (stderr_ref, x)

(* ****** ****** *)

implement
fprint_s3itm
  (out, s3i) = let
//
macdef prstr (x) = fprint_string (out, ,(x))
//
in
//
case+ s3i of
//
| S3ITMsvar (s2v) => {
    val () = prstr "S3ITMsvar("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")"
  } // end of [S3ITMsvar]
| S3ITMhypo (h3p) => {
    val () = prstr "S3ITMhypo("
    val () = fprint_h3ypo (out, h3p)
    val () = prstr ")"
  } // end of [S3ITMhypo]
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
| S3ITMcnstr (c3t) => {
    val () = prstr "S3ITMcnstr("
    val () = fprint_c3nstr (out, c3t)
    val () = prstr ")"
  } // end of [S3ITMcnstr]
| S3ITMcnstr_ref (ctr) => {
    val ref = ctr.c3nstroptref_ref
    val () = prstr "S3ITMcnstr_ref("
    val () = (
      case+ !ref of
      | Some c3t => fprint_c3nstr (out, c3t) | None () => ()
    ) : void // end of [val]
    val () = prstr ")"
  } // end of [S3ITMcnstr_ref]
//
| S3ITMdisj (s3iss) => {
    val () = prstr "S3ITMdisj("
    val () = fprint_s3itmlstlst (out, s3iss)
    val () = prstr ")"
  }
//
| S3ITMsolassert
    (s2e_prop) => {
    val () =
      prstr "S3ITMsolassert("
    val () = fprint_s2exp (out, s2e_prop)
    val ((*closing*)) = prstr ")"
  } (* end of [S3ITMsolassert] *)
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
