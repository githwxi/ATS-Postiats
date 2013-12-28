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
// Start Time: November, 2013
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_jsonize.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans3_env.sats"
staload "./pats_constraint3.sats"

(* ****** ****** *)

#define nil list_nil
#define :: list_cons
#define cons list_cons

(* ****** ****** *)

macdef
jsonize_loc (x) = jsonize_location (,(x))

(* ****** ****** *)

(*
//
// HX-2013-12-24:
// this does not seem to be really useful
//
extern
fun
jsonize_c3nstrkind: jsonize_ftype (c3nstrkind)
implement
jsonize_c3nstrkind
  (knd) = let
in
//
case+ knd of
//
| C3NSTRKmain () =>
    jsonval_conarg0 ("C3NSTRKmain")
//
| C3NSTRKcase_exhaustiveness
    (knd, p2tcss) => let
    val knd = jsonize_caskind (knd)
    val p2tcss = jsonize_ignored (p2tcss)
  in
    jsonval_conarg2
      ("C3NSTRKcase_exhaustiveness", knd, p2tcss)
  end // end of [C3NSTRKcase_exhaustiveness]
//
| C3NSTRKtermet_isnat () =>
    jsonval_conarg0 ("C3NSTRKtermet_isnat")
| C3NSTRKtermet_isdec () =>
    jsonval_conarg0 ("C3NSTRKtermet_isdec")
//
| C3NSTRKsome_fin
    (d2v, s2e1, s2e2) => let
    val d2v = jsonize_d2var (d2v)
    val s2e1 = jsonize_s2exp (s2e1)
    val s2e2 = jsonize_s2exp (s2e2)
  in
    jsonval_conarg3 ("C3NSTRKsome_fin", d2v, s2e1, s2e2)
  end // end of [C3NSTRKsome_fin]
| C3NSTRKsome_lvar
    (d2v, s2e1, s2e2) => let
    val d2v = jsonize_d2var (d2v)
    val s2e1 = jsonize_s2exp (s2e1)
    val s2e2 = jsonize_s2exp (s2e2)
  in
    jsonval_conarg3 ("C3NSTRKsome_lvar", d2v, s2e1, s2e2)
  end // end of [C3NSTRKsome_lvar]
| C3NSTRKsome_vbox
    (d2v, s2e1, s2e2) => let
    val d2v = jsonize_d2var (d2v)
    val s2e1 = jsonize_s2exp (s2e1)
    val s2e2 = jsonize_s2exp (s2e2)
  in
    jsonval_conarg3 ("C3NSTRKsome_vbox", d2v, s2e1, s2e2)
  end // end of [C3NSTRKsome_vbox]
//
| C3NSTRKlstate () =>
    jsonval_conarg0 ("C3NSTRKlstate")
| C3NSTRKlstate_var (d2v) =>
    jsonval_conarg1 ("C3NSTRKlstate_var", jsonize_d2var (d2v))
  // end of [C3NSTRKlstate_var]
//
| C3NSTRKloop (knd) =>
    jsonval_conarg1 ("C3NSTRKlloop", jsonval_int (knd))
//
end // end of [jsonize_c3nstrkind]
*)

(* ****** ****** *)

extern
fun jsonize_s3itm: jsonize_ftype (s3itm)
extern
fun jsonize_s3itmlst: jsonize_ftype (s3itmlst)
extern
fun jsonize_s3itmlstlst: jsonize_ftype (s3itmlstlst)

(* ****** ****** *)

extern fun jsonize_h3ypo: jsonize_ftype (h3ypo)
extern fun jsonize_c3nstropt: jsonize_ftype (c3nstropt)

(* ****** ****** *)

implement
jsonize_s3itm (s3i) = let
in
//
case+ s3i of
//
| S3ITMsvar (s2v) =>
    jsonval_conarg1 ("S3ITMsvar", jsonize_s2var (s2v))
  // end of [S3ITMsvar]
//
| S3ITMhypo (h3p) =>
    jsonval_conarg1 ("S3ITMhypo", jsonize_h3ypo (h3p))
  // end of [S3ITMhypo]
//
| S3ITMsVar (s2V) =>
    jsonval_conarg1 ("S3ITMsVar", jsonize_s2Var (s2V))
  // end of [S3ITMsVar]
