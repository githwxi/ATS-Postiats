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

#ifndef ATSLIB_LIBC_NETINET_IN_CATS
#define ATSLIB_LIBC_NETINET_IN_CATS

/* ****** ****** */
//
#include <arpa/inet.h>
#include <netinet/in.h>
//
/* ****** ****** */
//
typedef
struct in_addr in_addr_struct;
typedef
struct in6_addr in6_addr_struct;
//
/* ****** ****** */
//
typedef
struct sockaddr_in sockaddr_in_struct ;
typedef
struct sockaddr_in6 ats_sockaddr_in6_struct ;
//
#define atslib_socklen_in (sizeof(ats_sockaddr_in_struct))
#define atslib_socklen_in6 (sizeof(ats_sockaddr_in6_struct))
//
/* ****** ****** */

ATSinline()
in_port_t
atslib_in_port2nbo
  (atstype_int n) {
  in_port_t nport = n ; return htons(nport) ;
} // end of [atslib_in_port2nbo]

/* ****** ****** */

ATSinline()
in_addr_t
atslib_in_addr_hbo2nbo
  (in_addr_t addr_hbo) { return htonl (addr_hbo) ; }
/* end of [atslib_in_addr_hbo2nbo] */

/* ****** ****** */

typedef
struct in_addr in_addr_struct ;

/* ****** ****** */

#endif // ifndef ATSLIB_LIBC_NETINET_IN_CATS

/* ****** ****** */

/* end of [in.cats] */
