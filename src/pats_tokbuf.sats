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

fun tokbuf_get_token (buf: &tokbuf): token

(* ****** ****** *)

fun tokbuf_get_location (buf: &tokbuf): location

(* ****** ****** *)

fun tokbuf_reset (buf: &tokbuf): void
fun tokbuf_getloc_reset (buf: &tokbuf): location

(* ****** ****** *)

(* end of [pats_tokbuf.sats] *)
