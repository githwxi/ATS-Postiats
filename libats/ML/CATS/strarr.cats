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
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: April, 2013 *)
*/

/* ****** ****** */

#ifndef ATSLIB_LIBATS_ML_STRING0_CATS
#define ATSLIB_LIBATS_ML_STRING0_CATS

/* ****** ****** */

#ifndef strncmp
extern
int strncmp (const char *s1, const char *s2, size_t n) ;
#endif // ifndef(strncmp)

/* ****** ****** */

#ifndef memchr
extern void *memchr(const void *s, int c, size_t n) ;
#endif // ifndef(memchr)

#ifndef memcpy
extern void *memcpy(void *dst, const void *src, size_t n) ;
#endif // ifndef(memcpy)

/* ****** ****** */

extern
size_t
fwrite
(
  const void *ptr, size_t size, size_t nmemb, FILE *stream
) ; // end of [fwrite] // in [stdio.h]

/* ****** ****** */

#define atslib_ML_strarr_memchr memchr
#define atslib_ML_strarr_memcpy memcpy
#define atslib_ML_strarr_strncmp strncmp
#define atslib_ML_strarr_fwrite fwrite

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_ML_STRING0_CATS

/* ****** ****** */

/* end of [strarr.cats] */