//
| S3ITMcnstr (c3t) =>
    jsonval_conarg1 ("S3ITMcnstr", jsonize_c3nstr (c3t))
  // end of [S3ITMcnstr]
//
| S3ITMcnstr_ref (c3tr) => let
    val loc = c3tr.c3nstroptref_loc
    val ref = c3tr.c3nstroptref_ref
    val loc = jsonize_location (loc)
    val opt = jsonize_c3nstropt (!ref)
  in
    jsonval_conarg2 ("S3ITMcnstr_ref", loc, opt)
  end // end of [S3ITMcnstr_ref]
//
| S3ITMdisj (s3iss) =>
    jsonval_conarg1 ("S3ITMdisj", jsonize_s3itmlstlst (s3iss))
  // end of [S3ITMdisj]
//
end // end of [jsonize_s3itm]

(* ****** ****** *)
//
implement
jsonize_s3itmlst
  (s3is) = jsonize_list_fun (s3is, jsonize_s3itm)
implement
jsonize_s3itmlstlst
  (s3iss) = jsonize_list_fun (s3iss, jsonize_s3itmlst)
//
(* ****** ****** *)

implement
jsonize_h3ypo (h3p0) = let
//
fun auxmain
  (h3p0: h3ypo): jsonval = let
in
//
case+
h3p0.h3ypo_node of
//
| H3YPOprop (s2e) => let
(*
    val () =
    println! ("jsonize_h3ypo: H3YPOprop: s2e = ", s2e)
*)
  in
    jsonval_conarg1 ("H3YPOprop", jsonize1_s2exp (s2e))
  end // end of [H3YPOprop]
| H3YPObind (s2v1, s2e2) => let
(*
    val () =
    println! ("jsonize_h3ypo: H3YPObind: s2v1 = ", s2v1)
    val () =
    println! ("jsonize_h3ypo: H3YPObind: s2e2 = ", s2e2)
*)
  in
    jsonval_conarg2
      ("H3YPObind", jsonize_s2var(s2v1), jsonize1_s2exp(s2e2))
  end // end of [H3YPObind]
| H3YPOeqeq (s2e1, s2e2) => let
(*
    val () =
    println! ("jsonize_h3ypo: H3YPObind: s2e1 = ", s2e1)
    val () =
    println! ("jsonize_h3ypo: H3YPObind: s2e2 = ", s2e2)
*)
  in
    jsonval_conarg2
      ("H3YPOeqeq", jsonize1_s2exp(s2e1), jsonize1_s2exp(s2e2))
  end // end of [H3YPOeqeq]
//
end // end of [auxmain]
//
val loc0 = h3p0.h3ypo_loc
val loc0 = jsonize_loc (loc0)
val h3p0 = auxmain (h3p0)
//
in
  jsonval_labval2 ("h3ypo_loc", loc0, "h3ypo_node", h3p0)
end // end of [jsonize_h3ypo]

(* ****** ****** *)

implement
jsonize_c3nstr (c3t0) = let
//
fun auxmain
  (c3t0: c3nstr): jsonval = let
in
//
case+
c3t0.c3nstr_node of
//
| C3NSTRprop (s2e) =>
    jsonval_conarg1 ("C3NSTRprop", jsonize1_s2exp (s2e))
  // end of [C3NSTRprop]
//
| C3NSTRitmlst (s3is) =>
    jsonval_conarg1 ("C3NSTRitmlst", jsonize_s3itmlst (s3is))
  // end of [C3NSTRitmlst]
//
end // end of [auxmain]
//
val loc0 = c3t0.c3nstr_loc
val loc0 = jsonize_loc (loc0)
val c3t0 = auxmain (c3t0)
//
in
  jsonval_labval2 ("c3nstr_loc", loc0, "c3nstr_node", c3t0)
end // end of [jsonize_c3nstr]

(* ****** ****** *)

implement
jsonize_c3nstropt
  (opt) = jsonize_option_fun (opt, jsonize_c3nstr)
// end of [jsonize_c3nstropt]

(* ****** ****** *)

implement
c3nstr_export
  (out, c3t0) = let
//
val jsv0 = jsonize_c3nstr (c3t0)
//
val ((*void*)) = fprint_jsonval (out, jsv0)
val ((*void*)) = fprint_newline (out)
in
  // nothing
end // end of [c3nstr_export]

(* ****** ****** *)

(* end of [pats_constraint3_jsonize.dats] *)
