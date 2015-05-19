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
// Start Time: May, 2011
//
(* ****** ****** *)

staload
LOC = "./pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

fun{} prerr_ERROR_beg(): void
fun{} prerr_ERROR_end(): void

(* ****** ****** *)
//
fun{} prerr_FILENAME (): void // specific
//
fun{} prerr_interror (): void // generic
fun{} prerr_interror_loc (loc: location): void // generic
//
fun{} prerr_error1_loc (loc: location): void // generic
fun{} prerr_error2_loc (loc: location): void // generic
fun{} prerr_errmac_loc (loc: location): void // generic
fun{} prerr_error3_loc (loc: location): void // generic
fun{} prerr_error4_loc (loc: location): void // generic
//
fun{} prerr_errccomp_loc (loc: location): void // generic
//
fun{} prerr_warning1_loc (loc: location): void // generic
fun{} prerr_warning2_loc (loc: location): void // generic
fun{} prerr_warning3_loc (loc: location): void // generic
fun{} prerr_warning4_loc (loc: location): void // generic
//
fun{} prerr_warnccomp_loc (loc: location): void // generic
//
(* ****** ****** *)

(* end of [pats_errmsg.sats] *)
