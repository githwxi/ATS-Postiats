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

staload LOC = "pats_location.sats"
stadef location = $LOC.location
stadef position = $LOC.position

(* ****** ****** *)

staload LBF = "pats_lexbuf.sats"
stadef lexbuf = $LBF.lexbuf

(* ****** ****** *)

datatype
token_node =
//
  | IDENTIFIER_alp of string
  | IDENTIFIER_sym of string
//
  | INTEGER_dec of string
  | INTEGER_oct of string
  | INTEGER_hex of string
//
  | FLOAT_deciexp of string
  | FLOAT_hexiexp of string
//
  | LPAREN of ()
  | RPAREN of ()
  | LBRACKET of ()
  | RBRACKET of ()
  | LBRACE of ()
  | RBRACE of ()
//
  | COMMA of ()
  | SEMICOLON of ()
  | BACKSLASH of ()
//
  | ATLPAREN of ()       // "@("
  | QUOTELPAREN of ()    // "'("
  | ATLBRACKET of ()     // "@["
  | QUOTELBRACKET of ()  // "'["
  | HASHBRACKET of ()    // "#["
  | ATLBRACE of ()       // "@{"
  | QUOTELBRACE of ()    // "'{"
//
  | BACKQUOTELPAREN of () // "`(" // macro syntax
  | COMMALPAREN of ()     // ",(" // macro syntax
  | PERCENTLPAREN of ()   // "%(" // macro syntax
//
  | EXTCODE of (int(*kind*), string)
//
  | COMMENT_line of ()
  | COMMENT_block of ()
  | COMMENT_rest of ()
//
  | TOKEN_eof of ()
  | TOKEN_err of ()
// end of [token_node]

typedef token = '{
  token_loc= location, token_node= token_node
} // end of [token]

(* ****** ****** *)

fun fprint_token
  (out: FILEref, tok: token): void
overload fprint with fprint_token

fun print_token (tok: token): void
overload print with print_token

(* ****** ****** *)

fun token_make
  (loc: location, node: token_node): token
// end of [token_make]

(* ****** ****** *)

fun lexing_IDENTIFIER_sym
  (buf: &lexbuf, pos: &position): uint

(* ****** ****** *)

fun lexing_UNSPECIFIED
  (buf: &lexbuf, pos: &position): uint

(* ****** ****** *)

fun lexing_next_token (buf: &lexbuf): token

(* ****** ****** *)

(* end of [pats_lexing.sats] *)
