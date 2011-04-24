(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: April, 2011
//
(* ****** ****** *)

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload SYM = "pats_symbol.sats"
macdef fprint_symbol = $SYM.fprint_symbol

(* ****** ****** *)

staload "pats_basics.sats"
staload "pats_syntax.sats"
staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"

(* ****** ****** *)

implement
fprint_p1at
  (out, p1t0) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ p1t0.p1at_node of
| _ => prstr "P1T...(...)"
//
end // end of [fprint_p1at]

(* ****** ****** *)

implement
fprint_d1exp
  (out, d1e0) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ d1e0.d1exp_node of
| D1Edqid (dq, id) => {
    val () = prstr "D1Edqid("
    val () = fprint_d0ynq (out, dq)
    val () = fprint_symbol (out, id)
    val () = prstr ")"
  }
| D1Ebool (x) => {
    val () = prstr "D1Ebool("
    val () = fprint_bool (out, x)
    val () = prstr ")"
  }
| D1Echar (x) => {
    val () = prstr "D1Echar("
    val () = fprint_c0har (out, x)
    val () = prstr ")"
  }
| D1Efloat (x) => {
    val () = prstr "D1Efloat("
    val () = fprint_f0loat (out, x)
    val () = prstr ")"
  }
| D1Estring (x) => {
    val () = prstr "D1Estring("
    val () = fprint_s0tring (out, x)
    val () = prstr ")"
  }
| D1Eempty () => prstr "D1Eempty()"
| D1Etop () => prstr "D1Etop()"
//
| D1Etmpid (qid, arg) => {
    val () = prstr "D1Etmpid("
    val () = fprint_dqi0de (out, qid)
    val () = prstr "; "
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D1Eapp_dyn (
    _fun, _locarg, npf, _arg
  ) => {
    val () = prstr "D1Eapp_dyn("
    val () = fprint_d1exp (out, _fun)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d1explst (out, _arg)
    val () = prstr ")"
  }
| D1Elist (npf, xs) => {
    val () = prstr "D1Elist("
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d1explst (out, xs)
    val () = prstr ")"
  }
| _ => prstr "D1E...(...)"
//
end // end of [fprint_d1exp]

implement
print_d1exp (x) = fprint_d1exp (stdout_ref, x)
implement
prerr_d1exp (x) = fprint_d1exp (stderr_ref, x)

implement
fprint_d1explst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_d1exp)
// end of [fprint_d1explst]

(* ****** ****** *)

extern
fun fprint_v1aldec : fprint_type (v1aldec)
implement
fprint_v1aldec (out, x) = {
  val () = fprint_p1at (out, x.v1aldec_pat)
  val () = fprint_string (out, " = ")
  val () = fprint_d1exp (out, x.v1aldec_def)
}

(* ****** ****** *)

implement
fprint_d1ecl
  (out, d1c0) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ d1c0.d1ecl_node of
| D1Cnone () => prstr "D1Cnone()"
| D1Clist (ds) => {
    val () = prstr "D1Clist(\n"
    val () = fprint_d1eclist (out, ds)
    val () = prstr "\n)"
  } // end of [D1Clist]
//
| D1Csymintr (ids) => {
    val () = prstr "D1Csymintr("
    val () = $UT.fprintlst (out, ids, ", ", fprint_i0de)
    val () = prstr ")"
  }
| D1Csymelim (ids) => {
    val () = prstr "D1Csymelim("
    val () = $UT.fprintlst (out, ids, ", ", fprint_i0de)
    val () = prstr ")"
  }
//
| D1Ce1xpdef (id, def) => {
    val () = prstr "D1Ce1xpdef("
    val () = fprint_symbol (out, id)
    val () = prstr " = "
    val () = fprint_e1xp (out, def)
    val () = prstr ")"
  }
| D1Ce1xpundef (id) => {
    val () = prstr "D1Ce1xpundef("
    val () = fprint_symbol (out, id)
    val () = prstr ")"
  }
//
| D1Cdatsrts (xs) => {
    val () = prstr "D1Cdatsrts(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_d1atsrtdec)
    val () = prstr "\n)"
  }
| D1Csrtdefs (xs) => {
    val () = prstr "D1Csrtdefs(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1rtdef)
    val () = prstr "\n)"
  }
//
| D1Cstacsts (xs) => {
    val () = prstr "D1Cstacsts(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1tacst)
    val () = prstr "\n)"
  }
| D1Cstacons (knd, xs) => {
    val () = prstr "D1Cstacons("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1tacon)
    val () = prstr "\n)"
  }
| D1Cstavars (xs) => {
    val () = prstr "D1Cstavars(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1tavar)
    val () = prstr "\n)"
  }
//
| D1Csexpdefs (knd, xs) => {
    val () = prstr "D1Csexpdefs("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1expdef)
    val () = prstr "\n)"
  }
| D1Csaspdec (x) => {
    val () = prstr "D1Csaspdec("
    val () = fprint_s1aspdec (out, x)
    val () = prstr ")"
  }
//
| D1Cdatdecs (knd, xs1, xs2) => {
    val () = prstr "D1Cdatdecs("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = prstr "..."
    val () = prstr "\n)"
  }
| D1Cexndecs (xs) => {
    val () = prstr "D1Cexndecs(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_e1xndec)
    val () = prstr "\n)"
  }
//
| D1Cclassdec (id, sup) => {
    val () = prstr "D1Cclassdec("
    val () = fprint_i0de (out, id)
    val () = (case+ sup of
      | Some s1e => let
          val () = prstr " : " in fprint_s1exp (out, s1e)
        end
      | None () => ()
    ) : void // end of [val]
    val () = prstr ")"
  }
//
| D1Cdcstdecs (dck, qarg, xs) => {
    val () = prstr "D1Cdcstdecs("
    val () = fprint_dcstkind (out, dck)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_d1cstdec)
    val () = prstr "\n)"
  }
//
| D1Cvaldecs (knd, isrec, ds) => {
    val () = prstr "D1Cvaldecs("
    val () = fprint_valkind (out, knd)
    val () = prstr "; "
    val () = fprint_bool (out, isrec)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, ds, "\n", fprint_v1aldec)
    val () = prstr "\n)"
  }
//
| D1Cinclude (xs) => {
    val () = prstr "D1Cinclude(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_d1ecl)
    val () = prstr "\n)"
  }
//
| D1Clocal (
    ds_head, ds_body
  ) => {
    val () = prstr "D1Clocal(\n"
    val () = fprint_d1eclist (out, ds_head)
    val () = prstr "\n(*in*)\n"
    val () = fprint_d1eclist (out, ds_body)
    val () = prstr "\n)"
  }
//
  | _ => prstr "D1C...(...)"
end // end of [fprint_d1ecl]

implement
fprint_d1eclist (out, xs) = $UT.fprintlst (out, xs, "\n", fprint_d1ecl)

(* ****** ****** *)

(* end of [pats_dynexp1_print.dats] *)
