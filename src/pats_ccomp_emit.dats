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
// Start Time: November, 2012
//
(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_dynexp_up"

(* ****** ****** *)

staload LAB = "pats_label.sats"
staload STMP = "pats_stamp.sats"

(* ****** ****** *)

staload GLOB = "pats_global.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

implement
emit_label (out, lab) = $LAB.fprint_label (out, lab)

(* ****** ****** *)

implement
emit_tmpvar
  (out, tmp) = let
//
val knd = tmpvar_get_tpknd (tmp)
//
val () = (case+ 0 of
  | _ when knd = 0 => let
    in
      fprint_string (out, "tmp") // local temporary variable
    end // end of [_]
  | _ (*(static)top*) => let
    in
      fprint_string (out, "statmp") // static toplevel temporary
    end // end of [knd = 1]
) : void // end of [val]
//
val stmp = tmpvar_get_stamp (tmp)
//
in
  $STMP.fprint_stamp (out, stmp)
end // end of [emit_tmpvar]

(* ****** ****** *)

implement
emit_instr
  (out, ins) = let
//
val loc0 = ins.instr_loc
//
// generating #line progma for debugging
//
val gline =
  $GLOB.the_DEBUGATS_dbgline_get ()
val () = (
  if gline > 0 then $LOC.fprint_line_pragma (out, loc0)
) : void // end of [val]
//
val gflag =
  $GLOB.the_DEBUGATS_dbgflag_get ()
val () = (
//
// HX: generating debug information
//
  if gflag > 0 then let
    val () = fprint_string (out, "/* ")
    val () = fprint_instr (out, ins)
    val () = fprint_string (out, " */\n")
  in
    // empty
  end // end of [if]
) : void // end of [val]
//
in
//
case+ ins.instr_node of
| _ => let
    val () = prerr_interror_loc (loc0)
    val () = (
      prerr ": emit_instr: ins = "; prerr_instr (ins); prerr_newline ()
    ) // end of [val]
    val () = assertloc (false)
  in
    // nothing
  end // end of [_]
end // end of [emit_instr]

(* ****** ****** *)

implement
emit_instrlst
  (out, inss) = let
//
fun loop (
  out: FILEref, inss: instrlst, sep: string, i: int
) : void = let
in
//
case+ inss of
| list_cons (ins, inss) => let
    val () =
      if i > 0 then fprint_string (out, sep)
    val () = emit_instr (out, ins)
  in
    loop (out, inss, sep, i+1)
  end // end of [list_cons]
| list_nil () => let
    val () =
      if i = 0 then fprint_string (out, "/* empty */")
    // end of [val]
  in
    // nothing
  end // end of [list_nil]
//
end // end of [loop]
//
in
  loop (out, inss, "\n", 0)
end // end of [emit_instrlst]    

(* ****** ****** *)

(* end of [pats_ccomp_emit.dats] *)
