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

fun is_BAR (x: tnode): bool
fun is_COMMA (x: tnode): bool
fun is_SEMICOLON (x: tnode): bool
fun is_RPAREN (x: tnode): bool
fun is_EOF (x: tnode): bool

(* ****** ****** *)

datatype
parerr_node =
//
  | PE_BAR
  | PE_COMMA
  | PE_SEMICOLON
  | PE_RPAREN
  | PE_EOF
//
  | PE_i0de
  | PE_i0de_dlr
  | PE_i0nt
  | PE_i0nt_but_i0ntsp
  | PE_i0ntsp
  | PE_p0rec
  | PE_atme0xp
  | PE_e0xp
  | PE_d0ecl
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

typedef
parser (a: type) =
  (&tokbuf, int(*bt*), &int(*err*)) -> a
// end of [parser]

(* ****** ****** *)

fun ptoken_fun (
  buf: &tokbuf, bt: int, err: &int
, f: (tnode) -> bool, enode: parerr_node
) : token // end of [ptoken_fun]

fun ptoken_test_fun (
  buf: &tokbuf, f: (tnode) -> bool
) : bool // end of [ptoken_test_fun]

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

fun pstar_fun0_sep
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a), sep: (&tokbuf) -> bool
) : List_vt (a) // end of [pstar_fun0_COMMA]

fun pstar_fun0_BAR
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : List_vt (a) // end of [pstar_fun0_BAR]

fun pstar_fun0_COMMA
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : List_vt (a) // end of [pstar_fun0_COMMA]

fun pstar_fun0_SEMICOLON
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : List_vt (a) // end of [pstar_fun0_SEMICOLON]

(* ****** ****** *)

fun pplus_fun
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : List_vt (a) // end of [pplus_fun]

(* ****** ****** *)

fun popt_fun
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : Option_vt (a) // end of [popt_fun]

(* ****** ****** *)

fun ptest_fun
  {a:type} (
  buf: &tokbuf, f: parser (a), ent: &synent? >> synent
) : bool // end of [ptest_fun]

(* ****** ****** *)

fun p_BAR : parser (token)
fun p_BAR_test (buf: &tokbuf): bool

fun p_COMMA : parser (token)
fun p_COMMA_test (buf: &tokbuf): bool

fun p_SEMICOLON : parser (token)
fun p_SEMICOLON_test (buf: &tokbuf): bool

fun p_RPAREN : parser (token)
fun p_RPAREN_test (buf: &tokbuf): bool

fun p_EOF : parser (token)

(* ****** ****** *)

fun p_p0rec : parser (p0rec)

(* ****** ****** *)

fun p_i0de : parser (i0de)
fun p_i0de_dlr : parser (i0de)

fun p_i0deseq1 : parser (i0delst)

fun p_i0nt : parser (i0nt)

fun p_e0xp : parser (e0xp)
fun p_s0exp : parser (s0exp)

(* ****** ****** *)

fun p_d0ecl : parser (d0ecl)
fun p_d0eclist : parser (d0eclist)

(* ****** ****** *)

(* end of [pats_parsing.sats] *)
