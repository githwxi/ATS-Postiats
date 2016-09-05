/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2015 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
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
** Source:
** $PATSHOME/libc/sys/CATS/CODEGEN/socket.atxt
** Time of generation: Wed Jun  1 19:08:18 2016
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: November, 2014 *)
*/

/* ****** ****** */

#ifndef ATSLIB_LIBC_SYS_CATS_SOCKET
#define ATSLIB_LIBC_SYS_CATS_SOCKET

/* ****** ****** */
//
#include <unistd.h>
#include <sys/socket.h>
//
/* ****** ****** */

#include "share/H/pats_atslib.h"

/* ****** ****** */

/*
typedef
unsigned short int sa_family_t; // socket address family
*/
typedef
unsigned short int sp_family_t; // socket protocol family

/* ****** ****** */

#define atslib_socket_AF_type socket_AF_type
#define atslib_socket_PF_type socket_PF_type

/* ****** ****** */
//
#define \
atslib_bind_err(fd, sa, len) \
  bind(fd, (const struct sockaddr*)sa, len)
//
extern
void
atslib_bind_exn
(
  int sockfd, atstype_ptr sa, socklen_t salen
); // end of [atslib_bind_exn]
//
/* ****** ****** */
//
#define \
atslib_listen_err(fd, qsz) listen(fd, qsz)
//
extern
void
atslib_listen_exn (int sockfd, int listenqsz);
//
/* ****** ****** */
//
#define \
atslib_connect_err(fd, sa, len) \
  connect(fd, (const struct sockaddr*)sa, len)
//
extern
void
atslib_connect_exn
(
  int sockfd, atstype_ptr sa, socklen_t salen
); // end of [atslib_connect_exn]
//
/* ****** ****** */
//
#define \
atslib_accept_err(fd, sa, len) \
  accept(fd, (struct sockaddr*)sa, (socklen_t*)len)
//
#define \
atslib_accept_null_err(fd) atslib_accept_err(fd, 0, 0)
//
/* ****** ****** */

#define atslib_socket_close(fd) close(fd)

/* ****** ****** */

#define atslib_shutdown(fd, how) shutdown(fd, how)

/* ****** ****** */

#define \
atslib_socket_read(fd, bufp, bsz) read(fd, (char*)bufp, bsz)
#define \
atslib_socket_write(fd, bufp, bsz) write(fd, (const char*)bufp, bsz)

/* ****** ****** */

#endif // ifndef ATSLIB_LIBC_SYS_CATS_SOCKET

/* ****** ****** */

/* end of [socket.cats] */
