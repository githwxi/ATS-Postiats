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
// Authoremail: gmhwxiATgmailDOTcom
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

staload
LEX = "./pats_lexing.sats"
typedef token = $LEX.token

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_staexp2_jsonize.dats"

(* ****** ****** *)

#define nil list_nil
#define :: list_cons
#define cons list_cons

(* ****** ****** *)

macdef
jsonize_loc (x) = jsonize_location (,(x))

(* ****** ****** *)

extern
fun jsonize_i0nt (tok: token): jsonval
extern
fun jsonize_c0har (tok: token): jsonval
extern
fun jsonize_f0loat (tok: token): jsonval
extern
fun jsonize_s0tring (tok: token): jsonval

(* ****** ****** *)

extern
fun jsonize_d2cst : jsonize_type (d2cst)
extern
fun jsonize_d2var : jsonize_type (d2var)
extern
fun jsonize_d2sym : jsonize_type (d2sym)

(* ****** ****** *)

extern
fun jsonize_p2at : jsonize_type (p2at)
extern
fun jsonize_p2atlst : jsonize_type (p2atlst)
extern
fun jsonize_pckind : jsonize_type (pckind)

(* ****** ****** *)

extern
fun jsonize_d2exp : jsonize_type (d2exp)
extern
fun jsonize_d2explst : jsonize_type (d2explst)
extern
fun jsonize_d2expopt : jsonize_type (d2expopt)
  
(* ****** ****** *)

extern
fun jsonize_d2exparg : jsonize_type (d2exparg)
extern
fun jsonize_d2exparglst : jsonize_type (d2exparglst)

(* ****** ****** *)

implement
jsonize_i0nt
  (tok) = let
//
val-$LEX.T_INTEGER
  (base, rep, sfx) = tok.token_node
//
in
  jsonval_string (rep)
end // end of [jsonize_i0nt]

implement
jsonize_c0har
  (tok) = let
//
val-$LEX.T_CHAR(c) = tok.token_node
//
in
  jsonval_int (int_of_char(c))
end (* end of [jsonize_c0har] *)

implement
jsonize_f0loat
  (tok) = let
//
val-$LEX.T_FLOAT
  (base, rep, sfx) = tok.token_node
//
in
  jsonval_string (rep)
end // end of [jsonize_f0loat]

implement
jsonize_s0tring
  (tok) = let
//
val-$LEX.T_STRING (rep) = tok.token_node
//
in
  jsonval_string (rep)
end // end of [jsonize_s0tring]

(* ****** ****** *)

implement
jsonize_d2cst
  (d2c) = let
//
val sym =
  jsonize_symbol (d2cst_get_sym (d2c))
val stamp =
  jsonize_stamp (d2cst_get_stamp (d2c))
//
in
//
jsonval_labval2 ("d2cst_name", sym, "d2cst_stamp", stamp)
//
end // end of [jsonize_d2cst]

(* ****** ****** *)

implement
jsonize_d2var
  (d2v) = let
//
val sym =
  jsonize_symbol (d2var_get_sym (d2v))
val stamp =
  jsonize_stamp (d2var_get_stamp (d2v))
//
in
//
jsonval_labval2 ("d2var_name", sym, "d2var_stamp", stamp)
//
end // end of [jsonize_d2var]

(* ****** ****** *)

implement
jsonize_d2sym
  (d2s) = let
//
val sym =
  jsonize_symbol (d2s.d2sym_sym)
//
in
  jsonval_labval1 ("d2sym_name", sym)
end // end of [jsonize_d2sym]

(* ****** ****** *)

extern fun jsonize_f2undec : jsonize_type (f2undec)
extern fun jsonize_f2undeclst : jsonize_type (f2undeclst)

(* ****** ****** *)

extern fun jsonize_v2aldec : jsonize_type (v2aldec)
extern fun jsonize_v2aldeclst : jsonize_type (v2aldeclst)

(* ****** ****** *)

