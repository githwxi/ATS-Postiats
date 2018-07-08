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
// Start Time: April, 2013
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
LOC = "./pats_location.sats"

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

(* ****** ****** *)

fun aux_funval
(
  out: FILEref
, pmv_fun: primval, hse_fun: hisexp, isclo: &bool
) : void = let
in
//
case+ pmv_fun.primval_node of
//
| PMVcst (d2c) => let
    val isfun = $D2E.d2cst_is_fundec (d2c)
  in
    if isfun
      then emit_d2cst (out, d2c)
      else aux_funval2 (out, pmv_fun, hse_fun, isclo)
    // end of [if]
  end // end of [PMVcst]
//
| PMVfunlab (flab) => emit_funlab (out, flab)
| PMVcfunlab (knd, flab) => emit_funlab (out, flab)
//
| PMVtmpltcst _ => emit_primval (out, pmv_fun)
| PMVtmpltvar _ => emit_primval (out, pmv_fun)
//
| PMVtmpltcstmat _ => emit_primval (out, pmv_fun)
| PMVtmpltvarmat _ => emit_primval (out, pmv_fun)
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
(*
val () = println! ("aux_funval2: pmv_fun = ", pmv_fun)
val () = println! ("aux_funval2: hse_fun = ", hse_fun)
*)
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
val () = emit_LPAREN (out)
val () = emit_primval (out, pmv_fun)
val () = emit_text (out, ", ")
val () = emit_LPAREN (out)
//
val hses_arg = (
if isclo
  then list_cons (hisexp_cloptr, hses_arg)
  else (hses_arg)
) : hisexplst // end of [val]
val () = emit_hisexplst_sep (out, hses_arg, ", ")
//
val () = emit_RPAREN (out)
val () = emit_text (out, ", ")
val () = emit_hisexp (out, hse_res)
val () = emit_RPAREN (out)
//
in
  // nothing
end // end of [aux_funval2]

(* ****** ****** *)

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
      funent_eval_d2envlst (fent)
    // end of [val]
  in
    emit_d2envlst (out, d2es, 0(*i*))
  end (* end of [Some] *)
| None ((*void*)) => (0)
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
| _ => (0)
//
end // end of [aux_funenv]

(* ****** ****** *)

fun
emit_fparamlst
(
  out: FILEref, n: int, pmvs: primvalist
) : void = let
in
//
case+ pmvs of
| list_cons _ => let
    val () =
    if (n > 0) then
      emit_text (out, ", ")
    // end of [if]
  in
    emit_primvalist (out, pmvs)
  end (* end of [list_cons] *)
| list_nil ((*void*)) => ()
//
end // end of [emit_fparamlst]

(* ****** ****** *)

fun emit_freeaft_fun
(
  out: FILEref, pmv: primval
) : void = let
in
//
case+
  pmv.primval_node of
| PMVrefarg
    (knd, freeknd, pmv) =>
  if freeknd > 0 then
  (
    emit_text (out, "ATSINSfreeclo(");
    emit_primval (out, pmv); emit_text (out, ") ;\n")
  ) (* end of [PMVrefarg] *)
| _ => ()
//
end // end of [emit_freeaft_fun]

(* ****** ****** *)

