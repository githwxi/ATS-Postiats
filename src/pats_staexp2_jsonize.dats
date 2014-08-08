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
// Author: William Blair
// Authoremail: william.douglass.blairATgmailDOTcom
// Contribing Time: August 7, 2014
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
jsonize_s2rt
  (s2t0) = let
in
//
case+ s2t0 of
| S2RTbas (s2tb) => let
    val s2tb = jsonize_s2rtbas (s2tb)
  in
    jsonval_conarg1 ("S2RTbas", s2tb)
  end // end of [S2RTbas]
//
| S2RTfun
    (s2ts_arg, s2t_res) => let
//
    val arg =
      jsonize_s2rtlst (s2ts_arg)
    // end of [val]
    val res = jsonize_s2rt (s2t_res)
//
  in
    jsonval_conarg2 ("S2RTfun", arg, res)
  end // end of [S2RTfun]
//
| S2RTtup (s2ts) => let
    val s2ts = jsonize_s2rtlst (s2ts)
  in
    jsonval_conarg1 ("S2RTtup", s2ts)
  end // end of [S2RTtup]
//
| _(*ignored*) => jsonval_conarg0 ("S2RTignored")
//
end // end of [jsonize_s2rt]
  
(* ****** ****** *)

implement
jsonize_s2rtlst
  (s2ts) = let
//
val jsvs =
  list_map_fun (s2ts, jsonize_s2rt)
//
in
  JSONlist (list_of_list_vt{jsonval}(jsvs))
end // end of [jsonize_s2rtlst]

(* ****** ****** *)

implement
jsonize_s2cst
  (s2c) = let
//
val sym =
  jsonize_symbol (s2cst_get_sym (s2c))
val s2t = jsonize_s2rt (s2cst_get_srt (s2c))
val stamp =
  jsonize_stamp (s2cst_get_stamp (s2c))
val supcls = 
  jsonize1_s2explst (s2cst_get_supcls (s2c))
//
in
//
jsonval_labval4
(
  "s2cst_name", sym, "s2cst_srt", s2t
, "s2cst_stamp", stamp, "s2cst_supcls", supcls
)
//
end // end of [jsonize_s2cst]

(* ****** ****** *)

implement
jsonize_s2var
  (s2v) = let
//
val sym =
  jsonize_symbol (s2var_get_sym (s2v))
val s2rt = jsonize_s2rt (s2var_get_srt (s2v))
val stamp =
  jsonize_stamp (s2var_get_stamp (s2v))
//
in
//
jsonval_labval3
  ("s2var_name", sym, "s2var_srt", s2rt, "s2var_stamp", stamp)
//
end // end of [jsonize_s2var]

(* ****** ****** *)

implement
jsonize_s2Var
  (s2V) = let
//
val stamp =
  jsonize_stamp (s2Var_get_stamp (s2V))
val szexp =
  jsonize_s2zexp (s2Var_get_szexp (s2V))
//
in
//
  jsonval_labval2 ("s2Var_stamp", stamp, "s2Var_szexp", szexp)
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

implement
jsonize_tyreckind
  (knd) = let
in
//
case+ knd of
//
| TYRECKINDbox () => jsonval_conarg0 ("TYRECKINDbox")
| TYRECKINDbox_lin () => jsonval_conarg0 ("TYRECKINDbox_lin")
//
| TYRECKINDflt0 () => jsonval_conarg0 ("TYRECKINDflt0")
| TYRECKINDflt1 (x) => 
    jsonval_conarg1 ("TYRECKINDflt1", jsonize_stamp (x))
| TYRECKINDflt_ext (name) =>
    jsonval_conarg1 ("TYRECKINDflt_ext", jsonval_string (name))
//
end // end of [jsonize_tyreckind]

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
  (s2es) = jsonize_s2explst (0(*hnfize*), s2es)
implement
jsonize1_s2explst
  (s2es) = jsonize_s2explst (1(*hnfize*), s2es)
// 
(* ****** ****** *)
//
implement
jsonize0_s2expopt
  (opt) = jsonize_s2expopt (0(*hnfize*), opt)
implement
jsonize1_s2expopt
  (opt) = jsonize_s2expopt (1(*hnfize*), opt)
// 
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
    jsonval_conarg1 ("S2Ecst", jsonize_s2cst (s2c))
//
| S2Eextype (name, arg) =>
    jsonval_conarg1 ("S2Eextype", jsonval_string (name))
