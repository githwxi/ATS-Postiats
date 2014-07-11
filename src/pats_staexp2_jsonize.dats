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
staload "./pats_staexp2_util.sats"

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
| S2RTbas (s2tb) => let
  val name = jsonval_string ("s2rt_bas")
  val srt = jsonize_s2rtbas (s2tb)
in
  jsonval_labval2 ("s2rt_name", name, "s2rt_args", srt)
end
| S2RTfun (args, res) => let
  val name = jsonval_string ("s2rt_fun")
  val args = JSONlist (list_of_list_vt (
    list_map_fun<s2rt><jsonval> (args, jsonize_s2rt)
  ))
  val res = jsonize_s2rt (res)
in
  jsonval_labval3 ("s2rt_name", name, "s2rt_args", args, "s2rt_res", res)
end
| S2RTtup (s2ts) => let
  val name = jsonval_string ("s2rt_tup")
  val args = JSONlist (list_of_list_vt (
    list_map_fun<s2rt><jsonval> (s2ts, jsonize_s2rt)
  ))
in
  jsonval_labval2 ("s2rt_name", name, "s2rt_args", args)
end
| _(*unspecified*) => let
  val name = jsonval_string ("s2rt_anon")
in
  jsonval_labval1 ("s2rt_name", name)
end
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
  (flag, s2c) = let
//
val sym =
  jsonize_symbol (s2cst_get_sym (s2c))
val stamp =
  jsonize_stamp (s2cst_get_stamp (s2c))
val srt = 
  jsonize_s2rt (s2cst_get_srt (s2c))
val supcls = 
  jsonize1_s2explst (s2cst_get_supcls (s2c))
//
in
//
jsonval_labval4
  ("s2cst_name", sym, "s2cst_stamp", stamp, "s2cst_srt", srt, "s2cst_supcls", supcls)
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
val srt =
  jsonize_s2rt (s2var_get_srt (s2v))
//
in
//
jsonval_labval3
  ("s2var_name", sym, "s2var_stamp", stamp, "s2var_srt", srt)
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
jsonize_s2varlst
  (s2vs) = let
//
val jsvs =
  list_map_fun (s2vs, jsonize_s2var)
//
in
  JSONlist (list_of_list_vt{jsonval}(jsvs))
end // end of [jsonize_s2varlst]

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

implement
jsonize_d2con_long
  (d2c) = let
//
val sym =
  jsonize_symbol (d2con_get_sym (d2c))
val type =
  jsonize1_s2exp (d2con_get_type (d2c))
val stamp =
  jsonize_stamp (d2con_get_stamp (d2c))
//
in
//
jsonval_labval3
(
  "d2con_name", sym
, "d2con_type", type
, "d2con_stamp", stamp
)
//
end // end of [jsonize_d2con_long]

(* ****** ****** *)
// 
implement
jsonize0_s2exp
  (s2e) = jsonize_s2exp (0(*hnfize*), s2e)
implement
jsonize1_s2exp
  (s2e) = jsonize_s2exp (1(*hnfize*), s2e)
// 
(* ****** ****** *)
//
implement
jsonize0_s2explst
  (s2e) = jsonize_s2explst (0(*hnfize*), s2e)
implement
jsonize1_s2explst
  (s2e) = jsonize_s2explst (1(*hnfize*), s2e)
// 
(* ****** ****** *)

(* ****** ****** *)

implement
jsonize_s2exp
  (flag, s2e0) = let
//
fun auxmain
(
  flag: int, s2e0: s2exp
) : jsonval = let
//
val s2e0 =
(
  if flag = 0 then s2e0 else s2exp_hnfize (s2e0)
) : s2exp // end of [val]
//
in
//
case+ s2e0.s2exp_node of
//
| S2Eint (i) =>
    jsonval_conarg1 ("S2Eint", jsonval_int (i))
| S2Eintinf (i) =>
    jsonval_conarg1 ("S2Eintinf", jsonval_intinf (i))
//
| S2Ecst (s2c) =>
    jsonval_conarg1 ("S2Ecst", jsonize_s2cst (flag, s2c))
//
| S2Eextype (name, arg) =>
    jsonval_conarg1 ("S2Eextype", jsonval_string (name))
| S2Eextkind (name, arg) =>
    jsonval_conarg1 ("S2Eextkind", jsonval_string (name))
//
| S2Evar (s2v) =>
    jsonval_conarg1 ("S2Evar", jsonize_s2var (s2v))
| S2EVar (s2V) => let
    (**
      normalizing the expression does not take care of
      the s2zexp tied to this sVar. If a static variable
      is linked to this sVar through a szexp, replace the
      sVar with it.
    *)
    val szexp = s2Var_get_szexp (s2V)
