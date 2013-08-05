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
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "hiredis/SATS/hiredis.sats"
staload "hiredis/SATS/hiredis_ML.sats"

(* ****** ****** *)

implement
redisReply2Val0
  (rep) = let
  val rdsv = redisReply2Val1 (rep)
  val ((*void*)) = freeReplyObject (rep) in rdsv
end // end of [redisReply2Val0]

(* ****** ****** *)

extern
fun redisReply_strdup (rep: !redisReply1): Strptr1
implement
redisReply_strdup (rep) = let
  val len = redisReply_get_strlen (rep)
  val len = g0int2uint_int_size (len)
  val [n:int] len = g1ofg0 (len)
  val (fpf | str) = redisReply_get_string (rep)
  val str2 = string_make_substring ($UN.castvwtp1{string(n)}(str), i2sz(0), len)
  prval ((*void*)) = fpf (str)
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
in
//
case+ t of
| _ when t =
    REDIS_REPLY_NIL => RDSVnil ()
| _ when t =
    REDIS_REPLY_STRING => let
    val str = redisReply_strdup (rep)
  in
    RDSVstring (strptr2string(str))
  end // end of [_ when ...]
//
| _ when t =
    REDIS_REPLY_INTEGER => let
    val int = redisReply_get_integer (rep)
  in
    RDSVinteger (int)
  end // end of [_ when ...]
//
| _ when t =
    REDIS_REPLY_STATUS => let
    val str = redisReply_strdup (rep)
  in
    RDSVstatus (strptr2string(str))
  end // end of [_ when ...]
//
| _ when t =
    REDIS_REPLY_ERROR => let
    val str = redisReply_strdup (rep)
  in
    RDSVerror (strptr2string(str))
  end // end of [_ when ...]
//
| _ => let val () = assertloc (false) in exit(1) end
//
end // end of [redisReply2Val1]

(* ****** ****** *)

implement
redis_get_val
  (ctx, k) = let
//
val p0 = ptrcast (ctx)
val rep = $extfcall (redisReply0, "redisCommand", p0, "GET %s", k)
val () = assertloc (ptrcast(rep) > 0)
//
in
  redisReply2Val0 (rep)
end // end of [redis_get_val]

(* ****** ****** *)

implement
redis_set_int
  (ctx, k, v) = let
//
val p0 = ptrcast (ctx)
val rep = $extfcall (redisReply0, "redisCommand", p0, "SET %s %i", k, v)
val () = freeReplyObject (rep)
//
in
  // nothing
end // end of [redis_set_int]

(* ****** ****** *)

implement
redis_set_string
  (ctx, k, v) = let
//
val p0 = ptrcast (ctx)
val rep = $extfcall (redisReply0, "redisCommand", p0, "SET %s %s", k, v)
val () = freeReplyObject (rep)
//
in
  // nothing
end // end of [redis_set_string]

(* ****** ****** *)

(* end of [hiredis_ML.dats] *)
