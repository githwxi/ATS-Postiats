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
// Start Time: January, 2013
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
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)
//
staload
"./pats_errmsg.sats"
staload
_(*anon*) = "./pats_errmsg.dats"
//
implement
prerr_FILENAME<> () = prerr "pats_ccomp_emit2"
//
(* ****** ****** *)
//
staload
ERR = "./pats_error.sats"
//
staload
FIL = "./pats_filename.sats"
staload
LOC = "./pats_location.sats"
//
(* ****** ****** *)

staload SYM = "./pats_symbol.sats"
staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload
S2E = "./pats_staexp2.sats"
typedef d2con = $S2E.d2con
typedef d2conlst = $S2E.d2conlst

(* ****** ****** *)

staload
D2E = "./pats_dynexp2.sats"
typedef d2cst = $D2E.d2cst
typedef d2ecl = $D2E.d2ecl
typedef d2eclist = $D2E.d2eclist
overload = with $D2E.eq_d2cst_d2cst
overload != with $D2E.neq_d2cst_d2cst

(* ****** ****** *)

staload
TR2ENV = "./pats_trans2_env.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

implement
emit_exndec
  (out, hid) = let
//
val loc0 = hid.hidecl_loc
val-HIDexndecs (d2cs) = hid.hidecl_node
//
val () = emit_text (out, "/*\n")
val () = emit_location (out, loc0)
val () = emit_text (out, "\n*/\n")
//
fun auxlst
(
  out: FILEref, d2cs: d2conlst
) : void = let
in
//
case+ d2cs of
| list_nil () => ()
| list_cons
    (d2c, d2cs) => let
    val () =
    emit_text (out, "ATSdynexn_dec(")
    val () = emit_d2con (out, d2c)
    val () = emit_text (out, ") ;\n")
  in
    auxlst (out, d2cs)
  end // end of [list_cons]
//
end (* end of [auxlst] *)
//
in
  auxlst (out, d2cs)
end // end of [emit_exndec]

(* ****** ****** *)

implement
emit_saspdec
  (out, hid) = let
//
val loc0 = hid.hidecl_loc
val-HIDsaspdec (d2c) = hid.hidecl_node
//
val () = emit_text (out, "/*\n")
val () = emit_location (out, loc0)
val () = emit_text (out, "\n*/\n")
//
val () = emit_text (out, "ATSassume(")
val () = emit_s2cst (out, d2c.s2aspdec_cst)
val () = emit_text (out, ") ;\n")
//
in
  // nothing
end // end of [emit_saspdec]

(* ****** ****** *)

implement
emit_extype
  (out, hid) = let
//
val loc0 = hid.hidecl_loc
//
val-HIDextype
  (name, hse_def) = hid.hidecl_node
//
val () = emit_text (out, "/*\n")
val () = emit_location (out, loc0)
val () = emit_text (out, "\n*/\n")
//
in
//
case+
hse_def.hisexp_node of
//
| HSEtysum _ => {
//
    val () =
    emit_text (out, "typedef\n")
    val () =
    emit_hisexp_sel (out, hse_def)
    val () = emit_text (out, "\n")
    val () = emit_text (out, name)
    val () = emit_text (out, "_")
    val () = emit_text (out, " ;\n")
//
    val () =
    emit_text (out, "typedef\n")
    val () = emit_text (out, name)
    val () = emit_text (out, "_ *")
    val () = emit_text (out, name)
    val () = emit_text (out, " ;\n")
//
  } (* end of [HSEtysum] *)
//
| _ (*non-tysum*) => {
    val () =
    emit_text (out, "typedef\n")
    val () = emit_hisexp (out, hse_def)
    val () = emit_text (out, "\n")
    val () = emit_text (out, name)
    val () = emit_text (out, " ;\n")
  } (* end of [non-tysum] *)
//
end // end of [emit_extype]

(* ****** ****** *)

implement
emit_extcode
  (out, hid) = let
//
val loc0 = hid.hidecl_loc
val-HIDextcode (knd, pos, code) = hid.hidecl_node
//
val () = emit_text (out, "/*\n")
val () = emit_location (out, loc0)
val () = emit_text (out, "\n*/")
val () = emit_text (out, "\nATSextcode_beg()")
val () = emit_text (out, code)
val () = emit_text (out, "ATSextcode_end()\n")
//
in
  // nothing
end // end of [emit_extcode]

(* ****** ****** *)

local

fun
auxloc
(
  out: FILEref, loc: location
) : void = let
  val () = emit_text (out, "/*\n")
  val () = emit_location (out, loc)
  val () = emit_text (out, "\n*/\n")
in
  // nothing
end // end of [auxloc]

fun
auxsta
(
  out: FILEref, d2cs: d2eclist
) : void = let
//
(*
val () = println! ("auxsta")
*)
//
in
//
case+ d2cs of
| list_nil
    ((*void*)) => ()
  // end of [list_nil]
| list_cons
  (
    d2c, d2cs
  ) => auxsta(out, d2cs) where
  {
    val () =
    (
    case+
    d2c.d2ecl_node
    of // case+
//
    | $D2E.D2Cextcode
        (knd, pos, code) =>
      (
(*
      println! ("auxsta: pos = ", pod);
*)
//
      if
      (pos = 0) // %{#
      then let
        val loc = d2c.d2ecl_loc
      in
        auxloc(out, loc); emit_text(out, code)
      end // end of [then] // end of [if]
//
      ) (* end of [D2Cextcode] *)
//
    | $D2E.D2Cstaload
      (
        idopt
      , fil, flag, fenv, _(*loaded*)
      ) => let
        val () =
          auxloc(out, d2c.d2ecl_loc)
        val d2cs =
          $TR2ENV.filenv_get_d2eclist(fenv)
        val issta =
          $FIL.filename_is_sats(fil)
      in
        if issta then auxsta(out, d2cs) else ((*void*))
      end // end of [D2Cstaload]
//
    | _ (* rest-of-d2ecl *) => ((*skipped*))
//
    ) : void // end of [val]
  } (* end of [where] *) // end of [list_cons]
//
end // end of [auxsta]