implement
jsonize_pckind (knd) =
(
  case+ knd of
  | PCKcon () => jsonval_string "PCKcon"
  | PCKlincon () => jsonval_string "PCKlincon"
  | PCKfree () => jsonval_string "PCKfree"
  | PCKunfold () => jsonval_string "PCKunfold"
) (* end of [jsonize_pckind] *)

(* ****** ****** *)

local

fun aux0
(
  name: string
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (list_nil)
in
  jsonval_labval2 ("p2at_name", name, "p2at_arglst", arglst)
end // end of [aux0]

fun aux1
(
  name: string, arg: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_sing (arg)
in
  jsonval_labval2 ("p2at_name", name, "p2at_arglst", arglst)
end // end of [aux1]

fun aux2
(
  name: string
, arg1: jsonval, arg2: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_pair (arg1, arg2)
in
  jsonval_labval2 ("p2at_name", name, "p2at_arglst", arglst)
end // end of [aux2]

fun aux3
(
  name: string
, arg1: jsonval, arg2: jsonval, arg3: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (arg1 :: arg2 :: arg3 :: nil ())
in
  jsonval_labval2 ("p2at_name", name, "p2at_arglst", arglst)
end // end of [aux2]

in (* in of [local] *)

implement
jsonize_p2at
  (p2t0) = let
//
fun auxmain
  (p2t0: p2at): jsonval = let
in
//
case+ p2t0.p2at_node of
//
| P2Tany () => aux0 ("P2Tany")
| P2Tvar (d2v) => let
    val jsv1 = jsonize_d2var (d2v)
  in
    aux1 ("P2Tvar", jsv1)
  end // end of [P2Tvar]
//
| P2Tcon
  (
    pcknd, d2c, s2qs, s2e_con, npf, p2ts
  ) => let
    val name = "P2Tcon"
    val name =
      jsonval_string (name)
    val jsv1 =
      jsonize_pckind (pcknd)
    val jsv2 = jsonize_d2con (d2c)
    val jsv3 = jsonize_ignored (s2qs)
    val jsv4 = jsonize_ignored (s2e_con)
    val jsv5 = jsonval_int (npf)
    val jsv6 = jsonize_p2atlst (p2ts)
    val arglst =
    jsonval_list (
      jsv1 :: jsv2 :: jsv3 :: jsv4 :: jsv5 :: jsv6 :: nil ()
    ) (* end of [val] *)
  in
    jsonval_labval2 ("p2at_name", name, "p2at_arglst", arglst)
  end // end of [P2Tcon]
//
| P2Tint (i) => aux1 ("P2Tint", jsonval_int (i))
| P2Tintrep (rep) => aux1 ("P2Tint", jsonval_string (rep))
//
| P2Tbool (b) => aux1 ("P2Tbool", jsonval_bool (b))
| P2Tchar (c) => aux1 ("P2Tbool", jsonval_int (int_of_char(c)))
| P2Tfloat (rep) => aux1 ("P2Tfloat", jsonval_string (rep))
| P2Tstring (str) => aux1 ("P2Tstring", jsonval_string (str))
//
| P2Ti0nt (tok) => aux1 ("P2Ti0nt", jsonize_i0nt (tok))
| P2Tf0loat (tok) => aux1 ("P2Tf0loat", jsonize_f0loat (tok))
//
| P2Tempty () => aux0 ("P2Tempty")
//
| P2Trefas (d2v, p2t) =>
  (
    aux2 ("P2Trefas", jsonize_d2var (d2v), jsonize_p2at (p2t))
  ) (* end of [P2Trefas] *)
//
| P2Tvbox (d2v) => aux1 ("P2Tvbox", jsonize_d2var (d2v))
//
| P2Terr ((*void*)) => aux0 ("P2Terr")
//
| _ => jsonize_ignored (p2t0)
//
end // end of [auxmain]
//
val loc0 = p2t0.p2at_loc
val loc0 = jsonize_loc (loc0)
val p2t0 = auxmain (p2t0)
//
in
  jsonval_labval2 ("p2at_loc", loc0, "p2at_node", p2t0)
end // end of [jsonize_p2at]

end // end of [local]

(* ****** ****** *)

implement
jsonize_p2atlst
  (p2ts) = let
//
val jsvs =
  list_map_fun (p2ts, jsonize_p2at)
//
in
  jsonval_list (list_of_list_vt (jsvs))
end // end of [jsonize_p2atlst]

(* ****** ****** *)

local

fun aux0
(
  name: string
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (list_nil)
in
  jsonval_labval2 ("d2exp_name", name, "d2exp_arglst", arglst)
end // end of [aux0]

fun aux1
(
  name: string, arg: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_sing (arg)
in
  jsonval_labval2 ("d2exp_name", name, "d2exp_arglst", arglst)
end // end of [aux1]

fun aux2
(
  name: string
, arg1: jsonval, arg2: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_pair (arg1, arg2)
in
  jsonval_labval2 ("d2exp_name", name, "d2exp_arglst", arglst)
end // end of [aux2]

fun aux3
(
  name: string
, arg1: jsonval, arg2: jsonval, arg3: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (arg1 :: arg2 :: arg3 :: nil ())
in
  jsonval_labval2 ("d2exp_name", name, "d2exp_arglst", arglst)
end // end of [aux3]

fun aux4
(
  name: string
, arg1: jsonval, arg2: jsonval, arg3: jsonval, arg4: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (arg1 :: arg2 :: arg3 :: arg4 :: nil ())
in
  jsonval_labval2 ("d2exp_name", name, "d2exp_arglst", arglst)
end // end of [aux4]

in (* in of [local] *)

implement
jsonize_d2exp
  (d2e0) = let
//
fun auxmain
  (d2e0: d2exp): jsonval = let
in
//
case+
d2e0.d2exp_node of
//
| D2Ecst (d2c) => let
    val jsv1 = jsonize_d2cst (d2c)
  in
    aux1 ("D2Ecst", jsv1)
  end // end of [D2Ecst]
| D2Evar (d2v) => let
    val jsv1 = jsonize_d2var (d2v)
  in
    aux1 ("D2Evar", jsv1)
  end // end of [D2Evar]
//
| D2Eint (int) =>
    aux1 ("D2Eint", jsonval_int (int))
//
| D2Ei0nt (tok) =>
    aux1 ("D2Ei0nt", jsonize_i0nt (tok))
| D2Ef0loat (tok) =>
    aux1 ("D2Ef0loat", jsonize_f0loat (tok))
| D2Es0tring (tok) =>
    aux1 ("D2Es0tring", jsonize_s0tring (tok))
//
| D2Esym (d2s) =>
    aux1 ("D2Esym", jsonize_d2sym (d2s))
//
| D2Eapplst
    (d2e, d2as) => let
    val jsv1 = jsonize_d2exp (d2e)
    val jsv2 = jsonize_d2exparglst (d2as)
  in
    aux2 ("D2Eapplst", jsv1, jsv2)
  end // end of [D2Eapplst]
//
| D2Eifhead
  (
    inv, _test, _then, _else
  ) => let
    val jsv1 = jsonize_ignored (inv)
    val jsv2 = jsonize_d2exp (_test)
    val jsv3 = jsonize_d2exp (_then)
    val jsv4 = jsonize_d2expopt (_else)
  in
    aux4 ("D2Eifhead", jsv1, jsv2, jsv3, jsv4)
  end // end of [D2Eifhead]
//
| D2Elam_dyn
  (
    lin, npf, p2ts_arg, d2e_body
  ) => let
    val jsv1 = jsonval_int (lin)
    val jsv2 = jsonval_int (npf)
    val jsv3 = jsonize_p2atlst (p2ts_arg)
    val jsv4 = jsonize_d2exp (d2e_body)
  in
    aux4 ("D2Elam_dyn", jsv1, jsv2, jsv3, jsv4)
  end // end of [D2Elam_dyn]
//
| D2Eann_type
    (d2e, s2e) => let
    val jsv1 = jsonize_d2exp (d2e)
    val jsv2 = jsonize_s2exp (s2e)
  in
    aux2 ("D2Eann_type", jsv1, jsv2)
  end // end of [D2Eann_type]
| D2Eann_seff
    (d2e, s2fe) => let
    val jsv1 = jsonize_d2exp (d2e)
    val jsv2 = jsonize_s2eff (s2fe)
  in
    aux2 ("D2Eann_seff", jsv1, jsv2)
  end // end of [D2Eann_seff]
| D2Eann_funclo
    (d2e, funclo) => let
    val jsv1 = jsonize_d2exp (d2e)
    val jsv2 = jsonize_funclo (funclo)
  in
    aux2 ("D2Eann_funclo", jsv1, jsv2)
  end // end of [D2Eann_funclo]
//
| _ => jsonize_ignored (d2e0)
//
end // end of [auxmain]
//
val loc0 = d2e0.d2exp_loc
val loc0 = jsonize_loc (loc0)
val d2e0 = auxmain (d2e0)
//
in
  jsonval_labval2 ("d2exp_loc", loc0, "d2exp_node", d2e0)
end // end of [jsonize_d2exp]

end // end of [local]

(* ****** ****** *)
  
implement
jsonize_d2explst
  (d2es) = let
//
val jsvs =
  list_map_fun (d2es, jsonize_d2exp)
//
in
  jsonval_list (list_of_list_vt (jsvs))
end // end of [jsonize_d2explst]

implement
jsonize_d2expopt
  (opt) = let
in
//
case+ opt of
| None () => jsonval_none ()
| Some (d2e) => jsonval_some (jsonize_d2exp (d2e))
//
end // end of [jsonize_d2expopt]

(* ****** ****** *)

implement
jsonize_d2exparg
  (d2a) = let
in
//
case+ d2a of
| D2EXPARGsta
    (loc, s2as) => let
    val name = "D2EXPARGsta"
    val name = jsonval_string (name)
    val arglst = jsonval_list (list_nil)
  in
    jsonval_labval2 ("d2exparg_name", name, "d2exparg_arglst", arglst)
  end // end of [D2EXPARGsta]
| D2EXPARGdyn
    (npf, loc, d2es) => let
    val name = "D2EXPARGdyn"
    val name = jsonval_string (name)
    val jsv1 = jsonval_int (npf)
    val jsv2 = jsonize_loc (loc)
    val jsv3 = jsonize_d2explst (d2es)
    val arglst = jsonval_list (jsv1 :: jsv2 :: jsv3 :: nil ())
  in
    jsonval_labval2 ("d2exparg_name", name, "d2exparg_arglst", arglst)
  end // end of [D2EXPARGdyn]
//
end // end of [jsonize_d2exparg]
  
(* ****** ****** *)

implement
jsonize_d2exparglst
  (d2as) = let
//
val jsvs =
  list_map_fun (d2as, jsonize_d2exparg)
//
in
  jsonval_list (list_of_list_vt (jsvs))
end // end of [jsonize_d2exparglst]

(* ****** ****** *)

local

fun aux0
(
  name: string
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (list_nil)
in
  jsonval_labval2 ("d2ecl_name", name, "d2ecl_arglst", arglst)
end // end of [aux0]

fun aux1
(
  name: string, arg: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_sing (arg)
in
  jsonval_labval2 ("d2ecl_name", name, "d2ecl_arglst", arglst)
end // end of [aux1]

fun aux2
(
  name: string
, arg1: jsonval, arg2: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_pair (arg1, arg2)
in
  jsonval_labval2 ("d2ecl_name", name, "d2ecl_arglst", arglst)
end // end of [aux2]

fun aux3
(
  name: string
, arg1: jsonval, arg2: jsonval, arg3: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (arg1 :: arg2 :: arg3 :: nil ())
in
  jsonval_labval2 ("d2ecl_name", name, "d2ecl_arglst", arglst)
end // end of [aux2]

in (* in of [local] *)

implement
jsonize_d2ecl
  (d2c0) = let
//
fun auxmain
  (d2c0: d2ecl): jsonval = let
in
//
case+
d2c0.d2ecl_node of
//
| D2Cnone () => aux0 ("D2Cnone")
| D2Clist (d2cs) =>
    aux1 ("D2Clist", jsonize_d2eclist (d2cs))
  // end of [D2Clist]
//
| D2Cfundecs
  (
    knd, s2qs, f2ds
  ) => let
    val knd = jsonize_funkind (knd)
    val s2qs = jsonize_ignored (s2qs)
    val f2ds = jsonize_f2undeclst (f2ds)
  in
    aux3 ("D2Cfundecs", knd, s2qs, f2ds)
  end // end of [D2Cfundecs]
//
| D2Cvaldecs
    (knd, v2ds) => let
    val knd = jsonize_valkind (knd)
    val v2ds = jsonize_v2aldeclst (v2ds)
  in
    aux2 ("D2Cvaldecs", knd, v2ds)
  end // end of [D2Cvaldecs]
//
| D2Cinclude (d2cs) =>
    aux1 ("D2Cinclude", jsonize_d2eclist (d2cs))
  // end of [D2Cinclude]
//
| _ => jsonize_ignored (d2c0)
//
end // end of [auxmain]
//
val loc0 = d2c0.d2ecl_loc
val loc0 = jsonize_loc (loc0)
val d2c0 = auxmain (d2c0)
//
in
  jsonval_labval2 ("d2ecl_loc", loc0, "d2ecl_node", d2c0)
end // end of [jsonize_d2ecl]

end // end of [local]

(* ****** ****** *)

implement
jsonize_d2eclist
  (d2cs) = let
//
val jsvs =
  list_map_fun (d2cs, jsonize_d2ecl)
//
in
  jsonval_list (list_of_list_vt (jsvs))
end // end of [jsonize_d2eclist]

(* ****** ****** *)

implement
jsonize_f2undec
  (f2d) = let
//
val loc = jsonize_loc (f2d.f2undec_loc)
val d2v = jsonize_d2var (f2d.f2undec_var)
val def = jsonize_d2exp (f2d.f2undec_def)
val ann = jsonize_ignored (f2d.f2undec_ann)
//
in
//
jsonval_labval4 (
  "f2undec_loc", loc, "f2undec_var", d2v, "f2undec_def", def, "f2undec_ann", ann
) (* end of [jsonize_labval4] *)
//
end // end of [json_f2undec]

(* ****** ****** *)

implement
jsonize_f2undeclst
  (d2cs) = let
//
val jsvs =
  list_map_fun (d2cs, jsonize_f2undec)
//
in
  jsonval_list (list_of_list_vt (jsvs))
end // end of [jsonize_f2undeclst]

(* ****** ****** *)

implement
jsonize_v2aldec
  (v2d) = let
//
val loc = jsonize_loc (v2d.v2aldec_loc)
val pat = jsonize_p2at (v2d.v2aldec_pat)
val def = jsonize_d2exp (v2d.v2aldec_def)
val ann = jsonize_ignored (v2d.v2aldec_ann)
//
in
//
jsonval_labval4 (
  "v2aldec_loc", loc, "v2aldec_pat", pat, "v2aldec_def", def, "v2aldec_ann", ann
) (* end of [jsonize_labval4] *)
//
end // end of [json_v2aldec]

(* ****** ****** *)

implement
jsonize_v2aldeclst
  (d2cs) = let
//
val jsvs =
  list_map_fun (d2cs, jsonize_v2aldec)
//
in
  jsonval_list (list_of_list_vt (jsvs))
end // end of [jsonize_v2aldeclst]

(* ****** ****** *)

(* end of [pats_dynexp2_jsonize.dats] *)
