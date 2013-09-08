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

staload "./../SATS/hiredis.sats"

(* ****** ****** *)

datatype
redisVal =
| RDSstring of string
| RDSinteger of llint
| {n:nat}
  RDSarray of (arrayref (redisVal, n), size_t n)
| RDSnil of ()
| RDSstatus of string
| RDSerror of string

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
//
fun redis_auth
  (!redisContext1, pass: string): redisVal
//
(* ****** ****** *)

fun redis_ping (!redisContext1): redisVal
fun redis_echo (!redisContext1, msg: string): redisVal

(* ****** ****** *)

fun redis_quit (ctx: redisContext1): redisVal

(* ****** ****** *)

fun redis_keys (!redisContext1, pat: string): redisVal

(* ****** ****** *)

fun redis_flushdb (!redisContext1): redisVal
fun redis_flushall (!redisContext1): redisVal

(* ****** ****** *)
//
fun redis_del1
  (!redisContext1, k: string): redisVal
fun redis_del2
  (!redisContext1, k1: string, k2: string): redisVal
fun redis_del3
  (!redisContext1, k1: string, k2: string, k3: string): redisVal
//
symintr redis_del
overload redis_del with redis_del1
overload redis_del with redis_del2
overload redis_del with redis_del3
//
(* ****** ****** *)

fun redis_exists
  (!redisContext1, k: string): redisVal
// end of [redis_exists]
  
(* ****** ****** *)

fun redis_get
  (!redisContext1, k: string): redisVal
// end of [redis_get]

(* ****** ****** *)

fun redis_strlen
  (!redisContext1, k: string): redisVal
// end of [redis_strlen]

(* ****** ****** *)

fun redis_set_int
  (!redisContext1, k: string, v: int): redisVal
// end of [redis_set_string]
fun redis_set_string
  (!redisContext1, k: string, v: string): redisVal
// end of [redis_set_string]

(* ****** ****** *)

fun redis_setnx_int
  (!redisContext1, k: string, v: int): redisVal
// end of [redis_setnx_string]
fun redis_setnx_string
  (!redisContext1, k: string, v: string): redisVal
// end of [redis_setnx_string]

(* ****** ****** *)

fun redis_getset_int
  (!redisContext1, k: string, v: int): redisVal
// end of [redis_getset_int]
fun redis_getset_string
  (!redisContext1, k: string, v: string): redisVal
// end of [redis_getset_string]

(* ****** ****** *)

fun redis_decr (!redisContext1, k: string): redisVal
fun redis_decrby (!redisContext1, k: string, d: int): redisVal

fun redis_incr (!redisContext1, k: string): redisVal
fun redis_incrby (!redisContext1, k: string, d: int): redisVal
fun redis_incrbyfloat (!redisContext1, k: string, d: double): redisVal

(* ****** ****** *)

fun redis_rename
  (!redisContext1, k: string, k2: string): redisVal
// end of [redis_rename]

(* ****** ****** *)
//
fun redis_llen
  (!redisContext1, k: string): redisVal
//
fun redis_lpop
  (!redisContext1, k: string): redisVal
//
fun redis_lpush_int
  (!redisContext1, k: string, v: int): redisVal
fun redis_lpush_string
  (!redisContext1, k: string, v: string): redisVal
//
fun redis_rpop
  (!redisContext1, k: string): redisVal
//
fun redis_rpush_int
  (!redisContext1, k: string, v: int): redisVal
fun redis_rpush_string
  (!redisContext1, k: string, v: string): redisVal
//
fun redis_lindex
  (!redisContext1, k: string, i: int): redisVal
//
fun redis_lrange
  (!redisContext1, k: string, i0: int, i1: int): redisVal
//
(* ****** ****** *)
//
fun redis_scard
  (!redisContext1, k: string): redisVal
//
fun redis_sadd_int
  (!redisContext1, k: string, v: int): redisVal
fun redis_sadd_string
  (!redisContext1, k: string, v: string): redisVal
//
fun redis_srem_int
  (!redisContext1, k: string, v: int): redisVal
fun redis_srem_string
  (!redisContext1, k: string, v: string): redisVal
//
fun redis_spop
  (!redisContext1, k: string): redisVal
//
fun redis_smove_int
  (!redisContext1, k1: string, k2: string, v: int): redisVal
fun redis_smove_string
  (!redisContext1, k1: string, k2: string, v: string): redisVal
//
fun redis_smembers
  (!redisContext1, k: string): redisVal
//
fun redis_sismember_int
  (!redisContext1, k: string, v: int): redisVal
fun redis_sismember_string
  (!redisContext1, k: string, v: string): redisVal
//
(* ****** ****** *)

fun redis_hlen
  (!redisContext1, k: string): redisVal
//
fun redis_hkeys
  (!redisContext1, k: string): redisVal
fun redis_hvals
  (!redisContext1, k: string): redisVal
//
fun redis_hexists
  (!redisContext1, k: string, f: string): redisVal
//
fun redis_hdel1
  (!redisContext1, k: string, f: string): redisVal
fun redis_hdel2
  (!redisContext1, k: string, f1: string, f2: string): redisVal
//
symintr redis_hdel
overload redis_hdel with redis_hdel1
overload redis_hdel with redis_hdel2
//
fun redis_hget
  (!redisContext1, k: string, f: string): redisVal
//
fun redis_hset_int
  (!redisContext1, k: string, f: string, v: int): redisVal
fun redis_hset_string
  (!redisContext1, k: string, f: string, v: string): redisVal
//
fun redis_hgetall (!redisContext1, k: string): redisVal
//
fun redis_hsetnx_int
  (!redisContext1, k: string, f: string, v: int): redisVal
fun redis_hsetnx_string
  (!redisContext1, k: string, f: string, v: string): redisVal
//
fun redis_hincrby
  (!redisContext1, k: string, f: string, d: int): redisVal
fun redis_hincrbyfloat
  (!redisContext1, k: string, f: string, d: double): redisVal
//
(* ****** ****** *)

(* end of [hiredis_ML.sats] *)