fun
auxdyn
(
  out: FILEref, d2cs: d2eclist
) : void = let
in
//
case+ d2cs of
//
| list_nil
    ((*void*)) => ()
  // end of [list_nil]
//
| list_cons
  (
    d2c, d2cs
  ) => auxdyn(out, d2cs) where
  {
    val () =
    (
    case+
    d2c.d2ecl_node
    of // case+
//
    | $D2E.D2Cextcode
        (knd, pos, code) =>
      (
(*
      println! ("auxdyn: knd = ", knd);
*)
//
      if
      (pos = 0) // %{#
      then let
        val loc = d2c.d2ecl_loc
      in
        auxloc(out, loc); emit_text(out, code)
      end // end of [then] // end of [if]
//
      ) (* end of [D2Cextcode] *)
//
    | $D2E.D2Cstaload
      (
        idopt
      , fil, flag, fenv, loaded
      ) => let
        val () =
          auxloc(out, d2c.d2ecl_loc)
        val d2cs =
          $TR2ENV.filenv_get_d2eclist(fenv)
        val issta =
          $FIL.filename_is_sats(fil)
      in
        if issta
          then auxsta(out, d2cs) else auxdyn(out, d2cs)
        // end of [if]
      end // end of [D2Cstaload]
//
    | $D2E.D2Clocal
      (
        d2cs_head, d2cs_body
      ) =>
      (
        auxdyn(out, d2cs_head); auxdyn(out, d2cs_body)
      ) // end of [D2Clocal]
//
    | $D2E.D2Cinclude
        (knd, d2cs) =>
      (
        if knd = 0
          then auxsta(out, d2cs) else auxdyn(out, d2cs)
        // end of [if]
      ) (* end of [D2Cinclude] *)
    | _ (* rest-of-d2ecl *) => ((*skipped*))
//
    ) : void // end of [val]
//
  } (* end of [where] *) // end of [list_cons]
//
end // end of [auxdyn]

in (* in of [local] *)

implement
emit_staload
  (out, hid) = let
//
val-HIDstaload
(
  idopt, fil, flag, fenv, loaded
) = hid.hidecl_node // end-of-val
(*
val () = 
  println! ("emit_staload: flag = ", flag)
*)
val d2cs =
  $TR2ENV.filenv_get_d2eclist(fenv)
//
val issta = $FIL.filename_is_sats(fil)
//
in
  if issta then auxsta(out, d2cs) else auxdyn(out, d2cs)
end // end of [emit_staload]

end // end of [local]

(* ****** ****** *)
//
extern
fun
emit_tmprimval(out: FILEref, tpmv: tmprimval): void
extern
fun
emit_tmpmovlst(out: FILEref, tmvlst: tmpmovlst): void
//
(* ****** ****** *)

implement
emit_tmprimval (out, tpmv) =
(
case+ tpmv of
| TPMVnone (pmv) => emit_primval (out, pmv)
| TPMVsome (tmp, _) => emit_tmpvar (out, tmp)
) (* end of [emit_tmprimval] *)

(* ****** ****** *)

implement
emit_tmpmovlst (out, tmvlst) = let
//
fun auxlst
(
  out: FILEref, i: int, xs: tmpmovlst
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () =
    emit_text (out, "ATSINSmove(")
    val () = emit_tmpvar (out, x.1)
    val () = emit_text (out, ", ")
    val () = emit_tmprimval (out, x.0)
    val () = emit_text (out, ") ; ")
  in
    auxlst (out, i+1, xs)
  end // end of [list_cons]
| list_nil((*void*)) => ((*void*))
//
end // end of [auxlst]
//
in
  auxlst (out, 0(*i*), tmvlst)
end (* end of [emit_tmpmovlst] *)

(* ****** ****** *)
//
extern
fun
emit_patckont
  (out: FILEref, fail: patckont): void
//
implement
emit_patckont
  (out, fail) = let
in
//
case+ fail of
//
| PTCKNTtmplab (tlab) =>
  {
    val () =
    emit_text (out, "ATSINSgoto(")
    val () = emit_tmplab (out, tlab)
    val ((*closing*)) = emit_text (out, ")")
  }
//
| PTCKNTtmplabint (tlab, int) =>
  {
    val () =
    emit_text (out, "ATSINSgoto(")
    val () = emit_tmplabint (out, tlab, int)
    val ((*closing*)) = emit_text (out, ")")
  }
//
| PTCKNTtmplabmov (tlab, tmvlst) =>
  {
    val () =
    emit_tmpmovlst (out, tmvlst)
    val () =
    emit_text (out, "ATSINSgoto(")
    val () = emit_tmplab (out, tlab)
    val ((*closing*)) = emit_text (out, ")")
  }
//
| PTCKNTraise (tmp, pmv_exn) =>
  {
    val () =
    emit_text (out, "ATSINSraise_exn(")
    val () = (
      emit_tmpvar (out, tmp); emit_text (out, ", "); emit_primval (out, pmv_exn)
    ) (* end of [val] *)
    val ((*closing*)) = emit_text (out, ")")
  }
//
| PTCKNTcaseof_fail (loc) =>
  {
    val () =
    emit_text (out, "ATSINScaseof_fail(\"")
    val () = $LOC.fprint_location (out, loc)
    val ((*closing*)) = emit_text (out, "\")")
  }
//
| PTCKNTfunarg_fail (loc, flab) =>
  {
    val () =
    emit_text (out, "ATSINSfunarg_fail(\"")
    val () = $LOC.fprint_location (out, loc)
    val ((*closing*)) = emit_text (out, "\")")
  }
//
| PTCKNTnone ((*void*)) =>
  {
    val () = emit_text (out, "ATSINSdeadcode_fail()")
  }
//
end // (* end of [emit_patckont] *)
//
(* ****** ****** *)
//
// HX-2013-01:
//
// the kind of code duplication in the implementation
// of [emit_instr_patck] can be readily removed by using
// template system of ATS2.
//
//
local

fun auxcon
(
  out: FILEref
, pmv: primval
, d2c: d2con, fail: patckont
) : void =let
//
val s2c = $S2E.d2con_get_scst (d2c)
//
in
//
case+ 0 of
| _ when
    $S2E.s2cst_is_singular (s2c) => ()
| _ when
    $S2E.s2cst_is_listlike (s2c) => let
    val islst = $S2E.s2cst_get_islst (s2c) 
    val isnil = (
      case+ islst of
      | Some xx =>
          $S2E.eq_d2con_d2con (d2c, xx.0)
      | None () => false (* deadcode *)
    ) : bool // end of [val]
    val () = emit_text (out, "ATSifthen(")
    val () = (
      if isnil
        then emit_text (out, "ATSCKptriscons(")
        else emit_text (out, "ATSCKptrisnull(")
      // end of [if]
    ) : void // end of [val]
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; } ;")
  in
    // nothing
  end // end of [islistlike]