| S2Eextkind (name, arg) =>
    jsonval_conarg1 ("S2Eextkind", jsonval_string (name))
//
| S2Evar (s2v) =>
    jsonval_conarg1 ("S2Evar", jsonize_s2var (s2v))
| S2EVar (s2V) =>
    jsonval_conarg1 ("S2EVar", jsonize_s2Var (s2V))
//
| S2Esizeof (s2e) =>
    jsonval_conarg1 ("S2Esizeof", jsonize_s2exp (flag, s2e))
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
    val s2es1 = jsonize_s2explst (flag, s2es1)
    and s2es2 = jsonize_s2explst (flag, s2es2)
  in
    jsonval_conarg2 ("S2Emetdec", s2es1(*met*), s2es2(*bound*))
  end // end of [S2Emetdec]
//
| S2Etyarr
    (_elt, _dim) => let
    val _elt = jsonize_s2exp (flag, _elt)
    val _dim = jsonize_s2explst (flag, _dim)
  in
    jsonval_conarg2 ("S2Etyarr", _elt, _dim)
  end // end of [S2Etyarr]
| S2Etyrec
    (knd, npf, ls2es) => let
    val knd =
      jsonize_tyreckind (knd)
    val npf = jsonval_int (npf)
    val ls2es = jsonize_labs2explst (flag, ls2es)
  in
    jsonval_conarg3 ("S2Etyrec", knd, npf, ls2es)
  end // end of [S2Etyrec]
//
| S2Einvar (s2e) =>
    jsonval_conarg1 ("S2Einvar", jsonize_s2exp (flag, s2e))
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
| S2Etop (knd, s2e) =>  let
    val s2e = jsonize_s2exp (flag, s2e)
  in
    jsonval_conarg2("S2Etop", jsonval_int(knd), s2e)
  end // end of [S2Etop]
//
| S2Eerr ((*void*)) => jsonval_conarg0 ("S2Eerr")
//
| _(*ignored*) => jsonval_conarg0 ("S2Eignored")
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
    (s2e, s2es) => let
    val s2e =
      jsonize_s2exp (flag, s2e)
    // end of [val]
    val s2es = auxlst (flag, s2es)
  in
    list_cons (s2e, s2es)
  end // end of [list_cons]
| list_nil ((*void*)) => list_nil ()
//
in
  JSONlist (auxlst (flag, s2es))
end // end of [jsonize_s2explst]

(* ****** ****** *)

implement
jsonize_s2expopt
  (flag, opt) = let
in
//
case+ opt of
| None () => JSONoption (None ())
| Some (s2e) => JSONoption (Some (jsonize_s2exp (flag, s2e)))
//
end // end of [jsonize_s2expopt]

(* ****** ****** *)

implement
jsonize_labs2explst
  (flag, ls2es) = let
//
fun auxlst
(
  flag: int, ls2es: labs2explst
) : jsonvalist =
//
case+ ls2es of
| list_cons
    (ls2e, ls2es) => let
    val+SLABELED
      (lab, name, s2e) = ls2e
    val lab = jsonize_label (lab)
    val name =
    (
      case+ name of
      | None () => jsonval_none ()
      | Some (x) => jsonval_some (jsonval_string(x))
    ) : jsonval
    val s2e = jsonize_s2exp (flag, s2e)
    val ls2e = jsonval_conarg3 ("SL0ABELED", lab, name, s2e)
  in
    list_cons (ls2e, auxlst (flag, ls2es))
  end // end of [list_cons]
| list_nil ((*void*)) => list_nil ()
//
in
  JSONlist (auxlst (flag, ls2es))
end // end of [jsonize_labs2explst]

(* ****** ****** *)

implement
jsonize_s2eff (s2fe) = jsonize_ignored (s2fe)

(* ****** ****** *)

implement
jsonize_s2zexp
  (s2ze) =
(
//
case+ s2ze of
//
| S2ZEbot () =>
    jsonval_conarg0 ("S2ZEbot")
//
| S2ZEvar (s2v) => let
    val s2v = jsonize_s2var(s2v)
  in
    jsonval_conarg1 ("S2ZEvar", s2v)
  end // end of [S2ZEvar]
//
| _(*ignored*) => jsonval_conarg0 ("S2ZEignored")
//
) (* end of [jsonize_s2zexp] *)

(* ****** ****** *)

(* end of [pats_staexp2_jsonize.dats] *)
