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

#define ATS_PACKNAME "ATSCNTRB.hiredis"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_hiredis_" // prefix for external names

(* ****** ****** *)

%{^#
//
#include "hiredis/CATS/hiredis.cats
//
%} // end of [%{^#]

(* ****** ****** *)

absvtype redisReply_vtype (l:addr)
vtypedef redisReply (l:addr) = redisReply_vtype (l)
vtypedef redisReply0 = [l:addr] redisReply_vtype (l)
vtypedef redisReply1 = [l:addr | l > null] redisReply_vtype (l)

castfn
redisReply2ptr{l:addr} (ctx: !redisReply (l)):<> ptr (l)
overload ptrcast with redisReply2ptr

(* ****** ****** *)

/*
void freeReplyObject(void *reply);
*/
fun freeReplyObject (obj: redisReply0): void = "mac#%"

(* ****** ****** *)

(*
absvtype redisReadTask_vtype (l:addr)
vtypedef redisReadTask (l:addr) = redisReadTask_vtype (l)
vtypedef redisReadTask0 = [l:addr] redisReadTask_vtype (l)
vtypedef redisReadTask1 = [l:addr | l > null] redisReadTask_vtype (l)
*)

(* ****** ****** *)

absvtype redisReader_vtype (l:addr)
vtypedef redisReader (l:addr) = redisReader_vtype (l)
vtypedef redisReader0 = [l:addr] redisReader_vtype (l)
vtypedef redisReader1 = [l:addr | l > null] redisReader_vtype (l)

castfn
redisReader2ptr{l:addr} (ctx: !redisReader (l)):<> ptr (l)
overload ptrcast with redisReader2ptr

(* ****** ****** *)

/*
redisReader *redisReaderCreate(void);
*/
fun redisReaderCreate (): redisReader0 = "mac#%"
fun redisReaderCreate_exn (): redisReader1 = "mac#%"

(* ****** ****** *)

/*
void redisReaderFree(redisReader *r);
*/
fun redisReaderFree (r: redisReader0): void = "mac#%"

(* ****** ****** *)

/*
int redisReaderFeed
  (redisReader *r, const char *buf, size_t len);
*/
fun redisReaderFeed{n:int}
(
  rdr: !redisReader1
, buf: &(@[byte?][n]) >> @[byte][n], len: size_t n
) : int = "mac#%" // end of [redisReaderFeed]

(* ****** ****** *)

/*
int redisReaderGetReply(redisReader *r, void **reply);
*/
fun redisReaderGetReply
(
  rdr: !redisReader1, reply: &ptr? >> redisReply0
) : int(*err*) = "mac#%" // endfun

(* ****** ****** *)

absvtype redisContext_vtype (l:addr)
vtypedef redisContext (l:addr) = redisContext_vtype (l)
vtypedef redisContext0 = [l:addr] redisContext_vtype (l)
vtypedef redisContext1 = [l:addr | l > null] redisContext_vtype (l)

castfn
redisContext2ptr{l:addr} (ctx: !redisContext (l)):<> ptr (l)
overload ptrcast with redisContext2ptr

(* ****** ****** *)

/*
redisContext *redisConnect(const char *ip, int port);
redisContext *redisConnectWithTimeout(const char *ip, int port, struct timeval tv);
redisContext *redisConnectNonBlock(const char *ip, int port);
redisContext *redisConnectUnix(const char *path);
redisContext *redisConnectUnixWithTimeout(const char *path, struct timeval tv);
redisContext *redisConnectUnixNonBlock(const char *path);
*/

(* ****** ****** *)

fun redisConnect
  (ip: RD(string), port: int): redisContext0 = "mac#%"
fun redisConnect_exn
  (ip: RD(string), port: int): redisContext1 = "mac#%"

(* ****** ****** *)

fun redisConnectNonBlock
  (ip: RD(string), port: int): redisContext0 = "mac#%"

(* ****** ****** *)

fun redisConnectUnix
  (path: RD(string)): redisContext0 = "mac#%"
fun redisConnectUnix_exn
  (path: RD(string)): redisContext1 = "mac#%"

(* ****** ****** *)

fun redisConnectUnixNonBlock
  (path: RD(string)): redisContext0 = "mac#%"

(* ****** ****** *)

/*
void redisFree(redisContext *ctx);
*/
fun redisFree (ctx: redisContext0): void = "mac#%"

(* ****** ****** *)

/*
int redisBufferRead(redisContext *c);
int redisBufferWrite(redisContext *c, int *done);
*/
fun redisBufferRead (ctx: !redisContext1): int = "mac#%"
fun redisBufferWrite
  (ctx: !redisContext1, done: &int? >> int): int = "mac#%"
//
(* ****** ****** *)

/*
int redisGetReply(redisContext *c, void **reply);
int redisGetReplyFromReader(redisContext *c, void **reply);
*/

fun redisGetReply
(
  ctx: !redisContext1, reply: &ptr? >> redisReply0
) : int(*err*) = "mac#%" // endfun

fun redisGetReplyFromReader
(
  ctx: !redisContext1, reply: &ptr? >> redisReply0
) : int(*err*) = "mac#%" // endfun

(* ****** ****** *)

/*
int redisFormatCommand(char **target, const char *format, ...);
int redisvFormatCommand(char **target, const char *format, va_list ap);
int redisFormatCommandArgv(char **target, int argc, const char **argv, const size_t *argvlen);
*/

(* ****** ****** *)

/*
int redisAppendCommand(redisContext *c, const char *format, ...);
int redisvAppendCommand(redisContext *c, const char *format, va_list ap);
int redisAppendCommandArgv(redisContext *c, int argc, const char **argv, const size_t *argvlen);
*/

(* ****** ****** *)

/*
void *redisCommand(redisContext *c, const char *format, ...);
void *redisvCommand(redisContext *c, const char *format, va_list ap);
void *redisCommandArgv(redisContext *c, int argc, const char **argv, const size_t *argvlen);
*/

(* ****** ****** *)

(* end of [hiredis.sats] *)