in
  case+ szexp of
    | S2ZEvar (s2v) => let
      val srt = s2var_get_srt (s2v)
      val s2e = s2exp_var_srt (srt, s2v)
    in
      auxmain (flag, s2e)
    end
    | _ => jsonval_conarg1 ("S2EVar", jsonize_s2Var (s2V))
end
//
| S2Esizeof (s2e) => let
    val s2e1 = (
      if flag = 0 then s2e else s2exp_hnfize (s2e)
    ) : s2exp // end of [val]
    (** Unwrap the argument if necessary. *)
    val s2e1 = (
        case+ s2e1.s2exp_node of
           | S2Etop (_, s2e2) => s2e2
           | _ =>> s2e1
    ) : s2exp // end of [val]
in
    jsonval_conarg1 ("S2Esizeof", jsonize_s2exp (flag, s2e1))
end
//
| S2Eeqeq
    (s2e1, s2e2) => let
    val s2e1 = jsonize_s2exp (flag, s2e1)
    and s2e2 = jsonize_s2exp (flag, s2e2)
  in
    jsonval_conarg2 ("S2Eeqeq", s2e1(*left*), s2e2(*right*))
  end // end of [S2Eeqeq]
//
| S2Eapp
    (s2e1, s2es2) => let
    val s2e1 = jsonize_s2exp (flag, s2e1)
    val s2es2 = jsonize_s2explst (flag, s2es2)
  in
    jsonval_conarg2 ("S2Eapp", s2e1(*fun*), s2es2(*arglst*))
  end // end of [S2Eapp]
//
| S2Efun
  (
    fc, lin, s2fe, npf, _arg, _res
  ) => let
    val npf = jsonval_int (npf)
    val _arg = jsonize_s2explst (flag, _arg)
    val _res = jsonize_s2exp (flag, _res)
  in
    jsonval_conarg3 ("S2Efun", npf, _arg, _res)
  end // end of [S2Efun]
//
| S2Emetdec
    (s2es1, s2es2) => let
    val s2e = s2exp_metdec_reduce (s2es1, s2es2)
    val s2es = jsonize_s2exp (flag, s2e)
  in
    jsonval_conarg1 ("S2Emetdec", s2es(*met*))
  end // end of [S2Emetdec]
//
| S2Etop
    (_, s2es1) => jsonize_s2exp (flag, s2es1)
//
| S2Eexi
  (
    s2vs, s2ps, s2e_body
  ) => let
    val s2vs = jsonize_s2varlst (s2vs)
    val s2ps = jsonize_s2explst (flag, s2ps)
    val s2e_body = jsonize_s2exp (flag, s2e_body)
  in
    jsonval_conarg3 ("S2Eexi", s2vs, s2ps, s2e_body)
  end // end of [S2Eexi]
| S2Euni
  (
    s2vs, s2ps, s2e_body
  ) => let
    val s2vs = jsonize_s2varlst (s2vs)
    val s2ps = jsonize_s2explst (flag, s2ps)
    val s2e_body = jsonize_s2exp (flag, s2e_body)
  in
    jsonval_conarg3 ("S2Euni", s2vs, s2ps, s2e_body)
  end // end of [S2Euni]
//
| S2Einvar (s2e) =>
    jsonval_conarg1 ("S2Einvar", jsonize_s2exp (flag, s2e))
//
| S2Eerr ((*void*)) => jsonval_conarg0 ("S2Eerr")
//
| _(*yet-to-be-processed*) => let
  val () = prerrln! s2e0
in
  jsonval_conarg0 ("S2Eignored")
end
//
end // end of [auxmain]
//
val s2t0 = s2e0.s2exp_srt
val s2t0 = jsonize_s2rt (s2t0)
val s2e0 = auxmain (flag, s2e0)
//
in
  jsonval_labval2 ("s2exp_srt", s2t0, "s2exp_node", s2e0)
end // end of [jsonize_s2exp]

(* ****** ****** *)

implement
jsonize_s2explst
  (flag, s2es) = let
//
fun auxlst
(
  flag: int, s2es: s2explst
) : jsonvalist =
//
case+ s2es of
| list_cons
    (s2e, s2es) =>
  (
    list_cons (jsonize_s2exp (flag, s2e), auxlst (flag, s2es))
  ) // end of [list_cons]
| list_nil ((*void*)) => list_nil ()
//
in
  JSONlist (auxlst (flag, s2es))
end // end of [jsonize_s2explst]

(* ****** ****** *)

implement
jsonize_s2eff (s2fe) = jsonize_ignored (s2fe)

(* ****** ****** *)

(* end of [pats_staexp2_jsonize.dats] *)