(*
//
// HX-2014-03-02:
// no support for auto-freeing of funarg
// as it may interfere with tail-recursion
//
fun
emit_freeaft_funarg
(
  out: FILEref, pmvs: primvalist
) : void = let
in
//
case+ pmvs of
//
| list_nil () => ()
//
| list_cons
    (pmv, pmvs) => let
    val () = (
      case+
        pmv.primval_node of
      | PMVrefarg (
          knd, freeknd, pmv
        ) when freeknd > 0 =>
        {
          val () =
          emit_text (out, "ATSINSfreeclo(")
          val () = emit_primval (out, pmv)
          val () = emit_text (out, ") ;\n")
        } (* end of [PMVrefarg] *)
      | _ (*non-refarg*) => ()
    ) : void // end of [val]
  in
    emit_freeaft_funarg (out, pmvs)
  end // end of [list_cons]
//
end // end of [emit_freeaft_funarg]
*)

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
val () = (
  if noret then emit_text (out, "_void")
) (* end of [val] *)
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
  then list_cons (pmv_fun, pmvs_arg) else (pmvs_arg)
) : primvalist // end of [val]
//
val () = emit_LPAREN (out)
val ln = aux_funenv (out, pmv_fun)
val () = emit_fparamlst (out, ln, pmvs_arg)
val () = emit_RPAREN (out)
//
val () = emit_text (out, ") ;\n")
//
val () = emit_freeaft_fun (out, pmv_fun)
//
(*
val () = emit_freeaft_funarg (out, pmvs_arg)
*)
//
in
  // nothing
end // end of [emit_instr_fcall]

(* ****** ****** *)

local

fun
aux1
( out: FILEref
, ntl: int, pmv: primval, i: int
) : void = let
//
val () =
emit_text
(out, "ATSINSmove_tlcal(")
//
val () =
(
if ntl <= 1
  then fprintf(out, "apy%i", @(i))
  else fprintf(out, "a%ipy%i", @(ntl, i))
// end of [if]
) : void // end of [val]
//
val () = emit_text (out, ", ")
val () = emit_primval (out, pmv)
val () = emit_text (out, ") ;\n")
//
in
  // nothing
end // end of [aux1]

fun
aux1lst
(
  out: FILEref
, ntl: int, pmvs: primvalist, i: int
) : void = let
in
//
case+ pmvs of
| list_nil
    ((*void*)) => ()
| list_cons
    (pmv, pmvs) =>
  (
    aux1(out, ntl, pmv, i);
    aux1lst(out, ntl, pmvs, i+1)
  ) (* end of [list_cons] *)
//
end // end of [aux1lst]

fun
aux2
(
  out: FILEref
, ntl: int, pmv: primval, i: int
) : void = let
//
val () =
emit_text
(
out, "ATSINSargmove_tlcal("
) (* val *)
//
val () =
(
if
(ntl <= 1)
then fprintf(out, "arg%i", @(i))
else fprintf(out, "a%irg%i", @(ntl, i))
// end of [if]
) : void // end of [val]
val () =
(
if
(ntl <= 1)
then fprintf(out, ", apy%i", @(i))
else fprintf(out, ", a%ipy%i", @(ntl, i))
// end of [if]
) : void // end of [val]
//
val ((*void*)) = emit_text(out, ") ;\n")
//
in
  // nothing
end // end of [aux2]

fun
aux2lst
(
  out: FILEref
, ntl: int, pmvs: primvalist, i: int
) : void = let
in
//
case+ pmvs of
| list_nil
    ((*void*)) => ()
  // list_nil
| list_cons
    (pmv, pmvs) =>
  (
    aux2(out, ntl, pmv, i);
    aux2lst(out, ntl, pmvs, i+1)
  ) (* end of [list_cons] *)
//
end // end of [aux2lst]

fun
auxgoto
(
  out: FILEref, flab: funlab
) : void = let
//
val () =
emit_text
(
out, "ATSINSfgoto("
) (* val *)
//
val () =
emit_text(out, "__patsflab_")
//
val () = emit2_funlab(out, flab)
//
val ((*void*)) = emit_text(out, ") ;\n")
//
in
  // nothing
end // end of [auxgoto]

in (* in of [local] *)

implement
emit_instr_fcall2
  (out, ins) = let
//
val-
INSfcall2
(
  tmp, flab
, ntl, hse_fun, pmvs_arg
) = ins.instr_node
//
val () =
emit_text
(out, "ATStailcal_beg()\n")
//
val () =
aux1lst(out, ntl, pmvs_arg, 0(*i*))
val () =
aux2lst(out, ntl, pmvs_arg, 0(*i*))
//
val () =
auxgoto(out, flab) // HX: jump for tail-call
//
val () =
emit_text(out, "ATStailcal_end()\n")
//
in
  // nothing