| _ => let
    val isnul =
      $S2E.d2con_is_nullary (d2c)
    // end of [val]
    val () =
      emit_text (out, "ATSifnthen(")
    val () =
    (
      if isnul
        then emit_text (out, "ATSCKpat_con0(")
        else emit_text (out, "ATSCKpat_con1(")
      // end of [if]
    ) : void // end of [val]
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_int (out, $S2E.d2con_get_tag (d2c))
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; } ;")
  in
    // nothing
  end // end of [PATCKcon]
//
end // end of [auxcon]

fun auxexn
(
  out: FILEref
, pmv: primval
, d2c: d2con, fail: patckont
) : void = let
//
val narg =
  $S2E.d2con_get_arity_real (d2c)
//
val () =
  emit_text (out, "ATSifnthen(")
val () =
(
  if narg = 0
    then emit_text (out, "ATSCKpat_exn0(")
    else emit_text (out, "ATSCKpat_exn1(")
  // end of [if]
) : void // end of [val]
val () = emit_primval (out, pmv)
val () = emit_text (out, ", ")
val () = emit_d2con (out, d2c);
val () = emit_text (out, ")) { ")
val () = emit_patckont (out, fail)
val () = emit_text (out, " ; } ;")
//
in
  // nothing
end // end of [auxexn]

fun auxmain (
  out: FILEref
, pmv: primval, patck: patck, fail: patckont
) : void = let
in
//
case+ patck of
//
| PATCKcon (d2c) => let
    val iscon = $S2E.d2con_is_con (d2c)
  in
    if iscon then
      auxcon (out, pmv, d2c, fail) else auxexn (out, pmv, d2c, fail)
    // end of [if]
  end // end of [PATCKcon]
//
| PATCKint (i) => {
    val () = emit_text (out, "ATSifnthen(")
    val () = emit_text (out, "ATSCKpat_int(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVint (out, i)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; } ;")
  } (* end of [PATCKint] *)
//
| PATCKbool (b) => {
    val () = emit_text (out, "ATSifnthen(")
    val () = emit_text (out, "ATSCKpat_bool(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVbool (out, b)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; } ;")
  } (* end of [PATCKbool] *)
//
| PATCKchar (c) => {
    val () = emit_text (out, "ATSifnthen(")
    val () = emit_text (out, "ATSCKpat_char(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVchar (out, c)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; } ;")
  } (* end of [PATCKchar] *)
//
| PATCKfloat (float) =>
  {
    val () = emit_text (out, "ATSifnthen(")
    val () = emit_text (out, "ATSCKpat_float(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVfloat (out, float)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; } ;")
  } (* end of [PATCKfloat] *)
//
| PATCKstring (string) =>
  {
    val () = emit_text (out, "ATSifnthen(")
    val () = emit_text (out, "ATSCKpat_string(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVstring (out, string)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; } ;")
  } (* end of [PATCKstring] *)
//
| PATCKi0nt (tok) => {
    val () = emit_text (out, "ATSifnthen(")
    val () = emit_text (out, "ATSCKpat_int(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVi0nt (out, tok)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; } ;")
  } (* end of [PATCKi0nt] *)
//
| PATCKf0loat (tok) => {
    val () = emit_text (out, "ATSifnthen(")
    val () = emit_text (out, "ATSCKpat_float(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVf0loat (out, tok)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; } ;")
  } (* end of [PATCKf0loat] *)
//
(*
| _ (*unrecognized*) => let
    val () = prerr_interror ()
    val () = prerrln! (": emit_instr_patck: patck = ", patck)
    val () = assertloc (false)
  in
    $ERR.abort ((*void*))
  end // end of [let] // end of [_]
*)
//
end (* end of [auxmain] *)

in (* in of [local] *)

implement
emit_instr_patck
  (out, ins) = let
//
val-INSpatck
  (pmv, patck, fail) = ins.instr_node
val isnone = patckont_is_none (fail)
val () =
  if isnone then emit_text (out, "#if(0)\n")
val () = auxmain (out, pmv, patck, fail)
val () =
  if isnone then emit_text (out, "\n#endif")
//
in
  // nothing
end // end of [emit_instr_patck]

end // end of [local]

(* ****** ****** *)

local

fun aux
(
  out: FILEref, ibr: ibranch
) : void =  let
//
val inss = ibr.ibranch_inslst
//
val () = emit_text (out, "ATSbranch_beg()\n")
val () = emit_instrlst_ln (out, inss)
val () = emit_text (out, "ATSbranch_end()\n")
//
in
  // nothing
end // end of [emit_branch]

in (*in-of-local*)

implement
emit_ibranchlst
  (out, ibrs) = let
//
fun auxlst
(
  out: FILEref
, i: int, ibrs: ibranchlst
) : void = let
in
//
case+ ibrs of
| list_cons
    (ibr, ibrs) =>
  {
    val () = aux (out, ibr)
    val () = emit_newline (out)
    val () = auxlst (out, i+1, ibrs)
  } // end of [list_cons]
| list_nil () => ()
//
end // end of [auxlst]
//
val () = emit_text
(
  out, "/*\n** ibranchlst-beg\n*/\n"
)
val () = auxlst (out, 0(*i*), ibrs)
val () = emit_text
(
  out, "/*\n** ibranchlst-end\n*/\n"
)
in
  // nothing
end // end of [emit_ibranchlst]

end // end of [local]

(* ****** ****** *)

local

