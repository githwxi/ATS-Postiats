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
** Copyright (C) 2002-2008 Hongwei Xi.
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

#include <hiredis/hiredis.h>

/* ****** ****** */

#define atscntrb_hiredis_redisReaderFree redisReaderFree
#define atscntrb_hiredis_redisReaderCreate redisReaderCreate
#define atscntrb_hiredis_redisReaderFeed redisReaderFeed
#define atscntrb_hiredis_redisReaderGetReply redisReaderGetReply

/* ****** ****** */
//
#define atscntrb_hiredis_redisFree redisFree
//
#define atscntrb_hiredis_redisConnect redisConnect
#define atscntrb_hiredis_redisConnectWithTimeout redisConnectTimeout
#define atscntrb_hiredis_redisConnectNonBlock redisConnectNonBlock
//
#define atscntrb_hiredis_redisConnectUnix redisConnectUnix
#define atscntrb_hiredis_redisConnectUnixWithTimeout redisConnectUnixTimeout
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
