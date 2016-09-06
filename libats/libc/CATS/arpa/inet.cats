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

#ifndef ATSLIB_LIBATS_LIBC_CATS_ARPA_INET
#define ATSLIB_LIBATS_LIBC_CATS_ARPA_INET

/* ****** ****** */
//
#include <arpa/inet.h>
#include <netinet/in.h>
//
/* ****** ****** */

#ifndef EXIT_SUCCESS
#define	EXIT_SUCCESS 0
#endif // EXIT_SUCCESS
#ifndef EXIT_FAILURE
#define EXIT_FAILURE 1
#endif // EXIT_FAILURE

/* ****** ****** */
//
#define atslib_libc_htons htons
#define atslib_libc_ntohs ntohs
//
#define atslib_libc_htonl htonl
#define atslib_libc_ntohl ntohl
//
/* ****** ****** */

extern
int
inet_aton
(
  const char *cp, struct in_addr *inp
) ; // end of [inet_aton]

ATSinline()
atstype_bool
atslib_libc_inet_aton
(
  atstype_ptr cp, atstype_ref inp
) {
//
  int rtn ;
//
  rtn =
  inet_aton((char*)cp, (struct in_addr*)inp) ;
//
  return (rtn ? atsbool_true : atsbool_false) ;
//
} // end of [atslib_libc_inet_aton]

/* ****** ****** */

#define \
atslib_libc_inet_addr inet_addr
#define \
atslib_libc_inet_network inet_network

/* ****** ****** */

#define \
atslib_libc_inet_makeaddr inet_makeaddr

/* ****** ****** */

#define atslib_libc_inet_ntoa inet_ntoa

/* ****** ****** */

#define \
atslib_libc_inet4_pton(cp, inp) inet_pton(AF_INET4, cp, inp)
#define \
atslib_libc_inet6_pton(cp, inp) inet_pton(AF_INET6, cp, inp)

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_CATS_ARPA_INET

/* ****** ****** */

/* end of [inet.cats] */
