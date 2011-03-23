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

%{#
#include "pats_tokbuf.cats"
%} // end of [%{#]

(* ****** ****** *)

staload LEX = "pats_lexing.sats"
typedef token = $LEX.token

staload LOC = "pats_location.sats"
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

fun tokbuf_initialize_filp
  {m:file_mode} {l:addr} (
  pfmod: file_mode_lte (m, r)
, pffil: FILE m @ l
| r: &tokbuf? >> tokbuf, p: ptr l
) : void // end of [tokbuf_initialize_filp]

fun tokbuf_initialize_getc (
  buf: &tokbuf? >> tokbuf, getc: () -<cloptr1> int
) : void // end of [tokbuf_initialize_getc]

(* ****** ****** *)

fun tokbuf_uninitialize (
  buf: &tokbuf >> tokbuf?
) : void // end of [tokbuf_uninitialize]

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

(* end of [pats_tokbuf.sats] *)
