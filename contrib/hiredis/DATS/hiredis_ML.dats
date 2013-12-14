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

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/hiredis.sats"
staload "./../SATS/hiredis_ML.sats"

(* ****** ****** *)

implement
redisReply2Val0
  (rep) = let
  val rdsv = redisReply2Val1 (rep)
  val ((*void*)) = freeReplyObject (rep) in rdsv
end // end of [redisReply2Val0]

(* ****** ****** *)

implement
fprint_val<redisVal> = fprint_redisVal

(* ****** ****** *)

implement
print_redisVal (x) = fprint_redisVal (stdout_ref, x)
implement
prerr_redisVal (x) = fprint_redisVal (stderr_ref, x)

(* ****** ****** *)

implement
fprint_redisVal
  (out, x) = let
in
//
case+ x of
| RDSstring (str) =>
    fprint! (out, "RDSstring(", str, ")")
| RDSinteger (int) =>
    fprint! (out, "RDSinteger(", int, ")")
| RDSarray (A, n) =>
  {
    val () = fprint (out, "RDSarray(")
    val () = fprint_arrayref_sep (out, A, n, ", ")
    val () = fprint (out, ")")
  }
| RDSnil () => fprint! (out, "RDSnil(", ")")
| RDSstatus (str) => fprint! (out, "RDSstatus(", str, ")")
| RDSerror (str) => fprint! (out, "RDSerror(", str, ")")
//
end // end of [fprint_redisVal]

(* ****** ****** *)

extern
fun redisReply_strdup (rep: !redisReply1): Strptr1
implement
redisReply_strdup (rep) = let
  val len = redisReply_get_strlen (rep)
  val len = g0int2uint_int_size (len)
  val [n:int] len = g1ofg0 (len)
  val str = redisReply_get_strptr (rep)
  val str2 = string_make_substring ($UN.castvwtp1{string(n)}(str), i2sz(0), len)
in
  $UN.castvwtp0{Strptr1}(str2)
end // end of [redisReply_strdup]

(* ****** ****** *)

implement
redisReply2Val1
  (rep) = let
//
val t = redisReply_get_type (rep)
//
(*
val () = println! ("redisReply2Val1: t = ", t)
*)
//
in
//
case+ t of
| _ when t =
    REDIS_REPLY_STRING => let
    val str = redisReply_strdup (rep)
  in
    RDSstring (strptr2string(str))
  end // end of [STRING]
//
| _ when t =
    REDIS_REPLY_INTEGER => let
    val int = redisReply_get_integer (rep)
  in
    RDSinteger (int)
  end // end of [INTEGER]
//
| _ when t =
    REDIS_REPLY_ARRAY => let
    var asz: size_t
    val (pf, fpf | p) = redisReply_get_array (rep, asz)
    prval [n:int] EQINT () = eqint_make_guint (asz)
    val (pf2, pf2gc | p2) = array_ptr_alloc<redisVal> (asz)
//
    vtypedef a = redisReply1 and b = redisVal
//
    local
    implement
    array_mapto$fwork<a><b>
      (x, y) = y := redisReply2Val1 (x)
    in (* in of [local] *)
    val () = array_mapto<a><b> (!p, !p2, asz)
    end // end of [local]
//
    prval () = fpf (pf)
    val A2 = $UN.castvwtp0{arrayref(b,n)}((pf2, pf2gc | p2))
  in
    RDSarray (A2, asz)
  end // end of [ARRAY]
//
| _ when t =
    REDIS_REPLY_NIL => RDSnil ()
//
| _ when t =
    REDIS_REPLY_STATUS => let
    val str = redisReply_strdup (rep)
  in
    RDSstatus (strptr2string(str))
  end // end of [STATUS]
//
| _ when t =
    REDIS_REPLY_ERROR => let
    val str = redisReply_strdup (rep)
  in
    RDSerror (strptr2string(str))
  end // end of [ERROR]
//
| _ => let val () = assertloc (false) in exit(1) end
//
end // end of [redisReply2Val1]

(* ****** ****** *)

implement
redisReply2Val0_err
  (rep, err) =
