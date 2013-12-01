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
datatype
c3nstrkind =
  | C3NSTRKINDmain of () // generic
//
  | C3NSTRKINDcase_exhaustiveness of
      (caskind (*case/case+*), p2atcstlst) // no [case-]
//
  | C3NSTRKINDtermet_isnat of () // term. metric welfounded
  | C3NSTRKINDtermet_isdec of () // term. metric decreasing
//
  | C3NSTRKINDsome_fin of (d2var, s2exp(*fin*), s2exp)
  | C3NSTRKINDsome_lvar of (d2var, s2exp(*lvar*), s2exp)
  | C3NSTRKINDsome_vbox of (d2var, s2exp(*vbox*), s2exp)
//
  | C3NSTRKINDlstate of () // lstate merge
  | C3NSTRKINDlstate_var of (d2var) // lstate merge for d2var
//
  | C3NSTRKINDloop of (int) // HX: ~1/0/1: enter/break/continue
// end of [c3nstrkind]
*)
extern
fun jsonize_c3nstrkind: jsonize_type (c3nstrkind)

(* ****** ****** *)

implement
jsonize_c3nstrkind
  (knd) = let
//
fun aux0
(
  name: string
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (list_nil)
in
//
jsonval_labval2
  ("c3nstrkind_name", name, "c3nstrkind_arglst", arglst)
//
end // end of [aux0]
//
fun aux1
(
  name: string, arg: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_sing (arg)
in
//
jsonval_labval2
  ("c3nstrkind_name", name, "c3nstrkind_arglst", arglst)
//
end // end of [aux1]
//
fun aux2
(
  name: string
, arg1: jsonval, arg2: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_pair (arg1, arg2)
in
//
jsonval_labval2
  ("c3nstrkind_name", name, "c3nstrkind_arglst", arglst)
//
end // end of [aux2]

fun aux3
(
  name: string
, arg1: jsonval, arg2: jsonval, arg3: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (arg1 :: arg2 :: arg3 :: nil())
in
//
jsonval_labval2
  ("c3nstrkind_name", name, "c3nstrkind_arglst", arglst)
//
end // end of [aux3]
//
in
//
case+ knd of
//
| C3NSTRKINDmain () => aux0 ("C3NSTRKINDmain")
//
| C3NSTRKINDcase_exhaustiveness
    (knd, p2tcss) => let
    val knd = jsonize_caskind (knd)
    val p2tcss = jsonize_ignored (p2tcss)
  in
    aux2 ("C3NSTRKINDcase_exhaustiveness", knd, p2tcss)
  end // end of [C3NSTRKINDcase_exhaustiveness]
//
| C3NSTRKINDtermet_isnat () => aux0 ("C3NSTRKINDtermet_isnat")
| C3NSTRKINDtermet_isdec () => aux0 ("C3NSTRKINDtermet_isdec")
//
| C3NSTRKINDsome_fin
    (d2v, s2e1, s2e2) => let
    val d2v = jsonize_d2var (d2v)
    val s2e1 = jsonize_s2exp (s2e1)
    val s2e2 = jsonize_s2exp (s2e2)
  in
    aux3 ("C3NSTRKINDsome_fin", d2v, s2e1, s2e2)
  end // end of [C3NSTRKINDsome_fin]
| C3NSTRKINDsome_lvar
    (d2v, s2e1, s2e2) => let
    val d2v = jsonize_d2var (d2v)
    val s2e1 = jsonize_s2exp (s2e1)
    val s2e2 = jsonize_s2exp (s2e2)
  in
    aux3 ("C3NSTRKINDsome_lvar", d2v, s2e1, s2e2)
  end // end of [C3NSTRKINDsome_lvar]
| C3NSTRKINDsome_vbox
    (d2v, s2e1, s2e2) => let
    val d2v = jsonize_d2var (d2v)
    val s2e1 = jsonize_s2exp (s2e1)
    val s2e2 = jsonize_s2exp (s2e2)
  in
    aux3 ("C3NSTRKINDsome_vbox", d2v, s2e1, s2e2)
  end // end of [C3NSTRKINDsome_vbox]
//
| C3NSTRKINDlstate () => aux0 ("C3NSTRKINDlstate")
| C3NSTRKINDlstate_var (d2v) => let
    val d2v = jsonize_d2var (d2v) in aux1 ("C3NSTRKINDlstate_var", d2v)
  end // end of [C3NSTRKINDlstate_var]
//
| C3NSTRKINDloop (knd) =>
    aux1 ("C3NSTRKINDlloop", jsonval_int (knd))
//
end // end of [jsonize_c3nstrkind]

(* ****** ****** *)

(*
datatype s3itm =
  | S3ITMsvar of s2var
  | S3ITMhypo of h3ypo
  | S3ITMsVar of s2Var
  | S3ITMcnstr of c3nstr
  | S3ITMcnstr_ref of c3nstroptref // HX: for handling state types
  | S3ITMdisj of s3itmlstlst
// end of [s3item]
*)
extern
fun jsonize_s3itm: jsonize_type (s3itm)
extern
fun jsonize_s3itmlst: jsonize_type (s3itmlst)
extern
fun jsonize_s3itmlstlst: jsonize_type (s3itmlstlst)

(* ****** ****** *)

implement
jsonize_s3itm (s3i) = let
//
fun aux0
(
  name: string
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (list_nil)
in
//
jsonval_labval2
  ("s3itm_name", name, "s3itm_arglst", arglst)
//
end // end of [aux0]
//
fun aux1
(
  name: string, arg: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_sing (arg)
in
//
jsonval_labval2
  ("s3itm_name", name, "s3itm_arglst", arglst)
//
end // end of [aux1]
//
in
//
case+ s3i of
| S3ITMsvar (s2v) =>
    aux1 ("S3ITMsvar", jsonize_s2var (s2v))
| S3ITMcnstr (c3t) =>
    aux1 ("S3ITMcnstr", jsonize_c3nstr (c3t))
| S3ITMdisj (s3iss) =>
    aux1 ("S3ITMdisj", jsonize_s3itmlstlst (s3iss))
//
| _(*yet-to-be-processed*) => aux0 ("S3ITMignored")
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

local

fun aux0
(
  name: string
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (list_nil)
in
  jsonval_labval2 ("c3nstr_name", name, "c3nstr_arglst", arglst)
end // end of [aux0]

fun aux1
(
  name: string, arg: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_sing (arg)
in
  jsonval_labval2 ("c3nstr_name", name, "c3nstr_arglst", arglst)
end // end of [aux1]

fun aux2
(
  name: string
, arg1: jsonval, arg2: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_pair (arg1, arg2)
in
  jsonval_labval2 ("c3nstr_name", name, "c3nstr_arglst", arglst)
end // end of [aux2]

fun aux3
(
  name: string
, arg1: jsonval, arg2: jsonval, arg3: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (arg1 :: arg2 :: arg3 :: nil())
in
  jsonval_labval2 ("c3nstr_name", name, "c3nstr_arglst", arglst)
end // end of [aux3]

fun aux4
(
  name: string
, arg1: jsonval, arg2: jsonval, arg3: jsonval, arg4: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (arg1 :: arg2 :: arg3 :: arg4 :: nil())
in
  jsonval_labval2 ("c3nstr_name", name, "c3nstr_arglst", arglst)
end // end of [aux4]

in (* in of [local] *)

implement
jsonize_c3nstr
  (c3t0) = let
//
fun auxmain
  (c3t0: c3nstr): jsonval = let
in
//
case+
c3t0.c3nstr_node of
//
| _ (*yet-to-be-processed*) => aux0 ("C3NSTRignored")
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

end // end of [local]

(* ****** ****** *)

implement
c3nstr_export (out, c3t0) = ()

(* ****** ****** *)

(* end of [pats_constraint3_jsonize.dats] *)