fun
auxfun
(
  out: FILEref, fent: funent
) : void = let
//
val flab = funent_get_lab(fent)
val istmp = (funlab_get_tmpknd(flab) > 0)
//
val qopt = funlab_get_d2copt(flab)
val isqua =
(
  case+ qopt of Some(d2c) => true | None() => false
) : bool // end of [val]
val isext =
(
case+ qopt of
| Some (d2c) =>
    if $D2E.d2cst_is_static(d2c) then false else true
| None _ => false
) : bool // end of [val]
//
val flopt = funlab_get_origin(flab)
val isqua =
(
  case+ flopt of Some _ => false | None () => isqua
) : bool // end of [val]
val isext =
(
  case+ flopt of Some _ => false | None () => isext
) : bool // end of [val]
val issta = not (isext)
//
val () = if istmp then emit_text (out, "#if(0)\n")
val () = if isqua then emit_text (out, "#if(0)\n")
//
val () = if isext then emit_text (out, "ATSextern()\n")
val () = if issta then emit_text (out, "ATSstatic()\n")
//
val hse_res = funlab_get_type_res (flab)
val hses_arg = funlab_get_type_fullarg (flab)
//
val (
) = emit_hisexp (out, hse_res)
val () = emit_text (out, "\n")
val () = emit_funlab (out, flab)
val () = emit_text (out, "(")
val (
) = emit_hisexplst_sep (out, hses_arg, ", ")
val () = emit_text (out, ") ;\n")
//
val () =
  if isqua then emit_text (out, "#endif // end of [QUALIFIED]\n")
//
val () =
  if istmp then emit_text (out, "#endif // end of [TEMPLATE]\n")
//
in
  // nothing
end // end of [auxfun]

in (* in of [local] *)

implement
emit_funent_ptype
  (out, fent) = let
//
val () = auxfun (out, fent)
//
val () = emit_newline (out)
//
in
  // nothing
end // end of [emit_funentry_ptype]

end // end of [local]

(* ****** ****** *)

local

fun
aux0_arglst
(
  out: FILEref
, hses: hisexplst, i: int
) : void = let
in
//
case+ hses of
//
| list_nil () => ()
//
| list_cons
    (hse, hses) => let
    val () =
    if i > 0
      then emit_text (out, ", ")
    // end of [if]
    val () = emit_hisexp (out, hse)
  in
    aux0_arglst (out, hses, i+1)
  end // end of [list_cons]
//
end (* end of [aux0_arglst] *)

fun
aux1_arglst
(
  out: FILEref
, hses: hisexplst, n0: int, i: int
) : void = let
in
//
case+ hses of
//
| list_nil () => ()
//
| list_cons
    (hse, hses) => let
    val () =
    if n0+i > 0 then emit_text (out, ", ")
    val () =
    (
      emit_hisexp (out, hse); emit_text (out, " arg"); emit_int (out, i)
    ) : void // end of [val]
  in
    aux1_arglst (out, hses, n0, i+1)
  end // end of [list_cons]
//
end (* end of [aux1_arglst] *)

fun
aux2_arglst
(
  out: FILEref
, hses: hisexplst, n0: int, i: int
) : void = let
in
//
case+ hses of
//
| list_nil () => ()  
//
| list_cons
    (hse, hses) => let
    val () =
    if n0+i > 0 then emit_text (out, ", ")
    val () =
    (
      emit_text (out, "arg"); emit_int (out, i)
    ) : void // end of [val]
  in
    aux2_arglst (out, hses, n0, i+1)
  end // end of [list_cons]
//
end (* end of [aux2_arglst] *)

fun
aux0_envlst
(
  out: FILEref, d2es: d2envlst, i: int
) : void = let
in
//
case+ d2es of
//
| list_nil () => ()
//
| list_cons
    (d2e, d2es) => let
    val hse = d2env_get_type (d2e)
    val () =
    if i > 0
      then emit_text (out, ", ")
    // end of [if]
    val () = emit_hisexp (out, hse)
  in
    aux0_envlst (out, d2es, i+1)
  end // end of [list_cons]
//
end (* end of [aux0_envlst] *)

fun
aux1_envlst
(
  out: FILEref, d2es: d2envlst, i: int
) : void = let
in
//
case+ d2es of
//
| list_nil () => ()
//
| list_cons
    (d2e, d2es) => let
    val hse = d2env_get_type (d2e)
    val () =
    (
      emit_hisexp (out, hse); emit_text (out, " env"); emit_int (out, i)
    )
    val () = emit_text (out, " ;\n")
  in
    aux1_envlst (out, d2es, i+1)
  end // end of [list_cons]
//
end (* end of [aux1_envlst] *)

fun
aux2_envlst
(
  out: FILEref
, d2es: d2envlst, n0: int, i: int
) : int = let
in
//
case+ d2es of
//
| list_nil () => (n0+i)
//
| list_cons
    (d2e, d2es) => let
    val hse = d2env_get_type (d2e)
    val () =
    if n0+i > 0 then emit_text (out, ", ")
    val () =
    (
      emit_hisexp (out, hse); emit_text (out, " env"); emit_int (out, i)
    ) : void // end of [val]
  in
    aux2_envlst (out, d2es, n0, i+1)
  end // end of [list_cons]
//
end (* end of [aux2_envlst] *)

fun
aux3_envlst
(
  out: FILEref
, d2es: d2envlst, n0: int, i: int
) : int = let
in
//
case+ d2es of
//
| list_nil () => (n0+i)
//
| list_cons
    (d2e, d2es) => let
    val () =
    if n0+i > 0 then emit_text (out, ", ")
    val () =
    (
      emit_text (out, "env"); emit_int (out, i)
    ) : void // end of [val]
  in
    aux3_envlst (out, d2es, n0, i+1)
  end // end of [list_cons]
//
end (* end of [aux3_envlst] *)

fun
aux4_envlst
(
  out: FILEref
, d2es: d2envlst, n0: int, i: int
) : int = let
in
//
case+ d2es of
//
| list_nil () => (i)
//
| list_cons
    (d2e, d2es) => let
    val () =
    if n0+i > 0 then emit_text (out, ", ")
    val () =
    (
      emit_text (out, "p_cenv->env"); emit_int (out, i)
    ) : void // end of [val]
  in
    aux4_envlst (out, d2es, n0, i+1)
  end // end of [list_cons]
