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

%{#
#include "pats_lexbuf.cats"
%} // end of [%{#]

(* ****** ****** *)

staload
LOC = "./pats_location.sats"
typedef position = $LOC.position
typedef location = $LOC.location

(* ****** ****** *)
//
absvt@ype
lexbuf_vt0ype =
$extype "pats_lexbuf_struct"
//
vtypedef lexbuf = lexbuf_vt0ype
//
(* ****** ****** *)

fun
lexbuf_initize_filp
  {m:file_mode}{l0:addr}
(
  pfmod:
  file_mode_lte(m,r)
, pffil: FILE (m) @ l0
| lexbuf: &lexbuf? >> lexbuf, p0: ptr l0
) : void // end of [lexbuf_initize_filp]

(* ****** ****** *)

fun
lexbuf_initize_getc
(
  buf: &lexbuf? >> lexbuf, getc: () -<cloptr1> int
) : void // end of [lexbuf_initize_getc]

(* ****** ****** *)

fun
lexbuf_initize_string
(
  buf: &lexbuf? >> lexbuf, inp: string
) : void // end of [lexbuf_initize_string]

(* ****** ****** *)

fun
lexbuf_initize_charlst_vt
(
  buf: &lexbuf? >> lexbuf, inp: List_vt (char)
) : void // end of [lexbuf_initize_charlst_vt]

(* ****** ****** *)

fun lexbuf_uninitize
(
  buf: &lexbuf >> lexbuf?
) : void // end of [lexbuf_uninitize]

(* ****** ****** *)

fun lexbuf_get_base (buf: &lexbuf): lint

(* ****** ****** *)
//
fun
lexbuf_get_position
(
  buf: &lexbuf, pos: &position? >> position
) : void // end-of-fun
//
fun lexbuf_set_position
  (buf: &lexbuf >> lexbuf, pos: &position): void
//
(* ****** ****** *)

fun lexbuf_get_nspace (buf: &lexbuf): int
fun lexbuf_set_nspace (buf: &lexbuf, n: int): void

(* ****** ****** *)

fun lexbufpos_diff
  (buf: &lexbuf, pos: &position): uint
// end of [lexbufpos_diff]

fun lexbufpos_get_location
  (buf: &lexbuf, pos: &position): location
// end of [lexbufpos_get_location]

(* ****** ****** *)

fun
lexbuf_get_char(buf: &lexbuf, nchr: uint): int
fun
lexbufpos_get_char(buf: &lexbuf, position: &position): int

(* ****** ****** *)

fun lexbuf_incby_count (buf: &lexbuf, cnt: uint): void

(* ****** ****** *)
//
fun
lexbuf_get_strptr0
  (buf: &lexbuf, ln: uint): strptr0
fun
lexbuf_get_strptr1
  (buf: &lexbuf, ln: uint): strptr1
//
fun
lexbufpos_get_strptr0
  (buf: &lexbuf, pos: &position): strptr0
fun
lexbufpos_get_strptr1
  (buf: &lexbuf, pos: &position): strptr1
//
fun
lexbuf_get_substrptr0
  (buf: &lexbuf, st: uint, ln: uint): strptr0
fun
lexbuf_get_substrptr1
  (buf: &lexbuf, st: uint, ln: uint): strptr1
//
(* ****** ****** *)

(* end of [pats_lexbuf.sats] *)
