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

#define ATS_PACKNAME "ATSCNTRB.hiredis"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_hiredis_" // prefix for external names

(* ****** ****** *)

%{^#
//
#include "hiredis/CATS/hiredis.cats"
//
%} // end of [%{^#]

(* ****** ****** *)

staload
TIME = "libc/sys/SATS/time.sats"
typedef timeval = $TIME.timeval

(* ****** ****** *)

macdef
HIREDIS_MAJOR = $extval (int, "HIREDIS_MAJOR")
macdef
HIREDIS_MINOR = $extval (int, "HIREDIS_MINOR")
macdef
HIREDIS_PATCH = $extval (int, "HIREDIS_PATCH")

(* ****** ****** *)

fun{} hiredis_version (): int

(* ****** ****** *)

macdef REDIS_OK = $extval (int, "REDIS_OK")
macdef REDIS_ERR = $extval (int, "REDIS_ERR")

(* ****** ****** *)

macdef
REDIS_REPLY_NIL = $extval (int, "REDIS_REPLY_NIL")
macdef
REDIS_REPLY_ARRAY = $extval (int, "REDIS_REPLY_ARRAY")
macdef
REDIS_REPLY_STRING = $extval (int, "REDIS_REPLY_STRING")
macdef
REDIS_REPLY_INTEGER = $extval (int, "REDIS_REPLY_INTEGER")
macdef
REDIS_REPLY_STATUS = $extval (int, "REDIS_REPLY_STATUS")
macdef
REDIS_REPLY_ERROR = $extval (int, "REDIS_REPLY_ERROR")

(* ****** ****** *)

(*
typedef
struct redisReply
{
//
  int type; /* REDIS_REPLY_* */
  long long integer; /* The integer when type is REDIS_REPLY_INTEGER */
  int len; /* Length of string */
  char *str; /* Used for both REDIS_REPLY_ERROR and REDIS_REPLY_STRING */
  size_t elements; /* number of elements, for REDIS_REPLY_ARRAY */
  struct redisReply **element; /* elements vector for REDIS_REPLY_ARRAY */
//
} redisReply;
*)
absvtype redisReply_vtype (l:addr) = ptr(l)
vtypedef redisReply (l:addr) = redisReply_vtype (l)
vtypedef redisReply = [l:addr] redisReply_vtype (l)
vtypedef redisReply0 = [l:agez] redisReply_vtype (l)
vtypedef redisReply1 = [l:addr | l >  null] redisReply_vtype (l)

castfn
redisReply2ptr{l:addr} (rep: !redisReply (l)):<> ptr (l)
overload ptrcast with redisReply2ptr

(* ****** ****** *)
/*
void freeReplyObject(void *reply);
*/
fun freeReplyObject (obj: redisReply0): void = "mac#%"

(* ****** ****** *)

fun
redisReply_get_array
(
  rep: !redisReply1, n: &size_t? >> size_t n
) : #[l:addr;n:nat]
(
  array_v (redisReply1, l, n)
, array_v (redisReply1, l, n) -<lin,prf> void | ptr l
) = "mac#%" // end of [redisReply_get_array]
fun
redisReply_get_string (rep: !redisReply1): vStrptr1 = "mac#%"
fun
redisReply_get_integer (rep: !redisReply1): llint = "mac#%"
fun
redisReply_get_status (rep: !redisReply1): vStrptr1 = "mac#%"
fun
redisReply_get_error (rep: !redisReply1): vStrptr1 = "mac#%"

(* ****** ****** *)

fun redisReply_get_type (rep: !redisReply1): int = "mac#%"
fun redisReply_get_strlen (rep: !redisReply1): int = "mac#%"
fun redisReply_get_strptr (rep: !redisReply1): ptr = "mac#%"

(* ****** ****** *)

(*
absvtype redisReadTask_vtype (l:addr) = ptr(l)
vtypedef redisReadTask (l:addr) = redisReadTask_vtype (l)
vtypedef redisReadTask = [l:addr] redisReadTask_vtype (l)
vtypedef redisReadTask0 = [l:agez] redisReadTask_vtype (l)
vtypedef redisReadTask1 = [l:addr | l > null] redisReadTask_vtype (l)
*)

(* ****** ****** *)

(*
typedef
struct redisReader
{
//
  int err; /* Error flags, 0 when there is no error */
  char errstr[128]; /* String representation of error when applicable */
//
  char *buf; /* Read buffer */
  size_t pos; /* Buffer cursor */
  size_t len; /* Buffer length */
//
  redisReadTask rstack[3];
  int ridx; /* Index of current read task */
  void *reply; /* Temporary reply pointer */
//
  redisReplyObjectFunctions *fn;
  void *privdata;
//
} redisReader;
*)
absvtype redisReader_vtype (l:addr) = ptr(l)
vtypedef redisReader (l:addr) = redisReader_vtype (l)
vtypedef redisReader = [l:addr] redisReader_vtype (l)
vtypedef redisReader0 = [l:agez] redisReader_vtype (l)
vtypedef redisReader1 = [l:addr | l > null] redisReader_vtype (l)

castfn
redisReader2ptr{l:addr} (rdr: !redisReader (l)):<> ptr (l)
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
fun redisReaderFree (rdr: redisReader0): void = "mac#%"

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

(*
typedef struct redisContext {
    int err; /* Error flags, 0 when there is no error */
    char errstr[128]; /* String representation of error when applicable */
    int fd;
    int flags;
    char *obuf; /* Write buffer */
    redisReader *reader; /* Protocol reader */
} redisContext;
*)
absvtype redisContext_vtype (l:addr) = ptr(l)
vtypedef redisContext (l:addr) = redisContext_vtype (l)
vtypedef redisContext = [l:addr] redisContext_vtype (l)
vtypedef redisContext0 = [l:agez] redisContext_vtype (l)
vtypedef redisContext1 = [l:addr | l > null] redisContext_vtype (l)

castfn
redisContext2ptr{l:addr} (ctx: !redisContext (l)):<> ptr (l)
overload ptrcast with redisContext2ptr

(* ****** ****** *)

fun redis_get_err (ctx: !redisContext1):<> int = "mac#%"
fun redis_get_errstr (ctx: !redisContext1):<> vStrptr1 = "mac#%"

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

fun redisConnectWithTimeout_tval
  (ip: RD(string), port: int, tv: timeval): redisContext0 = "mac#%"
fun redisConnectWithTimeout_fsec
  (ip: RD(string), port: int, fsec: double): redisContext0 = "mac#%"
//
symintr redisConnectWithTimeout
overload redisConnectWithTimeout with redisConnectWithTimeout_tval
overload redisConnectWithTimeout with redisConnectWithTimeout_fsec

(* ****** ****** *)

fun redisConnectNonBlock
  (ip: RD(string), port: int): redisContext0 = "mac#%"

(* ****** ****** *)

fun redisConnectUnix
  (path: RD(string)): redisContext0 = "mac#%"
fun redisConnectUnix_exn
  (path: RD(string)): redisContext1 = "mac#%"

(* ****** ****** *)

fun redisConnectUnixWithTimeout_tval
  (ip: RD(string), tv: timeval): redisContext0 = "mac#%"
fun redisConnectUnixWithTimeout_fsec
  (ip: RD(string), fsec: double): redisContext0 = "mac#%"
//
symintr redisConnectUnixWithTimeout
overload redisConnectUnixWithTimeout with redisConnectUnixWithTimeout_tval
overload redisConnectUnixWithTimeout with redisConnectUnixWithTimeout_fsec

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