//
end (* end of [aux4_envlst] *)

fun
aux5_envlst
(
  out: FILEref, d2es: d2envlst, i: int
) : void = let
in
//
case+ d2es of
| list_cons
    (d2e, d2es) => let
    val hse = d2env_get_type (d2e)
    val () =
    (
      emit_text (out, "p_cenv->env"); emit_int (out, i)
    ) : void // end of [val]
    val () =
    (
      emit_text (out, " = "); emit_text (out, "env"); emit_int (out, i)
    ) : void // end of [val]
    val () = emit_text (out, " ;\n")
  in
    aux5_envlst (out, d2es, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end (* end of [aux5_envlst] *)

fun
auxclo_type
(
  out: FILEref
, flab: funlab, d2es: d2envlst
) : void = let
//
val () = emit_text (out, "typedef\n")
val () = emit_text (out, "ATSstruct {\n")
val () = emit_text (out, "atstype_funptr cfun ;\n")
val () = aux1_envlst (out, d2es, 0)
val ((*closing*)) = emit_text (out, "} ")
//
val () = emit_funlab (out, flab)
val () = emit_text (out, "__closure_t0ype ;\n")
//
in
  // nothing
end (* end of [auxclo_type] *)

fun
auxclo_cfun
(
  out: FILEref
, flab: funlab, d2es: d2envlst
) : void = let
//
val hse_res = funlab_get_type_res (flab)
val hses_arg = funlab_get_type_arg (flab)
//
val isvoid = hisexp_is_void (hse_res)
//
val () = emit_text (out, "ATSstatic()\n")
val () = emit_hisexp (out, hse_res)
val () = emit_text (out, "\n")
val () = emit_funlab (out, flab)
val () = emit_text (out, "__cfun")
val () = emit_text (out, "\n(\n")
val () = emit_funlab (out, flab)
val () = emit_text (out, "__closure_t0ype *p_cenv")
val () = aux1_arglst (out, hses_arg, 1, 0)
val () = emit_text (out, "\n)\n{\n")
val () = emit_text (out, "ATSFCreturn")
val () = if isvoid then emit_text (out, "_void")
val () = emit_text (out, "(")
val () = emit_funlab (out, flab)
val () = emit_text (out, "(")
val n0 = aux4_envlst (out, d2es, 0, 0)
val () = aux2_arglst (out, hses_arg, n0, 0)
val () = emit_text (out, ")) ;\n")
val () = emit_text (out, "} /* end of [cfun] */\n")
//
in
  // nothing
end (* end of [auxclo_cfun] *)

fun
auxclo_init
(
  out: FILEref
, flab: funlab, d2es: d2envlst
) : void = let
//
val () = emit_text (out, "ATSstatic()\n")
val () = emit_text (out, "atstype_cloptr\n")
//
val () = emit_funlab (out, flab)
val () = emit_text (out, "__closureinit")
val () = emit_text (out, "\n(\n")
//
val () = emit_funlab (out, flab)
val () = emit_text (out, "__closure_t0ype *p_cenv")
val n0 = aux2_envlst (out, d2es, 1, 0)
//
val () = emit_text (out, "\n)\n{\n")
val () = aux5_envlst (out, d2es, 0)
val () = emit_text (out, "p_cenv->cfun = ")
val () = emit_funlab (out, flab)
val () = emit_text (out, "__cfun ;\n")
val () = emit_text (out, "return p_cenv ;\n")
val () = emit_text (out, "} /* end of [closureinit] */\n")
//
in
  // nothing
end (* end of [auxclo_init] *)

fun
auxclo_create
(
  out: FILEref
, flab: funlab, d2es: d2envlst
) : void = let
//
val () = emit_text (out, "ATSstatic()\n")
val () = emit_text (out, "atstype_cloptr\n")
//
val () = emit_funlab (out, flab)
val () = emit_text (out, "__closurerize")
val () = emit_text (out, "\n(\n")
//
val n0 = aux2_envlst (out, d2es, 0, 0)
val () = if n0 = 0 then emit_text (out, "// argumentless")
//
val () = emit_text (out, "\n)\n{\n")
val () = emit_text (out, "return ")
val () = emit_funlab (out, flab)
val () = emit_text (out, "__closureinit(")
val () = emit_text (out, "ATS_MALLOC(sizeof(")
val () = emit_funlab (out, flab)
val () = emit_text (out, "__closure_t0ype))")
val n0 = aux3_envlst (out, d2es, 1, 0)
val () = emit_text (out, ") ;\n")
val () = emit_text (out, "} /* end of [closurerize] */\n")
//
in
  // nothing
end (* end of [auxclo_create] *)

fun
auxall_beg
(
  out: FILEref
, flab: funlab, d2es: d2envlst
) : void =
{
//
val hse_res = funlab_get_type_res (flab)
val hses_arg = funlab_get_type_arg (flab)
//
val () =
emit_text
(
  out
, "ATSclosurerize_beg"
) (* end of [val] *)
//
val () = emit_LPAREN (out)
//
val () =
emit_funlab (out, flab)
//
val () = emit_text (out, ", ")
//
val () = emit_LPAREN (out)
val () = aux0_envlst (out, d2es, 0)
val () = emit_RPAREN (out)
//
val () = emit_text (out, ", ")
//
val () = emit_LPAREN (out)
val () = aux0_arglst (out, hses_arg, 0)
val () = emit_RPAREN (out)
//
val () = emit_text (out, ", ")
//
val () = emit_hisexp (out, hse_res)
//
val () = emit_RPAREN (out)
val () = emit_newline (out)
//
} (* end of [auxall_end] *)

fun auxall_end
(
  out: FILEref
, flab: funlab, d2es: d2envlst
) : void =
{
//
val () = emit_text (out, "ATSclosurerize_end()\n")
//
} (* end of [auxall_end] *)

in (* in of [local] *)

implement
emit_funent_closure
  (out, fent) = let
//
val flab = funent_get_lab (fent)
val d2es = funent_eval_d2envlst (fent)
//
val () = auxall_beg (out, flab, d2es)
//
val () = auxclo_type (out, flab, d2es)
val () = auxclo_cfun (out, flab, d2es)
val () = auxclo_init (out, flab, d2es)
//
val fc =
funlab_get_funclo (flab)
val () =
if funclo_is_ptr(fc)
  then auxclo_create (out, flab, d2es)
// end of [if]
//
val () = auxall_end (out, flab, d2es)
//
in
  // nothing
end // end of [emit_funent_closure]

end // end of [local]

(* ****** ****** *)
//
extern
fun
emit_funlab_funarg
  (out: FILEref, flab: funlab): void
//
implement
emit_funlab_funarg (out, flab) = let
//
fun auxlst
(
  out: FILEref, hses: hisexplst, i: int
) : void = let
in
//
case+ hses of
| list_cons
    (hse, hses) => let
    val () =
      emit_text (out, "ATStmpdec(")
    // end of [val]
(*
    val isvoid = hisexp_is_void (hse)
    val ((*void*)) =
      if isvoid then emit_text (out, "_void")
    // end of [val]
*)
    val () = (
      emit_funarg (out, i); emit_text (out, ", "); emit_hisexp (out, hse)
    ) (* end of [val] *)
    val () = emit_text (out, ") ;\n")
  in
    auxlst (out, hses, i+1)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [auxlst]
//
val hses = funlab_get_type_arg (flab)
//
in
  auxlst (out, hses, 0(*i*))
end // end of [emit_funlab_funarg]
//
(* ****** ****** *)
//
extern
fun
emit_funlab_funapy
  (out: FILEref, flab: funlab): void
//
implement
emit_funlab_funapy
  (out, flab) = let
//
fun
auxlst
(
  out: FILEref, hses: hisexplst, i: int
) : void = let
in
//
case+ hses of
| list_cons
    (hse, hses) => let
    val () =
      emit_text(out, "ATStmpdec(")
    // end of [val]
(*
    val isvoid = hisexp_is_void (hse)
    val ((*void*)) =
      if isvoid then emit_text (out, "_void")
    // end of [val]
*)
    val () =
    (
      emit_funapy(out, i); emit_text(out, ", "); emit_hisexp(out, hse)
    ) (* end of [val] *)
    val () = emit_text(out, ") ;\n")
  in
    auxlst(out, hses, i+1)
  end // end of [list_cons]
| list_nil((*void*)) => ()
//
end // end of [auxlst]
//
val hses = funlab_get_type_arg (flab)
//
in
  auxlst (out, hses, 0(*i*))
end // end of [emit_funlab_funapy]

(* ****** ****** *)

extern
fun
emit_funent_fundec
  (out: FILEref, fent: funent): void
implement
emit_funent_fundec
  (out, fent) = let
//
val flab = funent_get_lab(fent)
//
val tmpret = funent_get_tmpret(fent)
val ntlcal = tmpvar_get_tailcal(tmpret)
//
val () = emit_text (out, "/* tmpvardeclst(beg) */\n")
//
val () =
  if ntlcal >= 2 then emit_funlab_funapy(out, flab)
//
val () = emit_tmpdeclst(out, funent_get_tmpvarlst(fent))
//
val () = emit_text (out, "/* tmpvardeclst(end) */\n")
//
in
  // nothing
end // end of [emit_funent_fundec]

(* ****** ****** *)
//
extern
fun
emit_funent_funbody
  (out: FILEref, fent: funent): void
//
implement
emit_funent_funbody
  (out, fent) = let
//
val () = emit_text (out, "ATSfunbody_beg()\n")
val () = emit_instrlst_ln (out, funent_get_instrlst (fent))
val () = emit_text (out, "ATSfunbody_end()\n")
//
val tmpret = funent_get_tmpret (fent)
//
val () = let
  val isvoid = tmpvar_is_void (tmpret)
in
  if ~isvoid
    then emit_text(out, "ATSreturn(") else emit_text(out, "ATSreturn_void(")
  // end of [if]
end : void // end of [let] // end of [val]
//
val () = emit_tmpvar (out, tmpret)
//
val ((*closing*)) = emit_text (out, ") ;\n")
//
in
  // nothing
end // end of [emit_funent_funbody]

(* ****** ****** *)
//
extern
fun
emit_funent_fnxdeclst (out: FILEref, fent0: funent): void
extern
fun
emit_funent_fnxbodylst (out: FILEref, fent0: funent): void
//
(* ****** ****** *)

local

fun auxfl
(
  out: FILEref
, fent0: funent, fl: funlab
) : void = let
//
val opt = funlab_get_funent (fl)
//
in
//
case+ opt of
| Some (fent) => let
    val () = emit_funlab_funarg (out, fl)
    val () = emit_funent_fundec (out, fent)
  in
    // nothing
  end // end of [Some]
| None ((*void*)) => ()
//
end // end of [auxfl]

and auxflist
(
  out: FILEref
, fent0: funent, fls: funlablst, i: int
) : void = let
in
//
case+ fls of
| list_cons
    (fl, fls) => let
    val () = emit_set_nfnx (i)
    val () = auxfl (out, fent0, fl)
    val () = emit_set_nfnx (0)
    val () = auxflist (out, fent0, fls, i+1)
  in
    // nothing
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [auxflist]

in (* in of [local] *)

implement
emit_funent_fnxdeclst
  (out, fent0) = let
//
val fls = funent_get_fnxlablst(fent0)
//
val () = (
case+ fls of
| list_cons _ =>
  emit_text(out, "/*\nemit_funent_fnxdeclst:\n*/\n")
| list_nil((*void*)) => ((*void*))
) : void // end of [val]
//
in
//
case+ fls of
| list_cons
    (fl0, fls) => auxflist (out, fent0, fls, 2(*i*))
  // end of [list_cons]
| list_nil((*void*)) => ((*void*))
//
end // end of [emit_funent_fnxdeclst]

end // end of [local]

(* ****** ****** *)

local

fun auxfl
(
  out: FILEref
, fent0: funent, fl: funlab
) : void = let
//
val opt = funlab_get_funent(fl)
//
in
//
case+ opt of
| Some (fent) =>
    emit_funent_funbody(out, fent)
| None ((*void*)) => ((*void*))
//
end // end of [auxfl]

and auxflist
(
  out: FILEref
, fent0: funent, fls: funlablst, i: int
) : void = let
in
//
case+ fls of
| list_cons
    (fl, fls) => let
    val () = emit_set_nfnx (i)
    val () = auxfl (out, fent0, fl)
    val () = emit_set_nfnx (0)
    val () = auxflist (out, fent0, fls, i+1)
  in
    // nothing
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [auxflist]

in (* in of [local] *)

implement
emit_funent_fnxbodylst
  (out, fent0) = let
//
val fls = funent_get_fnxlablst (fent0)
//
val () = (
case+ fls of
| list_cons _ =>
  emit_text (out, "/*\nemit_funent_fnxbodylst:\n*/\n")
| _ => ((*void*))
) : void // end of [val]
//
in
//
case+ fls of
| list_cons
    (fl0, fls) => auxflist (out, fent0, fls, 2(*i*))
  // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [emit_funent_fnxbodylst]

end // end of [local]

(* ****** ****** *)

local

fun auxtmp
(
  out: FILEref, fent: funent
) : void = let
//
val imparg = funent_get_imparg (fent)
val tmparg = funent_get_tmparg (fent)
val tsubopt = funent_get_tmpsub (fent)
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "imparg = ")
val () = $S2E.fprint_s2varlst (out, imparg)
val () = emit_text (out, "\n")
val () = emit_text (out, "tmparg = ")
val () = $S2E.fprint_s2explstlst (out, tmparg)
val () = emit_text (out, "\n")
val () = emit_text (out, "tmpsub = ")
val () = fprint_tmpsubopt (out, tsubopt)
val () = emit_text (out, "\n")
val () = emit_text (out, "*/\n")
//
in
  // nothing
