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

staload "pats_staexp1.sats"

(* ****** ****** *)

implement
fprint_e1xp (out, e0) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
  case+ e0.e1xp_node of
  | E1XPapp (e, _(*loc*), es) => {
      val () = prstr "E1XPapp("
      val () = fprint_e1xp (out, e)
      val () = prstr "; "
      val () = fprint_e1xplst (out, es)
      val () = prstr ")"
    } // end of [E1XPapp]
  | E1XPchar (c: char) => begin
      prstr "E1XPchar("; fprint_char (out, c); prstr ")"
    end // end of [E1XPchar]
  | E1XPfloat (f: string) => begin
      prstr "E1XPfloat("; fprint_string (out, f); prstr ")"
    end // end of [E1XPfloat]
  | E1XPide (id) => begin
      $SYM.fprint_symbol (out, id)
    end // end of [E1XPide]
  | E1XPint (int(*string*)) => begin
      prstr "E1XPint("; fprint_string (out, int); prstr ")"
    end // end of [E1XPint]
  | E1XPlist es => begin
      prstr "E1XPlist("; fprint_e1xplst (out, es); prstr ")"
    end // end of [E1XPlist]
  | E1XPnone () => begin
      fprint_string (out, "E1XPnone()")
    end // end of [E1XPnone]
  | E1XPstring (str, len) => {
      val () = prstr "E1XPstring("
      val () = fprint_string (out, str)
      val () = prstr ", "
      val () = fprint_int (out, len)
      val () = prstr ")"
    } // end of [E1XPstring]
  | E1XPundef () => begin
      fprint_string (out, "E1XPundef()")
    end // end of [E1XPundef]
end // end of [fprint_e1xp]

(* ****** ****** *)

implement print_e1xp (x) = fprint_e1xp (stdout_ref, x)
implement prerr_e1xp (x) = fprint_e1xp (stderr_ref, x)

(* ****** ****** *)

implement print_e1xplst (x) = fprint_e1xplst (stdout_ref, x)
implement prerr_e1xplst (x) = fprint_e1xplst (stderr_ref, x)

(* ****** ****** *)

(* end of [pats_staexp1_print.dats] *)
