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

#ifndef \
ATSLIB_LIBATS_LIBC_CATS_STDLIB
#define \
ATSLIB_LIBATS_LIBC_CATS_STDLIB

/* ****** ****** */

#include <stdlib.h>

/* ****** ****** */

#define \
atslib_libats_libc_abort abort

/* ****** ****** */

#define \
atslib_libats_libc__Exit _Exit

/* ****** ****** */

#define \
atslib_libats_libc_atexit atexit

/* ****** ****** */

#define atslib_libats_libc_abs abs
#define atslib_libats_libc_labs labs
#define atslib_libats_libc_llabs llabs

/* ****** ****** */

#define atslib_libats_libc_div div
#define atslib_libats_libc_ldiv ldiv
#define atslib_libats_libc_lldiv lldiv

/* ****** ****** */

#define atslib_libats_libc_a64l a64l
#define atslib_libats_libc_l64a l64a

/* ****** ****** */

#define atslib_libats_libc_atoi atoi
#define atslib_libats_libc_atol atol
#define atslib_libats_libc_atoll atoll

/* ****** ****** */

#define atslib_libats_libc_atof atof

/* ****** ****** */

#define \
atslib_libats_libc_strtol0(nptr, base) \
atslib_libats_libc_strtol_unsafe(nptr, 0, base)
#define \
atslib_libats_libc_strtol1(nptr, endptr, base) \
atslib_libats_libc_strtol_unsafe(nptr, endptr, base)
#define \
atslib_libats_libc_strtol_unsafe(nptr, endptr, base) \
strtol((char*)(nptr), (char**)(endptr), base)

/* ****** ****** */

#define \
atslib_libats_libc_strtoll0(nptr, base) \
atslib_libats_libc_strtoll_unsafe(nptr, 0, base)
#define \
atslib_libats_libc_strtoll1(nptr, endptr, base) \
atslib_libats_libc_strtoll_unsafe(nptr, endptr, base)
#define \
atslib_libats_libc_strtoll_unsafe(nptr, endptr, base) \
strtoll((char*)(nptr), (char**)(endptr), base)

/* ****** ****** */

#define \
atslib_libats_libc_strtof0(nptr) \
atslib_libats_libc_strtof_unsafe(nptr, 0)
#define \
atslib_libats_libc_strtof1(nptr, endptr) \
atslib_libats_libc_strtof_unsafe(nptr, endptr)
#define \
atslib_libats_libc_strtof_unsafe(nptr, endptr) \
strtof((char*)(nptr), (char**)(endptr))

/* ****** ****** */

#define \
atslib_libats_libc_strtod0(nptr) \
atslib_libats_libc_strtod_unsafe(nptr, 0)
#define \
atslib_libats_libc_strtod1(nptr, endptr) \
atslib_libats_libc_strtod_unsafe(nptr, endptr)
#define \
atslib_libats_libc_strtod_unsafe(nptr, endptr) \
strtod((char*)(nptr), (char**)(endptr))

/* ****** ****** */

#define atslib_libats_libc_getenv getenv
#define atslib_libats_libc_putenv putenv
#define atslib_libats_libc_setenv setenv
#define atslib_libats_libc_unsetenv unsetenv

/* ****** ****** */

#define atslib_libats_libc_rand rand
#define atslib_libats_libc_srand srand
#define atslib_libats_libc_rand_r rand_r

/* ****** ****** */

#if _WIN32
#define atslib_libats_libc_random rand
#define atslib_libats_libc_srandom srand
#else
#define atslib_libats_libc_random random
#define atslib_libats_libc_srandom srandom
#endif

/* ****** ****** */
//
#define atslib_libats_libc_seed48 seed48
#if _WIN32
#define atslib_libats_libc_srand48 srand
#else
#define atslib_libats_libc_srand48 srand48
#endif

//
#if _WIN32
#define atslib_libats_libc_drand48() ((double)(rand()) / RAND_MAX)
#else
#define atslib_libats_libc_drand48 drand48
#endif
#define atslib_libats_libc_erand48 erand48
#define atslib_libats_libc_lrand48 lrand48
#define atslib_libats_libc_nrand48 nrand48
#define atslib_libats_libc_mrand48 mrand48
#define atslib_libats_libc_jrand48 jrand48
#define atslib_libats_libc_lcong48 lcong48
//
/* ****** ****** */

#define \
atslib_libats_libc_qsort\
(base, nmemb, size, compar) \
qsort(base, nmemb, size, (void*)compar)

/* ****** ****** */

#define \
atslib_libats_libc_bsearch\
(key, base, nmemb, size, compar) \
bsearch(key, base, nmemb, size, (void*)compar)

/* ****** ****** */

#define \
atslib_libats_libc_mkstemp mkstemp
#define \
atslib_libats_libc_mkostemp mkostemp

/* ****** ****** */

#define \
atslib_libats_libc_mfree_libc free
#define \
atslib_libats_libc_malloc_libc malloc

/* ****** ****** */

#define atslib_libats_libc_system system

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_CATS_STDLIB

/* ****** ****** */

/* end of [stdlib.cats] */
