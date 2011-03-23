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

staload LEX = "pats_lexing.sats"
typedef tnode = $LEX.tnode

(* ****** ****** *)

staload "pats_tokbuf.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

typedef
parser (a: type) =
  (&tokbuf, int(*bt*), &int(*err*)) -> a
// end of [parser]

(* ****** ****** *)

fun sep_COMMA (buf: &tokbuf): bool
fun sep_SEMICOLON (buf: &tokbuf): bool

(* ****** ****** *)

fun ptest_fun
  {a:type} (
  buf: &tokbuf, f: parser (a), ent: &synent? >> synent
) : bool // end of [ptest_fun]

(* ****** ****** *)

fun pstar_fun
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : List_vt (a) // end of [pstar_fun]

(* ****** ****** *)

fun pstar_sep_fun
  {a:type} (
  buf: &tokbuf, bt: int, sep: (&tokbuf) -> bool, f: parser (a)
) : List_vt (a) // end of [pstar_sep_fun]

(* ****** ****** *)

fun pstar_fun0_COMMA
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : List_vt (a) // end of [pstar_fun0_COMMA]

(* ****** ****** *)

fun p_COMMA : parser (token)
fun p_RPAREN : parser (token)

(* ****** ****** *)

fun p_i0de : parser (i0de)
fun p_e0xp : parser (e0xp)
fun p_s0exp : parser (s0exp)

(* ****** ****** *)

datatype
parerr_node =
  | PE_COMMA
  | PE_RPAREN
  | PE_i0de 
  | PE_atme0xp
  | PE_e0xp
// end of [parerr_node]

typedef parerr = '{
  parerr_loc= location, parerr_node= parerr_node
} // end of [parerr]

fun parerr_make (
  loc: location, node: parerr_node
) : parerr // end of [parerr_make]

fun the_parerrlst_add (x: parerr): void
fun the_parerrlst_add_ifnbt (
  bt: int, loc: location, node: parerr_node
) : void // end of [the_parerrlst_add_ifnbt]

fun fprint_parerr (out: FILEref, x: parerr): void

fun fprint_the_parerrlst (out: FILEref): void

(* ****** ****** *)

(* end of [pats_parsing.sats] *)
