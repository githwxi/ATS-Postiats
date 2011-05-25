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
// Start Time: May, 2011
//
(* ****** ****** *)

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload SYM = "pats_symbol.sats"
macdef fprint_symbol = $SYM.fprint_symbol

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_staexp2.sats"

(* ****** ****** *)

implement
fprint_s2rtdat (out, x) = let
  val sym = s2rtdat_get_sym (x) in fprint_symbol (out, sym)
end // end of [fprint_s2rtdat]

(* ****** ****** *)

implement
fprint_s2rtbas (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x of
| S2RTBASpre (sym) => {
    val () = prstr "S2ETBASpre("
    val () = fprint_symbol (out, sym)
    val () = prstr ")"
  }
| S2RTBASimp (sym, knd) => {
    val () = prstr "S2ETBASimp("
    val () = fprint_symbol (out, sym)
    val () = prstr ")"
  }
| S2RTBASdef (s2td) => {
    val () = prstr "S2ETBASdef("
    val () = fprint_s2rtdat (out, s2td)
    val () = prstr ")"
  }
//
end // end of [fprint_s2rtbas]

(* ****** ****** *)

implement
fprint_s2rt (out, x) = let
//
  val x = s2rt_delink (x)
//
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x of
| S2RTbas (s2tb) => {
    val () = prstr "S2RTbas("
    val () = fprint_s2rtbas (out, s2tb)
    val () = prstr ")"
  }
| S2RTfun (s2ts, s2t) => {
    val () = prstr "S2RTfun("
    val () = fprint_s2rtlst (out, s2ts)
    val () = prstr "; "
    val () = fprint_s2rt (out, s2t)
    val () = prstr ")"
  }
| S2RTtup (s2ts) => {
    val () = prstr "S2RTtup("
    val () = fprint_s2rtlst (out, s2ts)
    val () = prstr ")"
  }
| S2RTVar _ => {
    val () = prstr "S2RTVar("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| S2RTerr () => prstr "S2RTerr()"
//
end // end of [fprint_s2rt]

implement print_s2rt (x) = fprint_s2rt (stdout_ref, x)
implement prerr_s2rt (x) = fprint_s2rt (stderr_ref, x)

implement fprint_s2rtlst (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_s2rt)

implement print_s2rtlst (xs) = fprint_s2rtlst (stdout_ref, xs)
implement prerr_s2rtlst (xs) = fprint_s2rtlst (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_s2itm (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x of
| S2ITMcst (s2cs) => {
    val () = prstr "S2ITMcst("
    val () = fprint_s2cstlst (out, s2cs)
    val () = prstr ")"
  }
| S2ITMdatconptr (d2c) => {
    val () = prstr "S2ITMdatconptr("
    val () = fprint_d2con (out, d2c)
    val () = prstr ")"
  }
| S2ITMdatcontyp (d2c) => {
    val () = prstr "S2ITMdatcontyp("
    val () = fprint_d2con (out, d2c)
    val () = prstr ")"
  }
| S2ITMe1xp (e1xp) => {
    val () = prstr "S2ITMe1xp("
    val () = fprint_e1xp (out, e1xp)
    val () = prstr ")"
  }
| S2ITMfil (fenv) => {
    val () = prstr "S2ITMfil("
    val () = $FIL.fprint_filename (out, filenv_get_name fenv)
    val () = prstr ")"
  }
| S2ITMvar (s2v) => {
    val () = prstr "S2ITMvar("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")"
  }
//
end // end of [fprint_s2itm]

implement print_s2itm (xs) = fprint_s2itm (stdout_ref, xs)
implement prerr_s2itm (xs) = fprint_s2itm (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_s2exp (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x of
| _ => prstr "S2E...(...)"
//
end // end of [fprint_s2exp]

implement print_s2exp (xs) = fprint_s2exp (stdout_ref, xs)
implement prerr_s2exp (xs) = fprint_s2exp (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_s2rtext (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x of
| S2TEsrt (s2t) => {
    val () = prstr "S2TEsrt("
    val () = fprint_s2rt (out, s2t)
    val () = prstr ")"
  }
| S2TEsub _ => {
    val () = prstr "S2TEsub("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| S2TEerr () => prstr "S2TEerr()"
//
end // end of [fprint_s2rtext]

(* ****** ****** *)

implement
fprint_sp2at
  (out, sp2t) = (
//
case+ sp2t.sp2at_node of
| SP2Tcon (s2c, s2vs) => {
    val () = fprint_string (out, "SP2Tcon(")
    val () = fprint_s2cst (out, s2c)
    val () = fprint_string (out, "; ")
    val () = fprint_s2varlst (out, s2vs)
    val () = fprint_string (out, ")")
  } // end of [SP2Tcon]
//
) // end of [fprint_sp2at]

(* ****** ****** *)

(* end of [pats_staexp2_print.dats] *)