end // end of [emit_instr_fcall2]

end // end of [local]

(* ****** ****** *)

implement
emit_instr_extfcall
  (out, ins) = let
//
val
loc0 = ins.instr_loc
//
val-
INSextfcall
( tmp
, fun_name
, pmvs_arg) = ins.instr_node
//
val noret = tmpvar_is_void(tmp)
//
val () =
(
if ~noret
  then emit_text(out, "ATSINSmove(")
  else emit_text(out, "ATSINSmove_void(")
// end of [if]
) : void // end of [val]
//
val () =
(
  emit_tmpvar(out, tmp); emit_text(out, ", ")
) (* end of [val] *)
//
val () =
emit_text
(
out, "ATSextfcall("
)
val () =
emit_text(out, fun_name)
val () = emit_text(out, ", ")
val () = emit_text( out, "(" )
val () = emit_primvalist(out, pmvs_arg)
val () = emit_text( out, "))) ;" )
//
in
  // nothing
end // end of [emit_instr_extfcall]

(* ****** ****** *)

implement
emit_instr_extmcall
  (out, ins) = let
//
val loc0 = ins.instr_loc
val-
INSextmcall
( tmp
, pmv_obj
, mtd_name
, pmvs_arg) = ins.instr_node
//
val noret = tmpvar_is_void(tmp)
//
val () =
(
if ~noret
  then emit_text(out, "ATSINSmove(")
  else emit_text(out, "ATSINSmove_void(")
// end of [if]
) : void // end of [val]
//
val () =
(
  emit_tmpvar(out, tmp); emit_text(out, ", ")
) (* end of [val] *)
//
val () =
emit_text
(
out, "ATSextmcall("
)
val () =
emit_primval(out, pmv_obj)
//
val () = emit_text(out, ", ")
val () = emit_text(out, mtd_name)
//
val () = emit_text(out, ", ")
val () = emit_text( out, "(" )
val () = emit_primvalist(out, pmvs_arg)
val () = emit_text( out, "))) ;" )
//
in
  // nothing
end // end of [emit_instr_extmcall]

end // end of [local]

(* ****** ****** *)

implement
emit_funenvlst
  (out, d2es) = let
//
(*
val () =
fprintln!
( stdout_ref
, "emit_funenvlst: d2es = ", d2es)
*)
//
fun loop
( out: FILEref
, d2es: d2envlst, sep: string, i: int
) : int = let
in
//
case+ d2es of
| list_nil
    ((*void*)) => (i)
  // list_nil
//
| list_cons
    (d2e, d2es) => let
    val
    hse = d2env_get_type(d2e)
    val () =
    if i > 0
      then emit_text(out, sep)
    // end of [val]
    val () = emit_hisexp(out, hse)
    val () = fprintf(out, " env%i", @(i))
  in
    loop(out, d2es, sep, i+1)
  end (* end of [list_cons] *)
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
fun
loop
(
  out: FILEref, n: int
, hses: hisexplst, sep: string, i: int
) : void = let
(*
val () =
println! ("emit_funarglst: loop")
*)
in
//
case+ hses of
| list_nil
    ((*void*)) => ()
  // list_nil
| list_cons
    (hse, hses) => let
    val () =
    if n > 0
      then emit_text(out, sep)
    // end of [val]
    val () = emit_hisexp(out, hse)
    val () = fprintf(out, " arg%i", @(i))
  in
    loop(out, n+1, hses, sep, i+1)
  end // end of [list_cons]
//
end // end of [loop]
//
in
  loop(out, nenv, hses, ", ", 0)
end // end of [emit_funarglst]

(* ****** ****** *)

(* end of [pats_ccomp_emit2.dats] *)
