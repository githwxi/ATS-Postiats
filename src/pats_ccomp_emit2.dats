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
implement prerr_FILENAME<> () = prerr "pats_ccomp_emit"

(* ****** ****** *)

staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

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
    val () = emit_text (out, "if (")
    val () = emit_text (out, "0==ATSPACKint(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_int (out, i)
    val () = emit_text (out, ") { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  }
| PATCKbool (b) => {
    val () = emit_text (out, "if (")
    val () = emit_text (out, "0==ATSPACKbool(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_bool (out, b)
    val () = emit_text (out, ") { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  } // end of [PATCKbool]
| PATCKchar (c) => {
    val () = emit_text (out, "if (")
    val () = emit_text (out, "0==ATSPACKchar(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = emit_char (out, c)
    val () = emit_text (out, ") { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  } // end of [PATCKchar]
| PATCKi0nt (x) => {
    val () = emit_text (out, "if (")
    val () = emit_text (out, "0==ATSPACKint(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = $SYN.fprint_i0nt (out, x)
    val () = emit_text (out, ") { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  } // end of [PATCKi0nt]
| PATCKf0loat (x) => {
    val () = emit_text (out, "if (")
    val () = emit_text (out, "0==ATSPACKfloat(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ", ")
    val () = $SYN.fprint_f0loat (out, x)
    val () = emit_text (out, ") { ")
    val () = emit_patckont (out, fail)
    val () = emit_text (out, " ; }")
  } // end of [PATCKf0loat]
| _ => let
    val () = prerr_interror ()
    val () = prerrln! (": emit_instr_patck: patck = ", patck)
    val () = assertloc (false)
  in
    $ERR.abort ()
  end // end of [_]
//
end // end of [emit_instr_patck]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_emit2.dats] *)
