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
(* Start time: February, 2013 *)
*/

/* ****** ****** */

#ifndef ATSLIB_LIBATS_LIBC_CATS_STRING
#define ATSLIB_LIBATS_LIBC_CATS_STRING

/* ****** ****** */

#include <errno.h>
#include <string.h>

/* ****** ****** */

#define atslib_libats_libc_strcmp strcmp
#define atslib_libats_libc_strncmp strncmp

/* ****** ****** */

#define atslib_libats_libc_strcoll strcoll

/* ****** ****** */

#define atslib_libats_libc_strspn strspn
#define atslib_libats_libc_strcspn strcspn

/* ****** ****** */

#define atslib_libats_libc_strlen strlen
#define atslib_libats_libc_strnlen strnlen

/* ****** ****** */

#define atslib_libats_libc_strcat strcat
#define atslib_libats_libc_strcat_unsafe strcat
#define atslib_libats_libc_strncat_unsafe strncat

/* ****** ****** */

#define atslib_libats_libc_strcpy strcpy
#define atslib_libats_libc_strcpy_unsafe strcpy
#define atslib_libats_libc_strncpy_unsafe strncpy

/* ****** ****** */

#define atslib_libats_libc_strdup strdup
#define atslib_libats_libc_strndup strndup
#define atslib_libats_libc_strdup_free atsruntime_mfree_libc

#define atslib_libats_libc_strdupa strdupa
#define atslib_libats_libc_strndupa strndupa
#define atslib_libats_libc_strdupa_free atsruntime_afree_libc

/* ****** ****** */

#define atslib_libats_libc_strfry strfry

/* ****** ****** */

#define atslib_libats_libc_memcpy memcpy
#define atslib_libats_libc_memcpy_unsafe memcpy

/* ****** ****** */

#define atslib_libats_libc_memccpy_unsafe memccpy

/* ****** ****** */

#define atslib_libats_libc_mempcpy mempcpy
#define atslib_libats_libc_mempcpy_unsafe mempcpy

/* ****** ****** */

#define atslib_libats_libc_memset_unsafe memset

/* ****** ****** */

#define atslib_libats_libc_memmove_unsafe memmove

/* ****** ****** */

#define atslib_libats_libc_strerror strerror
#define atslib_libats_libc_strerror_r strerror_r

/* ****** ****** */

ATSinline()
atstype_ptr
atslib_libats_libc_strdup_gc
  (atstype_string src)
{
  char *dst ;
  size_t len, len1 ;
  len = atslib_libats_libc_strlen((char*)src) ;
  len1 = len + 1;
  dst = atspre_malloc_gc(len1) ;
  return atslib_libats_libc_memcpy(dst, src, len1) ;
} // end of [atslib_libats_libc_strdup_gc]

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_CATS_STRING

/* ****** ****** */

/* end of [string.cats] */
