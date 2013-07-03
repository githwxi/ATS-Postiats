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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
S2E = "./pats_staexp2.sats"
staload
S2UT = "./pats_staexp2_util.sats"
staload
D2E = "./pats_dynexp2.sats"
typedef d2var = $D2E.d2var
typedef d2varlst = $D2E.d2varlst

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

local

fun
funval_isbot
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
end // end of [funval_isbot]

fun aux_funval
(
  out: FILEref
, pmv_fun: primval, hse_fun: hisexp, isclo: &bool
) : void = let
in
//
case+ pmv_fun.primval_node of
//
| PMVcst (d2c) => emit_d2cst (out, d2c)
//
| PMVfunlab (flab) => emit_funlab (out, flab)
| PMVcfunlab (knd, flab) => emit_funlab (out, flab)
//
| PMVtmpltcst _ => emit_primval (out, pmv_fun)
| PMVtmpltvar _ => emit_primval (out, pmv_fun)
//
| PMVtmpltcstmat _ => emit_primval (out, pmv_fun)
//
| _(*funval*) => aux_funval2 (out, pmv_fun, hse_fun, isclo)
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
end // end of [aux_funval]

and aux_funval2
(
  out: FILEref
, pmv_fun: primval, hse_fun: hisexp, isclo: &bool
) : void = let
//
val-HSEfun
(
  fc, hses_arg, hse_res
) = hse_fun.hisexp_node
//
val () = emit_text (out, "ATSfunclo")
//
val () =
(
case+ fc of
| FUNCLOfun _ => () | FUNCLOclo _ => isclo := true
) : void // end of [val]
val () =
(
if isclo
  then emit_text (out, "_clo") else emit_text (out, "_fun")
// end of [if]
) : void // end of [val]
//
val () = emit_lparen (out)
val () = emit_primval (out, pmv_fun)
val () = emit_text (out, ", ")
val () = emit_lparen (out)
//
val hses_arg =
(
if isclo
  then list_cons (hisexp_cloptr, hses_arg) else hses_arg
) : hisexplst // end of [val]
val () = emit_hisexplst_sep (out, hses_arg, ", ")
//
val () = emit_rparen (out)
val () = emit_text (out, ", ")
val () = emit_hisexp (out, hse_res)
val () = emit_rparen (out)
//
in
  // nothing
end // end of [aux_funval2]

fun aux_funenv
(
  out: FILEref, pmv_fun: primval
) : int(*nenv*) = let
//
fun auxflab
(
  out: FILEref, flab: funlab
) : int = let
  val opt = funlab_get_funent (flab)
in
//
case+ opt of
| Some (fent) => let
    val d2es =
      funent_eval_d2envlst (fent) in emit_d2envlst (out, d2es)
  end // end of [Some]
| None ((*void*)) => 0
//
end // end of [auxflab]
//
in (* in of [let] *)
//
case+
pmv_fun.primval_node of
//
| PMVfunlab (flab) => auxflab (out, flab)
| PMVcfunlab (knd, flab) => auxflab (out, flab)
//
| _ => 0
//
end // end of [aux_funenv]

fun emit_fparamlst
(
  out: FILEref, n: int, pmvs: primvalist
) : void = let
in
//
case+ pmvs of
| list_cons _ => let
    val () =
    (
      if (n > 0) then emit_text (out, ", ")
    ) // end of [val]
  in
    emit_primvalist (out, pmvs)
  end (* end of [list_cons] *)
| list_nil () => ()
//
end // end of [emit_fparamlst]

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
  if noret then true else funval_isbot (pmv_fun)
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
//
var
isclo: bool = false
val () = aux_funval (out, pmv_fun, hse_fun, isclo)
//
val pmvs_arg =
(
if isclo
  then list_cons (pmv_fun, pmvs_arg) else pmvs_arg
) : primvalist // end of [val]
//
val () = emit_lparen (out)
val ln = aux_funenv (out, pmv_fun)
val () = emit_fparamlst (out, ln, pmvs_arg)
val () = emit_rparen (out)
//
val () = emit_text (out, ") ;")
//
in
  // nothing
end // end of [emit_instr_fcall]

(* ****** ****** *)

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
val () =
(
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

implement
emit_funenvlst
  (out, d2es) = let
//
(*
val () = fprintln! (stdout_ref, "emit_funenvlst: d2es = ", d2es)
*)
//
fun loop
(
  out: FILEref
, d2es: d2envlst, sep: string, i: int
) : int = let
in
//
case+ d2es of
| list_cons
    (d2e, d2es) => let
    val hse = d2env_get_type (d2e)
    val () =
      if i > 0 then emit_text (out, sep)
    val () = emit_hisexp (out, hse)
    val () = fprintf (out, " env%i", @(i))
  in
    loop (out, d2es, sep, i+1)
  end (* end of [list_cons] *)
| list_nil () => (i)
//
end (* end of [loop] *)
//
in
  loop (out, d2es, ", ", 0)
end // end of [emit_funenvlst]

implement
emit_funarglst
  (out, nenv, hses) = let
//
fun loop
(
  out: FILEref, n: int
, hses: hisexplst, sep: string, i: int
) : void = let
in
//
case+ hses of
| list_cons
    (hse, hses) => let
    val () =
      if n > 0 then emit_text (out, sep)
    val () = emit_hisexp (out, hse)
    val () = fprintf (out, " arg%i", @(i))
  in
    loop (out, n+1, hses, sep, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
in
  loop (out, nenv, hses, ", ", 0)
end // end of [emit_funarglst]

(* ****** ****** *)

(* end of [pats_ccomp_emit2.dats] *)
