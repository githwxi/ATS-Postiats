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
(* Start time: March, 2013 *)
*/

/* ****** ****** */

#ifndef ATSLIB_LIBATS_LIBC_CATS_MALLOC
#define ATSLIB_LIBATS_LIBC_CATS_MALLOC

/* ****** ****** */

#if _WIN32
#include <stdio.h>
#else
#include <malloc.h>
#endif

/* ****** ****** */

#if _WIN32

static
int atslib_libats_libc_mallopt(int param, int value) {
  return 0; // error
}
static
int atslib_libats_libc_malloc_trim(size_t pad) {
  return 0; // unable to release any memory back to system
}
static
size_t atslib_libats_libc_malloc_usable_size(void *ptr) {
  return 0; // no usable bytes in the pointer that we know of...
}
static
void atslib_libats_libc_malloc_stats() {
  fprintf(stderr, "malloc_stats() is not implemented");
}
static
void *atslib_libats_libc_malloc_get_state() {
  return NULL; // error: unable to allocate memory for storing state
}
static
int atslib_libats_libc_malloc_set_state(void *state) {
  return -1; // error: unable to restore state
}

#else
#define atslib_libats_libc_mallopt mallopt
#define atslib_libats_libc_malloc_trim malloc_trim
#define atslib_libats_libc_malloc_usable_size malloc_usable_size
#define atslib_libats_libc_malloc_stats malloc_stats
#define atslib_libats_libc_malloc_get_state malloc_get_state
#define atslib_libats_libc_malloc_set_state malloc_set_state
#endif

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_CATS_MALLOC

/* ****** ****** */

/* end of [malloc.cats] */