end // end of [auxtmp]

in (* in of [local] *)

implement
emit_funent_implmnt
  (out, fent) = let
(*
val () =
fprintln!
( stdout_ref
, "emit_funent_implmnt: fent = ", fent
)
*)
val loc0 = funent_get_loc (fent)
val flab = funent_get_lab (fent)
val d2es = funent_eval_d2envlst (fent)
(*
val () =
fprintln!
( stdout_ref
, "emit_funent_implmnt: d2es = ", d2es
)
*)
val () = emit_text (out, "/*\n")
val () = $LOC.fprint_location (out, loc0)
val () = emit_text (out, "\n*/\n")
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "local: ")
val lfls0 = funent_get_flablst (fent)
val () = fprint_funlablst (out, lfls0)
val () = emit_newline (out)
val () = emit_text (out, "global: ")
val gfls0 = funent_eval_flablst (fent)
val () = fprint_funlablst (out, gfls0)
val () = emit_newline (out)
//
val () = emit_text (out, "local: ")
val ld2es = funent_eval_d2envlst (fent)
val () = fprint_d2envlst (out, ld2es)
val () = emit_newline (out)
val () = emit_text (out, "global: ")
val gd2es = funent_eval_d2envlst (fent)
val () = fprint_d2envlst (out, gd2es)
val () = emit_newline (out)
//
val () = emit_text (out, "*/\n")
//
val hse_res = funlab_get_type_res (flab)
val hses_arg = funlab_get_type_arg (flab)
//
// function header
//
val qopt = funlab_get_d2copt (flab)
val isext =
(
case+ qopt of
| Some (d2c) =>
    if $D2E.d2cst_is_static (d2c) then false else true
| None _ => false
) : bool // end of [val]
val flopt = funlab_get_origin (flab)
val isext =
(
  case+ flopt of Some (d2c) => false | None () => isext
) : bool // end of [val]
val issta = not (isext)
//
val () =
  if isext then emit_text (out, "ATSextern()\n")
