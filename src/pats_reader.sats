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
#include "pats_reader.cats"
%} // end of [%{#]

(* ****** ****** *)
//
// HX-2012-06:
// this style is some sort of experiment; in retrospect, it seems more
// approriate to represent a reader as an object (instead of a struct)
//
(* ****** ****** *)

absviewt@ype
reader_vt0ype =
$extype "pats_reader_struct"
viewtypedef reader = reader_vt0ype

(* ****** ****** *)
//
sortdef
fmode = file_mode
//
fun
reader_initize_filp
  {m:fmode}{l0:addr}
(
  pfmod:
  file_mode_lte(m,r)
, pffil: FILE(m) @ l0
| reader: &reader? >> reader, p0: ptr l0
) : void // end of [reader_initize_filp]
//
(* ****** ****** *)

fun
reader_initize_getc
(
  r: &reader? >> reader, getc: () -<cloptr1> int
) : void // end of [reader_initize_getc]

(* ****** ****** *)

fun
reader_initize_string
(
  r: &reader? >> reader, inp: string
) : void // end of [reader_initize_string]

(* ****** ****** *)

fun
reader_initize_charlst_vt
(
  r: &reader? >> reader, inp: List_vt (char)
) : void // end of [reader_initize_charlst_vt]

(* ****** ****** *)

fun
reader_uninitize
(
  r: &reader >> reader?
) : void // end of [reader_uninitize]

(* ****** ****** *)

fun reader_get_char (r: &reader): int // HX: EOF(-1) is returned at the end

(* ****** ****** *)

(* end of [pats_reader.sats] *)
