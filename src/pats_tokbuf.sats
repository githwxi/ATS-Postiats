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
#include "pats_tokbuf.cats"
%} // end of [%{#]

(* ****** ****** *)

staload
LBF = "./pats_lexbuf.sats"
stadef lexbuf = $LBF.lexbuf
staload
LEX = "./pats_lexing.sats"
typedef token = $LEX.token
staload
LOC = "./pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)
//
// HX-2011-03-13:
// [tokbuf] may store visited tokens to support backtracking
//
absviewt@ype
tokbuf_vt0ype =
$extype "pats_tokbuf_struct"
//
viewtypedef tokbuf = tokbuf_vt0ype
//
(* ****** ****** *)

fun
tokbuf_initize_filp
  {m:file_mode} {l:addr} (
  pfmod: file_mode_lte (m, r)
, pffil: FILE m @ l
| r: &tokbuf? >> tokbuf, p: ptr l
) : void // end of [tokbuf_initize_filp]

fun
tokbuf_initize_getc
(
  buf: &tokbuf? >> tokbuf, getc: () -<cloptr1> int
) : void // end of [tokbuf_initize_getc]

fun
tokbuf_initize_string
(
  buf: &tokbuf? >> tokbuf, inp: string
) : void // end of [tokbuf_initize_string]

fun
tokbuf_initize_lexbuf
(
  buf: &tokbuf? >> tokbuf, lbf: &lexbuf >> lexbuf?
) : void // end of [tokbuf_initize_lexbuf]

(* ****** ****** *)
//
fun
tokbuf_uninitize (buf: &tokbuf >> tokbuf?) : void
//
(* ****** ****** *)

fun tokbuf_get_ntok (buf: &tokbuf): uint
fun tokbuf_set_ntok (buf: &tokbuf, n0: uint): void

(* ****** ****** *)

fun tokbuf_incby1 (buf: &tokbuf): void
fun tokbuf_incby_count (buf: &tokbuf, k: uint): void

(* ****** ****** *)

fun tokbuf_reset (buf: &tokbuf): void

(* ****** ****** *)

fun tokbuf_get_token (buf: &tokbuf): token
fun tokbuf_getinc_token (buf: &tokbuf): token

(* ****** ****** *)

fun tokbuf_discard_all (buf: &tokbuf): void

(* ****** ****** *)
//
// HX-2012-06:
// for pushing back a given token
// this one is needed by libatsynmark
//
fun tokbuf_unget_token (buf: &tokbuf, tok: token): void
//
(* ****** ****** *)

(* end of [pats_tokbuf.sats] *)
