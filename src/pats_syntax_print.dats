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

staload FX = "pats_fixity.sats"

(* ****** ****** *)

staload "pats_symbol.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

implement
fprint_i0nt
  (out, x) = fprint_string (out, x.i0nt_rep)
// end of [fprint_i0nt]

(* ****** ****** *)

implement
fprint_i0de
  (out, x) = fprint_symbol (out, x.i0de_sym)
// end of [fprint_i0de]

implement
fprint_f0xty (out, x) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
  case+ x of
  | F0XTYinf _ => prstr "F0XTYinf(...)"
  | F0XTYpre _ => prstr "F0XTYpre(...)"
  | F0XTYpos _ => prstr "F0XTYpos(...)"
end // end of [fprint_f0xty]

(* ****** ****** *)

implement
fprint_s0taq (out, x) =
  case+ x.s0taq_node of
  | S0TAQnone () => ()
  | S0TAQsymdot (sym) => {
      val () = fprint_symbol (out, sym)
      val () = fprint_string (out, ".")
    }
  | S0TAQsymcolon (sym) => {
      val () = fprint_symbol (out, sym)
      val () = fprint_string (out, ":")
    }
// end of [fprint_s0taq]

(* ****** ****** *)

implement
fprint_sqi0de (out, x) = {
  val () = fprint_s0taq (out, x.sqi0de_qua)
  val () = fprint_symbol (out, x.sqi0de_sym)
}

(* ****** ****** *)

implement
fprint_e0xpactkind (out, x) =
  case+ x of
  | E0XPACTassert () => fprint_string (out, "E0XPACTassert")
  | E0XPACTerror () => fprint_string (out, "E0XPACTerror")
  | E0XPACTprint () => fprint_string (out, "E0XPACTprint")
// end of [fprint_e0xpactkind]

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
      val () = fprint_string (out, x.i0nt_rep)
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

implement
fprint_s0exp (out, x) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
  case+ x.s0exp_node of
  | S0Eapp (s0e1, s0e2) => {
      val () = prstr "S0Eapp("
      val () = fprint_s0exp (out, s0e1)
      val () = prstr "; "
      val () = fprint_s0exp (out, s0e2)
      val () = prstr ")"
    }
  | S0Eextype (name, s0es) => {
      val () = prstr "S0Eextype("
      val () = fprint_string (out, name)
      val () = prstr "; "
      val () = $UT.fprintlst<s0exp> (out, s0es, ", ", fprint_s0exp)
      val () = prstr ")"
    }
  | S0Echar (c) => {
      val () = prstr "S0Echar("
      val () = fprint_char (out, c)
      val () = prstr ")"
    }
  | S0Ei0nt (int) => {
      val () = prstr "S0Ei0nt("
      val () = fprint_i0nt (out, int)
      val () = prstr ")"
    }
  | S0Elist (s0es) => {
      val () = prstr "S0Elist("
      val () = $UT.fprintlst<s0exp> (out, s0es, ", ", fprint_s0exp)
      val () = prstr ")"
    }
  | S0Elist2 (s0es1, s0es2) => {
      val () = prstr "S0Elist2("
      val () = $UT.fprintlst<s0exp> (out, s0es1, ", ", fprint_s0exp)
      val () = prstr " | "
      val () = $UT.fprintlst<s0exp> (out, s0es2, ", ", fprint_s0exp)
      val () = prstr ")"
    }
  | S0Eopid (id) => {
      val () = prstr "S0Eopid("
      val () = fprint_symbol (out, id)
      val () = prstr ")"
    }
  | S0Esqid (sq, id) => {
      val () = prstr "S0Esqid("
      val () = fprint_s0taq (out, sq)
      val () = fprint_symbol (out, id)
      val () = prstr ")"
    }
  | S0Etytup (knd, s0es) => {
      val () = prstr "S0Etytup("
      val () = fprint_int (out, knd)
      val () = prstr "; "
      val () = $UT.fprintlst<s0exp> (out, s0es, ", ", fprint_s0exp)
      val () = prstr ")"
    }
  | S0Etytup2 (knd, s0es1, s0es2) => {
      val () = prstr "S0Etytup2("
      val () = fprint_int (out, knd)
      val () = prstr "; "
      val () = $UT.fprintlst<s0exp> (out, s0es1, ", ", fprint_s0exp)
      val () = prstr " | "
      val () = $UT.fprintlst<s0exp> (out, s0es2, ", ", fprint_s0exp)
      val () = prstr ")"
    }
(*
  | _ => prstr "S0E(...)"
*)
end // end of [fprint_s0exp]

(* ****** ****** *)

implement
fprint_d0ecl (out, x) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
  case+ x.d0ecl_node of
  | D0Cfixity (fxty, ids) => {
      val () = prstr "D0ECfixity("
      val () = fprint_f0xty (out, fxty)
      val () = prstr "; "
      val () = $UT.fprintlst<i0de> (out, ids, ", ", fprint_i0de)
      val () = prstr ")"
    }
  | D0Cnonfix (ids) => {
      val () = prstr "D0ECnonfix("
      val () = $UT.fprintlst<i0de> (out, ids, ", ", fprint_i0de)
      val () = prstr ")"
    }
  | D0Csymintr (ids) => {
      val () = prstr "D0ECsymintr("
      val () = $UT.fprintlst<i0de> (out, ids, ", ", fprint_i0de)
      val () = prstr ")"
    }
  | D0Ce0xpdef (id, def) => {
      val () = prstr "D0ECe0xpdef("
      val () = fprint_symbol (out, id)
      val () = prstr ", "
      val () = $UT.fprintopt<e0xp> (out, def, fprint_e0xp)
      val () = prstr ")"
    }
  | D0Ce0xpact (knd, act) => {
      val () = prstr "D0ECe0xpact("
      val () = fprint_e0xpactkind (out, knd)
      val () = prstr "; "
      val () = fprint_e0xp (out, act)
      val () = prstr ")"
    }
(*
  | _ => {
      val () = prstr "D0C...("
      val () = fprint_string (out, "...")
      val () = prstr ")"
    }
*)
end // end of [fprint_d0ecl]

implement
fprint_d0eclist
  (out, xs) = () where {
  val () = $UT.fprintlst (out, xs, "\n", fprint_d0ecl)
  val () = fprint_newline (out)
} // end of [fprint_d0eclst]

(* ****** ****** *)

(* end of [pats_syntax_print.dats] *)
