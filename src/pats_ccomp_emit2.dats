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
// Start Time: January, 2013
//
(* ****** ****** *)

staload ERR = "./pats_error.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_ccomp_emit2"

(* ****** ****** *)

staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload
S2E = "./pats_staexp2.sats"
typedef d2con = $S2E.d2con

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

extern
fun emit_patckont (out: FILEref, fail: patckont): void

implement
emit_patckont
  (out, fail) = let
in
//
case+ fail of
| PTCKNTnone () => {
    val () =
      emit_text (
      out, "ATSdeadcode_failure_handle()"
    ) // end of [val]
  }
| PTCKNTtmplab (tlab) => {
    val () =
      emit_text (out, "ATSgoto(")
    // end of [val]
    val () = emit_tmplab (out, tlab)
    val () = emit_text (out, ")")
  }
| PTCKNTtmplabint (tlab, i) => {
    val () =
      emit_text (out, "ATSgoto(")
    // end of [val]
    val () = emit_tmplabint (out, tlab, i)
    val () = emit_text (out, ")")
  }
| PTCKNTcaseof_fail (loc) => {
    val () =
      emit_text (
      out, "ATScaseof_failure_handle(\""
    ) // end of [val]
    val () = $LOC.fprint_location (out, loc)
    val () = emit_text (out, "\")")
  }
| PTCKNTfunarg_fail (loc, fl) => {
    val () =
      emit_text (
      out, "ATSfunarg_failure_handle(\""
    ) // end of [val]
    val () = $LOC.fprint_location (out, loc)
    val () = emit_text (out, "\")")
  }
| PTCKNTraise (pmv_exn) => {
    val () =
      emit_text (out, "ATSraise_exn(")
    val () = emit_primval (out, pmv_exn)
    val () = emit_text (out, ")")
  }
//
end // (* end of [emit_patckont] *)

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

fun auxcon (
  out: FILEref
, pmv: primval, d2c: d2con, fail: patckont
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
    val () = emit_text (out, "if (")
    val () = (
      if (isnil)
        then emit_text (out, "ATSisnil(")
        else emit_text (out, "ATSiscons(")
      // end of [if]
    ) : void // end of [val]
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  in
    // nothing
  end // end of [islistlike]
| _ => let
    val () = emit_text (out, "ATSifnot(")
    val () = emit_text (out, "ATSPATCKcon(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_int (out, $S2E.d2con_get_tag (d2c))
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  in
    // nothing
  end // end of [PATCKcon]
//
end // end of [auxcon]

fun auxexn (
  out: FILEref
, pmv: primval, d2c: d2con, fail: patckont
) : void = let
//
val narg = $S2E.d2con_get_arity_real (d2c)
//
val () = emit_text (out, "ATSifnot(")
val () = (
  if narg = 0
    then emit_text (out, "ATSPATCKexn0(")
    else emit_text (out, "ATSPATCKexn1(")
  // end of [if]
) : void // end of [val]
val () = emit_primval (out, pmv)
val () = emit_text (out, ", ")
val () = emit_d2con (out, d2c);
val () = emit_text (out, ")) { ")
val () = emit_patckont (out, fail)
val () = emit_text (out, " ; }")
//
in
  // nothing
end // end of [auxexn]

in (* in of [local] *)

implement
emit_instr_patck
  (out, ins) = let
//
val-INSpatck (pmv, patck, fail) = ins.instr_node
//
in
//
case+ patck of
| PATCKint (i) => {
    val () = emit_text (out, "ATSifnot(")
    val () = emit_text (out, "ATSPACKint(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVint (out, i)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  } // end of [PATCKint]
| PATCKbool (b) => {
    val () = emit_text (out, "ATSifnot(")
    val () = emit_text (out, "ATSPACKbool(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVbool (out, b)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  } // end of [PATCKbool]
| PATCKchar (c) => {
    val () = emit_text (out, "ATSifnot(")
    val () = emit_text (out, "ATSPACKchar(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVchar (out, c)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  } // end of [PATCKchar]
| PATCKstring (str) => {
    val () = emit_text (out, "ATSifnot(")
    val () = emit_text (out, "ATSPACKstring(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVstring (out, str)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  } // end of [PATCKstring]
| PATCKi0nt (tok) => {
    val () = emit_text (out, "ATSifnot(")
    val () = emit_text (out, "ATSPACKint(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVi0nt (out, tok)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  } // end of [PATCKi0nt]
| PATCKf0loat (tok) => {
    val () = emit_text (out, "ATSifnot(")
    val () = emit_text (out, "ATSPACKfloat(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_ATSPMVf0loat (out, tok)
    val () = emit_text (out, ")) { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  } // end of [PATCKf0loat]
//
| PATCKcon (d2c) => auxcon (out, pmv, d2c, fail)
| PATCKexn (d2c) => auxexn (out, pmv, d2c, fail)
//
(*
| _ => let
    val () = prerr_interror ()
    val () = prerrln! (": emit_instr_patck: patck = ", patck)
    val () = assertloc (false)
  in
    $ERR.abort ()
  end // end of [_]
*)
//
end // end of [emit_instr_patck]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_emit2.dats] *)
