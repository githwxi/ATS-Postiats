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

#ifndef ATS_LIBC_STDLIB_CATS
#define ATS_LIBC_STDLIB_CATS

/* ****** ****** */

#include <errno.h>
#include <stdlib.h>

/* ****** ****** */

#include "ats_types.h"

/* ****** ****** */

// implemented in [prelude/CATS/printf.cats]
extern ats_void_type
atspre_exit_prerrf(ats_int_type code, ats_ptr_type fmt, ...) ;

/* ****** ****** */

#define atslib_atoi atoi
#define atslib_atof atof
#define atslib_atol atol
#define atslib_atoll atoll

/* ****** ****** */

#define atslib_strtoi_errnul(str, base) strtoi(str, NULL, base)
#define atslib_strtol_errnul(str, base) strtol(str, NULL, base)
#define atslib_strtoll_errnul(str, base) strtoll(str, NULL, base)

/* ****** ****** */

#define atslib_getenv getenv 
#define atslib_putenv putenv
#define atslib_setenv setenv
#define atslib_unsetenv unsetenv

/* ****** ****** */

#define atslib_abort aboirt
#define atslib__Exit _Exit
#define atslib_atexit atexit

/* ****** ****** */

#define atslib_system system

/* ****** ****** */

#define atslib_mkstemp mkstemp
#define atslib_mkdtemp mkdtemp

/* ****** ****** */
//
// HX: [atslib_bsearch] is slightly different from [bsearch]
//
ATSinline()
ats_int_type
atslib_bsearch (
  ats_ref_type key,
  ats_ref_type base, ats_size_type nmemb, ats_size_type size,
  ats_fun_ptr_type compar
) {
  void *p ;
  p = bsearch (
    key, base, nmemb, size, (int(*)(const void*, const void*))compar
  ) ; // end of [bsearch]
  if (!p) return -1 ;
  return ((char*)p - (char*)base) / size ;
} /* end of [atslib_bsearch] */

/* ****** ****** */
//
// HX: [atslib_qsort] is the same as [qsort]
//
ATSinline()
ats_void_type
atslib_qsort (
  ats_ref_type base,
  ats_size_type nmemb,
  ats_size_type size,
  ats_ptr_type compar
) {
  qsort(base, nmemb, size, (int(*)(const void*, const void*))compar) ;
  return ;
} /* end of [atslib_qsort] */

/* ****** ****** */

#endif /* ATS_LIBC_STDLIB_CATS */

/* end of [stdlib.cats] */
