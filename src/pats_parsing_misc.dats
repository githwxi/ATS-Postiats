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

staload "pats_symbol.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

staload "pats_lexing.sats" // for tokens
staload "pats_tokbuf.sats" // for tokenizing

(* ****** ****** *)

staload "pats_parsing.sats"

(* ****** ****** *)

implement
p_COMMA (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
in
//
case+ tok.token_node of
| T_COMMA () => let
    val () = tokbuf_incby1 (buf) in tok
  end
| _ => let
    val loc = tok.token_loc
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_COMMA)
  in
    $UN.cast{token} (null)
  end // end of [_]
//
end // end of [p_COMMA]

implement
p_RPAREN (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
in
//
case+ tok.token_node of
| T_RPAREN () => let
    val () = tokbuf_incby1 (buf) in tok
  end
| _ => let
    val loc = tok.token_loc
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_RPAREN)
  in
    $UN.cast{token} (null)
  end // end of [_]
//
end // end of [p_RPAREN]

(* ****** ****** *)

fun
i0de_make_string (
  loc: location, name: string
) : i0de = let
  val sym = symbol_make_string (name)
in '{
  i0de_loc= loc, i0de_sym= sym
} end // end of [i0de_make_string]

(* ****** ****** *)

(*
i0de
  : IDENTIFIER_alp
  | IDENTIFIER_sym
  | EQ
  | GT
  | LT
  | AMPERSAND
  | BACKSLASH
  | BANG
  | TILDE
  | MINUSGT
  | MINUSLTGT
  | GTLT
; /* i0de */
*)

implement
p_i0de (buf, bt, err) = let
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
| T_EQ () => let
    val () = incby1 () in i0de_make_string (loc, "=")
  end
| T_GT () => let
    val () = incby1 () in i0de_make_string (loc, ">")
  end
| T_LT () => let
    val () = incby1 () in i0de_make_string (loc, "<")
  end
//
| T_AMPERSAND () => let
    val () = incby1 () in i0de_make_string (loc, "&")
  end
| T_BACKSLASH () => let
    val () = incby1 () in i0de_make_string (loc, "\\")
  end
| T_BANG () => let
    val () = incby1 () in i0de_make_string (loc, "!")
  end
| T_TILDE () => let
    val () = incby1 () in i0de_make_string (loc, "~")
  end
//
| T_MINUSGT () => let
    val () = incby1 () in i0de_make_string (loc, "->")
  end
| T_MINUSLTGT () => let
    val () = incby1 () in i0de_make_string (loc, "-<>")
  end
//
| T_GTLT () => let
    val () = incby1 () in i0de_make_string (loc, "><")
  end
//
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_i0de)
  in
    synent_null ()
  end // end of [_]
//
end // end of [p_i0de]

(* ****** ****** *)

(* end of [pats_parsing_misc.dats] *)