val () =
  if issta then emit_text (out, "ATSstatic()\n")
//
val istmp = funent_is_tmplt (fent)
val () = if istmp then auxtmp (out, fent)
//
val () = emit_hisexp (out, hse_res)
val () = emit_text (out, "\n")
val () = emit_funlab (out, flab)
val () = emit_text (out, "(")
val nenv = emit_funenvlst (out, d2es)
val () = emit_funarglst (out, nenv, hses_arg)
val () = emit_text (out, ")\n")
//
// tmpvardec and funbody
//
val () = funent_varbindmap_initize (fent)
val () = funent_varbindmap_initize2 (fent)
//
val () = emit_text (out, "{\n")
//
val () = emit_funent_fundec (out, fent)
val () = emit_funent_fnxdeclst (out, fent)
//
val () = emit_funent_funbody (out, fent)
val () = emit_funent_fnxbodylst (out, fent)
//
val () = emit_text (out, "} /* end of [")
val () = emit_funlab (out, flab)
val () = emit_text (out, "] */\n")
//
val () = funent_varbindmap_uninitize (fent)
//
in
  // nothing
end // end of [emit_funent_implmnt]

end // end of [local]

(* ****** ****** *)

implement
emit_dynload
  (out, hid) = let
//
val-HIDdynload (fil) = hid.hidecl_node
//
val () = emit_text (out, "ATSdynloadfcall(")
val () =
(
  emit_filename (out, fil); emit_text (out, "__dynload")
)
val () = emit_text (out, ") ;\n")
//
in
  // nothing
end (* end of [emit_dynload] *)

