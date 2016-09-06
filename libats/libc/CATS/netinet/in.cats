/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2014 Hongwei Xi, ATS Trustful Software, Inc.
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

#ifndef ATSLIB_LIBATS_LIBC_NETINET_IN_CATS
#define ATSLIB_LIBATS_LIBC_NETINET_IN_CATS

/* ****** ****** */
//
#include <arpa/inet.h>
#include <netinet/in.h>
//
/* ****** ****** */
//
typedef
struct in_addr in_addr_structats;
typedef
struct in6_addr in6_addr_structats;
//
/* ****** ****** */
//
typedef
struct sockaddr_in sockaddr_in_struct ;
typedef
struct sockaddr_in6 sockaddr_in6_struct ;
//
#define atslib_libc_socklen_in (sizeof(sockaddr_in_struct))
#define atslib_libc_socklen_in6 (sizeof(sockaddr_in6_struct))
//
/* ****** ****** */

#define atslib_libc_in_port_nbo_int(nport) htons(nport)
#define atslib_libc_in_port_nbo_uint(nport) htons(nport)

/* ****** ****** */

ATSinline()
in_addr_t
atslib_libc_in_addr_hbo2nbo
  (in_addr_t addr_hbo) { return htonl (addr_hbo) ; }
/* end of [atslib_libc_in_addr_hbo2nbo] */

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_NETINET_IN_CATS

/* ****** ****** */

/* end of [in.cats] */
