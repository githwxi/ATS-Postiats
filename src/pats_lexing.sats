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

staload LB = "pats_lexbuf.sats"
stadef lexbuf = $LB.lexbuf

(* ****** ****** *)

datatype token =
  | ANDWORD of string
  | IDENTIFIER_alp of string
  | TOKEN_eof of ()
// end of [token]

(* ****** ****** *)

fun lexing_ANYWORD1 (buf: &lexbuf): uint

(* ****** ****** *)

fun lexing_WHITESPACE0 (buf: &lexbuf): uint

(* ****** ****** *)

fun lexing_IDENTIFIER1_alp (buf: &lexbuf): uint

(* ****** ****** *)

fun lexing_get_next_token (buf: &lexbuf): token

(* ****** ****** *)

(* end of [pats_lexing.sats] *)
