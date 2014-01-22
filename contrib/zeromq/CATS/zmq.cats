/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
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
*) */

/* ****** ****** */

/*
(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start Time: December, 2012
*)
*/

/* ****** ****** */

#ifndef ZEROMQ_ZMQ_CATS
#define ZEROMQ_ZMQ_CATS

/* ****** ****** */

#include <zmq.h>

/* ****** ****** */

#define atscntrb_zeromq_zmq_errno zmq_errno

#define atscntrb_zeromq_zmq_ctx_new zmq_ctx_new
#define atscntrb_zeromq_zmq_ctx_destroy zmq_ctx_destroy

#define atscntrb_zeromq_zmq_ctx_get zmq_ctx_get
#define atscntrb_zeromq_zmq_ctx_set zmq_ctx_set

/* ****** ****** */

#define atscntrb_zeromq_zmq_socket zmq_socket

/* ****** ****** */

#define atscntrb_zeromq_zmq_getsockopt zmq_getsockopt
#define atscntrb_zeromq_zmq_getsockopt2 zmq_getsockopt
#define atscntrb_zeromq_zmq_setsockopt zmq_setsockopt

/* ****** ****** */

#define atscntrb_zeromq_zmq_bind zmq_bind
#define atscntrb_zeromq_zmq_unbind zmq_unbind

/* ****** ****** */

#define atscntrb_zeromq_zmq_connect zmq_connect
#define atscntrb_zeromq_zmq_disconnect zmq_disconnect

/* ****** ****** */

#define atscntrb_zeromq_zmq_close zmq_close

/* ****** ****** */

#define atscntrb_zeromq_zmq_send zmq_send
#define atscntrb_zeromq_zmq_recv zmq_recv

/* ****** ****** */

#define atscntrb_zeromq_zmq_msg_size zmq_msg_size
#define atscntrb_zeromq_zmq_msg_data zmq_msg_data
#define atscntrb_zeromq_zmq_msg_more zmq_msg_more

/* ****** ****** */

#define atscntrb_zeromq_zmq_msg_get zmq_msg_get
#define atscntrb_zeromq_zmq_msg_set zmq_msg_set

/* ****** ****** */

#define atscntrb_zeromq_zmq_msg_init zmq_msg_init
#define atscntrb_zeromq_zmq_msg_init_size zmq_msg_init_size
#define atscntrb_zeromq_zmq_msg_init_data zmq_msg_init_data

/* ****** ****** */

#define atscntrb_zeromq_zmq_msg_close zmq_msg_close

/* ****** ****** */

#define atscntrb_zeromq_zmq_msg_copy zmq_msg_copy
#define atscntrb_zeromq_zmq_msg_move zmq_msg_move

/* ****** ****** */

#define atscntrb_zeromq_zmq_msg_send zmq_msg_send
#define atscntrb_zeromq_zmq_msg_recv zmq_msg_recv

/* ****** ****** */

#define atscntrb_zeromq_zmq_version zmq_version

/* ****** ****** */

#define atscntrb_zeromq_zmq_term zmq_term

/* ****** ****** */

#define atscntrb_zeromq_zmq_sendmsg zmq_sendmsg
#define atscntrb_zeromq_zmq_recvmsg zmq_recvmsg

/* ****** ****** */

#endif // ifndef ZEROMQ_ZMQ_CATS

/* ****** ****** */

/* end of [zmq.cats] */
