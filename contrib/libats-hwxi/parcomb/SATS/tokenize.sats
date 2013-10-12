(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2002-2008 Hongwei Xi, Boston University
**
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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

(*
** Tokenization:
** using PCs to turn a character stream into a token stream
*)
//
// Author: Hongwei Xi
// Authoremail: hwxiATcsDOTbuDOTedu
// Start Time: December, 2008
//
(* ****** ****** *)

staload "./posloc.sats"

(* ****** ****** *)

datatype
token_node =
  | TOKchr of char
  | TOKide of string
  | TOKint of int
  | TOKsingleton of char
  | TOKstr of string
// end of [token_node]

where token = '{
  token_loc= location, token_node= token_node
} // end of [token]

and tokenlst = List token
and tokenopt = Option token

(* ****** ****** *)

fun print_token (tok: token): void
overload print with print_token
fun prerr_token (tok: token): void
overload prerr with prerr_token
fun fprint_token (out: FILEref, tok: token): void
overload fprint with fprint_token

(* ****** ****** *)

fun tokenstream_make_charstream
  (cps: stream char):<!laz> stream token
// end of [tokenstream_make_charstream]

(* ****** ****** *)

(* end of [tokenize.sats] *)