(
  if ptrcast(rep) > 0
    then redisReply2Val0 (rep)
    else let
      prval () = redisReply_free_null (rep)
    in
      err := err + 1; RDSnil((*void*))
    end // end of [else]
  // end of [if]
)

(* ****** ****** *)

implement
redis_auth
  (ctx, pass, err) = let
//
val p0 = ptrcast (ctx)
val rep = $extfcall
  (redisReply0, "redisCommand", p0, "AUTH %s", pass)
in
  redisReply2Val0_err (rep, err)
end // end of [redis_auth]

(* ****** ****** *)

implement
redis_ping
  (ctx, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "PING")
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_ping]

(* ****** ****** *)

implement
redis_echo
  (ctx, msg, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "ECHO %s", msg)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_echo]

(* ****** ****** *)

implement
redis_quit
  (ctx) = let
//
val p0 = ptrcast (ctx)
val rep = $extfcall (redisReply0, "redisCommand", p0, "QUIT")
val () = redisFree (ctx)
//
var err: int = 0
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_ping]

(* ****** ****** *)

implement
redis_keys
  (ctx, pat, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "KEYS %s", pat
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_keys]

(* ****** ****** *)

implement
redis_flushdb
  (ctx, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "FLUSHDB")
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_flushdb]

implement
redis_flushall
  (ctx, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "FLUSHALL")
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_flushall]

(* ****** ****** *)

implement
redis_del1
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "DEL %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_del1]

implement
redis_del2
  (ctx, k1, k2, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "DEL %s %s", k1, k2)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_del2]

implement
redis_del3
  (ctx, k1, k2, k3, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "DEL %s %s %s", k1, k2, k3
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_del3]

(* ****** ****** *)

implement
redis_exists
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "EXISTS %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_exists]

(* ****** ****** *)

implement
redis_get
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep = $extfcall (redisReply0, "redisCommand", p0, "GET %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_get]

(* ****** ****** *)

implement
redis_strlen
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep = $extfcall (redisReply0, "redisCommand", p0, "STRLEN %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_strlen]

(* ****** ****** *)

implement
redis_set_int
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "SET %s %i", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_set_int]

implement
redis_set_string
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "SET %s %s", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_set_string]

(* ****** ****** *)

implement
redis_setnx_int
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "SET %s %i", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_setnx_int]

implement
redis_setnx_string
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "SET %s %s", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_setnx_string]

(* ****** ****** *)

implement
redis_getset_int
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "GETSET %s %i", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_getset_int]

implement
redis_getset_string
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "GETSET %s %s", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_getset_string]

(* ****** ****** *)

implement
redis_decr
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep = $extfcall (redisReply0, "redisCommand", p0, "DECR %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_decr]

implement
redis_decrby
  (ctx, k, d, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "DECRBY %s %i", k, d)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_decrby]

(* ****** ****** *)

implement
redis_incr
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "INCR %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_incr]

implement
redis_incrby
  (ctx, k, d, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "INCRBY %s %i", k, d)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_incrby]

implement
redis_incrbyfloat
  (ctx, k, d, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "INCRBYFLOAT %s %f", k, d
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_incrbyfloat]

(* ****** ****** *)

implement
redis_rename
  (ctx, k, k2, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "RENAME %s %s", k, k2)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_rename]

(* ****** ****** *)

implement
redis_llen
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "LLEN %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_llen]

(* ****** ****** *)

implement
redis_lpop
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "LPOP %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_lpop]

implement
redis_lpush_int
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "LPUSH %s %i", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_lpush_int]

implement
redis_lpush_string
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "LPUSH %s %s", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_lpush_string]

(* ****** ****** *)

implement
redis_rpop
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "RPOP %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_rpop]

implement
redis_rpush_int
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "RPUSH %s %i", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_rpush_int]

implement
redis_rpush_string
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "RPUSH %s %s", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_rpush_string]

(* ****** ****** *)

implement
redis_rpoplpush
  (ctx, k1, k2, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "RPOPLPUSH %s %s", k1, k2
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_rpoplpush]

(* ****** ****** *)

implement
redis_lindex
  (ctx, k, i, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "LINDEX %s %i", k, i)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_lindex]

(* ****** ****** *)

implement
redis_lrange
  (ctx, k, i0, i1, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "LRANGE %s %i %i", k, i0, i1
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_lrange]

