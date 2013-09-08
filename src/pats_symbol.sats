(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: March, 2011
//
(* ****** ****** *)

abstype symbol_type // boxed
typedef symbol = symbol_type
typedef symbolist = List (symbol)
typedef symbolopt = Option (symbol)

(* ****** ****** *)

val symbol_empty : symbol

(* ****** ****** *)
//
val symbol_ADD : symbol // +
val symbol_SUB : symbol // -
val symbol_MUL : symbol // *
val symbol_DIV : symbol // /
//
val symbol_AMPERSAND : symbol // & // read-only
val symbol_AMPERBANG : symbol // &! // read-write
val symbol_AMPERQMARK : symbol // &? // write-only
//
val symbol_AT : symbol // @
val symbol_BACKSLASH : symbol // \
val symbol_BANG : symbol // !
val symbol_COLONEQ : symbol // := // assign
val symbol_COLONEQCOLON : symbol // :=: // exhange
val symbol_FUN: symbol // fun
//
val symbol_GT : symbol // >
val symbol_GTEQ : symbol // >=
val symbol_LT : symbol // <
val symbol_LTEQ : symbol // <=
//
val symbol_EQ : symbol // =
val symbol_EQEQ : symbol // ==
val symbol_LTGT : symbol // <>
val symbol_BANGEQ : symbol // !=
//
val symbol_GTLT : symbol // ><
//
val symbol_GTGT : symbol // >>
val symbol_LTLT : symbol // <<
//
val symbol_LAND : symbol // &&
val symbol_LOR : symbol // ||
val symbol_LRBRACKETS : symbol // []
val symbol_MINUSGT : symbol // ->
val symbol_MINUSLTGT : symbol // -<>
val symbol_QMARK : symbol // ?
val symbol_QMARKBANG : symbol // ?!
val symbol_TILDE : symbol // ~
val symbol_UNDERSCORE : symbol // _
//
val symbol_VBOX : symbol // for vbox pattern
//
val symbol_LAMAT : symbol // lam@
val symbol_LLAMAT : symbol // llam@
val symbol_REFAT : symbol // ref@
//
(* ****** ****** *)
//
// HX: for pre-defined predicative sorts
//
val symbol_INT : symbol
val symbol_BOOL : symbol
val symbol_ADDR : symbol
val symbol_CHAR : symbol
//
val symbol_CLS : symbol // for nominal classes
//
val symbol_EFF : symbol // for sets of effects
//
val symbol_TKIND : symbol // HX-2012-05-23: for template args
//
// HX: for pre-defined impredicative sorts
//
val symbol_PROP : symbol
val symbol_TYPE : symbol
val symbol_T0YPE : symbol
val symbol_VIEW : symbol
val symbol_VTYPE : symbol
val symbol_VT0YPE : symbol
val symbol_VIEWTYPE : symbol
val symbol_VIEWT0YPE : symbol
//
val symbol_TYPES : symbol
//
(* ****** ****** *)

val symbol_TRUE_BOOL : symbol
and symbol_FALSE_BOOL : symbol

(* ****** ****** *)

val symbol_DEFINED : symbol // defined
val symbol_UNDEFINED : symbol // undefined

(* ****** ****** *)

val symbol_TUPZ : symbol // TUPSIZE // for syndef

(* ****** ****** *)

val symbol_CAR : symbol // car
val symbol_CDR : symbol // mfcdr
val symbol_ISLIST : symbol // islist
val symbol_ISCONS : symbol // iscons
val symbol_ISNIL : symbol  // islist

(* ****** ****** *)

val symbol_PATSHOME : symbol
val symbol_PATSHOMERELOC : symbol

(* ****** ****** *)
//
val symbol_ATS_PACKNAME : symbol
//
val symbol_ATS_STALOADFLAG : symbol
val symbol_ATS_DYNLOADFLAG : symbol
//
val symbol_ATS_EXTERN_PREFIX : symbol
//
val symbol_ATS_MAINATSFLAG : symbol
//
(* ****** ****** *)

fun eq_symbol_symbol (x1: symbol, x2: symbol):<> bool
overload = with eq_symbol_symbol
fun neq_symbol_symbol (x1: symbol, x2: symbol):<> bool
overload != with eq_symbol_symbol

fun compare_symbol_symbol (x1: symbol, x2: symbol):<> Sgn
overload compare with compare_symbol_symbol

(* ****** ****** *)

fun print_symbol (x: symbol): void
overload print with print_symbol
fun prerr_symbol (x: symbol): void
overload prerr with prerr_symbol
fun fprint_symbol (out: FILEref, x: symbol): void

(* ****** ****** *)

typedef stamp = uint

fun symbol_get_name (x: symbol):<> string
fun symbol_get_stamp (x: symbol):<> stamp
fun symbol_make_string (name: string): symbol

(* ****** ****** *)

(* end of [pats_symbol.sats] *)
