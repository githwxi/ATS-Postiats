(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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
// HX-2014-12-09: Reorganizing
//
(* ****** ****** *)
//
staload 
ATSPRE =
  "./pats_atspre.dats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload
LEX = "./pats_lexing.sats"
typedef token = $LEX.token

(* ****** ****** *)

staload
SYN = "./pats_syntax.sats"

(* ****** ****** *)
//
staload "./pats_jsonize.sats"
//
staload
_(*anon*) = "./pats_jsonize.dats"
//
(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_jsonize_synent2.sats"

(* ****** ****** *)

#define nil list_nil
#define :: list_cons
#define cons list_cons

(* ****** ****** *)

macdef
jsonize_loc (x) = jsonize_location (,(x))

(* ****** ****** *)
//
// Statics
//
(* ****** ****** *)

extern
fun
jsonize_s2rtbas: jsonize_ftype (s2rtbas)

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
| S2RTbas(s2tb) => let
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
| S2RTtup(s2ts) => let
    val s2ts = jsonize_s2rtlst (s2ts)
  in
    jsonval_conarg1 ("S2RTtup", s2ts)
  end // end of [S2RTtup]
//
| S2RTVar(s2tV) =>
    jsonize_s2rt(s2rtVar_get_s2rt(s2tV))
  // end of [S2RTVar]
//
| S2RTerr((*void*)) => jsonval_conarg0 ("S2RTerr")
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
val stamp =
jsonize_stamp(s2cst_get_stamp(s2c))
//
in
  jsonval_labval1 ("s2cst_stamp", stamp)
end // end of [jsonize_s2cst]
//
implement
jsonize_s2cst_long
  (s2c) = let
//
val sym =
  jsonize_symbol(s2cst_get_sym(s2c))
//
val s2t =
  jsonize_s2rt(s2cst_get_srt(s2c))
val stamp =
  jsonize_stamp(s2cst_get_stamp(s2c))
//
val extdef = let
  val opt = s2cst_get_extdef(s2c)
in
//
case+ opt of
| $SYN.SCSTEXTDEFnone() => jsonval_none()
| $SYN.SCSTEXTDEFsome(name) => jsonval_some(jsonval_string(name))
//
end // end of [extdef]
//
val supcls = 
  jsonize0_s2explst(s2cst_get_supcls(s2c))
//
val
dconlstopt = let
  val opt =
    s2cst_get_dconlst (s2c)
  // end of [val]
in
//
case+ opt of
| None () => jsonval_none((*void*))
| Some (d2cs) =>
    jsonval_some(jsonize_d2conlst(d2cs))
  // end of [Some]
end // end of [val]
//
in
//
jsonval_labval6
(
  "s2cst_sym", sym
, "s2cst_srt", s2t
, "s2cst_stamp", stamp
, "s2cst_extdef", extdef
, "s2cst_supcls", supcls
, "s2cst_dconlst", dconlstopt
)
//
end // end of [jsonize_s2cst_long]

(* ****** ****** *)

implement
jsonize_s2cstlst
  (s2cs) =
(
  jsonize_list_fun<s2cst>(s2cs, jsonize_s2cst)
) (* end of [jsonize_s2cstlst] *)

(* ****** ****** *)

implement
jsonize_s2rtdat_long
  (s2td) = let
//
val sym =
  jsonize_symbol(s2rtdat_get_sym(s2td))
val stamp =
  jsonize_stamp(s2rtdat_get_stamp(s2td))
//
val sconlst=
jsonize_list_fun<s2cst>
  (s2rtdat_get_sconlst(s2td), jsonize_s2cst_long)
//
in
//
jsonval_labval3
(
  "s2rtdat_sym", sym
, "s2rtdat_stamp", stamp
, "s2rtdat_sconlst", sconlst
)
//
end // end of [jsonize_s2rtdat_long]

(* ****** ****** *)
//
implement
jsonize_s2var
  (s2v) = let
//
val stamp =
  jsonize_stamp(s2var_get_stamp(s2v))
//
in
  jsonval_labval1 ("s2var_stamp", stamp)
end // end of [jsonize_s2var]
//
implement
jsonize_s2var_long
  (s2v) = let
//
val sym =
  jsonize_symbol(s2var_get_sym(s2v))
val s2rt = jsonize_s2rt (s2var_get_srt (s2v))
val stamp =
  jsonize_stamp (s2var_get_stamp (s2v))
//
in
//
jsonval_labval3
  ("s2var_sym", sym, "s2var_srt", s2rt, "s2var_stamp", stamp)
//
end // end of [jsonize_s2var_long]
//
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
jsonize_s2Var
  (s2V) = let
//
val stamp =
  jsonize_stamp (s2Var_get_stamp (s2V))
val szexp =
  jsonize_s2zexp (s2Var_get_szexp (s2V))
//
in
  jsonval_labval2 ("s2Var_stamp", stamp, "s2Var_szexp", szexp)
end // end of [jsonize_s2Var]

implement
jsonize_s2Var_long (s2V) = jsonize_s2Var (s2V)

(* ****** ****** *)
//
implement
jsonize_d2con
  (d2c) = let
//
val stamp =
  jsonize_stamp(d2con_get_stamp(d2c))
//
in
  jsonval_labval1 ("d2con_stamp", stamp)
end // end of [jsonize_d2con]
//
implement
jsonize_d2con_long
  (d2c) = let
//
val sym =
  jsonize_symbol (d2con_get_sym (d2c))
val _type =
  jsonize0_s2exp (d2con_get_type (d2c))
val stamp =
  jsonize_stamp (d2con_get_stamp (d2c))
//
in
//
jsonval_labval3
(
  "d2con_sym", sym
, "d2con_type", _type
, "d2con_stamp", stamp
)
//
end // end of [jsonize_d2con_long]
//
(* ****** ****** *)

implement
jsonize_d2conlst
  (d2cs) =
(
  jsonize_list_fun<d2con>(d2cs, jsonize_d2con)
) (* end of [jsonize_d2conlst] *)

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
case+
s2e0.s2exp_node
of // case+
//
| S2Eint(i) =>
    jsonval_conarg1("S2Eint", jsonval_int(i))
| S2Eintinf(i) =>
    jsonval_conarg1("S2Eintinf", jsonval_intinf(i))
//
| S2Ecst(s2c) =>
    jsonval_conarg1("S2Ecst", jsonize_s2cst(s2c))
//
| S2Efloat(rep) =>
    jsonval_conarg1("S2Efloat", jsonval_string(rep))
//
| S2Eextype(name, arg) =>
    jsonval_conarg1("S2Eextype", jsonval_string(name))
| S2Eextkind(name, arg) =>
    jsonval_conarg1("S2Eextkind", jsonval_string(name))
//
| S2Evar(s2v) =>
    jsonval_conarg1("S2Evar", jsonize_s2var(s2v))
| S2EVar(s2V) =>
    jsonval_conarg1("S2EVar", jsonize_s2Var(s2V))
//
| S2Eat(s2elt, s2addr) => let
    val s2elt = jsonize_s2exp(flag, s2elt)
    val s2addr = jsonize_s2exp(flag, s2addr)
  in
    jsonval_conarg2("S2Eat", s2elt, s2addr)
  end // end of [S2Eat]
| S2Esizeof(s2e) =>
    jsonval_conarg1("S2Esizeof", jsonize_s2exp(flag, s2e))
//
| S2Eeqeq
    (s2e1, s2e2) => let
    val s2e1 = jsonize_s2exp(flag, s2e1)
    and s2e2 = jsonize_s2exp(flag, s2e2)
  in
    jsonval_conarg2("S2Eeqeq", s2e1(*left*), s2e2(*right*))
  end // end of [S2Eeqeq]
//
| S2Eapp
    (s2e1, s2es2) => let
    val s2e1 = jsonize_s2exp(flag, s2e1)
    val s2es2 = jsonize_s2explst(flag, s2es2)
  in
    jsonval_conarg2("S2Eapp", s2e1(*fun*), s2es2(*arglst*))
  end // end of [S2Eapp]
//
| S2Efun
  (
    fc, lin, s2fe, npf, _arg, _res
  ) => let
    val npf = jsonval_int(npf)
    val _arg = jsonize_s2explst(flag, _arg)
    val _res = jsonize_s2exp(flag, _res)
  in
    jsonval_conarg3("S2Efun", npf, _arg, _res)
  end // end of [S2Efun]
//
| S2Emetdec
    (s2es1, s2es2) => let
    val s2es1 = jsonize_s2explst(flag, s2es1)
    and s2es2 = jsonize_s2explst(flag, s2es2)
  in
    jsonval_conarg2
      ("S2Emetdec", s2es1(*met*), s2es2(*bound*))
    // jsonval_conarg2
  end // end of [S2Emetdec]
//
| S2Etop(knd, s2e) =>  let
    val knd = jsonval_int(knd)
    val s2e = jsonize_s2exp(flag, s2e)
  in
    jsonval_conarg2("S2Etop", knd, s2e)
  end // end of [S2Etop]
//
| S2Ewithout(s2e) =>
    jsonval_conarg1("S2Ewithout", jsonize_s2exp(flag, s2e))
  // end of [S2Ewithout]
//
| S2Etyarr
    (_elt, _dim) => let
    val _elt = jsonize_s2exp(flag, _elt)
    val _dim = jsonize_s2explst(flag, _dim)
  in
    jsonval_conarg2("S2Etyarr", _elt, _dim)
  end // end of [S2Etyarr]
//
| S2Etyrec
    (knd, npf, ls2es) => let
    val knd =
      jsonize_tyreckind(knd)
    // end of [val]
    val npf = jsonval_int(npf)
    val ls2es = jsonize_labs2explst(flag, ls2es)
  in
    jsonval_conarg3("S2Etyrec", knd, npf, ls2es)
  end // end of [S2Etyrec]
//
| S2Einvar(s2e) =>
    jsonval_conarg1("S2Einvar", jsonize_s2exp(flag, s2e))
//
| S2Eexi
  (
    s2vs, s2ps, s2e_body
  ) => let
    val s2vs = jsonize_s2varlst(s2vs)
    val s2ps = jsonize_s2explst(flag, s2ps)
    val s2e_body = jsonize_s2exp(flag, s2e_body)
  in
    jsonval_conarg3("S2Eexi", s2vs, s2ps, s2e_body)
  end // end of [S2Eexi]
| S2Euni
  (
    s2vs, s2ps, s2e_body
  ) => let
    val s2vs = jsonize_s2varlst(s2vs)
    val s2ps = jsonize_s2explst(flag, s2ps)
    val s2e_body = jsonize_s2exp(flag, s2e_body)
  in
    jsonval_conarg3("S2Euni", s2vs, s2ps, s2e_body)
  end // end of [S2Euni]
//
| S2Erefarg(knd, s2e) => let
    val knd = jsonval_int(knd)
    val s2e = jsonize_s2exp(flag, s2e)
  in
    jsonval_conarg2("S2Erefarg", knd, s2e)
  end // end of [S2Erefarg]
//
| S2Evararg(s2e) =>
    jsonval_conarg1("S2Evararg", jsonize_s2exp(flag, s2e))
  // end of [val]
//
| S2Ewthtype(s2e, ws2es) => let
    val s2e = jsonize_s2exp(flag, s2e)
    val ws2es = jsonize_wths2explst(flag, ws2es)
  in
    jsonval_conarg2("S2Ewthtype", s2e, ws2es)
  end // end of [S2Ewths2explst]
//
| S2Eerrexp((*void*)) => jsonval_conarg0("S2Eerrexp")
//
| _(* rest-of-s2exp *) => jsonval_conarg0("S2Eignored")
//
end // end of [auxmain]
//
val s2t0 = s2e0.s2exp_srt
val s2t0 = jsonize_s2rt(s2t0)
//
val s2e0 = auxmain(flag, s2e0)
//
in
  jsonval_labval2("s2exp_srt", s2t0, "s2exp_node", s2e0)
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
| list_nil((*void*)) => list_nil ()
//
in
  JSONlist (auxlst (flag, ls2es))
end // end of [jsonize_labs2explst]

(* ****** ****** *)

implement
jsonize_wths2explst
(
  flag, ws2es
) = auxlst(flag, ws2es) where
{
//
fun
auxlst
(
  flag: int, ws2es: wths2explst
) : jsonval =
//
case+ ws2es of
| WTHS2EXPLSTnil() =>
    jsonval_conarg0("WTHS2EXPLSTnil")
  // WTHS2EXPLSTnil
| WTHS2EXPLSTcons_none
    (ws2es) =>
    jsonval_conarg1
      ("WTHS2EXPLSTcons_none", auxlst(flag, ws2es))
  // WTHS2EXPLSTcons_none
| WTHS2EXPLSTcons_invar
    (knd, s2e, ws2es) => let
    val knd = jsonval_int(knd)
    val s2e = jsonize_s2exp(flag, s2e)
  in
    jsonval_conarg3
      ("WTHS2EXPLSTcons_invar", knd, s2e, auxlst(flag, ws2es))
  end // end of [WTHS2EXPLSTcons_invar]
| WTHS2EXPLSTcons_trans
    (knd, s2e, ws2es) => let
    val knd = jsonval_int(knd)
    val s2e = jsonize_s2exp(flag, s2e)
  in
    jsonval_conarg3
      ("WTHS2EXPLSTcons_trans", knd, s2e, auxlst(flag, ws2es))
  end // end of [WTHS2EXPLSTcons_trans]
//
} (* end of [jsonize_wths2explst] *)

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
//
// Dynamics
//
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
fun jsonize_d2sym : jsonize_ftype (d2sym)

(* ****** ****** *)

extern
fun jsonize_pckind : jsonize_ftype (pckind)

(* ****** ****** *)

extern
fun jsonize_p2at : jsonize_ftype (p2at)
extern
fun jsonize_p2atlst : jsonize_ftype (p2atlst)
extern
fun jsonize_p2atopt : jsonize_ftype (p2atopt)

(* ****** ****** *)

extern
fun jsonize_labp2at : jsonize_ftype (labp2at)
extern
fun jsonize_labp2atlst : jsonize_ftype (labp2atlst)

(* ****** ****** *)

extern
fun jsonize_d2exp : jsonize_ftype (d2exp)
extern
fun jsonize_d2explst : jsonize_ftype (d2explst)
extern
fun jsonize_d2expopt : jsonize_ftype (d2expopt)
  
(* ****** ****** *)

extern
fun jsonize_labd2exp : jsonize_ftype (labd2exp)
extern
fun jsonize_labd2explst : jsonize_ftype (labd2explst)

(* ****** ****** *)

extern
fun jsonize_d2exparg : jsonize_ftype (d2exparg)
extern
fun jsonize_d2exparglst : jsonize_ftype (d2exparglst)

(* ****** ****** *)

extern
fun jsonize_d2lab : jsonize_ftype (d2lab)
extern
fun jsonize_d2lablst : jsonize_ftype (d2lablst)

(* ****** ****** *)

extern
fun jsonize_c2lau : jsonize_ftype (c2lau)
extern
fun jsonize_c2laulst : jsonize_ftype (c2laulst)

(* ****** ****** *)

extern
fun jsonize_gm2at : jsonize_ftype (gm2at)
extern
fun jsonize_gm2atlst : jsonize_ftype (gm2atlst)

(* ****** ****** *)

implement
jsonize_i0nt
  (tok) = let
//
val-$LEX.T_INT
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
val-$LEX.T_STRING(rep) = tok.token_node
//
in
  jsonval_string (rep)
end // end of [jsonize_s0tring]

(* ****** ****** *)
//
extern
fun
jsonize_dcstextdef
  (ext:dcstextdef): jsonval
//
implement
jsonize_dcstextdef
  (ext) = let
(*
//
val () =
  println! ("jsonize_dcstextdef")
//
*)
in
//
case+ ext of
| $SYN.DCSTEXTDEFnone(knd) =>
    jsonval_conarg1("DCSTEXTDEFnone", jsonval_int(knd))
| $SYN.DCSTEXTDEFsome_ext(name) =>
    jsonval_conarg1("DCSTEXTDEFsome_ext", jsonval_string(name))
| $SYN.DCSTEXTDEFsome_mac(name) =>
    jsonval_conarg1("DCSTEXTDEFsome_mac", jsonval_string(name))
| $SYN.DCSTEXTDEFsome_sta(name) =>
    jsonval_conarg1("DCSTEXTDEFsome_sta", jsonval_string(name))
//
end // end of [jsonize_dcstextdef]

(* ****** ****** *)
//
implement
jsonize_d2cst
  (d2c) = let
//
val stamp =
  jsonize_stamp(d2cst_get_stamp(d2c))
//
in
//
  jsonval_labval1("d2cst_stamp", stamp)
//
end // end of [jsonize_d2cst]
//
// HX-2014-09-08:
// [jsonize_d2cst_long]
// may output more properties
//
implement
jsonize_d2cst_long
  (d2c) = let
//
val sym =
  jsonize_symbol (d2cst_get_sym (d2c))
//
val _type =
  jsonize0_s2exp (d2cst_get_type (d2c))
//
val extdef = 
  jsonize_dcstextdef(d2cst_get_extdef(d2c))
//
val stamp =
  jsonize_stamp (d2cst_get_stamp (d2c))
//
in
//
jsonval_labval4
(
  "d2cst_sym", sym
, "d2cst_type", _type
, "d2cst_extdef", extdef
, "d2cst_stamp", stamp
)
//
end // end of [jsonize_d2cst_long]

(* ****** ****** *)

implement
jsonize_d2cstlst
  (d2cs) =
(
  jsonize_list_fun<d2cst>(d2cs, jsonize_d2cst)
) (* end of [jsonize_d2cstlst] *)

(* ****** ****** *)

implement
jsonize_d2var
  (d2v) = let
//
val stamp =
  jsonize_stamp (d2var_get_stamp (d2v))
//
in
  jsonval_labval1 ("d2var_stamp", stamp)
end // end of [jsonize_d2var]

(* ****** ****** *)

implement
jsonize_d2var_long
  (d2v) = let
//
val sym =
  jsonize_symbol (d2var_get_sym (d2v))
val stamp =
  jsonize_stamp (d2var_get_stamp (d2v))
//
in
//
jsonval_labval2
(
  "d2var_sym", sym, "d2var_stamp", stamp
)
//
end // end of [jsonize_d2var_long]

(* ****** ****** *)

implement
jsonize_d2itm
  (d2i) = let
//
(*
val () =
println!
  ("jsonize_d2itm: d2i = ", d2i)
*)
//
in
//
case+ d2i of
//
| D2ITMcst (d2c) => let
    val d2c = jsonize_d2cst (d2c)
  in
    jsonval_conarg1 ("D2ITMcst", d2c)
  end // end of [D2ITMcst]
| D2ITMvar (d2v) => let
    val d2v = jsonize_d2var (d2v)
  in
    jsonval_conarg1 ("D2ITMvar", d2v)
  end // end of [D2ITMvar]
| D2ITMcon (d2cs) => let
    val d2cs = jsonize_d2conlst (d2cs)
  in
    jsonval_conarg1 ("D2ITMcon", d2cs)
  end // end of [D2ITMcon]
//
| _ (*rest*) => jsonval_conarg0 ("D2ITMignored")
//
end // end of [jsonize_d2itm]

(* ****** ****** *)

implement
jsonize_d2sym
  (d2s) = let
//
val sym =
  jsonize_symbol (d2s.d2sym_sym)
//
in
  jsonval_labval1 ("d2sym_sym", sym)
end // end of [jsonize_d2sym]

(* ****** ****** *)

extern fun jsonize_i2mpdec : jsonize_ftype (i2mpdec)

(* ****** ****** *)

extern fun jsonize_f2undec : jsonize_ftype (f2undec)
extern fun jsonize_f2undeclst : jsonize_ftype (f2undeclst)

(* ****** ****** *)

extern fun jsonize_v2aldec : jsonize_ftype (v2aldec)
extern fun jsonize_v2aldeclst : jsonize_ftype (v2aldeclst)

(* ****** ****** *)

extern fun jsonize_v2ardec : jsonize_ftype (v2ardec)
extern fun jsonize_v2ardeclst : jsonize_ftype (v2ardeclst)

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

implement
jsonize_p2at
  (p2t0) = let
//
fun auxmain
  (p2t0: p2at): jsonval = let
in
//
case+
p2t0.p2at_node of
//
| P2Tany () =>
    jsonval_conarg0 ("P2Tany")
//
| P2Tvar (d2v) => let
    val d2v = jsonize_d2var (d2v)
  in
    jsonval_conarg1 ("P2Tvar", d2v)
  end // end of [P2Tvar]
//
| P2Tcon
  (
    pcknd, d2c, s2qs, s2e_con, npf, p2ts
  ) => let
//
    val jsv1 =
      jsonize_pckind (pcknd)
    val jsv2 = jsonize_d2con (d2c)
    val jsv3 = jsonize_ignored (s2qs)
    val jsv4 = jsonize_ignored (s2e_con)
    val jsv5 = jsonval_int (npf)
    val jsv6 = jsonize_p2atlst (p2ts)
//
    val arglst = (
      jsv1 :: jsv2 :: jsv3 :: jsv4 :: jsv5 :: jsv6 :: list_nil
    ) (* end of [val] *)
//
  in
    jsonval_conarglst ("P2Tcon", arglst)
  end // end of [P2Tcon]
//
| P2Tint (i) =>
    jsonval_conarg1 ("P2Tint", jsonval_int (i))
| P2Tintrep (rep) =>
    jsonval_conarg1 ("P2Tintrep", jsonval_string (rep))
//
| P2Tbool (b) => 
    jsonval_conarg1 ("P2Tbool", jsonval_bool (b))
| P2Tchar (c) =>
    jsonval_conarg1 ("P2Tchar", jsonval_int (int_of_char(c)))
| P2Tfloat (rep) =>
    jsonval_conarg1 ("P2Tfloat", jsonval_string (rep))
| P2Tstring (str) =>
    jsonval_conarg1 ("P2Tstring", jsonval_string (str))
//
| P2Ti0nt (tok) =>
    jsonval_conarg1 ("P2Ti0nt", jsonize_i0nt (tok))
| P2Tf0loat (tok) =>
    jsonval_conarg1 ("P2Tf0loat", jsonize_f0loat (tok))
//
| P2Tempty ((*void*)) => jsonval_conarg0 ("P2Tempty")
//
| P2Trec
    (knd, npf, lp2ts) => let
    val knd = jsonval_int (knd)
    val npf = jsonval_int (npf)
    val lp2ts = jsonize_labp2atlst (lp2ts)
  in
    jsonval_conarg3 ("P2Trec", knd, npf, lp2ts)
  end (* end of [P2Trec] *)
//
| P2Trefas
    (d2v, p2t) =>
  (
    jsonval_conarg2
      ("P2Trefas", jsonize_d2var(d2v), jsonize_p2at(p2t))
  ) (* end of [P2Trefas] *)
//
| P2Tvbox (d2v) =>
    jsonval_conarg1 ("P2Tvbox", jsonize_d2var (d2v))
//
| P2Tann (p2t, ann) =>
  (
    jsonval_conarg2
      ("P2Tann", jsonize_p2at (p2t), jsonize0_s2exp(ann))
  ) (* end of [P2Tann] *)
//
| P2Terrpat ((*void*)) => jsonval_conarg0 ("P2Terrpat")
//
| _ (*yet-to-be-processed*) => jsonval_conarg0 ("P2Tignored")
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

(* ****** ****** *)

implement
jsonize_p2atlst
  (p2ts) =
(
  jsonize_list_fun<p2at>(p2ts, jsonize_p2at)
) // end of [jsonize_p2atlst]

implement
jsonize_p2atopt
  (p2topt) =
(
  jsonize_option_fun<p2at>(p2topt, jsonize_p2at)
) // end of [jsonize_p2atopt]

(* ****** ****** *)

implement
jsonize_labp2at (lp2t) = let
in
//
case+ lp2t of
| LABP2ATnorm
    (l0, p2t) => let
    val lab =
    jsonize_label (l0.l0ab_lab)
    val p2t = jsonize_p2at (p2t)
  in
    jsonval_labval1
      ("LABP2ATnorm", jsonval_pair (lab, p2t))
  end // end of [LABP2ATnorm]
| LABP2ATomit (loc) => let
    val loc = jsonize_location (loc)
  in
    jsonval_labval1 ("LABP2ATomit", jsonval_sing (loc))
  end // end of [LABP2ATomit]
//
end // end of [jsonize_labp2at]

(* ****** ****** *)

implement
jsonize_labp2atlst
  (lp2ts) =
(
  jsonize_list_fun<labp2at>(lp2ts, jsonize_labp2at)
) // end of [jsonize_labp2atlst]

(* ****** ****** *)

implement
jsonize_d2exp (d2e0) = let
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
    jsonval_conarg1 ("D2Ecst", jsv1)
  end // end of [D2Ecst]
| D2Evar (d2v) => let
    val jsv1 = jsonize_d2var (d2v)
  in
    jsonval_conarg1 ("D2Evar", jsv1)
  end // end of [D2Evar]
//
| D2Eint (int) =>
    jsonval_conarg1 ("D2Eint", jsonval_int (int))
| D2Eintrep (rep) =>
    jsonval_conarg1 ("D2Eintrep", jsonval_string (rep))
//
| D2Ei0nt (tok) =>
    jsonval_conarg1 ("D2Ei0nt", jsonize_i0nt (tok))
| D2Ec0har (tok) =>
    jsonval_conarg1 ("D2Ec0har", jsonize_c0har (tok))
| D2Ef0loat (tok) =>
    jsonval_conarg1 ("D2Ef0loat", jsonize_f0loat (tok))
| D2Es0tring (tok) =>
    jsonval_conarg1 ("D2Es0tring", jsonize_s0tring (tok))
//
| D2Esym (d2s) =>
    jsonval_conarg1 ("D2Esym", jsonize_d2sym (d2s))
//
| D2Eempty ((*void*)) => jsonval_conarg0 ("D2Eempty")
//
| D2Eextval(s2e, name) => let
    val s2e = jsonize0_s2exp(s2e)
    val name = jsonval_string(name)
  in
    jsonval_conarg2("D2Eextval", s2e, name)
  end // end of [D2Eextval]
| D2Eextfcall
    (s2e, name, d2es_arg) => let
    val s2e = jsonize0_s2exp(s2e)
    val name = jsonval_string(name)
    val d2es_arg = jsonize_d2explst(d2es_arg)
  in
    jsonval_conarg3("D2Eextfcall", s2e, name, d2es_arg)
  end // end of [D2Eextfcall]
| D2Eextmcall
    (s2e, obj, name, d2es_arg) => let
//
    val s2e = jsonize0_s2exp(s2e)
//
    val obj = jsonize_d2exp(obj)
    val name = jsonval_string(name)
    val d2es_arg = jsonize_d2explst(d2es_arg)
//
  in
    jsonval_conarg4("D2Eextmcall", s2e, obj, name, d2es_arg)
  end // end of [D2Eextmcall]
//
| D2Elet
    (d2cs, d2e_body) => let
    val d2cs = jsonize_d2eclist (d2cs)
    val d2e_body = jsonize_d2exp (d2e_body)
  in
    jsonval_conarg2 ("D2Elet", d2cs, d2e_body)
  end // end of [D2Elet]
| D2Ewhere
    (d2e_body, d2cs) => let
    val d2cs = jsonize_d2eclist (d2cs)
    val d2e_body = jsonize_d2exp (d2e_body)
  in
    jsonval_conarg2 ("D2Ewhere", d2e_body, d2cs)
  end // end of [D2Ewhere]
//
| D2Eapplst
    (d2e, d2as) => let
    val jsv1 = jsonize_d2exp (d2e)
    val jsv2 = jsonize_d2exparglst (d2as)
  in
    jsonval_conarg2 ("D2Eapplst", jsv1, jsv2)
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
    jsonval_conarg4 ("D2Eifhead", jsv1, jsv2, jsv3, jsv4)
  end // end of [D2Eifhead]
//
| D2Ecasehead
  (
    casknd, inv, d2es, c2ls
  ) => let
    val jsv1 =
      jsonize_caskind (casknd)
    // end of [val]
    val jsv2 = jsonize_ignored (inv)
    val jsv3 = jsonize_d2explst (d2es)
    val jsv4 = jsonize_c2laulst (c2ls)
  in
    jsonval_conarg4 ("D2Ecasehead", jsv1, jsv2, jsv3, jsv4)
  end // end of [D2Ecasehead]
//
| D2Esing(d2e) => let
    val jsv = jsonize_d2exp (d2e)
  in
    jsonval_conarg1 ("D2Esing", jsv)
  end // end of [D2Esing]
| D2Elist
    (npf, d2es) => let
    val jsv1 = jsonval_int (npf)
    val jsv2 = jsonize_d2explst (d2es)
  in
    jsonval_conarg2 ("D2Elist", jsv1, jsv2)
  end // end of [D2Elist]
//
| D2Etup
    (knd, npf, d2es) => let
    val jsv1 = jsonval_int (knd)
    val jsv2 = jsonval_int (npf)
    val jsv3 = jsonize_d2explst (d2es)
  in
    jsonval_conarg3 ("D2Etup", jsv1, jsv2, jsv3)
  end // end of [D2Etup]
//
| D2Erec
    (knd, npf, ld2es) => let
    val jsv1 = jsonval_int (knd)
    val jsv2 = jsonval_int (npf)
    val jsv3 = jsonize_labd2explst (ld2es)
  in
    jsonval_conarg3 ("D2Erec", jsv1, jsv2, jsv3)
  end // end of [D2Erec]
//
| D2Eseq (d2es) =>
    jsonval_conarg1 ("D2Eseq", jsonize_d2explst (d2es))
//
| D2Eselab
    (d2e, d2ls) => let
    val jsv1 = jsonize_d2exp (d2e)
    val jsv2 = jsonize_d2lablst (d2ls)
  in
    jsonval_conarg2 ("D2Eselab", jsv1, jsv2)
  end // end of [D2Eselab]
//
| D2Ederef(d2e) => let
    val d2e = jsonize_d2exp (d2e)
  in
    jsonval_conarg1("D2Ederef", d2e)
  end // end of [D2Ederef]
| D2Eassgn
    (d2e_l, d2e_r) => let
    val d2e_l = jsonize_d2exp (d2e_l)
    val d2e_r = jsonize_d2exp (d2e_r)
  in
    jsonval_conarg2("D2Eassgn", d2e_l, d2e_r)
  end // end of [D2Eassgn]
| D2Exchng
    (d2e_l, d2e_r) => let
    val d2e_l = jsonize_d2exp (d2e_l)
    val d2e_r = jsonize_d2exp (d2e_r)
  in
    jsonval_conarg2("D2Exchng", d2e_l, d2e_r)
  end // end of [D2Exchng]
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
    jsonval_conarg4 ("D2Elam_dyn", jsv1, jsv2, jsv3, jsv4)
  end // end of [D2Elam_dyn]
//
| D2Elam_met
  (
    ref, s2es_met, d2e_body
  ) => let
(*
    val jsv1 =
      jsonize_d2varlst (!ref)
*)
    val jsv2 =
      jsonize0_s2explst (s2es_met)
    // end of [jsv2]
    val jsv3 = jsonize_d2exp (d2e_body)
  in
    jsonval_conarg2 ("D2Elam_met", jsv2, jsv3)
  end // end of [D2Elam_met]
| D2Elam_sta
    (s2vs, s2ps, d2e) => let
    val jsv1 =
      jsonize_s2varlst (s2vs)
    val jsv2 =
      jsonize0_s2explst (s2ps)
    val jsv3 = jsonize_d2exp (d2e)
  in
    jsonval_conarg3 ("D2Elam_sta", jsv1, jsv2, jsv3)
  end // end of [D2Elam_sta]
//
| D2Eann_type
    (d2e, s2e) => let
    val jsv1 = jsonize_d2exp (d2e)
    val jsv2 = jsonize0_s2exp (s2e)
  in
    jsonval_conarg2 ("D2Eann_type", jsv1, jsv2)
  end // end of [D2Eann_type]
| D2Eann_seff
    (d2e, s2fe) => let
    val jsv1 = jsonize_d2exp (d2e)
    val jsv2 = jsonize_s2eff (s2fe)
  in
    jsonval_conarg2 ("D2Eann_seff", jsv1, jsv2)
  end // end of [D2Eann_seff]
| D2Eann_funclo
    (d2e, funclo) => let
    val jsv1 = jsonize_d2exp (d2e)
    val jsv2 = jsonize_funclo (funclo)
  in
    jsonval_conarg2 ("D2Eann_funclo", jsv1, jsv2)
  end // end of [D2Eann_funclo]
//
| D2Eerrexp ((*void*)) => jsonval_conarg0("D2Eerrexp")
//
| _ (*rest*) => let
    val () = prerrln!
    (
      "warning(ATS): [jsonize_d2exp]: ignored: ", d2e0
    ) (* end of [val] *)
  in
    jsonval_conarg0 ("D2Eignored")
  end (* end of [_] *)
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

(* ****** ****** *)
  
implement
jsonize_d2explst
  (d2es) =
(
  jsonize_list_fun<d2exp>(d2es, jsonize_d2exp)
) // end of [jsonize_d2explst]

(* ****** ****** *)

implement
jsonize_d2expopt (opt) = let
in
//
case+ opt of
| None () => jsonval_none ()
| Some (d2e) => jsonval_some (jsonize_d2exp (d2e))
//
end // end of [jsonize_d2expopt]

(* ****** ****** *)

implement
jsonize_labd2exp
  (ld2e) = let
  val+$SYN.DL0ABELED (l0, d2e) = ld2e
  val lab = jsonize_label (l0.l0ab_lab)
  val d2e = jsonize_d2exp (d2e)
in
  jsonval_conarg2 ("DL0ABELED", lab, d2e)
end // end of [jsonize_labd2exp]

(* ****** ****** *)

implement
jsonize_labd2explst
  (ld2es) =
(
  jsonize_list_fun<labd2exp>(ld2es, jsonize_labd2exp)
) // end of [jsonize_labd2explst]

(* ****** ****** *)

implement
jsonize_d2exparg
  (d2a) = let
in
//
case+ d2a of
| D2EXPARGsta
    (loc, s2as) => let
    val arglst = JSONlist (list_nil)
  in
    jsonval_labval1 ("D2EXPARGsta", arglst)
  end // end of [D2EXPARGsta]
| D2EXPARGdyn
    (npf, loc, d2es) => let
    val jsv1 = jsonval_int (npf)
    val jsv2 = jsonize_loc (loc)
    val jsv3 = jsonize_d2explst (d2es)
    val arglst =
      JSONlist (jsv1 :: jsv2 :: jsv3 :: list_nil)
    // end of [val]
  in
    jsonval_labval1 ("D2EXPARGdyn", arglst)
  end // end of [D2EXPARGdyn]
//
end // end of [jsonize_d2exparg]
  
(* ****** ****** *)

implement
jsonize_d2exparglst
  (d2as) =
(
  jsonize_list_fun<d2exparg>(d2as, jsonize_d2exparg)
) // end of [jsonize_d2exparglst]

(* ****** ****** *)

implement
jsonize_d2lab
  (d2l0) = let
//
fun auxmain
  (d2l0: d2lab): jsonval = let
in
//
case+
//
d2l0.d2lab_node of
//
| D2LABlab (lab) => let
    val lab = jsonize_label (lab)
  in
    jsonval_labval1 ("D2LABlab", jsonval_sing(lab))
  end // end of [D2LABlab]
| D2LABind (d2es) => let
    val d2es = jsonize_d2explst (d2es)
  in
    jsonval_labval1 ("D2LABind", jsonval_sing(d2es))
  end // end of [D2LABind]
//
end // end of [auxmain]
//
val loc0 = d2l0.d2lab_loc
val loc0 = jsonize_loc (loc0)
val d2l0 = auxmain (d2l0)
//
in
  jsonval_labval2 ("d2lab_loc", loc0, "d2lab_node", d2l0)
end // end of [jsonize_d2lab]

(* ****** ****** *)

implement
jsonize_d2lablst
  (d2ls) =
(
  jsonize_list_fun<d2lab>(d2ls, jsonize_d2lab)
) // end of [jsonize_d2lablst]

(* ****** ****** *)

implement
jsonize_gm2at
  (gm2t) = let
//
val loc = jsonize_loc (gm2t.gm2at_loc)
val exp = jsonize_d2exp (gm2t.gm2at_exp)
val pat = jsonize_p2atopt (gm2t.gm2at_pat)
//
in
//
jsonval_labval3
(
  "gm2at_loc", loc, "gm2at_exp", exp, "gm2at_pat", pat
)
//
end // end of [jsonize_gm2at]

implement
jsonize_gm2atlst
  (gm2ts) =
(
  jsonize_list_fun<gm2at>(gm2ts, jsonize_gm2at)
) // end of [jsonize_gm2atlst]

(* ****** ****** *)

implement
jsonize_c2lau
  (c2l0) = let
//
val loc = jsonize_loc (c2l0.c2lau_loc)
val pat = jsonize_p2atlst (c2l0.c2lau_pat)
val gua = jsonize_gm2atlst (c2l0.c2lau_gua)
val seq = jsonval_int (c2l0.c2lau_seq)
val neg = jsonval_int (c2l0.c2lau_neg)
val body = jsonize_d2exp (c2l0.c2lau_body)
//
in
//
jsonval_labval6
(
  "c2lau_loc", loc
, "c2lau_pat", pat
, "c2lau_gua", gua
, "c2lau_seq", seq
, "c2lau_neg", neg
, "c2lau_body", body
) (* end of [jsonize_labval6] *)
//
end // end of [jsonize_c2lau]

(* ****** ****** *)

implement
jsonize_c2laulst
  (c2ls) =
(
  jsonize_list_fun<c2lau>(c2ls, jsonize_c2lau)
) // end of [jsonize_c2laulst]

(* ****** ****** *)

implement
jsonize_d2ecl
  (d2c0) = let
//
(*
val () =
println! (
"jsonize_d2ecl: d2c0 = ", d2c0
) (* end of [val] *)
*)
//
fun auxmain
  (d2c0: d2ecl): jsonval = let
in
//
case+
d2c0.d2ecl_node of
//
| D2Cnone () =>
    jsonval_conarg0 ("D2Cnone")
| D2Clist (xs) => let
    val xs = jsonize_d2eclist (xs)
  in
    jsonval_conarg1 ("D2Clist", xs)
  end // end of [D2Clist]
//
| D2Coverload
    (id, pval, opt) => let
    val sym =
      jsonize_symbol(id.i0de_sym)
    val pval = jsonval_int (pval)
    val opt =
      jsonize_option_fun<d2itm>(opt, jsonize_d2itm)
    // end of [val]
  in
    jsonval_conarg3 ("D2Coverload", sym, pval, opt)
  end // end of [D2Coverload]
//
| D2Cstacsts (s2cs) => let
    val s2cs = jsonize_s2cstlst (s2cs)
  in
    jsonval_conarg1 ("D2Cstacsts", s2cs)
  end // end of [D2Cstacsts]
| D2Cstacons (knd, s2cs) => let
    val knd = jsonval_int (knd)
    val s2cs = jsonize_s2cstlst (s2cs)
  in
    jsonval_conarg2 ("D2Cstacsts", knd, s2cs)
  end // end of [D2Cstacons]
//
| D2Cextype
    (name, s2e_def) => let
    val name = jsonval_string (name)
    val s2e_def = jsonize0_s2exp (s2e_def)
  in
    jsonval_conarg2 ("D2Cextype", name, s2e_def)
  end // end of [D2Cextype]
| D2Cextvar
    (name, d2e_def) => let
    val name = jsonval_string (name)
    val d2e_def = jsonize_d2exp (d2e_def)
  in
    jsonval_conarg2 ("D2Cextvar", name, d2e_def)
  end // end of [D2Cextvar]
| D2Cextcode
    (knd, pos, code) => let
    val knd = jsonval_int (knd)
    val pos = jsonval_int (pos)
    val code = jsonval_string (code)
  in
    jsonval_conarg3 ("D2Cextcode", knd, pos, code)
  end // end of [D2Cextcode]
//
| D2Cdatdecs
    (knd, s2cs) => let
    val knd = jsonval_int (knd)
    val s2cs = jsonize_s2cstlst (s2cs)
  in
    jsonval_conarg2 ("D2Cdatdecs", knd, s2cs)
  end // end of [D2Cdatdecs]
| D2Cexndecs (d2cs) => let
    val d2cs = jsonize_d2conlst (d2cs)
  in
    jsonval_conarg1 ("D2Cexndecs", d2cs(*constr*))
  end // end of [D2Cdatdecs]
//
| D2Cdcstdecs
    (knd, dck, d2cs) => let
    val knd = jsonval_int (knd)
    val dck = jsonize_dcstkind (dck)
    val d2cs = jsonize_d2cstlst (d2cs)
  in
    jsonval_conarg3 ("D2Cdcstdecs", knd, dck, d2cs)
  end // end of [D2Cdcstdecs]
//
| D2Cimpdec
    (knd, i2mp) => let
    val knd = jsonval_int (knd)
    val i2mp = jsonize_i2mpdec (i2mp)
  in
    jsonval_conarg2 ("D2Cimpdec", knd, i2mp)
  end // end of [D2Cimpdec]
//
| D2Cfundecs
  (
    knd, s2qs, f2ds
  ) => let
    val knd = jsonize_funkind (knd)
    val s2qs = jsonize_ignored (s2qs)
    val f2ds = jsonize_f2undeclst (f2ds)
  in
    jsonval_conarg3 ("D2Cfundecs", knd, s2qs, f2ds)
  end // end of [D2Cfundecs]
//
| D2Cvaldecs
    (knd, v2ds) => let
    val knd = jsonize_valkind (knd)
    val v2ds = jsonize_v2aldeclst (v2ds)
  in
    jsonval_conarg2 ("D2Cvaldecs", knd, v2ds)
  end // end of [D2Cvaldecs]
//
| D2Cvardecs(v2ds) => let
    val v2ds = jsonize_v2ardeclst (v2ds)
  in
    jsonval_conarg1 ("D2Cvardecs", v2ds)
  end // end of [D2Cvardecs]
//
| D2Cinclude
    (knd, d2cs) => let
    val knd = jsonval_int (knd)
    val d2cs = jsonize_d2eclist (d2cs)
  in
    jsonval_conarg2 ("D2Cinclude", knd, d2cs)
  end // end of [D2Cinclude]
//
| D2Cstaload
  (
    idopt, fname, loadflag, fenv, loaded
  ) => let
    val idopt =
      jsonize_symbolopt (idopt)
    // end of [val]
    val fname = jsonize_filename (fname)
  in
    jsonval_conarg2 ("D2Cstaload", idopt, fname)
  end // end of [D2Cstaload]
//
| D2Clocal
    (head, body) => let
    val head = jsonize_d2eclist (head)
    val body = jsonize_d2eclist (body)
  in
    jsonval_conarg2 ("D2Clocal", head, body)
  end // end of [D2Clocal]
//
| _ (*rest*) => jsonval_conarg0 ("D2Cignored")
//
end // end of [auxmain]
//
val loc0 = d2c0.d2ecl_loc
val loc0 = jsonize_loc (loc0)
val d2c0 = auxmain (d2c0)
//
in
//
jsonval_labval2
  ("d2ecl_loc", loc0, "d2ecl_node", d2c0)
//
end // end of [jsonize_d2ecl]

(* ****** ****** *)
//
implement
jsonize_d2eclist (d2cs) =
  jsonize_list_fun<d2ecl>(d2cs, jsonize_d2ecl)
//
(* ****** ****** *)

implement
jsonize_i2mpdec
  (i2mp) = let
//
val loc = jsonize_loc (i2mp.i2mpdec_loc)
val locid = jsonize_loc (i2mp.i2mpdec_locid)
//
val d2c = jsonize_d2cst (i2mp.i2mpdec_cst)
//
val imparg = jsonize_ignored (i2mp.i2mpdec_imparg)
val tmparg = jsonize_ignored (i2mp.i2mpdec_tmparg)
val tmpgua = jsonize_ignored (i2mp.i2mpdec_tmpgua)
//
val def = jsonize_d2exp (i2mp.i2mpdec_def)
//
in
//
JSONlablist
(
   (   "i2mpdec_loc" , loc)
:: ( "i2mpdec_locid" , locid)
:: (   "i2mpdec_cst" , d2c)
:: ("i2mpdec_imparg" , imparg)
:: ("i2mpdec_tmparg" , tmparg)
:: ("i2mpdec_tmpgua" , tmpgua)
:: (   "i2mpdec_def" , def)
:: list_nil () // end-of-list
) (* end of [jsonval_lablist] *)
//
end // end of [i2mpdec]

(* ****** ****** *)

implement
jsonize_f2undec
  (f2d) = let
//
val loc = jsonize_loc (f2d.f2undec_loc)
val d2v = jsonize_d2var (f2d.f2undec_var)
val def = jsonize_d2exp (f2d.f2undec_def)
val ann = jsonize0_s2expopt (f2d.f2undec_ann)
//
in
//
jsonval_labval4
(
  "f2undec_loc", loc, "f2undec_var", d2v
, "f2undec_def", def, "f2undec_ann", ann
) (* end of [jsonize_labval4] *)
//
end // end of [json_f2undec]

(* ****** ****** *)

implement
jsonize_f2undeclst
  (f2ds) =
(
  jsonize_list_fun<f2undec>(f2ds, jsonize_f2undec)
) // end of [jsonize_f2undeclst]

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
jsonval_labval4
(
  "v2aldec_loc", loc, "v2aldec_pat", pat
, "v2aldec_def", def, "v2aldec_ann", ann
) (* end of [jsonize_labval4] *)
//
end // end of [json_v2aldec]

implement
jsonize_v2aldeclst
  (v2ds) =
(
  jsonize_list_fun<v2aldec>(v2ds, jsonize_v2aldec)
) // end of [jsonize_v2aldeclst]

(* ****** ****** *)

implement
jsonize_v2ardec
  (v2d) = let
//
val loc = jsonize_loc(v2d.v2ardec_loc)
val knd = jsonval_int(v2d.v2ardec_knd)
//
val svar = jsonize_s2var(v2d.v2ardec_svar)
val dvar = jsonize_d2var(v2d.v2ardec_dvar)
//
val init = jsonize_d2expopt(v2d.v2ardec_init)
//
val _type = jsonize0_s2expopt(v2d.v2ardec_type)
//
in
//
jsonval_labval6
(
  "v2ardec_loc", loc, "v2ardec_knd", knd
, "v2ardec_svar", svar, "v2ardec_dvar", dvar
, "v2ardec_init", init, "v2ardec_type", _type
) (* jsonval_labval6 *)
//
end // end of [jsonize_v2ardec]

implement
jsonize_v2ardeclst
  (v2ds) =
(
  jsonize_list_fun<v2ardec>(v2ds, jsonize_v2ardec)
) // end of [jsonize_v2ardeclst]

(* ****** ****** *)

implement
d2eclist_jsonize_out
  (out, d2cls) = let
//
val
( s2cs
, s2vs
, s2Vs
, d2cons
, d2csts
, d2vars
) = d2eclist_mapgen_all (d2cls)
//
val s2cs =
  s2cstset_vt_listize_free (s2cs)
val s2vs =
  s2varset_vt_listize_free (s2vs)
val s2Vs =
  s2Varset_vt_listize_free (s2Vs)
val d2cons =
  d2conset_vt_listize_free (d2cons)
val d2csts =
  d2cstset_vt_listize_free (d2csts)
val d2vars =
  d2varset_vt_listize_free (d2vars)
//
val jsv_s2cs =
  jsonize_list_fun<s2cst>($UN.linlst2lst(s2cs), jsonize_s2cst_long)
val () = list_vt_free (s2cs)
//
val jsv_s2vs =
  jsonize_list_fun<s2var>($UN.linlst2lst(s2vs), jsonize_s2var_long)
val () = list_vt_free (s2vs)
//
val jsv_s2Vs =
  jsonize_list_fun<s2Var>($UN.linlst2lst(s2Vs), jsonize_s2Var_long)
val () = list_vt_free (s2Vs)
//
val jsv_d2cons =
  jsonize_list_fun<d2con>($UN.linlst2lst(d2cons), jsonize_d2con_long)
val () = list_vt_free (d2cons)
//
val jsv_d2csts =
  jsonize_list_fun<d2cst>($UN.linlst2lst(d2csts), jsonize_d2cst_long)
val () = list_vt_free (d2csts)
//
val jsv_d2vars =
  jsonize_list_fun<d2var>($UN.linlst2lst(d2vars), jsonize_d2var_long)
val () = list_vt_free (d2vars)
//
val jsv_d2cls = jsonize_d2eclist(d2cls)
//
val () =
  fprint_string (out, "{\n\"s2cstmap\":\n")
//
val ((*void*)) = fprint_jsonval (out, jsv_s2cs)
val ((*void*)) = fprint_newline (out)
//
val () =
  fprint_string (out, ",\n\"s2varmap\":\n")
//
val ((*void*)) = fprint_jsonval (out, jsv_s2vs)
val ((*void*)) = fprint_newline (out)
//
val () =
  fprint_string (out, ",\n\"d2conmap\":\n")
//
val ((*void*)) = fprint_jsonval (out, jsv_d2cons)
val ((*void*)) = fprint_newline (out)
//
val () =
  fprint_string (out, ",\n\"d2cstmap\":\n")
//
val ((*void*)) = fprint_jsonval (out, jsv_d2csts)
val ((*void*)) = fprint_newline (out)
//
val () =
  fprint_string (out, ",\n\"d2varmap\":\n")
//
val ((*void*)) = fprint_jsonval (out, jsv_d2vars)
val ((*void*)) = fprint_newline (out)
//
val () =
  fprint_string (out, ",\n\"d2eclist\":\n")
//
val ((*void*)) = fprint_jsonval (out, jsv_d2cls)
val ((*void*)) = fprint_string (out, "\n}")
val ((*void*)) = fprint_newline (out)
//
in
  // nothing
end // end of [d2eclist_jsonize_out]

(* ****** ****** *)

(* end of [pats_jsonize_synent2.dats] *)