(* ****** ****** *)

implement
redis_blpop
  (ctx, k, tout, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "BLPOP %s %i", k, tout)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_blpop]

(* ****** ****** *)

implement
redis_brpop
  (ctx, k, tout, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "BRPOP %s %i", k, tout)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_brpop]

(* ****** ****** *)

implement
redis_brpoplpush
  (ctx, k1, k2, tout, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0
, "redisCommand", p0, "BRPOPLPUSH %s %s %i", k1, k2, tout
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_brpoplpush]

(* ****** ****** *)

implement
redis_scard
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "SCARD %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_scard]

(* ****** ****** *)

implement
redis_sadd_int
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall
  (redisReply0, "redisCommand", p0, "SADD %s %i", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_sadd_int]

implement
redis_sadd_string
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall
  (redisReply0, "redisCommand", p0, "SADD %s %s", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_sadd_string]

(* ****** ****** *)

implement
redis_srem_int
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "SREM %s %i", k, v
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_srem_int]

implement
redis_srem_string
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "SREM %s %s", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_srem_string]

(* ****** ****** *)

implement
redis_spop
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "SPOP %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_spop]

(* ****** ****** *)

implement
redis_smove_int
  (ctx, k1, k2, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "SMOVE %s %s %i", k1, k2, v
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_smove_int]

implement
redis_smove_string
  (ctx, k1, k2, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "SMOVE %s %s %s", k1, k2, v
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_smove_string]

(* ****** ****** *)

implement
redis_smembers
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "SMEMBERS %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_smembers]

(* ****** ****** *)

implement
redis_sismember_int
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "SISMEMBER %s %i", k, v)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_sismember_int]

implement
redis_sismember_string
  (ctx, k, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "SISMEMBER %s %s", k, v
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_sismember_string]

(* ****** ****** *)

implement
redis_hlen
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep = $extfcall (redisReply0, "redisCommand", p0, "HLEN %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hlen]

(* ****** ****** *)

implement
redis_hkeys
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep = $extfcall (redisReply0, "redisCommand", p0, "HKEYS %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hkeys]

implement
redis_hvals
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep = $extfcall
  (redisReply0, "redisCommand", p0, "HVALS %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hvals]

(* ****** ****** *)

implement
redis_hexists
  (ctx, k, f, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "HEXISTS %s %s", k, f
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hexists]

(* ****** ****** *)

implement
redis_hdel1
  (ctx, k, f, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "HDEL %s %s", k, f
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hdel1]

implement
redis_hdel2
  (ctx, k, f1, f2, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0
, "redisCommand", p0, "HDEL %s %s %s", k, f1, f2
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hdel2]

(* ****** ****** *)

implement
redis_hget
  (ctx, k, f, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "HGET %s %s", k, f
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hget]

(* ****** ****** *)

implement
redis_hgetall
  (ctx, k, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (redisReply0, "redisCommand", p0, "HGETALL %s", k)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hgetall]

(* ****** ****** *)

implement
redis_hset_int
  (ctx, k, f, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "HSET %s %s %i", k, f, v
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hset_int]

implement
redis_hset_string
  (ctx, k, f, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "HSET %s %s %s", k, f, v
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hset_string]

(* ****** ****** *)

implement
redis_hsetnx_int
  (ctx, k, f, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "HSETNX %s %s %i", k, f, v
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hsetnx_int]

implement
redis_hsetnx_string
  (ctx, k, f, v, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "HSETNX %s %s %s", k, f, v
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hsetnx_string]

(* ****** ****** *)

implement
redis_hincrby
  (ctx, k, f, d, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "HINCRBY %s %s %i", k, f, d
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hincrby]

implement
redis_hincrbyfloat
  (ctx, k, f, d, err) = let
//
val p0 = ptrcast (ctx)
val rep =
$extfcall (
  redisReply0, "redisCommand", p0, "HINCRBYFLOAT %s %s %f", k, f, d
) (* end of [val] *)
//
in
  redisReply2Val0_err (rep, err)
end // end of [redis_hincrbyfloat]

(* ****** ****** *)

(* end of [hiredis_ML.dats] *)
