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
// Start Time: April, 2013
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
S2E = "./pats_staexp2.sats"
typedef s2cst = $S2E.s2cst
typedef d2con = $S2E.d2con

(* ****** ****** *)

staload
S2UT = "./pats_staexp2_util.sats"

(* ****** ****** *)

staload
D2E = "./pats_dynexp2.sats"
typedef d2cst = $D2E.d2cst
typedef d2var = $D2E.d2var
typedef d2varlst = $D2E.d2varlst
typedef d2varset = $D2E.d2varset

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

extern
fun funent_eval_flabset (fent: funent): funlablst
extern
fun funent_eval_d2varset (fent: funent): d2varlst

(* ****** ****** *)

local

extern
fun funent_set_flabset_fin
(
  fent: funent, opt: Option (funlablst)
) : void = "ext#patsopt_funent_set_flabset_fin"

in (* in of [local] *)

implement
funent_eval_flabset
  (fent) = let
//
val opt = funent_get_flabset_fin (fent)
//
in
//
case+ opt of
| Some (fls) => fls
| None () => fls where
  {
    val fls =
      funent_get_flabset (fent)
    val fls = funlabset_listize (fls)
    val fls = list_of_list_vt (fls)
    val () = funent_set_flabset_fin (fent, Some (fls))
  } // end of [None]
//
end // end of [funent_eval_d2varset]

end // end of [local]

(* ****** ****** *)

local

extern
fun funent_set_d2varset_fin
(
  fent: funent, opt: Option (d2varlst)
) : void = "ext#patsopt_funent_set_d2varset_fin"

in (* in of [local] *)

implement
funent_eval_d2varset
  (fent) = let
//
val opt = funent_get_d2varset_fin (fent)
//
in
//
case+ opt of
| Some (d2vs) => d2vs
| None () => d2vs where
  {
    val d2vs =
      funent_get_d2varset (fent)
    val d2vs = $D2E.d2varset_listize (d2vs)
    val d2vs = list_of_list_vt (d2vs)
    val () = funent_set_d2varset_fin (fent, Some (d2vs))
  } // end of [None]
//
end // end of [funent_eval_d2varset]

end // end of [local]

(* ****** ****** *)

local

fun pmvfun_isbot
  (pmv: primval): bool = let
in
//
case+
  pmv.primval_node of
| PMVcst (d2c) =>
    $S2UT.s2exp_fun_isbot ($D2E.d2cst_get_type (d2c))
  // end of [PMVcst]
| _ => false // end of [_]
//
end // end of [pmvfun_isbot]

fun emit_pmvfun
(
  out: FILEref
, pmv_fun: primval, hse_fun: hisexp
) : void = let
in
//
case+ pmv_fun.primval_node of
//
| PMVcst (d2c) => emit_d2cst (out, d2c)
//
| PMVfunlab (flab) => emit_funlab (out, flab)
//
| PMVtmpltcst _ => emit_primval (out, pmv_fun)
| PMVtmpltvar _ => emit_primval (out, pmv_fun)
//
| PMVtmpltcstmat _ => emit_primval (out, pmv_fun)
//
| _(*funval*) => emit_pmvfun_val (out, pmv_fun, hse_fun)
//
(*
| _ => let
    val loc = pmv_fun.primval_loc
    val () = prerr_interror_loc (loc)
    val () = prerrln! (": emit_prmvfun: pmv_fun = ", pmv_fun)
    val () = prerrln! (": emit_prmvfun: hse_fun = ", hse_fun)
    val () = assertloc (false)
  in
    // nothing
  end // end of [_]
*)
end // end of [emit_pmvfun]

and emit_pmvfun_val
(
  out: FILEref
, pmv_fun: primval, hse_fun: hisexp
) : void = let
//
val-HSEfun
(
  fc, hses_arg, hse_res
) = hse_fun.hisexp_node
//
val () = emit_text (out, "ATSfunclo")
val () =
(
case+ fc of
| FUNCLOfun _ => emit_text (out, "_fun")
| FUNCLOclo _ => emit_text (out, "_clo")
) : void // end of [val]
val () = emit_lparen (out)
val () = emit_primval (out, pmv_fun)
val () = emit_text (out, ", ")
val () = emit_lparen (out)
val () = emit_hisexplst_sep (out, hses_arg, ", ")
val () = emit_rparen (out)
val () = emit_text (out, ", ")
val () = emit_hisexp (out, hse_res)
val () = emit_rparen (out)
//
in
  // nothing
end // end of [emit_pmvfun_val]

in (* in of [local] *)

implement
emit_instr_fcall
  (out, ins) = let
//
val loc0 = ins.instr_loc
val-INSfcall
  (tmp, pmv_fun, hse_fun, pmvs_arg) = ins.instr_node
(*
val () = (
  println! ("emit_instr_fcall: pmv_fun = ", pmv_fun);
  println! ("emit_instr_fcall: hse_fun = ", hse_fun);
) // end of [val]
*)
val noret = tmpvar_is_void (tmp)
val noret =
(
  if noret then true else pmvfun_isbot (pmv_fun)
) : bool // end of [val]
//
val () = emit_text (out, "ATSINSmove")
val () =
(
  if noret then emit_text (out, "_void")
)
val () = emit_text (out, "(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = emit_pmvfun (out, pmv_fun, hse_fun)
val () = emit_text (out, "(")
val () = emit_primvalist (out, pmvs_arg)
val () = emit_text (out, ")")
val () = emit_text (out, ") ;")
//
in
  // nothing
end // end of [emit_instr_fcall]

implement
emit_instr_extfcall
  (out, ins) = let
//
val loc0 = ins.instr_loc
val-INSextfcall
  (tmp, _fun, pmvs_arg) = ins.instr_node
//
val noret = tmpvar_is_void (tmp)
//
val () = (
  if ~noret
    then emit_text (out, "ATSINSmove(")
    else emit_text (out, "ATSINSmove_void(")
  // end of [if]
) : void // end of [val]
//
val () =
(
  emit_tmpvar (out, tmp); emit_text (out, ", ")
) (* end of [val] *)
val () = emit_text (out, _fun)
val () = emit_text (out, "(")
val () = emit_primvalist (out, pmvs_arg)
val () = emit_text (out, ")) ;")
//
in
  // nothing
end // end of [emit_instr_extfcall]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_emit2.dats] *)