(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
fun emit_primdec
  (out: FILEref, pmd: primdec) : void = let
in
//
case+ pmd.primdec_node of
//
| PMDnone () => ()
//
| PMDlist (pmds) => emit_primdeclst (out, pmds)
//
| PMDsaspdec _ => ()
//
| PMDextvar
    (name, inss) =>
    emit_instrlst_ln (out, $UN.cast{instrlst}(inss))
//
| PMDdatdecs _ => ()
| PMDexndecs _ => ()
//
| PMDimpdec (imp) => let
    val opt = hiimpdec_get_instrlstopt (imp)
  in
    case+ opt of
    | Some (inss) => emit_instrlst_ln (out, inss)
    | None () => ()
  end // end of [PMDimpdec]
//
| PMDfundecs _ => ()
//
| PMDvaldecs
    (knd, hvds, inss) =>
    emit_instrlst_ln (out, $UN.cast{instrlst}(inss))
| PMDvaldecs_rec
    (knd, hvds, inss) =>
    emit_instrlst_ln (out, $UN.cast{instrlst}(inss))
//
| PMDvardecs(hvds, inss) =>
    emit_instrlst_ln (out, $UN.cast{instrlst}(inss))
//
| PMDinclude
    (pfil, pmds) => emit_primdeclst (out, pmds)
//
| PMDstaload _ => ()
//
| PMDstaloadloc
    (pfil, nspace, pmds) => emit_primdeclst (out, pmds)
//
| PMDdynload (cfil) => emit_dynload (out, cfil)
//
| PMDlocal
  (
    pmds_head, pmds_body
  ) => {
    val (
    ) = emit_text (out, "/* local */\n")
    val () = emit_primdeclst (out, pmds_head)
    val (
    ) = emit_text (out, "/* in of [local] */\n")
    val () = emit_primdeclst (out, pmds_body)
    val (
    ) = emit_text (out, "/* end of [local] */\n")
    // end of [val]
  } // end of [PMDlocal]
//
end // end of [emit_primdec]

in (* in of [local] *)

implement
emit_primdeclst
  (out, pmds) = let
in
//
case+ pmds of
| list_cons
    (pmd, pmds) => let
    val () =
      emit_primdec (out, pmd) in emit_primdeclst (out, pmds)
    // end of [val]
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [emit_primdeclst]

end // end of [local]

(* ****** ****** *)

implement
emit_d2con_extdec
  (out, d2c) = let
//
val isexn =
  $S2E.d2con_is_exn (d2c)
val (
) = if isexn then {
//
val () = emit_text (out, "ATSdynexn_extdec")
val () = emit_text (out, "(")
val () = emit_d2con (out, d2c)
val () = emit_text (out, ") ;\n")
//
} // end of [if] // end of [val]
//
in
  // nothing
end // end of [emit_d2con_extdec]

implement
emit_d2conlst_extdec
  (out, d2cs) =
(
  list_app_cloptr<d2con> (d2cs, lam d2c =<1> emit_d2con_extdec (out, d2c))
) // end of [emit_d2conlst_extdec]

(* ****** ****** *)

implement
emit_d2conlst_initize
  (out, d2cs) = let
//
fun aux
(
  out: FILEref, d2c: d2con
) : void = let
//
val fil = $S2E.d2con_get_fil (d2c)
val name = $S2E.d2con_get_name (d2c)
//
val () = emit_text (out, "ATSdynexn_initize(")
val () = emit_d2con (out, d2c)
val () = emit_text (out, ", ")
val () = emit_text (out, "\"")
val () = $FIL.fprint_filename_full (out, fil)
val () = emit_text (out, ":")
val () = emit_text (out, name)
val () = emit_text (out, "\"")
val () = emit_text (out, ") ;\n")
//
in
  // nothing
end (* end of [aux] *)
//
in
//
case+ d2cs of
| list_cons
    (d2c, d2cs) => let
    val isexn = $S2E.d2con_is_exn (d2c)
    val ((*void*)) = if isexn then aux (out, d2c)
  in
    emit_d2conlst_initize (out, d2cs)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [emit_d2conlst_initize]

(* ****** ****** *)

(*
//
// HX-2014-03-14: should it be tried?
//
fun
d2cst_is_lamless
  (d2c: d2cst): bool = let
//
val opt = $D2E.d2cst_get_funlab (d2c)
//
in
//
case+ opt of
| None () => false
| Some (flab) => let
    val flab = $UN.cast{funlab}(flab)
    val opt2 = funlab_get_d2copt (flab)
  in
    case+ opt2 of
    | None () => false
    | Some (d2c2) => if d2c != d2c2 then true else false
  end // end of [Some]
//
end // end of [d2cst_is_lamless]
*)

(* ****** ****** *)

implement
emit_d2cst_extdec
  (out, d2c) = let
//
macdef
ismac = $D2E.d2cst_is_mac
//
macdef
isfundec = $D2E.d2cst_is_fundec
//
macdef
iscastfn = $D2E.d2cst_is_castfn
//
in
//
case+ 0 of
| _ when
    ismac (d2c) => let
    val () = emit_text (out, "ATSdyncst_mac(")
    val () = emit_d2cst (out, d2c)
    val () = emit_text (out, ")\n")
  in
    // nothing
  end // end of [ismac]
| _ when
    isfundec(d2c) => let
    val issta = $D2E.d2cst_is_static (d2c)
    val () =
    (
      if issta then
        emit_text (out, "ATSdyncst_stafun(")
      else
        emit_text (out, "ATSdyncst_extfun(")
      // end of [if]
    ) : void // end of [val]
//
    val () = emit_d2cst (out, d2c)
    val () =
    {
      val () = emit_text (out, ", (")
      val hses = d2cst_get2_type_arg (d2c)
      val () = emit_hisexplst_sep (out, hses, ", ")
      val () = emit_text (out, "), ")
    } // end of [val]
//
    val () = let
      val hse =
        d2cst_get2_type_res (d2c) in emit_hisexp (out, hse)
      // end of [val]
    end // end of [val]
//
    val () = emit_text (out, ") ;\n")
//
  in
    // nothing
  end // end of [isfundec]
//
| _ when
    iscastfn(d2c) => let
    val () = emit_text (out, "ATSdyncst_castfn(")
    val () = emit_d2cst (out, d2c)
    val () = emit_text (out, ")\n")
  in
    // nothing
  end // end of [castfn]
| _ (*non-fun*) => let
    val-Some(hse) = d2cst_get2_hisexp (d2c)
    val () = emit_text (out, "ATSdyncst_valdec(")
    val () = emit_d2cst (out, d2c)
    val () = emit_text (out, ", ")
    val () = emit_hisexp (out, hse)
    val () = emit_text (out, ") ;\n")
  in
    // nothing
  end // end of [_]
//
end // end of [emit_d2cst_extdec]

implement
emit_d2cstlst_extdec
  (out, d2cs) =
(
  list_app_cloptr<d2cst> (d2cs, lam d2c =<1> emit_d2cst_extdec (out, d2c))
) // end of [emit_d2cstlst_extdec]

(* ****** ****** *)

(* end of [pats_ccomp_emit3.dats] *)
