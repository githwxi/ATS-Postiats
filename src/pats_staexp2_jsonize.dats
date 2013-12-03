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

(* ****** ****** *)

#define nil list_nil
#define :: list_cons
#define cons list_cons

(* ****** ****** *)

macdef
jsonize_loc (x) = jsonize_location (,(x))

(* ****** ****** *)

extern
fun jsonize_s2rtbas: jsonize_ftype (s2rtbas)

(* ****** ****** *)

implement
jsonize_s2rt
  (s2t0) = let
in
//
case+ s2t0 of
| S2RTbas (s2tb) => jsonize_s2rtbas (s2tb)
| S2RTfun (_, _) => jsonval_string ("s2rt_fun")
| S2RTtup (s2ts) => jsonval_string ("s2rt_tup")
| _(*unspecified*) => jsonval_string ("s2rt_anon")
//
end // end of [jsonize_s2rt]
  
(* ****** ****** *)

implement
jsonize_s2rtbas
  (s2tb) = let
in
//
case+ s2tb of
| S2RTBASpre (sym) => jsonize_symbol (sym)
| S2RTBASimp (knd, sym) => jsonize_symbol (sym)
| S2RTBASdef (s2td) => let
    val sym = s2rtdat_get_sym (s2td) in jsonize_symbol (sym)
  end // end of [S2RTBASdef]
//
end // end of [jsonize_s2rtbas]

(* ****** ****** *)

implement
jsonize_s2cst
  (s2c) = let
//
val sym =
  jsonize_symbol (s2cst_get_sym (s2c))
val stamp =
  jsonize_stamp (s2cst_get_stamp (s2c))
//
in
//
jsonval_labval2
  ("s2cst_name", sym, "s2cst_stamp", stamp)
//
end // end of [jsonize_s2cst]

(* ****** ****** *)

implement
jsonize_s2var
  (s2v) = let
//
val sym =
  jsonize_symbol (s2var_get_sym (s2v))
val stamp =
  jsonize_stamp (s2var_get_stamp (s2v))
//
in
//
jsonval_labval2
  ("s2var_name", sym, "s2var_stamp", stamp)
//
end // end of [jsonize_s2var]

(* ****** ****** *)

implement
jsonize_s2Var
  (s2V) = let
//
val stamp =
  jsonize_stamp (s2Var_get_stamp (s2V))
//
in
//
  jsonval_labval1 ("s2Var_stamp", stamp)
//
end // end of [jsonize_s2Var]

(* ****** ****** *)

implement
jsonize_d2con
  (d2c) = let
//
val sym =
  jsonize_symbol (d2con_get_sym (d2c))
val stamp =
  jsonize_stamp (d2con_get_stamp (d2c))
//
in
//
jsonval_labval2
  ("d2con_name", sym, "d2con_stamp", stamp)
//
end // end of [jsonize_d2con]

(* ****** ****** *)

local

fun aux0
(
  name: string
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (list_nil)
in
  jsonval_labval2 ("s2exp_name", name, "s2exp_arglst", arglst)
end // end of [aux0]

fun aux1
(
  name: string, arg: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_sing (arg)
in
  jsonval_labval2 ("s2exp_name", name, "s2exp_arglst", arglst)
end // end of [aux1]

fun aux2
(
  name: string
, arg1: jsonval, arg2: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_pair (arg1, arg2)
in
  jsonval_labval2 ("s2exp_name", name, "s2exp_arglst", arglst)
end // end of [aux2]

fun aux3
(
  name: string
, arg1: jsonval, arg2: jsonval, arg3: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (arg1 :: arg2 :: arg3 :: nil ())
in
  jsonval_labval2 ("s2exp_name", name, "s2exp_arglst", arglst)
end // end of [aux3]

in (* in of [local] *)

implement
jsonize_s2exp
  (s2e0) = let
//
fun auxmain
  (s2e0: s2exp): jsonval = let
in
//
case+ s2e0.s2exp_node of
//
| S2Eint (i) =>
    aux1 ("S2Eint", jsonval_int (i))
| S2Eintinf (i) =>
    aux1 ("S2Eintinf", jsonval_intinf (i))
//
| S2Ecst (s2c) =>
    aux1 ("S2Ecst", jsonize_s2cst (s2c))
//
| S2Evar (s2v) =>
    aux1 ("S2Evar", jsonize_s2var (s2v))
| S2EVar (s2V) =>
    aux1 ("S2EVar", jsonize_s2Var (s2V))
//
| S2Esizeof (s2e) =>
    aux1 ("S2Esizeof", jsonize_s2exp (s2e))
//
| S2Eeqeq
    (s2e1, s2e2) => let
    val s2e1 = jsonize_s2exp (s2e1)
    and s2e2 = jsonize_s2exp (s2e2)
  in
    aux2 ("S2Eeqeq", s2e1(*left*), s2e2(*right*))
  end // end of [S2Eeqeq]
//
| S2Eapp
    (s2e1, s2es2) => let
    val s2e1 = jsonize_s2exp (s2e1)
    val s2es2 = jsonize_s2explst (s2es2)
  in
    aux2 ("S2Eapp", s2e1(*fun*), s2es2(*arglst*))
  end // end of [S2Eapp]
//
| S2Emetdec
    (s2es1, s2es2) => let
    val s2es1 = jsonize_s2explst (s2es1)
    and s2es2 = jsonize_s2explst (s2es2)
  in
    aux2 ("S2Emetdec", s2es1(*met*), s2es2(*bound*))
  end // end of [S2Emetdec]
//
| S2Einvar (s2e) =>
    aux1 ("S2Einvar", jsonize_s2exp (s2e))
//
| S2Eerr ((*void*)) => aux0 ("S2Eerr")
//
| _(*yet-to-be-processed*) => aux0 ("S2Eignored")
//
end // end of [auxmain]
//
val s2t0 = s2e0.s2exp_srt
val s2t0 = jsonize_s2rt (s2t0)
val s2e0 = auxmain (s2e0)
//
in
  jsonval_labval2 ("s2exp_srt", s2t0, "s2exp_node", s2e0)
end // end of [jsonize_s2exp]

end // end of [local]

(* ****** ****** *)

implement
jsonize_s2explst (s2es) =
  jsonize_list_fun (s2es, jsonize_s2exp)

(* ****** ****** *)

implement
jsonize_s2eff (s2fe) = jsonize_ignored (s2fe)

(* ****** ****** *)

(* end of [pats_staexp2_jsonize.dats] *)
