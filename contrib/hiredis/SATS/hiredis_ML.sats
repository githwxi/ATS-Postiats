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
** Start Time: July, 2013
** Author: Hanwen Wu
** Authoremail: steinwaywhw AT gmail DOT com
*)
(*
** Start Time: August, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#define
ATS_PACKNAME "ATSCNTRB.hiredis_ML"
#define
ATS_STALOADFLAG 0 // no static loading at run-time
#define
ATS_EXTERN_PREFIX "atscntrb_hiredis_ML_" // prefix for external names

(* ****** ****** *)

staload "hiredis/SATS/hiredis.sats"

(* ****** ****** *)

datatype
redisVal =
| RDSVstring of string
| RDSVinteger of llint
| {n:nat}
  RDSVarray of (arrayref (redisVal, n), size_t n)
| RDSVnil of ()
| RDSVstatus of string
| RDSVerror of string

(* ****** ****** *)

fun redisReply2Val0 (rep: redisReply1): redisVal
fun redisReply2Val1 (rep: !redisReply1): redisVal

(* ****** ****** *)

fun print_redisVal (redisVal): void
fun prerr_redisVal (redisVal): void
overload print with print_redisVal
overload prerr with prerr_redisVal
fun fprint_redisVal (FILEref, redisVal): void
overload fprint with fprint_redisVal

(* ****** ****** *)

fun redis_del (!redisContext1, k: string): void

(* ****** ****** *)

fun redis_get
  (!redisContext1, k: string): redisVal
// end of [redis_get]

(* ****** ****** *)

fun redis_set_int
  (!redisContext1, k: string, v: int): void
// end of [redis_set_string]
fun redis_set_string
  (!redisContext1, k: string, v: string): void
// end of [redis_set_string]

(* ****** ****** *)

fun redis_incr (!redisContext1, k: string): void

(* ****** ****** *)
//
fun redis_llen
  (!redisContext1, k: string): llint
//
fun redis_lpop
  (!redisContext1, k: string): void
//
fun redis_lpush_int
  (!redisContext1, k: string, v: int): void
fun redis_lpush_string
  (!redisContext1, k: string, v: string): void
//
fun redis_rpop
  (!redisContext1, k: string): void
//
fun redis_rpush_int
  (!redisContext1, k: string, v: int): void
fun redis_rpush_string
  (!redisContext1, k: string, v: string): void
//
fun redis_lrange
(
  !redisContext1, k: string, i0: int, i1: int
) : redisVal // end of [redis_lrang]
//
(* ****** ****** *)

(* end of [hiredis_ML.sats] *)
