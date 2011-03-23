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

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload LOC = "pats_location.sats"
overload + with $LOC.location_combine

(* ****** ****** *)

staload "pats_lexing.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

#define sz2i int_of_size

(* ****** ****** *)

implement
synent_null {a} () = $UN.cast{a} (null)
implement
synent_is_null (x) = ptr_is_null ($UN.cast{ptr} (x))
implement
synent_isnot_null (x) = ptr_isnot_null ($UN.cast{ptr} (x))

(* ****** ****** *)

implement
dcstkind_is_fun (x) =
  case+ x of DCKfun () => true | _ => false
// end of [dcstkind_is_fun]

implement
dcstkind_is_val (x) =
  case+ x of DCKval () => true | _ => false
// end of [dcstkind_is_val]

implement
dcstkind_is_prfun (x) =
  case+ x of DCKprfun () => true | _ => false
// end of [dcstkind_is_prfun]

implement
dcstkind_is_prval (x) =
  case+ x of DCKprval () => true | _ => false
// end of [dcstkind_is_prval]

implement
dcstkind_is_castfn (x) =
  case+ x of DCKcastfn () => true | _ => false
// end of [dcstkind_is_castfn]

implement
fprint_dcstkind
  (out, dck) = case+ dck of
  | DCKfun () => fprint_string (out, "DCKfun")
  | DCKval () => fprint_string (out, "DCKval")
  | DCKpraxi () => fprint_string (out, "DCKpraxi")
  | DCKprfun () => fprint_string (out, "DCKprfun")
  | DCKprval () => fprint_string (out, "DCKprval")
  | DCKcastfn () => fprint_string (out, "DCKcastfn")
// end of [fprint_dcstkind]

implement
print_dcstkind (x) = fprint_dcstkind (stdout_ref, x)

(* ****** ****** *)

implement
e0xp_app (e1, e2) = let
  val loc = e1.e0xp_loc + e2.e0xp_loc
in '{
  e0xp_loc= loc, e0xp_node= E0XPapp (e1, e2)
} end // end of [e0xp_app]

implement
e0xp_char (tok) = let
  val- T_CHAR (c) = tok.token_node
in '{
  e0xp_loc= tok.token_loc, e0xp_node= E0XPchar (c)
} end // end of [e0xp_char]

implement
e0xp_eval (
  t_beg, e, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  e0xp_loc= loc, e0xp_node= E0XPeval e
} end // end of [e0xp_eval]

implement
e0xp_float (tok) = let
  val- T_FLOAT_deciexp (f) = tok.token_node
in '{
  e0xp_loc= tok.token_loc, e0xp_node= E0XPfloat (f)
} end // end of [e0xp_float]

implement
e0xp_i0de (id) = '{
  e0xp_loc= id.i0de_loc, e0xp_node= E0XPide id.i0de_sym
} // end of [e0xp_ide]

implement
e0xp_int (tok) = let
  val- T_INTEGER_dec (i) = tok.token_node
in '{
  e0xp_loc= tok.token_loc, e0xp_node= E0XPint (i)
} end // end of [e0xp_int]

implement
e0xp_list (
  t_beg, es, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  e0xp_loc= loc, e0xp_node= E0XPlist es
} end // end of [e0xp_list]

implement
e0xp_string (tok) = let
  val- T_STRING (s) = tok.token_node
  val n = string_length (s)
in '{
  e0xp_loc= tok.token_loc, e0xp_node= E0XPstring (s, (sz2i)n)
} end // end of [e0xp_float]

(* ****** ****** *)

(* end of [pats_syntax.dats] *)
