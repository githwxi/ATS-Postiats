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

staload "pats_syntax.sats"
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
  | E1XPstring (str) => {
      val () = prstr "E1XPstring("
      val () = fprint_string (out, str)
      val () = prstr ")"
    } // end of [E1XPstring]
  | E1XPundef () => begin
      fprint_string (out, "E1XPundef()")
    end // end of [E1XPundef]
end // end of [fprint_e1xp]

implement print_e1xp (x) = fprint_e1xp (stdout_ref, x)
implement prerr_e1xp (x) = fprint_e1xp (stderr_ref, x)

(* ****** ****** *)

implement
fprint_e1xplst (out, xs) =
  $UT.fprintlst<e1xp> (out, xs, ", ", fprint_e1xp)
// end of [fprint_e1xplst]

implement print_e1xplst (xs) = fprint_e1xplst (stdout_ref, xs)
implement prerr_e1xplst (xs) = fprint_e1xplst (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_s1rt (out, s1t0) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
  case+ s1t0.s1rt_node of
  | S1RTapp (s1t, s1ts) => {
      val () = prstr "S1RTapp("
      val () = fprint_s1rt (out, s1t)
      val () = prstr "; "
      val () = fprint_s1rtlst (out, s1ts)
      val () = prstr ")"
    } // end of [S1RTapp]
  | S1RTlist s1ts => begin
      prstr "S1RTlist("; fprint_s1rtlst (out, s1ts); prstr ")"
    end // end of [S1RTlist]
  | S1RTqid (q, id) => {
      val () = prstr "S1RTqid("
      val () = fprint_s0rtq (out, q)
      val () = $SYM.fprint_symbol (out, id)
      val () = prstr ")"
    } // end of [S1RTqid]
  | S1RTtup s1ts => begin
      prstr "S1RTtup(";
      fprint_s1rtlst (out, s1ts);
      prstr ")"
    end // end of [S1RTtup]
end // end of [fprint_s1rt]

implement print_s1rt (x) = fprint_s1rt (stdout_ref, x)
implement prerr_s1rt (x) = fprint_s1rt (stderr_ref, x)

(* ****** ****** *)

implement
fprint_s1rtlst (out, xs) =
  $UT.fprintlst<s1rt> (out, xs, ", ", fprint_s1rt)
// end of [fprint_s1rtlst]

implement print_s1rtlst (xs) = fprint_s1rtlst (stdout_ref, xs)
implement prerr_s1rtlst (xs) = fprint_s1rtlst (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_s1rtopt (out, x) = $UT.fprintopt<s1rt> (out, x, fprint_s1rt)

(* ****** ****** *)

(* end of [pats_staexp1_print.dats] *)
