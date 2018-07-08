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
(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: November, 2014 *)
*/

/* ****** ****** */

#ifndef \
ATSLIB_LIBATS_LIBC_CATS_SYS_SOCKET_IN
#define \
ATSLIB_LIBATS_LIBC_CATS_SYS_SOCKET_IN

/* ****** ****** */
//
#include <sys/socket.h>
#include <netinet/in.h>
//
/* ****** ****** */
//
#ifdef memset
#else
extern
void *memset (void *p, int c, size_t n) ;
#endif // ifdef(memset)
//
/* ****** ****** */

ATSinline()
atsvoid_t0ype
atslib_libats_libc_sockaddr_in_init
(
  atstype_ptr sa
, sa_family_t af, in_addr_t inp, in_port_t port
) {
  struct sockaddr_in *sa2 = sa ;
  (void)memset(sa2, 0, sizeof(struct sockaddr_in)) ;
  sa2->sin_family = af ;
  sa2->sin_addr.s_addr = inp ;
  sa2->sin_port = port ;
} // end of [atslib_libats_libc_sockaddr_in_init]

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_CATS_SYS_SOCKET_IN

/* ****** ****** */

/* end of [socket_in.cats] */
