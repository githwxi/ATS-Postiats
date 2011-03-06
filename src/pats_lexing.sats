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
#include "pats_lexing.cats"
%} // end of [%{#]

(* ****** ****** *)

staload QR = "pats_queueref.sats"

(* ****** ****** *)

abstype token_t

(* ****** ****** *)

viewtypedef
lexstate =
$extype_struct
  "pats_lexstate_struct" of {
  empty=empty
//
, sta_nlin= int
, sta_noff= int
, sta_ntot= int
//
, cur_nlin= int
, cur_noff= int
, cur_ntot= int
//
, cur_char= int
//
, leading_space= int
, charbuf= $QR.queueref (char)
//
, getchar = () -<cloref1> int
//
} // end of [pats_lexstate]

(* ****** ****** *)

fun lexstate_get_next_char (state: &lexstate): int

(* ****** ****** *)

fun lexstate_get_next_token (state: &lexstate): token_t

(* ****** ****** *)

(* end of [pats_lexing.sats] *)
