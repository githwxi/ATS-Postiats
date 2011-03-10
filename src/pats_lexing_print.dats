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

staload "pats_lexing.sats"

(* ****** ****** *)

implement
fprint_token
  (out, tok) = case+ tok.token_node of
//
  | IDENTIFIER_alp (x) =>
      fprintf (out, "IDENTIFIER_alp(%s)", @(x))
    // end of [IDENTIFIER_alp]
  | IDENTIFIER_sym (x) =>
      fprintf (out, "IDENTIFIER_sym(%s)", @(x))
    // end of [IDENTIFIER_sym]
//
  | INTEGER_dec (x) =>
      fprintf (out, "INTEGER_dec(%s)", @(x))
    // end of [INTEGER_dec]
  | INTEGER_oct (x) =>
      fprintf (out, "INTEGER_oct(%s)", @(x))
    // end of [INTEGER_hex]
  | INTEGER_hex (x) =>
      fprintf (out, "INTEGER_hex(%s)", @(x))
    // end of [INTEGER_hex]
//
  | FLOAT_deciexp (x) =>
      fprintf (out, "FLOAT_deciexp(%s)", @(x))
    // end of [FLOAT_deciexp]
  | FLOAT_hexiexp (x) =>
      fprintf (out, "FLOAT_hexiexp(%s)", @(x))
    // end of [FLOAT_hexiexp]
//
  | LPAREN () => fprintf (out, "LPAREN()", @())
  | RPAREN () => fprintf (out, "RPAREN()", @())
  | LBRACKET () => fprintf (out, "LBRACKET()", @())
  | RBRACKET () => fprintf (out, "RBRACKET()", @())
  | LBRACE () => fprintf (out, "LBRACE()", @())
  | RBRACE () => fprintf (out, "RBRACE()", @())
//
  | COMMA () => fprintf (out, "COMMA()", @())
  | SEMICOLON () => fprintf (out, "SEMICOLON()", @())
  | BACKSLASH () => fprintf (out, "BACKSLASH()", @())
//
  | ATLPAREN () => fprintf (out, "ATLPAREN()", @())
  | QUOTELPAREN () => fprintf (out, "QUOTELPAREN()", @())
  | ATLBRACKET () => fprintf (out, "ATLBRACKET()", @())
  | QUOTELBRACKET () => fprintf (out, "QUOTELBRACKET()", @())
  | HASHBRACKET () => fprintf (out, "HASHBRACKET()", @())
  | ATLBRACE () => fprintf (out, "ATLBRACE()", @())
  | QUOTELBRACE () => fprintf (out, "QUOTELBRACE()", @())
//
  | BACKQUOTELPAREN () => fprintf (out, "BACKQUOTELPAREN()", @())
  | COMMALPAREN () => fprintf (out, "COMMALPAREN()", @())
  | PERCENTLPAREN () => fprintf (out, "PERCENTLPAREN()", @())
//
  | EXTCODE (knd, x) => fprintf (out, "EXTCODE(%i, %s)", @(knd, x))
//
  | COMMENT_line () => fprintf (out, "COMMENT_line()", @())
  | COMMENT_block () => fprintf (out, "COMMENT_block()", @())
  | COMMENT_rest () => fprintf (out, "COMMENT_rest()", @())
//
  | TOKEN_eof () => fprintf (out, "TOKEN_eof()", @())
  | TOKEN_err () => fprintf (out, "TOKEN_err()", @())
//
(* end of [fprint_token] *)

implement print_token (tok) = fprint_token (stdout_ref, tok)

(* ****** ****** *)

(* end of [pats_lexing.dats] *)
