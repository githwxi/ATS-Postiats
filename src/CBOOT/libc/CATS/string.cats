/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2008 Hongwei Xi, ATS Trustful Software, Inc.
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

/* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) */

/* ****** ****** */

#ifndef ATS_LIBC_STRING_CATS
#define ATS_LIBC_STRING_CATS

/* ****** ****** */

#include <string.h>

/* ****** ****** */

#define atslib_strcmp strcmp

ATSinline()
ats_int_type
atslib_substrcmp (
  ats_ptr_type str1, ats_size_type i1
, ats_ptr_type str2, ats_size_type i2
) {
  return strcmp((char*)str1+i1, (char*)str2+i2) ;
} /* end of [atslib_substrcmp] */

/* ****** ****** */

#define atslib_strncmp strncmp

ATSinline()
ats_int_type
atslib_substrncmp (
  ats_ptr_type str1, ats_size_type i1
, ats_ptr_type str2, ats_size_type i2
, ats_size_type n) {
  return strncmp(((char*)str1)+i1, ((char*)str2)+i2, n) ;
} // end of [atslib_substrncmp]

/* ****** ****** */

#define atslib_strlen strlen

/* ****** ****** */

#define atslib_strchr strchr
#define atslib_strrchr strrchr
#define atslib_strstr strstr

/* ****** ****** */

#define atslib_strspn strspn
#define atslib_strcspn strcspn

/* ****** ****** */

#define atslib_strcpy strcpy
#define atslib_strcat strcat
#define atslib_strncat strncat // HX: no interface in ATS

/* ****** ****** */

#define atslib_strpbrk strpbrk

/* ****** ****** */

#define atslib_memchr memchr
#define atslib_memcmp memcmp
#define atslib_memcpy memcpy
#define atslib_memset memset

/* ****** ****** */

#define atslib_strerror strerror
#define atslib_strerror_r strerror_r

/* ****** ****** */

#endif /* ATS_LIBC_STRING_CATS */

/* end of [string.cats] */
