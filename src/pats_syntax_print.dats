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
// Start Time: March, 2011
//
(* ****** ****** *)

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload "pats_symbol.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

implement
fprint_i0de
  (out, id) = fprint_symbol (out, id.i0de_sym)
// end of [fprint_i0de]

(* ****** ****** *)

implement
fprint_e0xp
  (out, x0) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
  case x0.e0xp_node of
  | E0XPapp (x1, x2) => {
      val () = prstr "E0XPapp("
      val () = fprint_e0xp (out, x1)
      val () = prstr "; "
      val () = fprint_e0xp (out, x2)
      val () = prstr ")"
    }
  | E0XPchar c => {
      val () = prstr "E0XPchar("
      val () = fprint_char (out, c)
      val () = prstr ")"
    }
  | E0XPeval (x) => {
      val () = prstr "E0XPeval("
      val () = fprint_e0xp (out, x)
      val () = prstr ")"
    }
  | E0XPfloat (x) => {
      val () = prstr "E0XPfloat("
      val () = fprint_string (out, x)
      val () = prstr ")"
    }
  | E0XPide (x) => {
      val () = prstr "E0XPide("
      val () = fprint_symbol (out, x)
      val () = prstr ")"
    }
  | E0XPint (x) => {
      val () = prstr "E0XPint("
      val () = fprint_string (out, x)
      val () = prstr ")"
    }
  | E0XPlist (xs) => {
      val () = prstr "E0XPlist("
      val () = $UT.fprintlst<e0xp> (out, xs, ", ", fprint_e0xp)
      val () = prstr ")"
    }
  | E0XPstring (x, n) => {
      val () = prstr "E0XPstring("
      val () = fprint_string (out, x)
      val () = prstr ")"
    }
end // end of [fprint_e0xp]

(* ****** ****** *)

(* end of [pats_syntax_print.dats] *)
