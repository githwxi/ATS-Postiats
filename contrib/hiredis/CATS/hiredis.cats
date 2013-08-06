/************************************************************************/
/*                                                                      */
/*                         Applied Type System                          */
/*                                                                      */
/*                              Hongwei Xi                              */
/*                                                                      */
/************************************************************************/

/*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2010-2013 Hongwei Xi.
**
** ATS is  free software;  you can redistribute it and/or modify it under
** the  terms of the  GNU General Public License as published by the Free
** Software Foundation; either version 2.1, or (at your option) any later
** version.
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
*/

/* ****** ****** */

/*
(*
** Start Time: July, 2013
** Author: Hanwen Wu
** Authoremail: steinwaywhw AT gmail DOT com
*)
(*
** Start Time: August, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)
*/

/* ****** ****** */

#ifndef HIREDIS_HIREDIS_CATS
#define HIREDIS_HIREDIS_CATS

/* ****** ****** */

#include <sys/time.h>

/* ****** ****** */

#include <hiredis/hiredis.h>

/* ****** ****** */

ATSinline()
atstype_string
redisReply_get_string
(
  struct redisReply *rep
) {
  if (((redisReply*)rep)->type != REDIS_REPLY_STRING)
  {
    fprintf(stderr
    , "exit(ATSCNTRB): [hiredis:redisReply_get_string]: non-string reply.\n"
    ) ; exit(1) ;
  }
  return (((redisReply*)rep)->str) ;
} // end of [redisReply_get_string]

ATSinline()
atstype_llint
redisReply_get_integer
(
  struct redisReply *rep
) {
  if (((redisReply*)rep)->type != REDIS_REPLY_INTEGER)
  {
    fprintf(stderr
    , "exit(ATSCNTRB): [hiredis:redisReply_get_integer]: non-integer reply.\n"
    ) ; exit(1) ;
  }
  return (((redisReply*)rep)->integer) ;
} // end of [redisReply_get_integer]

ATSinline()
atstype_arrptr
redisReply_get_array
(
  struct redisReply *rep, size_t *asz
) {
  if (((redisReply*)rep)->type != REDIS_REPLY_ARRAY)
  {
    fprintf(stderr
    , "exit(ATSCNTRB): [hiredis:redisReply_get_array]: non-array reply.\n"
    ) ; exit(1) ;
  }
  *asz = ((redisReply*)rep)->elements ;
  return (((redisReply*)rep)->element) ;
} // end of [redisReply_get_array]

ATSinline()
atstype_string
redisReply_get_status
(
  struct redisReply *rep
) {
  if (((redisReply*)rep)->type != REDIS_REPLY_STATUS)
  {
    fprintf(stderr
    , "exit(ATSCNTRB): [hiredis:redisReply_get_status]: non-status reply.\n"
    ) ; exit(1) ;
  }
  return (((redisReply*)rep)->str) ;
} // end of [redisReply_get_status]

ATSinline()
atstype_string
redisReply_get_error
(
  struct redisReply *rep
) {
  if (((redisReply*)rep)->type != REDIS_REPLY_ERROR)
  {
    fprintf(stderr
    , "exit(ATSCNTRB): [hiredis:redisReply_get_error]: non-error reply.\n"
    ) ; exit(1) ;
  }
  return (((redisReply*)rep)->str) ;
} // end of [redisReply_get_error]

/* ****** ****** */
//
#define atscntrb_hiredis_freeReplyObject freeReplyObject
#define atscntrb_hiredis_redisReply_get_array redisReply_get_array
#define atscntrb_hiredis_redisReply_get_string redisReply_get_string
#define atscntrb_hiredis_redisReply_get_integer redisReply_get_integer
#define atscntrb_hiredis_redisReply_get_status redisReply_get_status
#define atscntrb_hiredis_redisReply_get_error redisReply_get_error
//
#define atscntrb_hiredis_redisReply_get_type(rep) (((redisReply*)rep)->type)
#define atscntrb_hiredis_redisReply_get_strlen(rep) (((redisReply*)rep)->len)
#define atscntrb_hiredis_redisReply_get_strptr(rep) (((redisReply*)rep)->str)
//
/* ****** ****** */

#define atscntrb_hiredis_redisReaderFree redisReaderFree
#define atscntrb_hiredis_redisReaderCreate redisReaderCreate
#define atscntrb_hiredis_redisReaderFeed redisReaderFeed
#define atscntrb_hiredis_redisReaderGetReply redisReaderGetReply

/* ****** ****** */

#define atscntrb_hiredis_redis_get_err(ctx) (((redisContext*)ctx)->err)
#define atscntrb_hiredis_redis_get_errstr(ctx) (&((redisContext*)ctx)->errstr[0])

/* ****** ****** */
//
#define atscntrb_hiredis_redisFree redisFree
//
/* ****** ****** */
//
ATSinline()
redisContext*
redisConnectWithTimeout_fsec
(
  char *ip, int port, double fsec
)
{
  int isec ;
  struct timeval tv ;
  isec = (int)fsec ;
  tv.tv_sec = (time_t)isec;
  tv.tv_usec= (suseconds_t)(1000000 * (fsec - isec)) ;
  return redisConnectWithTimeout(ip, port, tv) ;
} // end of [redisConnectWithTimeout_fsec]
//
#define atscntrb_hiredis_redisConnect redisConnect
#define atscntrb_hiredis_redisConnectWithTimeout_tv redisConnectWithTimeout
#define atscntrb_hiredis_redisConnectWithTimeout_fsec redisConnectWithTimeout_fsec
#define atscntrb_hiredis_redisConnectNonBlock redisConnectNonBlock
//
/* ****** ****** */
//
ATSinline()
redisContext*
redisConnectUnixWithTimeout_fsec
(
  char *ip, double fsec
)
{
  int isec ;
  struct timeval tv ;
  isec = (int)fsec ;
  tv.tv_sec = (time_t)isec;
  tv.tv_usec= (suseconds_t)(1000000 * (fsec - isec)) ;
  return redisConnectUnixWithTimeout(ip, tv) ;
} // end of [redisConnectUnixWithTimeout_fsec]
//
#define atscntrb_hiredis_redisConnectUnix redisConnectUnix
#define atscntrb_hiredis_redisConnectUnixWithTimeout_tv redisConnectUnixWithTimeout
#define atscntrb_hiredis_redisConnectUnixWithTimeout_fsec redisConnectUnixWithTimeout_fsec
#define atscntrb_hiredis_redisConnectUnixNonBlock redisConnectUnixNonBlock
//
/* ****** ****** */

#define atscntrb_hiredis_redisBufferRead redisBufferRead
#define atscntrb_hiredis_redisBufferWrite redisBufferWrite

/* ****** ****** */

#define atscntrb_hiredis_redisGetReply redisGetReply
#define atscntrb_hiredis_redisGetReplyFromReader redisGetReplyFromReader

/* ****** ****** */

#define atscntrb_hiredis_redisCommand redisCommand
#define atscntrb_hiredis_redisFormatCommand redisFormatCommand
#define atscntrb_hiredis_redisAppendCommand redisAppendCommand

/* ****** ****** */

#endif // ifndef HIREDIS_HIREDIS_CATS

/* ****** ****** */

/* end of [hiredis.cats] */
