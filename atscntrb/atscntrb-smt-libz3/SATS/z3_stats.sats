(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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

(*
** Start Time: April, 2013
**
** Author: William Blair 
** Authoremail: wdblair AT bu DOT edu
**
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
*)

(* ****** ****** *)
//
#ifndef
ATSCNTRB_SMT_Z3_Z3_HEADER
#include "./z3_header.sats"
#endif // end of [ifndef]
//
(* ****** ****** *)

fun
Z3_stats_to_string
(
  ctx: !Z3_context, s: !Z3_stats
) : vStrptr1 = "mac#%" // endfun

(* ****** ****** *)
//
fun Z3_stats_inc_ref
  (s: !Z3_stats): Z3_stats = "mac#%"
//
fun Z3_stats_dec_ref (s: Z3_stats): void = "mac#%"
//
(* ****** ****** *)

fun Z3_stats_size (s: !Z3_stats): uint = "mac#%"

(* ****** ****** *)

fun Z3_stats_get_key
  (ctx: !Z3_context, s: !Z3_stats, idx: uint): vStrptr1 = "mac#%"
// end of [Z3_stats_get_key]

(* ****** ****** *)

fun Z3_stats_is_uint
  (ctx: !Z3_context, s: !Z3_stats, idx: uint): bool = "mac#%"
// end of [Z3_stats_is_uint]

fun Z3_stats_get_uint_value
  (ctx: !Z3_context, s: !Z3_stats, idx: uint): uint = "mac#%"
// end of [Z3_stats_get_uint_value]

(* ****** ****** *)

fun Z3_stats_is_double
  (ctx: !Z3_context, s: !Z3_stats, idx: uint): bool = "mac#%"
// end of [Z3_stats_is_double]

fun Z3_stats_get_double_value
  (ctx: !Z3_context, s: !Z3_stats, idx: uint): double = "mac#%"
// end of [Z3_stats_get_double_value]

(* ****** ****** *)

(* end of [z3_stats.sats] *)
