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
#include "pats_lexbuf.cats"
%} // end of [%{#]

(* ****** ****** *)

absviewt@ype
lexbuf = $extype "pats_lexbuf_struct"

(* ****** ****** *)

fun lexbuf_initialize_getchar (
  buf: &lexbuf? >> lexbuf, getchar: () -<cloref1> int
) : void // end of [lexbuf_initialize]

fun lexbuf_uninitialize (
  buf: &lexbuf >> lexbuf?
) : void // end of [lexbuf_uninitialize]

(* ****** ****** *)

fun lexbuf_get_next_char (buf: &lexbuf): int

(* ****** ****** *)

fun lexbuf_advance_reset (buf: &lexbuf, k: uint): void

(* ****** ****** *)

fun lexbuf_strptrout_reset (buf: &lexbuf, k: uint): strptr0

(* ****** ****** *)

(* end of [pats_lexbuf.sats] *)
