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

staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/option_vt.dats"

(* ****** ****** *)

staload "pats_symbol.sats"
staload "pats_lexing.sats"
staload "pats_tokbuf.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

staload "pats_parsing.sats"

(* ****** ****** *)

(*
di0de
  | IDENTIFIER_alp
  | IDENTIFIER_sym
  | BACKSLASH
  | BANG
  | EQ
  | GT
  | GTLT
  | LT
  | TILDE
*)

implement
p_di0de
  (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_IDENT_alp (x) => let
    val () = incby1 () in i0de_make_string (loc, x)
  end
| T_IDENT_sym (x) => let
    val () = incby1 () in i0de_make_string (loc, x)
  end
//
| T_GT () => let
    val () = incby1 () in i0de_make_sym (loc, symbol_GT)
  end
| T_LT () => let
    val () = incby1 () in i0de_make_sym (loc, symbol_LT)
  end
//
| T_BACKSLASH () => let
    val () = incby1 () in i0de_make_sym (loc, symbol_BACKSLASH)
  end
| T_BANG () => let
    val () = incby1 () in i0de_make_sym (loc, symbol_BANG)
  end
| T_TILDE () => let
    val () = incby1 () in i0de_make_sym (loc, symbol_TILDE)
  end
//
| T_GTLT () => let
    val () = incby1 () in i0de_make_sym (loc, symbol_GTLT)
  end
//
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_di0de)
  in
    synent_null ()
  end // end of [_]
//
end // end of [p_di0de]

(* ****** ****** *)

(* end of [pats_parsing_dynexp.dats] *)
